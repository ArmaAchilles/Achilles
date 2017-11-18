/*
	by Kex, based on Ares_fnc_showChooseDialog
	Displays a dialog that prompts the user to choose an option from a set of combo boxes.
	If the dialog has a title then the default values provided will be used the FIRST time a dialog is displayed, and the selected values remembered for the next time it is displayed.

	Params:
		0 - String - (default: "") The title to display for the combo box. Do not use non-standard characters (e.g. %&$*()!@#*%^&) that cannot appear in variable names
		1 - Array of Arrays - Each array represents a control.
		2 - String - (default: "") 	optionally a function can be given as an argument which will be executed as an combobox event handler when the selection is changed with params [<choice index>,<control>,<new selection index>]
									in addition the function will be executed when the dialog was opened or closed with parameter ["LOADED", _dialog] respective ["UNLOAD", _dialog]
	Returns:
		An array containing the results

	Note: Check Achilles Wiki for more details on params and returns: https://github.com/oOKexOo/AresModAchillesExpansion/wiki/Custom-Modules
*/

#include "AchillesDynamicDialog.h"

disableSerialization;

params [["_title_text","",[""]], ["_control_info",[],[[]]], ["_resource_fnc","",[""]]];

// Bring up the dialog frame we are going to add things to.
createDialog "Ares_Dynamic_Dialog";
private _dialog = findDisplay DYNAMIC_GUI_IDD;

// calculate dialog height
private _tot_height = 0;
{
	_x params [["_control_type","",[""]]];
	switch (_control_type) do
	{
		case "ALLSIDES"; case "SIDES": {_tot_height = _tot_height + GtC_H(4.1)};
		case "MESSAGE"; case "SCRIPT": {_tot_height = _tot_height + TOTAL_ROW_HEIGHT + 4*COMBO_HEIGHT};
		default {_tot_height = _tot_height + TOTAL_ROW_HEIGHT};
	};
} forEach _control_info;
if (_tot_height > MAX_ROW_Y) then {_tot_height = MAX_ROW_Y};

// adjust ctrl group accordingly
private _yCoord = _tot_height + TOTAL_ROW_HEIGHT + GtC_H(0.4);
private _ctrl_group = _dialog displayCtrl DYNAMIC_CTRL_GROUP;
private _pos = ctrlPosition _ctrl_group;
_pos set [3,_yCoord-(_pos select 1)];
_ctrl_group ctrlSetPosition _pos;
_ctrl_group ctrlCommit 0;

// adjust dialog bottom accordingly
_yCoord = _yCoord + GtC_H(0.4);
{
	private _bottomCtrl = _dialog displayCtrl _x;
	_pos = ctrlPosition _bottomCtrl;
	_pos set [1,_yCoord];
	_bottomCtrl ctrlSetPosition _pos;
	_bottomCtrl ctrlCommit 0;
} forEach DYNAMIC_BOTTOM_IDCs;

// Resize the background accordingly
_yCoord = _yCoord + TOTAL_ROW_HEIGHT;
private _background = _dialog displayCtrl DYNAMIC_BG_IDC;
_pos = ctrlPosition _background;
_pos set [3,_yCoord-(_pos select 1)];
_background ctrlSetPosition _pos;
_background ctrlCommit 0;

// set dialog title
if (_title_text != "") then
{
	private _ctrlTitle = _dialog displayCtrl DYNAMIC_TITLE_IDC;
	_ctrlTitle ctrlSetText _title_text;
};

// Set the start offset for the controls
_yCoord = START_ROW_Y;

// Get the ID for use when looking up previously selected values.
private _title_text_varName = _title_text call Achilles_fnc_TextToVariableName;
private _titleVariableIdentifier = format ["Ares_ChooseDialog_DefaultValues_%1", _title_text_varName];

