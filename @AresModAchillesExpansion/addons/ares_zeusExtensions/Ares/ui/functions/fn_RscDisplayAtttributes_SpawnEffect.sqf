
#define EFFECT_MODULES		["ModuleFlare_F","ModuleSmoke_F","ModuleIRGrenade_F","ModuleChemlight_F","ModuleLightSource_F","ModulePersistentSmokePillar_F","ModuleTracers_F"]
#define NO_CHOICE_MODULES	["ModuleIRGrenade_F","ModuleTracers_F"]

#define IDC_CTRL_CATEGORY	20000
#define IDD_DYNAMIC_GUI		133798
#define IDC_LABLE_TYPE		10001
#define IDC_CTRL_TYPE		20001

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
		_category_ctrl = _dialog displayCtrl IDC_CTRL_CATEGORY;
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_0", 0];
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_last_choice = if (_last_choice < lbSize _category_ctrl) then {_last_choice} else {(lbSize _category_ctrl) - 1};
		_category_ctrl lbSetCurSel _last_choice;
		
		[0,_category_ctrl,_last_choice] call Ares_fnc_RscDisplayAtttributes_SpawnEffect;
	};
	case "0": 
	{
		_type_ctrl = _dialog displayCtrl IDC_CTRL_TYPE;
		
		_module_category = EFFECT_MODULES select _comboIndex;

		if (_module_category in NO_CHOICE_MODULES) then
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				_ctrl ctrlEnable false;
				_ctrl ctrlCommit 0;
			} forEach [IDC_LABLE_TYPE,IDC_CTRL_TYPE];
		} else
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0;
				if (_x == IDC_CTRL_TYPE) then {_ctrl ctrlEnable true};
				_ctrl ctrlCommit 0;
			} forEach [IDC_LABLE_TYPE,IDC_CTRL_TYPE];
			
			_classNames = (configfile >> "CfgVehicles" >> _module_category) call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass;
			_displayNames = [{getText (configfile >> "CfgVehicles" >> _this >> "displayName")},_classNames] call Achilles_fnc_map;
			lbClear _type_ctrl;
			{_type_ctrl lbAdd _x} forEach _displayNames;
		};
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_last_choice = if (_last_choice < lbSize _type_ctrl) then {_last_choice} else {(lbSize _type_ctrl) - 1};
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_type_ctrl lbSetCurSel _last_choice;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
		[1,_type_ctrl,_last_choice] call Ares_fnc_RscDisplayAtttributes_SpawnEffect;	
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
