#define DIALOG_CLASS_NAME		"Achilles_rsc_loadSave"
#define IDC_TAB_SELECTION		3000
#define IDC_DATA_TREE			2010
#define IDC_CUSTOM_BUTTON		3050
#define IDCS_SAFE_SEC_BUTTONS	[3060, 3070, 3080]
#define SAVE_SECTION_SEL_IDX	1

disableSerialization;
params
[
	"_mode",
	["_uiElement", controlNull, [controlNull, displayNull]], 
	["_params", nil, []]
];

private _dialog = displayNull;
private _ctrl = controlNull;
if (_uiElement isEqualType displayNull) then 
{
	_dialog = _uiElement;
}
else
{
	_ctrl = _uiElement;
	_dialog = ctrlParent _ctrl;
};

switch (_mode) do
{
	case "LOAD":
	{
		private _ctrl = _dialog displayCtrl IDC_TAB_SELECTION;
		_ctrl lbSetCurSel SAVE_SECTION_SEL_IDX;
		["SWITCH_TAB", _ctrl, SAVE_SECTION_SEL_IDX] call Achilles_fnc_RscDisplayAttributes_loadSave;
		
		private _ctrl_tree = _dialog displayCtrl IDC_DATA_TREE;
		private _data = uiNamespace getVariable ["Achilles_var_rscLoadSaveData", []];
		for "_i_cat" from 0 to (count _data - 1) do
		{
			(_data select _i_cat) params ["_catName", ["_catData", []]];
			_ctrl_tree tvAdd [[], _catName];
			_ctrl_tree tvSetValue [[_i_cat], 0];
			for "_i_subcat" from 0 to (count _catData - 1) do
			{
				(_catData select _i_subcat) params ["_subcatName", ["_subcatData", []]];
				_ctrl_tree tvAdd [[_i_cat], _subcatName];
				_ctrl_tree tvSetValue [[_i_cat, _i_subcat], _i_cat];
				for "_i_item" from 0 to (count _subcatData - 1) do
				{
					(_subcatData select _i_item) params ["_itemName"];
					_ctrl_tree tvAdd [[_i_cat, _i_subcat], _itemName];
					_ctrl_tree tvSetValue [[_i_cat, _i_subcat, _i_item], _i_cat];
				};
			};
		};
	};
	case "PICTURE_BUTTON_FOCUSED":
	{
		private _ctrl_background = _dialog displayCtrl (ctrlIDC _ctrl + 1);
		_ctrl ctrlSetTextColor [0,0,0,1];
		_ctrl ctrlSetActiveColor [0,0,0,1];
		_ctrl_background ctrlSetBackgroundColor [1,1,1,1];
	};
	case "PICTURE_BUTTON_KILLED":
	{
		private _ctrl_background = _dialog displayCtrl (ctrlIDC _ctrl + 1);
		_ctrl ctrlSetTextColor [1,1,1,1];
		_ctrl ctrlSetActiveColor [1,1,1,1];
		_ctrl_background ctrlSetBackgroundColor [0,0,0,1];
	};
	case "SWITCH_TAB":
	{
		_params params ["_newSelIdx"];
		private _isSaveSection = _newSelIdx isEqualTo SAVE_SECTION_SEL_IDX;
		{
			(_dialog displayCtrl _x) ctrlShow _isSaveSection;
			(_dialog displayCtrl (_x + 1)) ctrlShow _isSaveSection;
		} forEach IDCS_SAFE_SEC_BUTTONS;
		private _ctrl_button = _dialog displayCtrl IDC_CUSTOM_BUTTON;
		_ctrl_button ctrlShow not _isSaveSection;
		_ctrl_button ctrlSetText (getArray (configfile >> DIALOG_CLASS_NAME >> "controls" >> ctrlClassName _ctrl >> "strings") select _newSelIdx);
	};
	case "CUSTOM_BUTTON_CLICK":
	{
		private _ctrl_tree = _dialog displayCtrl IDC_DATA_TREE;
		(tvCurSel _ctrl_tree) params ["_i_cat", ["_i_subcat", -1], ["_i_item", -1]];
		switch (lbCurSel (_dialog displayCtrl IDC_TAB_SELECTION)) do
		{
			case 0: // save
			{
			};
			case 2: // import
			{
			};
			case 3: // export
			{
				private _clipboard = "";
				if (_i_cat >= 0) then
				{
					private _data = uiNamespace getVariable ["Achilles_var_rscLoadSaveData", []];
					if (_i_subcat >= 0) then
					{
						(_data select _i_cat) params ["_catName", ["_catData", []]];
						if (_i_item >= 0) then
						{
							(_catData select _i_subcat) params ["_subcatName", ["_subcatData", []]];
							_clipboard = str [[_catName, [[_subcatName, [_subcatData select _i_item]]]]];
						}
						else
						{
							_clipboard = str [[_catName, [_catData select _i_subcat]]];
						};
					}
					else
					{
						_clipboard = str [_data select _i_cat];
					};
				};
				uiNamespace setVariable ["Ares_CopyPaste_Dialog_Text", _clipboard];
				private _dialog = createDialog "Ares_CopyPaste_Dialog";
			};
		};
	};
	case "CREATE_BUTTON_CLICK":
	{
		["PICTURE_BUTTON_FOCUSED", _ctrl] call Achilles_fnc_RscDisplayAttributes_loadSave;
	};
	case "EDIT_BUTTON_CLICK":
	{
		["PICTURE_BUTTON_FOCUSED", _ctrl] call Achilles_fnc_RscDisplayAttributes_loadSave;
	};
	case "DELETE_BUTTON_CLICK":
	{
		["PICTURE_BUTTON_FOCUSED", _ctrl] call Achilles_fnc_RscDisplayAttributes_loadSave;
	};
	case "UNLOAD":
	{
	};
};