// Iterate through control info list
{
	_x params [["_control_type","",[""]], ["_label_data","",["",[]]], ["_data",[],[[]]], ["_default_choice",0,[0,"",[]]], ["_force_default",false,[false]], ["_event_handlers",[],[[]]]];
	_control_type = toUpper _control_type;

	// If this dialog is named, attempt to get the default value from a previously displayed version
	private _defaultVariableId = format["%1_%2", _titleVariableIdentifier, _forEachIndex];
	if (_title_text != "" and {!_force_default}) then
	{
		_default_choice = uiNamespace getVariable [_defaultVariableId, _default_choice];
	};

	// create the control
	switch (_control_type) do
	{
		case "COMBOBOX":
		{
			// Create a label
			_label_data params [["_label_text","",[""]], ["_tooltip_text","",[""]]];
			private _ctrl_label = _dialog ctrlCreate ["RscText", BASE_IDC_LABEL + _forEachIndex, _ctrl_group];
			_ctrl_label ctrlSetText _label_text;
			_ctrl_label ctrlSetTooltip _tooltip_text;
			_ctrl_label ctrlSetBackgroundColor LABEL_BG_COLOR;
			_ctrl_label ctrlSetPosition [LABEL_COLUMN_X, _yCoord, LABEL_WIDTH, LABEL_HEIGHT];
			_ctrl_label ctrlCommit 0;

			// Create the combo box
			private _ctrl_cb = _dialog ctrlCreate ["RscCombo", BASE_IDC_CTRL + _forEachIndex, _ctrl_group];
			_ctrl_cb ctrlSetPosition [COMBO_COLUMN_X, _yCoord+LABEL_COMBO_DELTA_Y, COMBO_WIDTH, COMBO_HEIGHT];
			{
				_x params [["_entry_text_L","",[""]], ["_entry_text_R","",[""]], ["_str_data","",[""]]];
				private _id = _ctrl_cb lbAdd _entry_text_L;
				_ctrl_cb lbSetTextRight [_id, _entry_text_R + " "];
				_ctrl_cb lbSetData [_id, _str_data];
			} forEach _data;
			_ctrl_cb ctrlCommit 0;

			// Adjust default choice if it is invalid and select the current choice
			[(lbSize _ctrl_cb) - 1, _default_choice] select (_default_choice < lbSize _ctrl_cb);
			_ctrl_cb lbSetCurSel _default_choice;

			// Set the current choice in a global variable and update the default value as well
			uiNamespace setVariable [_defaultVariableId, _default_choice];
			uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _forEachIndex], _ctrl_cb lbData _default_choice];

			// add event handlers: 1) update global choice variables
			private _combo_script = "params [""_ctrl"", ""_id""]; uiNamespace setVariable [" + str _defaultVariableId + ", _id];";
			_combo_script = _combo_script + "uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1'," + str _forEachIndex + "], _ctrl lbData _id];";
			_ctrl_cb ctrlSetEventHandler["LBSelChanged", _combo_script];
			// add event handlers: 2) custom
			{
				_x params ["_keyword", "_script"];
				_ctrl_cb ctrlAddEventHandler [_keyword, _script];
			} forEach _event_handlers;

			// Move to the next control
			_yCoord = _yCoord + TOTAL_ROW_HEIGHT;
		};
		case "SLIDER":
		{
			// Create a label
			_label_data params [["_label_text","",[""]], ["_tooltip_text","",[""]]];
			private _ctrl_label = _dialog ctrlCreate ["RscText", BASE_IDC_LABEL + _forEachIndex, _ctrl_group];
			_ctrl_label ctrlSetText _label_text;
			_ctrl_label ctrlSetTooltip _tooltip_text;
			_ctrl_label ctrlSetBackgroundColor LABEL_BG_COLOR;
			_ctrl_label ctrlSetPosition [LABEL_COLUMN_X, _yCoord, LABEL_WIDTH, LABEL_HEIGHT];
			_ctrl_label ctrlCommit 0;

			// Create the slider
			private _ctrl_slider = _dialog ctrlCreate ["RscAchillesXSliderH", BASE_IDC_CTRL + _forEachIndex, _ctrl_group];
			_ctrl_slider ctrlSetPosition [COMBO_COLUMN_X, _yCoord+LABEL_COMBO_DELTA_Y, COMBO_WIDTH, COMBO_HEIGHT];
			_data params [["_slider_range", [0,1], [[]]], ["_slider_speed", [1,3], [[]]]];
			_ctrl_slider sliderSetRange _slider_range;
			_ctrl_slider sliderSetSpeed _slider_speed;
			_ctrl_slider ctrlCommit 0;

			// Adjust default choice if it is invalid and select the current choice
			_default_choice = linearConversion (_slider_range + [_default_choice] + _slider_range + [true]);
			_ctrl_slider sliderSetPosition _default_choice;
			_ctrl_slider ctrlSetTooltip str _default_choice;

			// Set the current choice in a global variable and update the default value as well
			uiNamespace setVariable [_defaultVariableId, _default_choice];
			uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _forEachIndex], _default_choice];

			// add event handlers: 1) update global choice variables
			private _combo_script = "params [""_ctrl"", ""_value""]; uiNamespace setVariable [" + str _defaultVariableId + ", _value];";
			_combo_script = _combo_script + "uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1'," + str _forEachIndex + "], _value];";
			_combo_script = _combo_script + "_ctrl ctrlSetTooltip str _value;";
			_ctrl_slider ctrlSetEventHandler["SliderPosChanged", _combo_script];
			// add event handlers: 2) custom
			{
				_x params ["_keyword", "_script"];
				_ctrl_slider ctrlAddEventHandler [_keyword, _script];
			} forEach _event_handlers;

			// Move to the next control
			_yCoord = _yCoord + TOTAL_ROW_HEIGHT;

		};
		case "TEXT"; case "MESSAGE"; case "SCRIPT":
		{
			// select params
			private _control_class = "RscAchillesEdit";
			private _add_height = 0;
			if (_control_type != "TEXT") then
			{
				if (_control_type == "MESSAGE") then
				{
					_control_class = "RscAchillesMessageEdit";
				} else
				{
					_control_class = "RscAchillesScriptEdit";
				};
				_add_height = 4*COMBO_HEIGHT;
			};

			// Create a label
			_label_data params [["_label_text","",[""]], ["_tooltip_text","",[""]]];
			private _ctrl_label = _dialog ctrlCreate ["RscText", BASE_IDC_LABEL + _forEachIndex, _ctrl_group];
			_ctrl_label ctrlSetText _label_text;
			_ctrl_label ctrlSetTooltip _tooltip_text;
			_ctrl_label ctrlSetBackgroundColor LABEL_BG_COLOR;
			_ctrl_label ctrlSetPosition [LABEL_COLUMN_X, _yCoord, LABEL_WIDTH, LABEL_HEIGHT + _add_height];
			_ctrl_label ctrlCommit 0;

			// Create the edit control
			private _ctrl_edit = _dialog ctrlCreate [_control_class, BASE_IDC_CTRL + _forEachIndex, _ctrl_group];
			_ctrl_edit ctrlSetPosition [COMBO_COLUMN_X, _yCoord+LABEL_COMBO_DELTA_Y, COMBO_WIDTH, COMBO_HEIGHT + _add_height];
			_ctrl_edit ctrlCommit 0;

			// Adjust default choice if it is invalid and select the current choice
			if (!(_default_choice isEqualType "")) then {_default_choice = ""};
			_ctrl_edit ctrlSetText _default_choice;

			// Set the current choice in a global variable and update the default value as well
			uiNamespace setVariable [_defaultVariableId, _default_choice];
			uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1", _forEachIndex], _default_choice];

			// add event handlers: 1) update global choice variables
			private _combo_script = "params [""_ctrl"", ""_value""]; uiNamespace setVariable [" + str _defaultVariableId + ", ctrlText _ctrl];";
			_combo_script = _combo_script + "uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1'," + str _forEachIndex + "], ctrlText _ctrl];";
			_ctrl_edit ctrlSetEventHandler["KeyUp", _combo_script];
			// add event handlers: 2) custom
			{
				_x params ["_keyword", "_script"];
				_ctrl_edit ctrlAddEventHandler [_keyword, _script];
			} forEach _event_handlers;

			// Move to the next control
			_yCoord = _yCoord + TOTAL_ROW_HEIGHT + _add_height;
		};
		case "SIDES"; case "ALLSIDES":
		{
		};
	};
} forEach _control_info;

