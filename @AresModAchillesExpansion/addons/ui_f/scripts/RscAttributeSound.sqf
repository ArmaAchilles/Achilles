#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params["_mode", "_params", "_unit"];

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTESOUND_VALUE;
		_ctrlValue ctrladdeventhandler ["lbselchanged","with uinamespace do {['lbSelChanged',_this,objnull] call RscAttributeSound};"];

		//--- Get sound objects
		private _sounds = uinamespace getvariable "RscAttributeSound_objects";
		if (isnil "_sounds") then {
			_sounds = [];
			{
				_sounds set [count _sounds,_x];
			} foreach ((((configfile >> "cfgvehicles") call bis_fnc_returnchildren) + ((missionConfigFile >> "cfgvehicles") call bis_fnc_returnchildren)) select {gettext (_x >> "sound") != "" && getnumber (_x >> "scope") > 1});
			uinamespace setvariable ["RscAttributeSound_objects",_sounds];
		};

		//--- Add objects to the list
		{
			private _name = gettext (_x >> "displayname");
			if (_name != "") then {
				private _lbadd = _ctrlValue lbadd _name;
				_ctrlValue lbsetdata [_lbadd,configname _x];
			};
		} foreach _sounds;

		_ctrlValue lbsetcursel (uinamespace getvariable ["RscAttributeSound_selected",0]);
	};
	case "confirmed": {
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTESOUND_VALUE;
		_unit setvariable ["RscAttributeSound",_ctrlValue lbdata (lbcursel _ctrlValue),true];
	};
	case "onUnload": {
		if !(isnil "RscAttributeSound_trigger") then {deletevehicle RscAttributeSound_trigger;};
		RscAttributeSound_trigger = nil;
	};
	case "lbSelChanged": {
		private _ctrlValue = _params select 0;
		private _cursel = _params select 1;
		private _sound = _ctrlValue lbdata _cursel;
		RscAttributeSound_selected = _cursel;

		if !(isnil "RscAttributeSound_trigger") then {deletevehicle RscAttributeSound_trigger;};
		RscAttributeSound_trigger = createtrigger ["EmptyDetector",position curatorcamera];
		RscAttributeSound_trigger settriggerstatements ["true","",""];
		RscAttributeSound_trigger setpos position curatorcamera;
		RscAttributeSound_trigger setsoundeffect ["$NONE$","","",gettext (configfile >> "cfgvehicles" >> _sound >> "sound")];
	};
};
