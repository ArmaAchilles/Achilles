#define IDD_COMPOSITION_GUI		133799
#define IDC_TREE_CTRL			1400
#define IDC_EDIT_BUTTON			3030
#define IDC_DEL_BUTTON			3020
#define IDC_ADD_BUTTON			3040
#define IDC_OK_BUTTON			3000

/*
 IDD_COMPOSITION_GUI=		133799;
 IDC_TREE_CTRL		=	1400;
 IDC_EDIT_BUTTON	=		3030;
 IDC_DEL_BUTTON		=	3020;
 IDC_ADD_BUTTON		=	3040;
*/

disableSerialization;
params ["_mode", ["_ctrl", controlNull, [controlNull]], ["_treePathSelection", [], [[]]]];

private _dialog = findDisplay IDD_COMPOSITION_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		_ok_ctrl = _dialog displayCtrl IDC_OK_BUTTON;
		_ok_ctrl ctrlRemoveAllEventHandlers "ButtonClick";
		_ok_ctrl ctrlAddEventHandler ["ButtonClick", "if (count (uiNamespace getVariable [""Ares_composition_last_choice"",[]]) == 3) then {uiNamespace setVariable ['Ares_Dialog_Result', 1]; closeDialog 1;}" ];
		{
			_button = _dialog displayCtrl _x;
			_button ctrlShow false;
		} forEach [IDC_EDIT_BUTTON,IDC_DEL_BUTTON,IDC_ADD_BUTTON];

		_tree_ctrl = _dialog displayCtrl IDC_TREE_CTRL;

		_tree_ctrl ctrlAddEventHandler ["TreeSelChanged", "([""SELECTION_CHANGED""] + _this) call Achilles_fnc_RscDisplayAttributes_spawnAdvancedComposition;"];

		_tvPath_ares = [_tree_ctrl tvAdd [[], "Ares"]];
		{
			_tvPath_category = [_tree_ctrl tvAdd [_tvPath_ares, _x select 0]];
			{
				_tvPath_item = [_tree_ctrl tvAdd [_tvPath_ares + _tvPath_category, _x select 0]];
				_tree_ctrl tvSetData [_tvPath_ares + _tvPath_category + _tvPath_item,str (_x select 1)];
			} forEach (_x select 1);
			_tree_ctrl tvSort [_tvPath_ares + _tvPath_category, false];
		} forEach Achilles_var_compositions;
		_tree_ctrl tvSort [_tvPath_ares, false];

		_custom_compositions = profileNamespace getVariable ["Achilles_var_compositions",[]];

		if (count _custom_compositions > 0) then
		{
			_tvPath_custom = [_tree_ctrl tvAdd [[], "Custom"]];
			{
				_tvPath_category = [_tree_ctrl tvAdd [_tvPath_custom, _x select 0]];
				{
					_tvPath_item = [_tree_ctrl tvAdd [_tvPath_custom + _tvPath_category, _x select 0]];
					_tree_ctrl tvSetData [_tvPath_custom + _tvPath_category + _tvPath_item,str (_x select 1)];
				} forEach (_x select 1);
				_tree_ctrl tvSort [_tvPath_custom + _tvPath_category, false];
			} forEach (_custom_compositions);
			_tree_ctrl tvSort [_tvPath_custom, false];
		};
		_last_choice = uiNamespace getVariable ["Ares_composition_last_choice", []];
		if (count _last_choice == 3) then
		{
			_categoryCount = _tree_ctrl tvCount [_last_choice select 0];
			if (_categoryCount < (_last_choice select 1)) then {_last_choice set [1, _categoryCount - 1]};
			_itemCount = _tree_ctrl tvCount [_last_choice select 0, _last_choice select 1];
			if (_itemCount < (_last_choice select 2)) then {_last_choice set [2, _itemCount - 1]};
			_tree_ctrl tvExpand [_last_choice select 0];
			_tree_ctrl tvExpand [_last_choice select 0, _last_choice select 1];
		};
		_tree_ctrl tvSetCurSel _last_choice;
	};
	case "SELECTION_CHANGED":
	{
		_tree_ctrl = _ctrl;
		Ares_var_current_composition = (_tree_ctrl tvData _treePathSelection);
		uiNamespace setVariable ["Ares_composition_last_choice", _treePathSelection];
	};
	case "UNLOAD" : {};
};
