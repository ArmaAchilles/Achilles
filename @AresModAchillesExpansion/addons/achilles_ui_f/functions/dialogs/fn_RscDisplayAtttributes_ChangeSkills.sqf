
#define SKILLS		["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding"]

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
		// get current damage
		_entity = BIS_fnc_initCuratorAttributes_target;
		_unit = if (typeName _entity == "OBJECT") then {_entity} else {leader _entity};
		
		// set initial slider values
		{
			_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _forEachIndex);
			_value = linearConversion [0.2,1,_unit skill _x,0,1,true];
			_ctrl sliderSetPosition _value;
			uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1",_forEachIndex], _value];
		} forEach SKILLS;
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
