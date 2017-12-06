#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

disableSerialization;
params ["_curator","_placedObject"];
if (local _placedObject) then
{
	Ares_CuratorObjectPlaced_UnitUnderCursor = curatorMouseOver;
	Ares_CuratorObjectPlaces_LastPlacedObjectPosition = position _placedObject;
	[format ["Placed Object %1 (%2) on %3 at position %4, %5", _placedObject, name _placedObject, str(Ares_CuratorObjectPlaced_UnitUnderCursor), str(Ares_CuratorObjectPlaces_LastPlacedObjectPosition), (nearestLocation [Ares_CuratorObjectPlaces_LastPlacedObjectPosition, "nameCity"]) call BIS_fnc_locationDescription]] call Achilles_fnc_logMessage;
}
else
{
	[format ["NON-LOCAL Placed Object %1 with %2 under mouse at position %3", _placedObject, str(Ares_CuratorObjectPlaced_UnitUnderCursor), str(Ares_CuratorObjectPlaces_LastPlacedObjectPosition)]] call Achilles_fnc_logMessage;
};

if (!isNil "Achilles_var_deleteCrewOnSpawn") then
{
	private _curatorDisplay = findDisplay IDD_RSCDISPLAYCURATOR;
	private _ctrlModeGroups = _curatorDisplay displayCtrl IDC_RSCDISPLAYCURATOR_MODEGROUPS;
	private _crew = crew _placedObject;
	if (ctrlScale _ctrlModeGroups != 1 and count _crew > 0) then
	{
		{_placedObject deleteVehicleCrew _x} forEach _crew;
	};
};

if (!isNil "Achilles_var_specifyPositionBeforeSpawn") then
{
	private _curatorDisplay = findDisplay IDD_RSCDISPLAYCURATOR;
	private _ctrlModeUnits = _curatorDisplay displayCtrl IDC_RSCDISPLAYCURATOR_MODEUNITS;
	private _ctrlModeRecent = _curatorDisplay displayCtrl IDC_RSCDISPLAYCURATOR_MODERECENT;
	if (ctrlScale _ctrlModeUnits == 1 or {ctrlScale _ctrlModeRecent == 1}) then
	{
		if (!(_placedObject isKindOf "module_f") and {count units group _placedObject - count crew _placedObject <= 0}) then
		{
			// if not a module or a group
			[_placedObject] call Achilles_fnc_PreplaceMode;
		}
	};
};
