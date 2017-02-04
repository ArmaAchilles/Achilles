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
		private "_leader";
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTESKILL_VALUE;
		_skill_value = (sliderposition _ctrlValue) * 0.1;
		if (typename _entity == typename grpnull) then 
		{
			_leader = leader _entity;
			_entity = units _entity
		} else 
		{
			_leader = _entity;
			_entity = [_entity];
		};
		if (abs (skill _leader - _skill_value) < 0.01) exitWith {};
		if (local _leader) then
		{
			{_x setskill _skill_value;} foreach _entity;
		} else
		{
			[[_entity,_skill_value],
			{
				_entity = _this select 0;
				_skill_value = _this select 1;
				{_x setskill _skill_value;} foreach _entity;
			}] remoteExec ["spawn",_leader];
		};
	};
	case "onUnload": {};
};