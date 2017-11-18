/*
	Author: Karel Moricky (edited by Kex to handle closeDisplay properly)

	Description:
	Initialize entity attribute. Called from UI using:
	onSetFocus = [_this,"RscAttributeTest","AresDisplays"] call (uinamespace getvariable "Achilles_fnc_initCuratorAttribute");

	Parameter(s):
		0: ARRAY - onSetFocus handler params - contains only DISPLAY
		1: STRING - attribute UI class
		2: STRING - CfgScriptPaths class

	Returns:
	BOOL
*/

//#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"
#define IDC_OK	1

with uinamespace do {
	params ["_params","_class","_path"];

	//--- Register script for the first time
	private _fncName = _class;
	if (isnil _fncName || cheatsEnabled) then {
		//--- Set script path
		private _scriptPath = gettext (configfile >> "cfgScriptPaths" >> _path);

		//--- Execute
		private _fncFile = preprocessfilelinenumbers format [_scriptPath + "%1.sqf",_class];
		_fncFile = format ["scriptname '%1_%2'; _fnc_scriptName = '%1';",_class] + _fncFile;
		uinamespace setvariable [_fncName,compileFinal _fncFile];
	};

	//--- Remove the initial handler
	private _control = _params select 0;
	_control ctrlremovealleventhandlers "setFocus";

	//--- Add handler executed when the display closes
	private _display = ctrlparent _control;
	_display displayaddeventhandler ["unload",format ["with uinamespace do {['onUnload',_this,missionnamespace getvariable ['BIS_fnc_initCuratorAttributes_target',objnull]] call %1};",_fncName]];

	//--- Add handler executed when dialog was closed with OK
	_display displayaddeventhandler ["unload",format ["if (_this select 1 == 1) then {with uinamespace do {['confirmed',_this,missionnamespace getvariable ['BIS_fnc_initCuratorAttributes_target',objnull]] call %1}};",_fncName]];

	//--- Call init script
	private _target = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_target",objnull]; //--- ToDo: Dynamic
	["onLoad",[ctrlparent (_params select 0)],_target] call (uinamespace getvariable _fncName);
};
