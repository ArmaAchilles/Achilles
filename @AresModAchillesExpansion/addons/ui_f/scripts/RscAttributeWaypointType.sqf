#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

switch _mode do {
	case "onLoad": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEWAYPOINTTYPE_VALUE;

		if (isnull waypointattachedvehicle _entity) then {
			_ctrlValue ctrladdeventhandler ["toolboxSelChanged",{with uinamespace do {RscAttributeWaypointType_value = _this select 1}}];
			_names = getarray (configfile >> "RscAttributeWaypointType" >> "controls" >> "Value" >> "names");
			
			//--- Select current waypoint type
			_type = _entity call bis_fnc_scriptedWaypointType;
			if (_type == "") then {_type = waypointtype _entity;};
			{
				if (_type == _x) exitwith {_ctrlValue lbsetcursel _foreachindex;};
			} foreach _names;
		} else {
			_ctrlValue ctrlshow false;
			_ctrlValue ctrlenable false;
			_ctrlBackground = _display displayctrl IDC_RSCATTRIBUTEWAYPOINTTYPE_BACKGROUND;
			_ctrlBackground ctrlsettext "Cannot set type of an attached waypoint";
		};
	};
	case "lbSelChanged": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEWAYPOINTTYPE_VALUE;
	};
	case "confirmed": {
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEWAYPOINTTYPE_VALUE;
		_valueID = uinamespace getvariable ["RscAttributeWaypointType_value",0];
		_values = getarray (configfile >> "RscAttributeWaypointType" >> "controls" >> "Value" >> "names");
		if (_valueID < count _values) then {
			_value = _values select _valueID;
			_valueConfig = [_value,configfile] call bis_fnc_configpath;
			if (isclass _valueConfig) then {
				_curatorSelectedWPs = ["wp"] call Achilles_fnc_getCuratorSelected;
				{
					_x setwaypointtype "SCRIPTED";
					_x setwaypointscript gettext (_valueConfig >> "file");
				} forEach _curatorSelectedWPs;
			} else {
				if (_value == waypointtype _entity) exitWith {};
				_curatorSelectedWPs = ["wp"] call Achilles_fnc_getCuratorSelected;
				{
					_x setwaypointtype _value;
				} forEach _curatorSelectedWPs;
			};
		};
	};
	case "onUnload": {
		RscAttributeWaypointType_value = nil;
	};
};