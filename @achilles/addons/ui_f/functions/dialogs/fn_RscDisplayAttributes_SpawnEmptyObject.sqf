#define IDD_DYNAMIC_GUI		133798
#define IDC_CATEGORY		20000
#define IDC_SUBCATEGORY		20001
#define IDC_OBJECT			20002
/*
 IDD_DYNAMIC_GUI	=	133798;
 IDC_CATEGORY		=20000;
 IDC_TYPE			=20001;
 OTHER_LABEL_IDCs	=[10002,10003,10004];
 OTHER_CTRL_IDCs	=	[20002,20003,20004];
*/

disableSerialization;
params ["_mode", ["_ctrl", controlNull, [controlNull]], ["_comboIndex", 0, [0]]];

private _dialog = findDisplay IDD_DYNAMIC_GUI;

switch (_mode) do
{
	case "LOADED":
	{
		if (isNil "Achilles_var_emptyObjects_allCategoryNames") then
		{
			_unsorted_categoryNames = [];
			_unsorted_subcategoryNames = [];
			_unsorted_objectNames = [];
			_unsorted_objectClasses = [];

			{
				_object_cfg = (configFile >> "CfgVehicles" >> _x);
				_object_name = getText (_object_cfg >> "displayName");
				_object_class = configName _object_cfg;
				if (_object_name != "") then
				{
					_categoryClass = getText (_object_cfg >> "editorCategory");
					_categoryName = getText (configfile >> "CfgEditorCategories" >> _categoryClass >> "displayName");
					_categoryIndex = _unsorted_categoryNames find _categoryName;
					if (_categoryIndex == -1) then
					{
						_categoryIndex = count _unsorted_categoryNames;
						_unsorted_categoryNames pushBack _categoryName;
						_unsorted_subcategoryNames pushBack [];
					};

					_subcategoryClass = getText (_object_cfg >> "editorSubcategory");
					_subcategoryName = getText (configfile >> "CfgEditorSubcategories" >> _categoryClass >> "displayName");
					_subcategory_list = _unsorted_subcategoryNames select _categoryIndex;
					_subcategoryIndex = _subcategory_list find _subcategoryName;
					if (_subcategoryIndex == -1) then
					{
						_subcategoryIndex = count _subcategory_list;
						_unsorted_subcategoryNames = [_unsorted_subcategoryNames,[_categoryIndex],_subcategoryName] call Achilles_fnc_pushBack;
						_unsorted_objectNames = [_unsorted_objectNames,[_categoryIndex],[_object_name]] call Achilles_fnc_pushBack;
						_unsorted_objectClasses = [_unsorted_objectClasses,[_categoryIndex],[_object_class]] call Achilles_fnc_pushBack;
					} else
					{
						_unsorted_objectNames = [_unsorted_objectNames,[_categoryIndex,_subcategoryIndex],_object_name] call Achilles_fnc_pushBack;
						_unsorted_objectClasses = [_unsorted_objectClasses,[_categoryIndex,_subcategoryIndex],_object_class] call Achilles_fnc_pushBack;
					};
				};
			} forEach ((configfile >> "CfgVehicles" >> "Static") call Achilles_fnc_ClassNamesWhichInheritsFromCfgClass);

			Achilles_var_emptyObjects_categoryNames = [];
			Achilles_var_emptyObjects_subcategoryNames = [];
			Achilles_var_emptyObjects_objectNames = [];
			Achilles_var_emptyObjects_objectClasses = [];

			Achilles_var_emptyObjects_categoryNames = [_unsorted_categoryNames,[],{_x},"ASCEND"] call BIS_fnc_sortBy;
			{
				_old_index = _unsorted_categoryNames find _x;


			} forEach Achilles_var_emptyObjects_categoryNames;
		};

		_ctrl = _dialog displayCtrl IDC_CATEGORY;
		lbClear _ctrl;
		{_ctrl lbAdd _x} forEach Achilles_var_emptyObjects_allCategoryNames;
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_0", 0];
		_last_choice = [0, _last_choice] select (_last_choice isEqualType 0);
		_last_choice = [(lbSize _ctrl) - 1, _last_choice] select (_last_choice < lbSize _ctrl);
		_ctrl lbSetCurSel _last_choice;
		[0,_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_SpawnEmptyObject;
	};
	case "0":
	{
		_subcategory_ctrl = _dialog displayCtrl IDC_SUBCATEGORY;
		lbClear _subcategory_ctrl;
		{_subcategory_ctrl lbAdd _x} forEach (Achilles_var_emptyObjects_subcategoryNames select _comboIndex);
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_last_choice = [(lbSize _subcategory_ctrl) - 1, _last_choice] select (_last_choice < lbSize _subcategory_ctrl);
		_last_choice = [0, _last_choice] select (_last_choice isEqualType 0);
		_subcategory_ctrl lbSetCurSel _last_choice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_0", _comboIndex];
		[1,_subcategory_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_SpawnEmptyObject;
	};
	case "1":
	{
		_object_ctrl = _dialog displayCtrl IDC_OBJECT;
		lbClear _object_ctrl;

		_category_ctrl = _dialog displayCtrl IDC_CATEGORY;
		_currentCategory = lbCurSel _category_ctrl;


		{_object_ctrl lbAdd _x} forEach (Achilles_var_emptyObjects_objectNames select _currentCategory select _comboIndex);
		_last_choice = uiNamespace getVariable ["Ares_ChooseDialog_ReturnValue_1", 0];
		_last_choice = [(lbSize _object_ctrl) - 1, _lat_choice] select (_last_choice < lbSize _object_ctrl);
		_last_choice = [0, _last_choice] select (_last_choice isEqualType 0);
		_object_ctrl lbSetCurSel _last_choice;

		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_1", _comboIndex];
		[2,_object_ctrl,_last_choice] call Achilles_fnc_RscDisplayAttributes_SpawnEmptyObject;
	};
	case "2":
	{
		_category_ctrl = _dialog displayCtrl IDC_CATEGORY;
		_currentCategory = lbCurSel _category_ctrl;

		_subcategory_ctrl = _dialog displayCtrl IDC_SUBCATEGORY;
		_currentSubcategory = lbCurSel _subcategory_ctrl;

		Achilles_var_emptyObject = (Achilles_var_emptyObjects_objectClasses select _currentCategory select _currentSubcategory select _comboIndex);
		uiNamespace setVariable ["Ares_ChooseDialog_ReturnValue_2", _comboIndex];
	};
	case "UNLOAD" : {};
	default
	{
		uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _mode], _comboIndex];
	};
};
