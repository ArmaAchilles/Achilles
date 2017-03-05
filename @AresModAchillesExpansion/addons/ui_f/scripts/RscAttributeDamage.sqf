#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

_mode = _this select 0;
_params = _this select 1;
_unit = _this select 2;

switch _mode do 
{
	case "onLoad": 
	{
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEDAMAGE_VALUE;
		_ctrlSlider slidersetposition (1 - damage _unit) * 10;
		_ctrlSlider ctrlenable alive _unit;
	};
	case "confirmed": 
	{
		_display = _params select 0;
		_ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEDAMAGE_VALUE;
		_damage = 1 - sliderposition _ctrlSlider * 0.1;
		systemChat str [_damage, damage _unit];
		if (abs (_damage - damage _unit) > 0.01) then 
		{
			systemChat str [_damage, damage _unit];
			_mode = if (_unit isKindOf "Man") then {"man"} else {"vehicle"};
			_curatorSelected = [_mode] call Achilles_fnc_getCuratorSelected;
			{_x setdamage _damage} forEach _curatorSelected;
		};
	};
	case "onUnload": {};
};