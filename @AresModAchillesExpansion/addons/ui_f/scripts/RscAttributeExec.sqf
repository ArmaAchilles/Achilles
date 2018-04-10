#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params ["_mode","_params","_entity"];

if (isnil "RscAttributeExec_templatesVar") then {RscAttributeExec_templatesVar = "RscAttributeExec";};
_templates = profilenamespace getvariable [RscAttributeExec_templatesVar,[]];

_params params ["_display"];
_ctrlValue = _display displayctrl IDC_RSCATTRIBUTEEXEC_VALUE;
_ctrlTemplate = _display displayctrl IDC_RSCATTRIBUTEEXEC_VALUETEMPLATE;

switch _mode do {
	case "onLoad": {
		//--- Load current template
		_ctrlTemplate ctrladdeventhandler ["lbselchanged","with uinamespace do {['lbSelChanged',[ctrlparent (_this select 0)],objnull] call RscAttributeExec;};"];
		_lbAdd = _ctrlTemplate lbadd localize "STR_A3_RscAttributeTaskDescription_New";
		_ctrlTemplate lbsetvalue [_lbAdd,-1];

		//--- Load previous templates
		{

			_xArray = toarray _x;
			if (count _xArray > 30) then {
				_xArray resize 30;
				_xArray = _xArray + [46,46,46];
			};
			_x = tostring _xArray;
			_lbAdd = _ctrlTemplate lbadd _x;
			_ctrlTemplate lbsetvalue [_lbAdd,_foreachindex];
		} foreach _templates;
		_ctrlTemplate lbsetcursel 0;
	};
	case "confirmed": {
		_exec = ctrltext _ctrlValue;
		with missionnamespace do {
			[_entity, compile("this = param[0];" + _exec), 0, _entity] call Achilles_fnc_spawn;
		};

		//--- Save into recent templates
		if ({_exec == _x} count _templates == 0) then {
			_templates = [_exec] + _templates;
			_templates resize (count _templates min 20);
			profilenamespace setvariable [RscAttributeExec_templatesVar,_templates];
			saveprofilenamespace;
		};
	};
	case "onUnload": {
	};
	case "lbSelChanged": {
		_templateID = _ctrlTemplate lbvalue lbcursel _ctrlTemplate;
		if (_templateID < 0) then {
			_ctrlValue ctrlsettext "";
		} else {
			_template = _templates select _templateID;
			_ctrlValue ctrlsettext _template;
		};
	};
};