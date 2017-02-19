#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

disableSerialization;
private ["_curator","_placedObject"];
_curator = _this select 0;
_placedObject = _this select 1;
if (local _placedObject) then
{
	Ares_CuratorObjectPlaced_UnitUnderCursor = curatorMouseOver;
	Ares_CuratorObjectPlaces_LastPlacedObjectPosition = position _placedObject;
	[format ["Placed Object %1 with %2 under mouse at position %3", _placedObject, str(Ares_CuratorObjectPlaced_UnitUnderCursor), str(Ares_CuratorObjectPlaces_LastPlacedObjectPosition)]] call Ares_fnc_LogMessage;
}
else
{
	[format ["NON-LOCAL Placed Object %1 with %2 under mouse at position %3", _placedObject, str(Ares_CuratorObjectPlaced_UnitUnderCursor), str(Ares_CuratorObjectPlaces_LastPlacedObjectPosition)]] call Ares_fnc_LogMessage;
};

if (not isNil "Achilles_var_deleteCrewOnSpawn") then
{
	_curatorDisplay = findDisplay IDD_RSCDISPLAYCURATOR;
	_ctrlModeGroups = _curatorDisplay displayCtrl IDC_RSCDISPLAYCURATOR_MODEGROUPS;
	_crew = crew _placedObject;
	if (ctrlScale _ctrlModeGroups != 1 and count _crew > 0) then
	{
		{_placedObject deleteVehicleCrew _x} forEach _crew;
	};
};

if (not isNil "Achilles_var_specifyPositionBeforeSpawn") then
{
	_curatorDisplay = findDisplay IDD_RSCDISPLAYCURATOR;
	_ctrlModeUnits = _curatorDisplay displayCtrl IDC_RSCDISPLAYCURATOR_MODEUNITS;
	if (ctrlScale _ctrlModeUnits == 1) then
	{
		[_placedObject] spawn Achilles_fnc_PreplaceMode;
	};
};

if (not isNil "Achilles_var_unitAttributesOnSpawn") then
{
	
};

if (not isNil "Achilles_var_vehicleAttributesOnSpawn") then
{
	
};
