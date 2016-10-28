#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_entity = _this select 2;

switch _mode do 
{
	case "onLoad": 
	{
		if (typename _entity == typename grpnull) then {_entity = leader _entity;};
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTESKILL_VALUE;
		_ctrlValue slidersetrange [2,10];
		_ctrlValue slidersetposition (skill _entity * 10);
		_ctrlValue ctrlenable alive _entity;
	};
	case "confirmed": 
	{
		private "_unit";
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTESKILL_VALUE;
		if (typename _entity == typename grpnull) then {_unit = leader _entity; _entity = units _entity} else {_unit = _entity; _entity = [_entity];};
		if (abs (skill _unit - sliderposition _ctrlValue * 0.1) < 0.01) exitWith {};
		{_x setskill (sliderposition _ctrlValue * 0.1);} foreach _entity;
	};
	case "onUnload": {};
};