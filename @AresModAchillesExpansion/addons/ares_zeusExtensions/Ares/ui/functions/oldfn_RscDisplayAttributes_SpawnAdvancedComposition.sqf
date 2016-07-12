
#define IDD_DYNAMIC_GUI		133798
#define IDC_AUTHOR			20000
#define IDC_CATEGORIES		20001
#define IDC_ITEMS			20002

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
		for "_i" from 0 to 2 do
		{
			_ctrl = _dialog displayCtrl (IDC_AUTHOR + _i);
			_last_choice = uiNamespace getVariable [format ["Ares_ChooseDialog_ReturnValue_%1", _i], 0];
			_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
			_ctrl lbSetCurSel _last_choice;
			if (_i == 0) then
			{
				[0,_ctrl,_last_choice] call Ares_fnc_RscDisplayAttributes_SpawnAdvancedComposition;
			};
		};
	};
	case "0":
	{
		_category_ctrl = _dialog displayCtrl IDC_CATEGORIES;
		
		_composition_category_names = [];
		_composition_category_item_lists = [];
		if (_comboIndex == 0) then
		{
			{
				_composition_category_names pushBack (_x select 0);
				_composition_category_item_lists pushBack (_x select 1);
			} forEach Achilles_var_compositions;
		} else
		{
			{
				_composition_category_names pushBack (_x select 0);
				_composition_category_item_lists pushBack (_x select 1);
			} forEach (profileNamespace getVariable ["Achilles_var_compositions",[]]);
		};
		_dialog setVariable ["composition_category_item_lists",_composition_category_item_lists];
		
		lbClear _category_ctrl;
		if (count _composition_category_names == 0) then
		{
			_category_ctrl lbAdd (localize "STR_EMPTY");
		} else
		{
			{_category_ctrl lbAdd _x} forEach _composition_category_names;
		};
		
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_last_choice = if (_last_choice < lbSize _category_ctrl) then {_last_choice} else {(lbSize _category_ctrl) - 1};
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_category_ctrl lbSetCurSel _last_choice;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
		[1,_category_ctrl,_last_choice] call Ares_fnc_RscDisplayAttributes_SpawnAdvancedComposition;	
	};
	case "1":
	{
		_category_ctrl = _ctrl;
		_items_ctrl = _dialog displayCtrl IDC_ITEMS;
		
		_composition_category_item_lists = _dialog getVariable ["composition_category_item_lists", []];
		_composition_item_list = _composition_category_item_lists select _comboIndex;
		
		_item_names = [];
		_item_info_lists = [];
		{
			_item_names pushBack (_x select 0);
			_item_info_lists pushBack (_x select 1);
		} forEach _composition_item_list;
		
		_dialog setVariable ["item_info_lists",_item_info_lists];
		
		lbClear _items_ctrl;
		if (count _item_names == 0) then
		{
			_items_ctrl lbAdd (localize "STR_EMPTY");
		} else
		{
			{_items_ctrl lbAdd _x} forEach _item_names;
		};
		
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_2", 0];
		_last_choice = if (_last_choice < lbSize _items_ctrl) then {_last_choice} else {(lbSize _items_ctrl) - 1};
		_last_choice = if (typeName _last_choice == "SCALAR") then {_last_choice} else {0};
		_items_ctrl lbSetCurSel _last_choice;
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_1", _comboIndex];
		[2,_items_ctrl,_last_choice] call Ares_fnc_RscDisplayAttributes_SpawnAdvancedComposition;		
	};
	case "2":
	{
		_item_info_lists = _dialog getVariable ["item_info_lists",[]];
		Ares_var_current_composition = if (count _item_info_lists != 0) then {_item_info_lists select _comboIndex} else {nil};
		
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_2", _comboIndex];
	};
	case "UNLOAD" : {};
	default 
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};