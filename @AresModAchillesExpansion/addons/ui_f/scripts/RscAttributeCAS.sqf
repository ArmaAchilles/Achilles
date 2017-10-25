#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineCommonGrids.inc"

params["_mode", "_params", "_logic"];

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;
		_ctrlValue ctrlsetfontheight GUI_GRID_H;
		
		private _weapon_types_list = [["machinegun"], ["missilelauncher"], ["machinegun","missilelauncher"], ["bomblauncher"]];
		
		// search for suitable CAS planes on first use
		if (isNil "Achilles_var_CASPlaneInfoCache") then
		{
			publicVariableServer "Achilles_fnc_moduleCAS_server";
			Achilles_var_CASPlaneInfoCache = [[],[],[],[]];
			
			{
				private _planeCfg = _x;
				private _vehicle = configName (_planeCfg);
                
				if ((_vehicle isKindOf "Plane") and (getNumber (_planeCfg >> "scope") == 2 or getNumber (_planeCfg >> "scopeCurator") == 2)) then
				{
					private _weapon_classes = getarray (_planeCfg >> "weapons");
					if (isClass (_planeCfg >> "Components" >> "TransportPylonsComponent")) then
					{
						private _pylon_cfgs = (_planeCfg >> "Components" >> "TransportPylonsComponent" >> "pylons") call BIS_fnc_returnChildren;
						{
							private _pylon_mag = getText (_x >> "attachment");
							_weapon_classes pushBack getText (configFile >> "cfgMagazines" >> _pylon_mag >> "pylonWeapon");
							if (count getArray (configFile >> "cfgMagazines" >> _pylon_mag >> "turret") > 0) then {private _gunner_is_driver = false};
						} forEach _pylon_cfgs;
					};
					{
						private _weaponTypes = _x;						
						private _weapons = [];
						private _gunner_is_driver = true;
						{
							if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then
							{
								private _modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
								if (count _modes > 0) then
								{
									_mode = _modes select 0;
									if (_mode == "this") then {_mode = _x;};
									_weapons pushBack [_x,_mode];
								};
							};
						} foreach _weapon_classes;
						if (count _weapons == 0) then 
						{
							private _turret_cfgs = (_planeCfg >> "Turrets" >> "GunnerTurret") call BIS_fnc_returnChildren;
							_turret_cfgs = _turret_cfgs select {getNumber (_x >> "primaryGunner") == 1};
							if (count _turret_cfgs == 0) exitWith {};
							_weapon_classes = getarray (_turret_cfgs select 0 >> "weapons");
							{
								if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then
								{
									private _modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
									if (count _modes > 0) then
									{
										_mode = _modes select 0;
										if (_mode == "this") then {_mode = _x;};
										_weapons pushBack [_x,_mode];
									};
								};
							} foreach _weapon_classes;
							_gunner_is_driver = false;
						};
						if (count _weapons != 0) then
						{
							private _cas_info_list = Achilles_var_CASPlaneInfoCache select _forEachIndex;
							_cas_info_list pushBack [_vehicle,_weapons,_gunner_is_driver];
						};
					} forEach _weapon_types_list;	
				};
			} foreach ((configfile >> "cfgvehicles" ) call bis_fnc_returnchildren);
		};
		
		// append planes to listbox
		private _weaponTypesID = _logic getvariable ["type",getnumber (configfile >> "cfgvehicles" >> typeof _logic >> "moduleCAStype")];
		if (_index == -1) exitWith {hint "Error: Not a valid CAS module!"};
		private _cas_info_list = Achilles_var_CASPlaneInfoCache select _weaponTypesID;
		{
			private _planeClass = _x select 0;
			private _planeCfg = (configfile >> "cfgvehicles" >> _planeClass);
			private _lnbAdd = _ctrlValue lnbaddrow ["","",gettext (_planeCfg >> "displayName")];
			_ctrlValue lnbSetValue [[_lnbAdd,0],_weaponTypesID];
			_ctrlValue lnbSetData [[_lnbAdd,0],_planeClass];
			_ctrlValue lnbSetValue  [[_lnbAdd,1],_forEachIndex];
			_ctrlValue lnbsetpicture [[_lnbAdd,0],gettext (configfile >> "cfgfactionclasses" >> gettext (_planeCfg >> "faction") >> "icon")];
			_ctrlValue lnbsetpicture [[_lnbAdd,1],gettext (_planeCfg >> "picture")];
		} foreach _cas_info_list;
		
		private _selected = missionnamespace getvariable ["RscATtributeCAS_selected",""];
		_ctrlValue lnbsort [2,false];
		for "_i" from 0 to ((lnbsize _ctrlValue select 0) - 1) do {
			if ((_ctrlValue lnbdata [_i,0]) == _selected) exitwith {_ctrlValue lnbsetcurselrow _i;};
		};
		if (lnbcurselrow _ctrlValue < 0) then {
			_ctrlValue lnbsetcurselrow 0;
		};
	};
	case "confirmed": {
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;
		private _weaponTypesID = _ctrlValue lnbvalue [lnbcurselrow _ctrlValue,0];
		private _planeClassID = _ctrlValue lnbvalue [lnbcurselrow _ctrlValue,1];
		private _plane_info = Achilles_var_CASPlaneInfoCache select _weaponTypesID select _planeClassID;
		
		// logic is not editable
		_logic setvariable ["BIS_fnc_curatorAttributes",[]];
		//--- Reveal the circle to curators
		_logic hideobject false;
		_logic setpos position _logic;
		_logic setdir (missionnamespace getvariable ["Achilles_var_CAS_dir", direction _logic]);
		
		// create public helper logic
		private _logic_group = createGroup sideLogic;
		private _helper = _logic_group createUnit ["module_f", getPosATL _logic, [], 0, "NONE"];
		_helper setPosATL getPosATL _logic;
		[_helper, direction _logic] remoteExecCall ["setDir", 0];
		_logic setVariable ["slave", _helper];
		_helper setVariable ["master", _logic];
		_helper addEventHandler ["Deleted", 
		{
			private _master = (_this select 0) getVariable ["master", objNull];
			if(not isNull _master) then {deleteVehicle _master};
		}];
		
		// handle CAS server side
		private _arguments = [player, _helper, _weaponTypesID] + _plane_info;
		_arguments remoteExec ["Achilles_fnc_moduleCAS_server",2];
		
		missionnamespace setvariable ["RscATtributeCAS_selected", _plane_info select 0];
	};
	case "onUnload": {
		if (!isnil "RscAttributePostProcess_default") then {
			[nil,0,false] call bis_fnc_setPPeffectTemplate;
		};
		RscAttributePostProcess_default = nil;
		
		// cleanup if cancled
		if (isNull (_logic getVariable ["slave", objNull])) then
		{
			deleteVehicle _logic;
		};
	};
};
