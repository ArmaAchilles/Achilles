#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineCommonGrids.inc"

_mode = _this select 0;
_params = _this select 1;
_logic = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;
		_ctrlValue ctrlsetfontheight GUI_GRID_H;
		
		_weapon_types_list = [["machinegun"], ["missilelauncher"], ["machinegun","missilelauncher"], ["bomblauncher"]];
		
		// search for suitable CAS planes on first use
		if (isNil "Achilles_var_CASPlaneInfoCache") then
		{
			publicVariableServer "Achilles_fnc_moduleCAS_server";
			Achilles_var_CASPlaneInfoCache = [[],[],[],[]];
			
			{
				_planeCfg = _x;
				_vehicle = configName (_planeCfg);
				if ((_vehicle isKindOf "Plane") and (getNumber (_planeCfg >> "scope") == 2)) then
				{
					_weapon_cfgs = getarray (_planeCfg >> "weapons");
					{
						_weaponTypes = _x;						
						_weapons = [];
						_gunner_is_driver = true;
						{
							if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then
							{
								_modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
								if (count _modes > 0) then
								{
									_mode = _modes select 0;
									if (_mode == "this") then {_mode = _x;};
									_weapons set [count _weapons,[_x,_mode]];
								};
							};
						} foreach _weapon_cfgs;
						if (count _weapons == 0) then 
						{
							_turret_cfgs = (_planeCfg >> "Turrets") call BIS_fnc_returnChildren;
							if (count _turret_cfgs == 0) exitWith {};
							_weapon_cfgs = getarray (_turret_cfgs select 0 >> "weapons");
							{
								if (tolower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then
								{
									_modes = getarray (configfile >> "cfgweapons" >> _x >> "modes");
									if (count _modes > 0) then
									{
										_mode = _modes select 0;
										if (_mode == "this") then {_mode = _x;};
										_weapons set [count _weapons,[_x,_mode]];
									};
								};
							} foreach _weapon_cfgs;
							_gunner_is_driver = false;
						};
						if (count _weapons != 0) then
						{
							_cas_info_list = Achilles_var_CASPlaneInfoCache select _forEachIndex;
							_cas_info_list pushBack [_vehicle,_weapons,_gunner_is_driver];
						};
					} forEach _weapon_types_list;	
				};
			} foreach ((configfile >> "cfgvehicles" ) call bis_fnc_returnchildren);
		};
		
		// append planes to listbox
		_weaponTypesID = _logic getvariable ["type",getnumber (configfile >> "cfgvehicles" >> typeof _logic >> "moduleCAStype")];
		if (_index == -1) exitWith {hint "Error: Not a valid CAS module!"};
		_cas_info_list = Achilles_var_CASPlaneInfoCache select _weaponTypesID;
		{
			_planeClass = _x select 0;
			_planeCfg = (configfile >> "cfgvehicles" >> _planeClass);
			_lnbAdd = _ctrlValue lnbaddrow ["","",gettext (_planeCfg >> "displayName")];
			_ctrlValue lnbSetValue [[_lnbAdd,0],_weaponTypesID];
			_ctrlValue lnbSetData [[_lnbAdd,0],_planeClass];
			_ctrlValue lnbSetValue  [[_lnbAdd,1],_forEachIndex];
			_ctrlValue lnbsetpicture [[_lnbAdd,0],gettext (configfile >> "cfgfactionclasses" >> gettext (_planeCfg >> "faction") >> "icon")];
			_ctrlValue lnbsetpicture [[_lnbAdd,1],gettext (_planeCfg >> "picture")];
		} foreach _cas_info_list;
		
		_selected = missionnamespace getvariable ["RscATtributeCAS_selected",""];
		_ctrlValue lnbsort [2,false];
		for "_i" from 0 to ((lnbsize _ctrlValue select 0) - 1) do {
			if ((_ctrlValue lnbdata [_i,0]) == _selected) exitwith {_ctrlValue lnbsetcurselrow _i;};
		};
		if (lnbcurselrow _ctrlValue < 0) then {
			_ctrlValue lnbsetcurselrow 0;
		};
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;
		_weaponTypesID = _ctrlValue lnbvalue [lnbcurselrow _ctrlValue,0];
		_planeClassID = _ctrlValue lnbvalue [lnbcurselrow _ctrlValue,1];
		_plane_info = Achilles_var_CASPlaneInfoCache select _weaponTypesID select _planeClassID;
		
		// logic is not editable
		_logic setvariable ["BIS_fnc_curatorAttributes",[]];
		//--- Reveal the circle to curators
		_logic hideobject false;
		_logic setpos position _logic;
		_logic setdir (missionnamespace getvariable ["Achilles_var_CAS_dir", direction _logic]);
		
		// create public helper logic
		_logic_group = createGroup sideLogic;
		_helper = _logic_group createUnit ["module_f", getPosATL _logic, [], 0, "NONE"];
		_helper setPosATL getPosATL _logic;
		[_helper, direction _logic] remoteExecCall ["setDir", 0];
		_logic setVariable ["slave", _helper];
		_helper setVariable ["master", _logic];
		_logic addEventHandler ["Deleted", 
		{
			_slave = (_this select 0) getVariable ["slave", objNull];
			if(not isNull _slave) then {deleteVehicle _slave};
		}];
		_helper addEventHandler ["Deleted", 
		{
			_master = (_this select 0) getVariable ["master", objNull];
			if(not isNull _master) then {deleteVehicle _master};
		}];
		
		// handle CAS server side
		_arguments = [player, _helper, _weaponTypesID] + _plane_info;
		_arguments remoteExec ["Achilles_fnc_moduleCAS_server",2];
		
		missionnamespace setvariable ["RscATtributeCAS_selected", _plane_info select 0];
	};
	case "onUnload": {
		if (!isnil "RscAttributePostProcess_default") then {
			[nil,0,false] call bis_fnc_setPPeffectTemplate;
		};
		RscAttributePostProcess_default = nil;
	};
};