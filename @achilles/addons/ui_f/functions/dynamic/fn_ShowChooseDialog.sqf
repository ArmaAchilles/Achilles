/*
	by Anton Struyk (extended by Kex)
	Displays a dialog that prompts the user to choose an option from a set of combo boxes.
	If the dialog has a title then the default values provided will be used the FIRST time a dialog is displayed, and the selected values remembered for the next time it is displayed.

	Params:
		0 - String - (default: "") The title to display for the combo box. Do not use non-standard characters (e.g. %&$*()!@#*%^&) that cannot appear in variable names
		1 - Array of Arrays - The set of choices to display to the user. Each element in the array should be an array in the following format: ["Choice Description", ["Choice1", "Choice2", etc...]] optionally the last element can be a number that indicates which element to select. For example: ["Choose A Pie", ["Apple", "Pumpkin"], 1] will have "Pumpkin" selected by default. If you replace the choices with a string then a textbox (with the string as default) will be displayed instead.
		2 - String - (default: "") 	optionally a function can be given as an argument which will be executed as an combobox event handler when the selection is changed with params [<choice index>,<control>,<new selection index>]
									in addition the function will be executed when the dialog was opened or closed with parameter ["LOADED"] respective ["UNLOAD"]
	Returns:
		An array containing the indices of each of the values chosen, or a null object if nothing was selected.
*/
disableSerialization;

private ["_defaultChoice","_defaultVariableId"];
params [["_titleText", "", [""]], ["_choicesArray", ["placeholder"], ["", []]], ["_ResourceScript", "", [""]]];

/*
if ((count _this) == 2 && (_choicesArray select 0) isEqualType "") then
{
	// Person is using the 'short' alternate syntax. Automatically wrap in another array.
	_choicesArray = [_this select 1];
};
*/

// Define some constants for us to use when laying things out.
#define GUI_GRID_X		(0)
#define GUI_GRID_Y		(0)
#define GUI_GRID_W		(0.025)
#define GUI_GRID_H		(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

//converts GUI grid to GUI coordinates
#define GtC_X(GRID)				GRID * GUI_GRID_W + GUI_GRID_X
#define GtC_Y(GRID)				GRID * GUI_GRID_H + GUI_GRID_Y
#define GtC_W(GRID)				GRID * GUI_GRID_W
#define GtC_H(GRID)				GRID * GUI_GRID_H

#define DYNAMIC_GUI_IDD			133798
#define DYNAMIC_TITLE_IDC		1000
#define DYNAMIC_BG_IDC			2000
#define DYNAMIC_CTRL_GROUP		7000
#define	DYNAMIC_BOTTOM_IDCs		[2010,3000,3010]

#define BG_WIDTH				(40 * GUI_GRID_W)
#define START_ROW_Y				(0 * GUI_GRID_H + GUI_GRID_Y)
#define MAX_ROW_Y				(29.4 * GUI_GRID_H + GUI_GRID_Y)
#define LABEL_COMBO_DELTA_Y		(0.5 * GUI_GRID_H + GUI_GRID_Y)
#define LABEL_COLUMN_X			(0.5 * GUI_GRID_W + GUI_GRID_X)
#define LABEL_WIDTH				(39 * GUI_GRID_W)
#define LABEL_HEIGHT			(2 * GUI_GRID_H)

#define COMBO_COLUMN_X			(16 * GUI_GRID_W + GUI_GRID_X)
#define COMBO_WIDTH				(22.5 * GUI_GRID_W)
#define COMBO_HEIGHT			(1 * GUI_GRID_H)
#define OK_BUTTON_X				(29.5 * GUI_GRID_W + GUI_GRID_X)
#define OK_BUTTON_WIDTH			(4 * GUI_GRID_W)
#define OK_BUTTON_HEIGHT		(1.5 * GUI_GRID_H)
#define CANCEL_BUTTON_X			(34 * GUI_GRID_W + GUI_GRID_X)
#define CANCEL_BUTTON_WIDTH		(4.5 * GUI_GRID_W)
#define CANCEL_BUTTON_HEIGHT	(1.5 * GUI_GRID_H)
#define TOTAL_ROW_HEIGHT		(2.1 * GUI_GRID_H)

