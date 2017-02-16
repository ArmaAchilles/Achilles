
#include "\a3\ui_f_curator\UI\displays\RscDisplayAttributes.sqf"

_ctrlButtonCustom = _display displayctrl 30004;

_y_offset = ((ctrlposition _ctrlButtonCustom) select 1) - 16.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) -	(safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2);

{
	_idc = _x;
	_ctrlButtonCustomPlus = _display displayctrl _idc;
	_ctrlButtonCustomPlusPos = ctrlposition _ctrlButtonCustomPlus;
	_ctrlButtonCustomPlusPos set [1,(_ctrlButtonCustomPlusPos select 1) + _y_offset];
	_ctrlButtonCustomPlus ctrlsetposition _ctrlButtonCustomPlusPos;
	_ctrlButtonCustomPlus ctrlcommit 0;
} forEach [30005];