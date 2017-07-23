#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params ["_mode", "_params", "_entity"];

switch _mode do 
{
	case "onLoad": 
	{
		if (typename _entity == typename grpnull) then {_entity = leader _entity;};
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTESKILL_VALUE;
		private _sliderRange = getArray (configFile >> "Cfg3DEN" >> "Attributes" >> "Skill" >> "Controls" >> "Value" >> "sliderRange");
		private _skill = skill _entity;
		_ctrlValue slidersetrange _sliderRange;
		_ctrlValue slidersetposition _skill;
		_ctrlValue ctrlSetTooltip str _skill;
		_ctrlValue ctrlSetEventHandler["SliderPosChanged", "params [""_ctrl"", ""_value""]; _ctrl ctrlSetTooltip str _value;"];
		_ctrlValue ctrlenable alive _entity;
			
	};
	case "confirmed": 
	{
		private ["_unit","_curatorSelected"];
		private _display = _params select 0;
		private _ctrlValue = _display displayctrl IDC_RSCATTRIBUTESKILL_VALUE;
		private _skill_value = sliderposition _ctrlValue;
		if (typename _entity == typename grpnull) then {
			private _selectedGroups = ["group"] call Achilles_fnc_getCuratorSelected;
			_curatorSelected = [];
			{_curatorSelected append units _x} forEach _selectedGroups;
			_unit = leader _entity;
		} else {
			_curatorSelected = ["man"] call Achilles_fnc_getCuratorSelected;
			_unit = _entity;
		};
		private _previousSkillValue = skill _unit;
		if (abs (_skill_value - _previousSkillValue) > 0.01) then
		{
			{
				if (local _x) then
				{
					_x setSkill _skill_value;
				} else {
					[_x, _skill_value] remoteExecCall ["setSkill", _x];
				};
			} forEach _curatorSelected;
		};
	};
	case "onUnload": {};
};