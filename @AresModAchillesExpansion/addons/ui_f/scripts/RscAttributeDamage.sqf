#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params ["_mode", "_params", "_unit"];

switch _mode do 
{
	case "onLoad": 
	{
		private _display = _params select 0;
		private _health = (1 - damage _unit);
		private _ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEDAMAGE_VALUE;
		_ctrlSlider sliderSetRange [0, 1];
		_ctrlSlider sliderSetSpeed [0.1, 0.3];
		_ctrlSlider slidersetposition _health;
		_ctrlSlider ctrlSetTooltip str _health;
		_ctrlSlider ctrlSetEventHandler["SliderPosChanged", "params [""_ctrl"", ""_value""]; _ctrl ctrlSetTooltip str _value;"];
		_ctrlSlider ctrlenable alive _unit;
	};
	case "confirmed": 
	{
		private _display = _params select 0;
		private _ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEDAMAGE_VALUE;
		private _damage = 1 - sliderposition _ctrlSlider;
		if (abs (_damage - damage _unit) > 0.01) then 
		{
			_mode = if (_unit isKindOf "Man") then {"man"} else {"vehicle"};
			_curatorSelected = [_mode] call Achilles_fnc_getCuratorSelected;
			{_x setdamage _damage} forEach _curatorSelected;
		};
	};
	case "onUnload": {};
};