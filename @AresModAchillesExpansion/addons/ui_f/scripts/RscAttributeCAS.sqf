#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#include "\A3\ui_f\hpp\defineCommonGrids.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTECAS_VALUE;
		_ctrlValue ctrlsetfontheight GUI_GRID_H;

		_selected = missionnamespace getvariable ["RscATtributeCAS_selected",""];
		
		//--- Detect gun
		_weaponTypesID = _unit getvariable ["type",getnumber (configfile >> "cfgvehicles" >> typeof _unit >> "moduleCAStype")];
		_weaponTypes = switch _weaponTypesID do
		{
			case 0: {["machinegun"]};
			case 1: {["missilelauncher"]};
			case 2: {["machinegun","missilelauncher"]};
			case 3: {["bomblauncher"]};
			default {[]};
		};

		{
			_planeCfg = _x;
			_vehicle = configName (_planeCfg);
			if ((_vehicle isKindOf "Plane") and (getNumber (_planeCfg >> "scope") == 2)) then
			{
				_weapon_cfgs = getarray (_planeCfg >> "weapons");
				_weapons = [];
				_gunner_is_driver = 1;
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
					_gunner_is_driver = 0;
				};
				if (count _weapons == 0) exitWith {};
				
				_lnbAdd = _ctrlValue lnbaddrow ["","",gettext (_planeCfg >> "displayName")];
				_ctrlValue lnbsetdata [[_lnbAdd,0],_vehicle];
				_ctrlValue lnbsetdata [[_lnbAdd,1],str _weapons];
				_ctrlValue lnbSetValue  [[_lnbAdd,1],_gunner_is_driver];
				_ctrlValue lnbsetpicture [[_lnbAdd,0],gettext (configfile >> "cfgfactionclasses" >> gettext (_planeCfg >> "faction") >> "icon")];
				_ctrlValue lnbsetpicture [[_lnbAdd,1],gettext (_planeCfg >> "picture")];
			};
		} foreach ((configfile >> "cfgvehicles" ) call bis_fnc_returnchildren);
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
		_vehicle = _ctrlValue lnbdata [lnbcurselrow _ctrlValue,0];
		_weapons = parseSimpleArray (_ctrlValue lnbdata [lnbcurselrow _ctrlValue,1]);
		_gunner_is_driver = _ctrlValue lnbvalue [lnbcurselrow _ctrlValue,1];

		_unit setvariable ["vehicle",_vehicle,true];
		_unit setvariable ["weapons",_weapons,true];
		_unit setvariable ["gunnerIsDriver",_gunner_is_driver,true];
		_unit setvariable ["BIS_fnc_curatorAttributes",[],true];
		missionnamespace setvariable ["RscATtributeCAS_selected",_vehicle];
	};
	case "onUnload": {
		if (!isnil "RscAttributePostProcess_default") then {
			[nil,0,false] call bis_fnc_setPPeffectTemplate;
		};
		RscAttributePostProcess_default = nil;
	};
};