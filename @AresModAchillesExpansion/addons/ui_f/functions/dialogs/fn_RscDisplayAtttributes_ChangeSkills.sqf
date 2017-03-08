
#define SKILLS		["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"]
#define ACE_TRAITS		["ace_medical_medicClass","ACE_IsEngineer","ACE_isEOD"]
#define VANILLA_TRAITS	["medic","engineer","explosiveSpecialist"]

#define IDD_DYNAMIC_GUI				133798
#define IDC_CTRL_BASE				20000

private ["_mode", "_ctrl", "_comboIndex"];

disableSerialization;
_mode = (_this select 0);
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

_dialog = findDisplay IDD_DYNAMIC_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		// get current skills
		_is_single_unit = (typeName BIS_fnc_initCuratorAttributes_target == "OBJECT");
		_ace_loaded = isClass (configfile >> "CfgPatches" >> "ace_main");
		
		_unit = if (_is_single_unit) then {_entity} else {leader _entity};
		private _i = 0;
		// set initial slider values
		if (_is_single_unit) then
		{
			if (_ace_loaded) then
			{
				{
					_trait_value = _unit getVariable [_x, 0];
					_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _i);
					_ctrl lbSetCurSel _trait_value;
					uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _i], _trait_value];
					_i = _i + 1;
				} forEach ACE_TRAITS;
			} else
			{
				{
					_trait_value = if (_unit getUnitTrait _x) then {1} else {0};
					_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _i);
					_ctrl lbSetCurSel _trait_value;
					uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _i], _trait_value];
					_i = _i + 1;
				} forEach VANILLA_TRAITS;			
			};
		};
		{
			_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _i);
			_value = linearConversion [0.2,1,_unit skill _x,0,1,true];
			_ctrl sliderSetPosition _value;
			uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1",_i], _value];
			_i = _i + 1;
		} forEach SKILLS;
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
