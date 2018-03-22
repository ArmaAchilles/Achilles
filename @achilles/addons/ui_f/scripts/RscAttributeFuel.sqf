#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params ["_mode", "_params", "_unit"];

switch _mode do {
	case "onLoad": {
		private _display = _params select 0;
		private _fuel = fuel _unit;
		private _ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEFUEL_VALUE;
		_ctrlSlider sliderSetRange [0, 1];
		_ctrlSlider sliderSetSpeed [0.1, 0.3];
		_ctrlSlider slidersetposition _fuel;
		_ctrlSlider ctrlSetTooltip str _fuel;
		_ctrlSlider ctrlSetEventHandler["SliderPosChanged", "params [""_ctrl"", ""_value""]; _ctrl ctrlSetTooltip str _value;"];
		_ctrlSlider ctrlenable alive _unit;
	};
	case "confirmed": {
		private _display = _params select 0;
		private _ctrlSlider = _display displayctrl IDC_RSCATTRIBUTEFUEL_VALUE;
		private _fuel = sliderposition _ctrlSlider;
		if (abs(fuel _unit - _fuel) < 0.01) exitwith {};
		private _curatorSelected = ["vehicle"] call Achilles_fnc_getCuratorSelected;
		{
			if (local _x) then {_x setFuel _fuel} else {[_x, _fuel] remoteExecCall ["setFuel", _x]};
		} forEach _curatorSelected;
	};
	case "onUnload": {
	};
};
