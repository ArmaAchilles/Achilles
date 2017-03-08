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
		private ["_mode", "_unit","_curatorSelected"];
		_display = _params select 0;
		_ctrlValue = _display displayctrl IDC_RSCATTRIBUTESKILL_VALUE;
		_skill_value = (sliderposition _ctrlValue) * 0.1;
		if (typename _entity == typename grpnull) then {
			_selectedGroups = ["group"] call Achilles_fnc_getCuratorSelected;
			_curatorSelected = [];
			{_curatorSelected append units _x} forEach _selectedGroups;
			_unit = leader _entity;
		} else {
			_curatorSelected = ["man"] call Achilles_fnc_getCuratorSelected;
			_unit = _entity;
		};
		_previousSkillValue = skill _unit;
		if (abs (_skill_value - _previousSkillValue) > 0.01) then {
			if (local _entity) then
			{
				{_x setskill _skill_value;} foreach _curatorSelected;
			} else {
				[[_curatorSelected, _skill_value], {
					_entities = _this select 0;
					_skill_value = _this select 1;
					{_x setskill _skill_value;} foreach _entities;
				}] remoteExec ["spawn", _unit];
			};		
		};
	};
	case "onUnload": {};
};