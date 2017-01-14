
#define IDD_DYNAMIC_GUI			133798
#define IDC_CATEGORIES			20000
#define IDC_NEW_CATEGORY		20001
#define IDC_NEW_CATEGORY_LABEL	10001
#define IDC_NEW_ITEM			20002
#define IDC_OK_BUTTON			3000

/*
 IDD_DYNAMIC_GUI		=133798;
 IDC_CATEGORIES			=20000;
 IDC_NEW_CATEGORY		=20001;
 IDC_NEW_CATEGORY_LABEL	=10001;
 IDC_NEW_ITEM			=20002;
 IDC_OK_BUTTON			=3000;
*/
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
		_ok_ctrl = _dialog displayCtrl IDC_OK_BUTTON;
		_ok_ctrl ctrlRemoveAllEventHandlers "ButtonClick";
		_ok_ctrl ctrlAddEventHandler ["ButtonClick", "[""OK_BUTTON""] call Achilles_fnc_RscDisplayAttributes_editAdvancedComposition"];
	
		_category_ctrl = _dialog displayCtrl IDC_CATEGORIES;
		_old_category = _category_ctrl lbText 0;
		
		_categories = [localize "STR_NEW_CATEGORY"];
		_custom_compositions = profileNamespace getVariable ["Achilles_var_compositions",[]];
		if (count _custom_compositions > 0) then
		{
			_categories append (_custom_compositions apply {_x select 0});
		};
		{if (_x != _old_category) then {_category_ctrl lbAdd _x}} forEach _categories;
		
		_last_choice = 0;
		_category_ctrl lbSetCurSel _last_choice;
		[0,_category_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_editAdvancedComposition;
	};
	case "0":
	{
		_category_ctrl = _ctrl;
		if (_comboIndex == 1) then
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0;
				if (_x == IDC_NEW_CATEGORY) then {_ctrl ctrlShow true};
				_ctrl ctrlCommit 0;
			} forEach [IDC_NEW_CATEGORY,IDC_NEW_CATEGORY_LABEL];	
		} else
		{
			{
				_ctrl = _dialog displayCtrl _x;
				_ctrl ctrlSetFade 0.8;
				if (_x == IDC_NEW_CATEGORY) then {_ctrl ctrlShow false};
				_ctrl ctrlCommit 0;
			} forEach [IDC_NEW_CATEGORY,IDC_NEW_CATEGORY_LABEL];
			
			Ares_var_composition_category = (_category_ctrl lbText _comboIndex);
		};
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
	};
	case "OK_BUTTON":
	{
		private _item_names = [];
		
		_combo_category = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_0", 0];
		_new_category_name = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", ""];
		_new_item_name = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_2", ""];
		
		_custom_compositions = profileNamespace getVariable ["Achilles_var_compositions",[]];			
		_result = true;
		if (_combo_category == 1) then
		{
			if (_new_category_name == "") exitWith {_result = nil};
			_category_names = _custom_compositions apply {_x select 0};
			_categoryIndex = _category_names find _new_category_name;
			if (_categoryIndex != -1) exitWith {_result = nil};
		} else
		{
			_category_names = _custom_compositions apply {_x select 0};
			_categoryIndex = _category_names find Ares_var_composition_category;
			_category_items = _custom_compositions select _categoryIndex select 1;		
			_item_names = _category_items apply {_x select 0};						
		};
		if (not isNil "_result") then
		{
			if (_new_item_name == "") exitWith {_result = nil};
			_itemIndex = _item_names find _new_item_name;
			if (_itemIndex != -1) exitWith {_result = nil};						
		};
		if (not isNil "_result") exitWith 
		{
			uiNamespace setVariable ['Ares_ChooseDialog_Result', 1];
			closeDialog 1;
		};
		[localize "STR_ENTRY_ALREADY_EXISTS"] call Ares_fnc_ShowZeusMessage; 
		playSound "FD_Start_F";
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};