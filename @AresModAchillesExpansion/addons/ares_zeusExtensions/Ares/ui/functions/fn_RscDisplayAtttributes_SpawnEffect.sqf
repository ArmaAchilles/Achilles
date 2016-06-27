
#define EFFECT_MODULES		["ModuleFlare_F","ModuleSmoke_F","ModuleIRGrenade_F","ModuleChemlight_F","ModuleLightSource_F","ModulePersistentSmokePillar_F","ModuleTracers_F"]
#define NO_CHOICE_MODULES	["ModuleIRGrenade_F","ModuleTracers_F"]

#define COMBO_IDC 			20000
#define DYNAMIC_GUI_IDD		133798
#define LABEL_IDCs			[10001]
#define CTRL_IDCs			[20001]
	
_mode = _this select 0;

if (not (_mode in ["LOADED",((localize "STR_CATEGORY") call Achilles_fnc_TextToVariableName)])) exitWith {};

disableSerialization;
_dialog = findDisplay DYNAMIC_GUI_IDD;
_ctrl = _dialog displayCtrl COMBO_IDC;
_selection = lbCurSel _ctrl;

_module_category = EFFECT_MODULES select _selection;

if (_module_category in NO_CHOICE_MODULES) then
{
	// "Nearest" selected
	{
		_ctrl = _dialog displayCtrl _x;
		_ctrl ctrlSetFade 0.8;
		_ctrl ctrlEnable false;
		_ctrl ctrlCommit 0;
	} forEach (LABEL_IDCs + CTRL_IDCs);
} else
{
	// "Range" selected
	{
		_ctrl = _dialog displayCtrl _x;
		_ctrl ctrlSetFade 0;
		if (_x in CTRL_IDCs) then {_ctrl ctrlEnable true};
		_ctrl ctrlCommit 0;
	} forEach (LABEL_IDCs + CTRL_IDCs);
	
	_classNames = (configfile >> "CfgVehicles" >> _module_category) call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass;
	_displayNames = [{getText (configfile >> "CfgVehicles" >> _this >> "displayName")},_classNames] call Achilles_fnc_map;
	lbClear _ctrl;
	{_ctrl lbAdd _x} forEach _displayNames; 
};