// set display event handlers
if (_resource_fnc != "") then
{
	call compile ("[""LOADED"", " + _dialog + "] call %1;" + _resource_fnc + "];");
	_dialog displayAddEventHandler ["unLoad", "Achilles_var_showChooseDialog = nil; _this call compile format[""['UNLOAD', _this] call %1;"", " + _resource_fnc + "];"];
} else
{
	_dialog displayAddEventHandler ["unLoad", "Achilles_var_showChooseDialog = nil;"];
};

// initialize display status variables and wait for closing the dialog
uiNamespace setVariable ["Ares_ChooseDialog_Result", -1];
Achilles_var_showChooseDialog = true;
waitUntil { isNil "Achilles_var_showChooseDialog" };

// Check whether the user confirmed the selection or not, and return the appropriate values.
private _return_values = [];
if (uiNamespace getVariable "Ares_ChooseDialog_Result" == 1) then
{
	for "_i" from 0 to (count _control_info - 1) do
	{
		private _return_value = uiNamespace getVariable format ["Ares_ChooseDialog_ReturnValue_%1", _i];
		if (_return_value isEqualType "" and {_return_value == ""}) then
		{
			_defaultVariableId = format["%1_%2", _titleVariableIdentifier, _i];
			_return_value = uiNamespace getVariable _defaultVariableId;
		};
		_return_values pushBack _return_value;
	};
};
_return_values
