
#define IDD_DYNAMIC_GUI		133798
#define IDC_CATEGORIES		20000
#define IDC_ITEMS			20001
#define IDC_ADD_BUTTON		3020
#define IDC_BOTTOM			2010

 IDD_DYNAMIC_GUI=		133798;
 IDC_CATEGORIES	=	20000;
 IDC_ITEMS		=	20001;
 IDC_ADD_BUTTON	=	3020;
 IDC_BOTTOM		=	2010;

disableSerialization;

private ["_mode", "_ctrl", "_comboIndex"];

_mode = _this select 0;
_ctrl = param [1,controlNull,[controlNull]];
_comboIndex = param [2,0,[0]];

_dialog = findDisplay IDD_DYNAMIC_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		_bottom_ctrl = _dialog displayCtrl IDC_BOTTOM;
		_bottom_pos = ctrlPosition _bottom_ctrl;
		_button_ctrl = _dialog ctrlCreate ["RscButtonMenu", IDC_ADD_BUTTON];
		_button_ctrl ctrlSetText ( "STR_NEW_CATEGORY");
		_button_ctrl ctrlSetPosition _bottom_pos;
		_codeString =
		"
			_dialogResult =
			[
				 ""STR_NEW_CATEGORY"",
				[
					[ ""STR_NAME"", """"]
				]
			] call Ares_fnc_showChooseDialog;
			if (count _dialogResult > 0) then
			{
				Ares_var_composition_category = _dialogResult select 0;
				[""ADD_CATEGORY"",controlNull,0] call Ares_fnc_RscDisplayAttributes_createAdvancedComposition;
			};
		";
		_button_ctrl ctrlAddEventHandler ["MouseButtonClick", _codeString];
		
		_category_ctrl = _dialog displayCtrl IDC_CATEGORIES;
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_0", 0];
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_category_ctrl lbSetCurSel _last_choice;
		
		[0,_category_ctrl,_last_choice] call Ares_fnc_RscDisplayAttributes_createAdvancedComposition;
	};
	case "ADD_CATEGORY":
	{
		_category_ctrl = _dialog displayCtrl IDC_CATEGORIES;
		_category_ctrl lbAdd Ares_var_composition_category;
		[0,_category_ctrl,(lbSize _category_ctrl) - 1] call Ares_fnc_RscDisplayAttributes_createAdvancedComposition;
	};
	case "0":
	{
		_category_ctrl = _ctrl;
		_item_info_lists = _dialog getVariable ["item_info_lists",[]];
		Ares_var_composition_category = (_category_ctrl lbText _comboIndex);
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};