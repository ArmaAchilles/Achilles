#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

disableSerialization;
private ["_curator","_placedGroup"];
_curator = _this select 0;
_placedGroup = _this select 1;

if (not isNil "Achilles_var_specifyPositionBeforeSpawn") then
{
	private _curatorDisplay = findDisplay IDD_RSCDISPLAYCURATOR;
	private _ctrlModeGroups = _curatorDisplay displayCtrl IDC_RSCDISPLAYCURATOR_MODEGROUPS;
	private _ctrlModeRecent = _curatorDisplay displayCtrl IDC_RSCDISPLAYCURATOR_MODERECENT;
	if (ctrlScale _ctrlModeGroups == 1 or {ctrlScale _ctrlModeRecent == 1}) then
	{
		[_placedGroup] call Achilles_fnc_PreplaceMode;
	};
};