#define BASE_IDC_LABEL			(10000)
#define BASE_IDC_CTRL			(20000)
#define BASE_IDC_ADDITONAL		(30000)
#define SIDE_BASE_IDC			(12000)

// Bring up the dialog frame we are going to add things to.
createDialog "Ares_Dynamic_Dialog";
private _dialog = findDisplay DYNAMIC_GUI_IDD;

// translate the bottom line of the dialog
private _row_heights = _choicesArray apply
{
	_choices = _x select 1;
	switch (_choices) do
	{
		case "ALLSIDE"; case "SIDE": {GtC_H(4.1)};
		case "MESSAGE": {TOTAL_ROW_HEIGHT + 4*COMBO_HEIGHT};
		default {TOTAL_ROW_HEIGHT};
	};
};
private _tot_height = _row_heights call Achilles_fnc_sum;
if (_tot_height > MAX_ROW_Y) then {_tot_height = MAX_ROW_Y};

private _yCoord = _tot_height + TOTAL_ROW_HEIGHT + GtC_H(0.4);

// Resize ctrl group
private _ctrl_group = _dialog displayCtrl DYNAMIC_CTRL_GROUP;
private _pos = ctrlPosition _ctrl_group;
_pos set [3,_yCoord-(_pos select 1)];
_ctrl_group ctrlSetPosition _pos;
_ctrl_group ctrlCommit 0;

_yCoord = _yCoord + GtC_H(0.4);

{
	private _bottomCtrl = _dialog displayCtrl _x;
	_pos = ctrlPosition _bottomCtrl;
	_pos set [1,_yCoord];
	_bottomCtrl ctrlSetPosition _pos;
	_bottomCtrl ctrlCommit 0;
} forEach DYNAMIC_BOTTOM_IDCs;

_yCoord = _yCoord + TOTAL_ROW_HEIGHT;

// Resize the background
private _background = _dialog displayCtrl DYNAMIC_BG_IDC;
_pos = ctrlPosition _background;
_pos set [3,_yCoord-(_pos select 1)];
_background ctrlSetPosition _pos;
_background ctrlCommit 0;

// set dialog title
if (_titleText != "") then
{
	private _ctrlTitle = _dialog displayCtrl DYNAMIC_TITLE_IDC;
	_ctrlTitle ctrlSetText _titleText;

};

// Set the start offset for the controls
_yCoord = START_ROW_Y;

