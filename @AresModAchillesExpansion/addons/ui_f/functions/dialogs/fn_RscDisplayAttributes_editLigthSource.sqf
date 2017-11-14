#define EFFECT_MODULES		["ModuleFlare_F","ModuleSmoke_F","ModuleIRGrenade_F","ModuleChemlight_F","ModuleLightSource_F","ModulePersistentSmokePillar_F","ModuleTracers_F"]
#define NO_CHOICE_MODULES	["ModuleIRGrenade_F","ModuleTracers_F"]

#define IDC_CTRL_BASE		20000
#define IDC_CTRL_RANGE		20003
#define IDD_DYNAMIC_GUI		133798

private ["_mode", "_ctrl", "_comboIndex"];

disableSerialization;
_mode = (_this select 0);
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

private _dialog = findDisplay IDD_DYNAMIC_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		{
			_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _x);
			_ctrl ctrlAddEventHandler ["onSliderPosChanged", {["UPDATE"] call Achilles_fnc_RscDisplayAttributes_editLigthSource}];
		} forEach [0,1,2,4,5,6];
		_ctrl = _dialog displayCtrl IDC_CTRL_RANGE;
		_ctrl ctrlAddEventHandler ["KillFocus", {["UPDATE"] call Achilles_fnc_RscDisplayAttributes_editLigthSource}];
	};
	case "UPDATE":
	{
		private _rgb_color = [];
		for "_i" from 0 to 2 do
		{
			_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _i);
			_color = sliderPosition _ctrl;
			_rgb_color pushBack _color;
		};

		_ctrl = _dialog displayCtrl IDC_CTRL_RANGE;
		private _attenuation = [parseNumber (ctrlText _ctrl)];

		for "_i" from 4 to 6 do
		{
			_ctrl = _dialog displayCtrl (IDC_CTRL_BASE + _i);
			_color = 100 * (sliderPosition _ctrl);
			_attenuation pushBack _color;
		};
		Achilles_var_AttributeWindowTargetObject setLightBrightness 1.0;
		Achilles_var_AttributeWindowTargetObject setLightAmbient  _rgb_color;
		Achilles_var_AttributeWindowTargetObject setLightColor  _rgb_color;
		Achilles_var_AttributeWindowTargetObject setLightColor  _rgb_color;
	};
	case "UNLOAD" : {};
	default
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
