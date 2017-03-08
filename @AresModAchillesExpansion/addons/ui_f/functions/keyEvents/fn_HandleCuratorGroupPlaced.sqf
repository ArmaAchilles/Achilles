#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

disableSerialization;
private ["_curator","_placedGroup"];
_curator = _this select 0;
_placedGroup = _this select 1;

if (not isNil "Achilles_var_specifyPositionBeforeSpawn") then
{
	_curatorDisplay = findDisplay IDD_RSCDISPLAYCURATOR;
	_ctrlModeUnits = _curatorDisplay displayCtrl IDC_RSCDISPLAYCURATOR_MODEGROUPS;
	if (ctrlScale _ctrlModeUnits == 1) then
	{
		[_placedGroup] spawn Achilles_fnc_PreplaceMode;
	};
};