// Get the ID for use when looking up previously selected values.
private _titleText_varName = _titleText call Achilles_fnc_TextToVariableName;
private _titleVariableIdentifier = format ["Ares_ChooseDialog_DefaultValues_%1", _titleText_varName];
{
    _x params ["_choiceName", "_choices", ["_defaultChoice", 0], ["_force_default", false, [false]]];

	private _choiceName_varName = _choiceName call Achilles_fnc_TextToVariableName;

	// If this dialog is named, attempt to get the default value from a previously displayed version
	if (_titleText != "" &&  !_force_default) then
	{
		_defaultVariableId = format["%1_%2", _titleVariableIdentifier, _forEachIndex];
		_defaultChoice = uiNamespace getVariable [_defaultVariableId, _defaultChoice];
	};

	// Create the label for this entry
	private _choiceLabel = _dialog ctrlCreate ["RscText", BASE_IDC_LABEL + _forEachIndex, _ctrl_group];
	_choiceLabel ctrlSetText _choiceName;
	_choiceLabel ctrlSetBackgroundColor [0,0,0,0.6];

	if (_choices isEqualType []) then
	{

		// set entry label position
		_choiceLabel ctrlSetPosition [LABEL_COLUMN_X, _yCoord, LABEL_WIDTH, LABEL_HEIGHT];
		_choiceLabel ctrlCommit 0;

		// Create the combo box for this entry and populate it.
		private _choiceCombo = _dialog ctrlCreate ["RscCombo", BASE_IDC_CTRL + _forEachIndex, _ctrl_group];
		_choiceCombo ctrlSetPosition [COMBO_COLUMN_X, _yCoord+LABEL_COMBO_DELTA_Y, COMBO_WIDTH, COMBO_HEIGHT];
		_choiceLabel ctrlSetBackgroundColor [0,0,0,0.5];
		_choiceCombo ctrlCommit 0;
		{
			_choiceCombo lbAdd _x;
		} forEach _choices;

		// Set the current choice, record it in the global variable, and setup the event handler to update it.

		private _comboScript = "";

		if (_ResourceScript != "") then
		{
			// combo boxes handled with custom scripts
			uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1",_forEachIndex], _defaultChoice];
			_comboScript = format["([""%1""] + _this) call %2;",_forEachIndex,_ResourceScript]
		} else
		{
			// combo boxes handled by default
			_defaultChoice = [0, _defaultChoice] select (_defaultChoice isEqualType 0);
			_defaultChoice = [(lbSize _choiceCombo) - 1, _defaultChoice] select (_defaultChoice < lbSize _choiceCombo);
			_choiceCombo lbSetCurSel _defaultChoice;
			uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1",_forEachIndex], _defaultChoice];

			_comboScript = "uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1'," + str (_forEachIndex) + "], _this select 1];"
		};
		_choiceCombo ctrlSetEventHandler ["LBSelChanged", _comboScript];

		// Move onto the next row
		_yCoord = _yCoord + TOTAL_ROW_HEIGHT;
	}
	else
	{
		private _choices = toUpper _choices;
		if (_choices in ["ALLSIDE","SIDE"]) then
		{
			// set entry label position
			_choiceLabel ctrlSetPosition [GtC_X(0.5),_yCoord,GtC_W(39),GtC_H(4)];
			_choiceLabel ctrlCommit 0;

			// create entry background
			private _ctrl = _dialog ctrlCreate ["RscText", BASE_IDC_CTRL + _forEachIndex, _ctrl_group];
			_yCoord = _yCoord + GtC_H(0.5);
			_ctrl ctrlSetBackgroundColor [1,1,1,0.1];
			_ctrl ctrlSetPosition [GtC_X(8),_yCoord,GtC_W(31),GtC_H(3)];
			_ctrl ctrlCommit 0;

			// create Active Entry Pictures
			_yCoord = _yCoord + GtC_H(0.5);
			private _xCoord = GtC_X(12.5);
			{
				private _icon = _x;
				_ctrl = _dialog ctrlCreate ["RscActivePicture", SIDE_BASE_IDC + 10*_forEachIndex, _ctrl_group];
				_ctrl ctrlSetBackgroundColor [1,1,1,1];
				_ctrl ctrlSetActiveColor [1,1,1,1];
				private _side_name = if (_foreachindex == 0) then {"ZEUS"} else {toUpper ((_foreachindex - 1) call bis_fnc_sideName)};
				_ctrl ctrlSetTooltip _side_name;
				_ctrl ctrlSetText _icon;
				_ctrl ctrlSetPosition [_xCoord,_yCoord,GtC_W(2.4),GtC_H(2)];
				_ctrl ctrlCommit 0;
				_xCoord = _xCoord + 4*GUI_GRID_W;
			} forEach ["\a3\Ui_F_Curator\Data\Logos\arma3_curator_eye_64_ca.paa","\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_east_ca.paa","\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_west_ca.paa","\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_guer_ca.paa","\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\side_civ_ca.paa"];

			if (_choices == "SIDE") then
			{
				// exclude side logic
				_ctrl = _dialog displayCtrl 12000;
				_ctrl ctrlShow false;
				_defaultChoice = [1, _defaultChoice] select (_defaultChoice isEqualType 0 and !(_defaultChoice in [-1,0]));
			} else
			{
				// include side logic
				_defaultChoice = [1, _defaultChoice] select (_defaultChoice isEqualType 0 and _defaultChoice != -1);
			};

			["onLoad",_dialog,_forEachIndex,_defaultChoice] call Achilles_fnc_sideTab;

			_yCoord = _yCoord + GtC_H(3.1);
		} else
		{
			private _add_height = [0, 4*COMBO_HEIGHT] select (_choices == "MESSAGE");

			// set entry label position
			_choiceLabel ctrlSetPosition [LABEL_COLUMN_X, _yCoord, LABEL_WIDTH, LABEL_HEIGHT + _add_height];
			_choiceLabel ctrlCommit 0;

			// create the control element
			private _ctrl_type = switch (_choices) do
			{
				case "SLIDER": {"RscXSliderH"};
				case "MESSAGE": {"RscAchillesMessageEdit"};
				default {"RscAchillesEdit"};
			};
			private _ctrl = _dialog ctrlCreate [_ctrl_type, BASE_IDC_CTRL + _forEachIndex, _ctrl_group];
			_ctrl ctrlSetPosition [COMBO_COLUMN_X, _yCoord+LABEL_COMBO_DELTA_Y, COMBO_WIDTH, COMBO_HEIGHT + _add_height];
			_ctrl ctrlCommit 0;
			if (_choices == "SLIDER") then
			{
				// set last choice or the default choice
				_defaultChoice = [0, _defaultChoice] select (_defaultChoice isEqualType 0 and _defaultChoice != -1);

				_ctrl sliderSetRange [0,1];
				_ctrl ctrlSetBackgroundColor [0, 0, 0, 1];
				_ctrl sliderSetPosition _defaultChoice;
				_ctrl ctrlSetEventHandler ["KeyUp", "uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1'," + str (_forEachIndex) + "], sliderPosition (_this select 0)];"];
				_ctrl ctrlSetEventHandler ["MouseButtonUp", "uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1'," + str (_forEachIndex) + "], sliderPosition (_this select 0)];"];

			} else
			{
				// set last choice or the default choice
				_defaultChoice = ["", _defaultChoice] select (_defaultChoice isEqualType "");

				_ctrl ctrlSetText _defaultChoice;
				_ctrl ctrlSetBackgroundColor [0, 0, 0, 0];
				_ctrl ctrlSetEventHandler ["KeyUp", "uiNamespace setVariable [format['Ares_ChooseDialog_ReturnValue_%1'," + str (_forEachIndex) + "], ctrlText (_this select 0)];"];
			};
			_ctrl ctrlCommit 0;

			uiNamespace setVariable [format["Ares_ChooseDialog_ReturnValue_%1",_forEachIndex], _defaultChoice];
			// Move onto the next row
			_yCoord = _yCoord + TOTAL_ROW_HEIGHT + _add_height;
		};
	};
} forEach _choicesArray;

uiNamespace setVariable ["Ares_ChooseDialog_Result", -1];

if (_ResourceScript != "") then {call compile format["[""LOADED""] call %1;",_ResourceScript]};

Ares_var_showChooseDialog = true;
_dialog displayAddEventHandler ["unload",{Ares_var_showChooseDialog = nil}];
waitUntil { isNil "Ares_var_showChooseDialog" };

if (_ResourceScript != "") then {call compile format["[""UNLOAD""] call %1;",_ResourceScript]};

// Check whether the user confirmed the selection or not, and return the appropriate values.
if (uiNamespace getVariable "Ares_ChooseDialog_Result" == 1) exitWith
{
	private _returnValue = [];
	{
		_returnValue pushBack (uiNamespace getVariable (format["Ares_ChooseDialog_ReturnValue_%1",_forEachIndex]));
	}forEach _choicesArray;

	// Save the selections as defaults for next time
	if (_titleText != "") then
	{
		{
			_defaultVariableId = format["%1_%2", _titleVariableIdentifier, _forEachIndex];
			uiNamespace setVariable [_defaultVariableId, _x];
		} forEach _returnValue;
	};
	_returnValue
};
[]
