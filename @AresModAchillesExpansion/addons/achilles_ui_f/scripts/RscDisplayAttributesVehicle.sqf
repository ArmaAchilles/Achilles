// fix available attributes for players
_show_skill = true;
_available_attributes = missionnamespace getvariable ["BIS_fnc_initCuratorAttributes_attributes",[]];
if (not ("%ALL" in _available_attributes)) then
{
	_available_attributes = ["Rank","Damage","Fuel","Ammo","RespawnVehicle2","RespawnPosition2"];
	missionnamespace setvariable ["BIS_fnc_initCuratorAttributes_attributes",_available_attributes];
	_show_skill = false;
};

#include "\a3\ui_f_curator\UI\displays\RscDisplayAttributes.sqf"

_ctrlButtonCustom = _display displayctrl 30004;
if (not _show_skill) then 
{
	_ctrlButtonCustom ctrlSetFade 0.8;
	_ctrlButtonCustom ctrlEnable false;
	_ctrlButtonCustom ctrlCommit 0;
};

_y_offset = ((ctrlposition _ctrlButtonCustom) select 1) - 16.1 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) -	(safezoneY + (safezoneH - (((safezoneW / safezoneH) min 1.2) / 1.2))/2);

{
	_idc = _x;
	_ctrlButtonCustomPlus = _display displayctrl _idc;
	_ctrlButtonCustomPlusPos = ctrlposition _ctrlButtonCustomPlus;
	_ctrlButtonCustomPlusPos set [1,(_ctrlButtonCustomPlusPos select 1) + _y_offset];
	_ctrlButtonCustomPlus ctrlsetposition _ctrlButtonCustomPlusPos;
	_ctrlButtonCustomPlus ctrlcommit 0;
} forEach [30005,30006,30007];