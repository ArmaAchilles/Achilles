
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
		_vehicle = BIS_fnc_initCuratorAttributes_target;		
		_damageValues = (getAllHitPointsDamage _vehicle) select 2;
		
		// set initial slider values
		{
			_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _forEachIndex);
			_ctrl sliderSetPosition _x;
			uiNamespace setVariable [format ["Ares_ChooseDialog_ReturnValue_%1",_forEachIndex], _x];
		} forEach _damageValues;
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
