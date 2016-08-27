
#define IDD_COMPOSITION_GUI		133799
#define IDC_TREE_CTRL			1400
#define IDC_OK_BUTTON			3000
#define IDC_CANCLE_BUTTON		3010
#define IDD_MESSAGE				999
#define IDC_TITLE				235100
#define IDC_TEXT_WARNING		235102
#define IDC_CONFIRM_WARNING		235106
#define IDC_CANCLE_WARNING		235107

/*
 IDD_MESSAGE		=	999;
 IDD_COMPOSITION_GUI=	133799;
 IDC_TREE_CTRL		=	1400;
 IDC_OK_BUTTON		=	3000;
 IDC_TITLE			=	235100;
 IDC_TEXT_WARNING			=	235102;
 IDC_CONFIRM_WARNING		=		235106;
 IDC_CANCLE_WARNING			=	235107;
*/

disableSerialization;

private ["_mode", "_ctrl", "_comboIndex","_item_name","_item_details","_categoryName"];

_mode = _this select 0;
_ctrl = param [1,controlNull,[controlNull]];
_treePathSelection = param [2,[],[[]]];

_dialog = findDisplay IDD_COMPOSITION_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		_cancle_ctrl = _dialog displayCtrl IDC_CANCLE_BUTTON;
		_cancle_ctrl ctrlRemoveAllEventHandlers "ButtonClick";
		_cancle_ctrl ctrlAddEventHandler ["ButtonClick", "saveProfileNamespace; hint localize ""STR_CHANGES_SAVED""; closeDialog 2;"];
		_dialog displayAddEventHandler ["KeyDown", "if (_this select 1 == 1) then {saveProfileNamespace; hint localize ""STR_CHANGES_SAVED"";}"];
		
		_button = _dialog displayCtrl IDC_OK_BUTTON;
		_button ctrlShow false;
		
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
	case "NEW_BUTTON":
	{
		[] spawn 
		{
			if (true) then 
			{
				closeDialog 0;
				_center_object = ([localize "STR_BASIS_OBJECT"] call Achilles_fnc_SelectUnits) select 0;
				if (isNil "_center_object") exitWith {};
				if (isNull _center_object) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};

				_objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits;
				if (isNil "_objects") exitWith {};
				if (count _objects == 0) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};	

				
				_center_pos = getPosWorld _center_object;
				_dir = direction _center_object;
				_type = typeOf _center_object;
				_composition_details = [[_type, [0,0,0], _dir, false]];

				{
						_dir = direction _x;
						_type = typeOf _x;
						_pos_diff = (getPosWorld _x) vectorDiff _center_pos;
						_enableSimulation = if (_x isKindOf "AllVehicles") then {true} else {false};
						_enableSimulation = _x getVariable ["enabledSimulation", _enableSimulation];
						_composition_details pushBack [_type, _pos_diff, _dir, _enableSimulation];
				} forEach (_objects - [_center_object]);
				
				_dialogResult = 
				[
					localize "STR_ADVANCED_COMPOSITION",
					[
						[localize "STR_CATEGORY", [localize "STR_LOADING_"]],
						[localize "STR_NEW_CATEGORY", ""],
						[localize "STR_NAME", "", "MyFirstComposition"]
					],
					"Achilles_fnc_RscDisplayAttributes_createAdvancedComposition"
				] call Ares_fnc_ShowChooseDialog;
				
				if (count _dialogResult > 0) then
				{					
					if (_dialogResult select 0 == 0) then
					{
						["ADD",controlNull,[],_dialogResult select 2,_composition_details,_dialogResult select 1] call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;
					} else
					{
						["ADD",controlNull,[],_dialogResult select 2,_composition_details] call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;
					};
				};
			};
			createDialog "Ares_composition_Dialog";
			["LOADED"] call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;
		};
	};
	case "EDIT_BUTTON":
	{
		[] spawn
		{
			if (true) then
			{
				disableSerialization;
				_tvPath = uiNamespace getVariable ["Ares_composition_last_choice", []];
				if (_tvPath select 0 == 0) exitWith {closeDialog 0;};
				if (count _tvPath < 3) exitWith {closeDialog 0;};
				_dialog = findDisplay IDD_COMPOSITION_GUI;
				_tree_ctrl = _dialog displayCtrl IDC_TREE_CTRL;
				_item_name = _tree_ctrl tvText _tvPath;
				_item_details = call compile (_tree_ctrl tvData _tvPath);
				_category_name = _tree_ctrl tvText [_tvPath select 0, _tvPath select 1];
				closeDialog 0;
				
				_dialogResult = 
				[
					localize "STR_ADVANCED_COMPOSITION",
					[
						[localize "STR_CATEGORY", [_category_name]],
						[localize "STR_NEW_CATEGORY", ""],
						[localize "STR_NAME", "", _item_name]
					],
					"Achilles_fnc_RscDisplayAttributes_editAdvancedComposition"
				] call Ares_fnc_ShowChooseDialog;
				
				if (count _dialogResult == 0) exitWith {};
				if (_dialogResult select 0 == 1) then
				{
					["ADD",controlNull,[],_dialogResult select 2,_item_details,_dialogResult select 1] call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;
				} else
				{
					["ADD",controlNull,[],_dialogResult select 2,_item_details] call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;
				};
				["REMOVE",controlNull,[],_category_name,_item_name] call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;
			};
			waitUntil {!dialog};
			createDialog "Ares_composition_Dialog";
			["LOADED"] spawn Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;
		};	
	};
	case "DELETE_BUTTON":
	{
		[] spawn
		{
			if (true) then
			{
				_tvPath = uiNamespace getVariable ["Ares_composition_last_choice", []];
				if (_tvPath select 0 == 0) exitWith {closeDialog 0;};
				if (count _tvPath < 3) exitWith {closeDialog 0;};
				_dialog = findDisplay IDD_COMPOSITION_GUI;
				_tree_ctrl = _dialog displayCtrl IDC_TREE_CTRL;
				_item_name = _tree_ctrl tvText _tvPath;
				_item = [_item_name, call compile (_tree_ctrl tvData _tvPath)];
				_category_name = _tree_ctrl tvText [_tvPath select 0, _tvPath select 1];
				closeDialog 0;
				
				createDialog "RscDisplayCommonMessage";
				_dialog = findDisplay IDD_MESSAGE;
				(_dialog displayCtrl IDC_TITLE) ctrlSetText (localize "STR_DELETE_COMPOSITION");
				(_dialog displayCtrl IDC_TEXT_WARNING) ctrlSetText (format [localize "STR_DO_YOU_WANT_TO_DELETE_X", _item_name]);
				
				(_dialog displayCtrl IDC_CONFIRM_WARNING) ctrlAddEventHandler ["ButtonClick","([""REMOVE"",controlNull,[]," + str _category_name + "," + str _item_name  + "]) call Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition; closeDialog 1;"];
				(_dialog displayCtrl IDC_CANCLE_WARNING) ctrlAddEventHandler ["ButtonClick", "closeDialog 2;"];
			};
			waitUntil {!dialog};
			createDialog "Ares_composition_Dialog";
			["LOADED"] spawn Achilles_fnc_RscDisplayAttributes_manageAdvancedComposition;
		};
	};
	case "ADD":
	{
		_item_name = _this select 3;
		_item_details = _this select 4;
		_categoryName = param [5,"",[""]];
		
		_custom_compositions = profileNamespace getVariable ["Achilles_var_compositions",[]];
		
		if (_categoryName != "") then
		{
			_custom_compositions pushBack [_categoryName, [[_item_name, _item_details]]];
		} else
		{
			_custom_categories = _custom_compositions apply {_x select 0};
			_category_index = _custom_categories find Ares_var_composition_category;
			_category_details = _custom_compositions select _category_index;
			_category_details set [1, (_category_details select 1) + [[_item_name, _item_details]]];
			_custom_categories set [_category_index,_category_details];
		};
		profileNamespace setVariable ["Achilles_var_compositions",_custom_compositions];
		
	};
	case "REMOVE":
	{
		_category_name = _this select 3;
		_item_name = _this select 4;
		
		_custom_compositions = profileNamespace getVariable ["Achilles_var_compositions",[]];
		_category_names = _custom_compositions apply {_x select 0};
		_categoryIndex = _category_names find _category_name;
		_category_items = _custom_compositions select _categoryIndex select 1;
		if (count _category_items == 1) then
		{
			if (count _custom_compositions == 0) then
			{
				_custom_compositions = [];
			} else
			{
				_custom_compositions set [_categoryIndex, -1];
				_custom_compositions = _custom_compositions - [-1];
			};
		} else
		{
			_item_names = (_custom_compositions select _categoryIndex select 1) apply {_x select 0};
			_itemIndex = _item_names find _item_name;
			_category_items set [_itemIndex, -1];
			_category_items = _category_items - [-1];
			_custom_compositions set [_categoryIndex, [_category_name,_category_items]];
		};
		profileNamespace setVariable ["Achilles_var_compositions",_custom_compositions];		
	};
	case "UNLOAD" : {};
};