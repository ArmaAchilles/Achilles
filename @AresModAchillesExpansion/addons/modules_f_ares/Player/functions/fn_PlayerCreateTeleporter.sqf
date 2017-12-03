#include "\achilles\modules_f_ares\module_header.hpp"

// Create a function in the mission namespace on all players machines to add the
// teleport action.
Ares_addNewTeleportMarkerActions =
{
	private _newMarker = _this select 0;

	if (isNil "Ares_TeleportMarkers") then { Ares_TeleportMarkers = []; };

	{
		// TODO deal with deleted markers.... Conditions?

		// Add an action to THIS marker to teleport to OTHER marker.
		private _actionName = format ["Teleport to %1", _x getVariable ["teleportMarkerName", "??"]];
		_newMarker addAction [_actionName, {
			private _teleportTarget = _this select 3;
			if (isNil "_teleportTarget" || !(alive _teleportTarget)) then
			{
				hint "Destination no longer exists...";
				sleep 3;
				hint "";
			}
			else
			{
				titleText ["You are being teleported...", "BLACK", 1];  sleep 1; titleFadeOut 2;
				player setPosATL (getPosATL _teleportTarget);
			};
		}, _x];

		// Add action to OTHER marker to teleport to THIS marker.
		_actionName = format ["Teleport to %1", _newMarker getVariable ["teleportMarkerName", "??"]];
		_x addAction [_actionName, {
			private _teleportTarget = _this select 3;
			if (isNil "_teleportTarget" || !(alive _teleportTarget)) then
			{
				hint "Destination no longer exists...";
				sleep 3;
				hint "";
			}
			else
			{
				titleText ["You are being teleported...", "BLACK", 1]; sleep 1; titleFadeOut 2;
				player setPosATL (getPosATL _teleportTarget);
			};
		}, _newMarker];
	} forEach ((Ares_TeleportMarkers) select {_x != _newMarker && alive _x});
};

// Check to see if there's an object under the cursor or not
private _unitUnderMouseCursor = [_logic, false] call Ares_fnc_GetUnitUnderCursor;

private _teleportMarker = objNull;
if (isNull _unitUnderMouseCursor) then
{
	// Create a new object to make a telporter
	_teleportMarker = "FlagPole_F" createVehicle (getPos _logic);
}
else
{
	if (_unitUnderMouseCursor getVariable ["teleportMarkerName", ""] == "") then
	{
		_teleportMarker = _unitUnderMouseCursor;
	}
	else
	{
		// Unit is already a teleporter! Log an error and exit.
		[objNull, "Object is already a teleporter"] call bis_fnc_showCuratorFeedbackMessage;
		breakTo MAIN_SCOPE_NAME;
	}
};

private _isFirstCallToCreateTeleporter = false;
if (isNil "Ares_TeleportMarkers") then
{
	Ares_TeleportMarkers = [];
	_isFirstCallToCreateTeleporter = true;
	publicVariable "Ares_addNewTeleportMarkerActions";
};
Ares_TeleportMarkers pushBack _teleportMarker;
publicVariable "Ares_TeleportMarkers";

// Set the name of the marker (used in the action)
private _teleportMarkerName = [(count Ares_TeleportMarkers) - 1] call Ares_fnc_GetPhoneticName;
private _dialogResult =
[
	localize "STR_AMAE_CREATE_NEW_LZ",
	[
		[localize "STR_AMAE_NAME", "", _teleportMarkerName, true]
	]
] call Ares_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};
_teleportMarkerName = _dialogResult select 0;
_teleportMarker setVariable ["teleportMarkerName", _teleportMarkerName, true];

// Make the teleport marker editable in zeus (needs to run on server)
[[_teleportMarker]] call Ares_fnc_AddUnitsToCurator;

// Call this to add the teleport marker actions on all machines. Persistent for JIP people as well.
[[_teleportMarker], "Ares_addNewTeleportMarkerActions", true, _isFirstCallToCreateTeleporter] call BIS_fnc_MP;

[objNull, format["Created teleporter '%1'", _teleportMarkerName]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
