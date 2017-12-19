#include "\achilles\modules_f_ares\module_header.hpp"

// Set the name of the marker (used in the action)
private _teleportMarkerName = if (!isNil "Ares_TeleportMarkers") then
{
	[(count Ares_TeleportMarkers) - 1] call Ares_fnc_GetPhoneticName;
};

private _dialogResult =
[
	localize "STR_AMAE_CREATE_NEW_LZ",
	[
		[localize "STR_AMAE_NAME", "", _teleportMarkerName, true]
	]
] call Ares_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};

// Create a function in the mission namespace on all players machines to add the
// teleport action.
Ares_addNewTeleportMarkerActions =
{
	private _newMarker = _this select 0;

	if (isNil "Ares_TeleportMarkers") then { Ares_TeleportMarkers = []; };

	{
		// TODO deal with deleted markers.... Conditions?

		// Add an action to THIS marker to teleport to OTHER marker.
		private _actionName = format [localize "STR_AMAE_TELEPORT_TO", _x getVariable ["teleportMarkerName", "??"]];
		_newMarker addAction [_actionName, {
			private _teleportTarget = _this select 3;
			if (isNil "_teleportTarget" || !(alive _teleportTarget)) then
			{
				hint localize "STR_AMAE_NO_TELEPORT_DESTINATION";
				sleep 3;
				hint "";
			}
			else
			{
				titleText [localize "STR_AMAE_YOU_ARE_BEING_TELEPORTED", "BLACK", 1];  sleep 1; titleFadeOut 2;
				player setPosATL (getPosATL _teleportTarget);
			};
		}, _x];

		// Add action to OTHER marker to teleport to THIS marker.
		_actionName = format [localize "STR_AMAE_TELEPORT_TO", _newMarker getVariable ["teleportMarkerName", "??"]];
		_x addAction [_actionName, {
			private _teleportTarget = _this select 3;
			if (isNil "_teleportTarget" || !(alive _teleportTarget)) then
			{
				hint localize "STR_AMAE_NO_TELEPORT_DESTINATION";
				sleep 3;
				hint "";
			}
			else
			{
				titleText [localize "STR_AMAE_YOU_ARE_BEING_TELEPORTED", "BLACK", 1]; sleep 1; titleFadeOut 2;
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
		[objNull, localize "STR_AMAE_OBJECT_ALREADY_TELEPORTER"] call bis_fnc_showCuratorFeedbackMessage;
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

_teleportMarkerName = _dialogResult select 0;
_teleportMarker setVariable ["teleportMarkerName", _teleportMarkerName, true];

// Make the teleport marker editable in zeus (needs to run on server)
[[_teleportMarker]] call Ares_fnc_AddUnitsToCurator;

// Call this to add the teleport marker actions on all machines. Persistent for JIP people as well.
[[_teleportMarker], "Ares_addNewTeleportMarkerActions", true, _isFirstCallToCreateTeleporter] call BIS_fnc_MP;

[objNull, format[localize "STR_AMAE_CREATED_TELEPORT", _teleportMarkerName]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
