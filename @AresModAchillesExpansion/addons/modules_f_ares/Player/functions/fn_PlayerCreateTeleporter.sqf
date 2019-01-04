#include "\achilles\modules_f_ares\module_header.inc.sqf"

// Set the name of the marker (used in the action)
private _teleportMarkerName = if (isNil "Ares_TeleportMarkers") then
{
	[0] call Ares_fnc_GetPhoneticName;
}
else
{
	[count Ares_TeleportMarkers] call Ares_fnc_GetPhoneticName;
};

private _dialogResult =
[
	localize "STR_AMAE_CREATE_NEW_LZ",
	[
		[localize "STR_AMAE_NAME", "", _teleportMarkerName, true]
	]
] call Ares_fnc_showChooseDialog;

if (_dialogResult isEqualTo []) exitWith {};


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
	if (_unitUnderMouseCursor getVariable ["teleportMarkerName", ""] isEqualTo "") then
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
// on first call
if (isNil "Ares_TeleportMarkers") then
{
	Ares_TeleportMarkers = [];
	
	// Create a function in the mission namespace on all players machines to add the
	// teleport action.
	Ares_fnc_updateTeleportMarkerActions =
	{
		private _actionCode =
		{
			private _teleportTarget = param[3];
			private _message = "Destination no longer exists!";
			if (not alive _teleportTarget) then
			{
				if (isLocalized "STR_AMAE_NO_TELEPORT_DESTINATION") then
				{
					_message = localize "STR_AMAE_NO_TELEPORT_DESTINATION";
				}
				else
				{
					if (Achilles_var_zeusLanguage == language) then
					{
						_message = STR_AMAE_NO_TELEPORT_DESTINATION;
					};
				};
				hint _message;
				sleep 3;
				hintSilent "";
			}
			else
			{
				private _message = "You are beeing teleported...";
				if (isLocalized "STR_AMAE_YOU_ARE_BEING_TELEPORTED") then
				{
					_message = localize "STR_AMAE_YOU_ARE_BEING_TELEPORTED";
				}
				else
				{

					if (Achilles_var_zeusLanguage == language) then
					{
						_message = STR_AMAE_YOU_ARE_BEING_TELEPORTED;
					};
				};
				titleText [_message, "BLACK", 1];
				sleep 1;
				titleFadeOut 2;
				player setPosATL (getPosATL _teleportTarget);
			};
		};
		private _actionNameFormatString =  "Teleport to %1";
		if (isLocalized "STR_AMAE_TELEPORT_TO") then
		{
			_actionNameFormatString = localize "STR_AMAE_TELEPORT_TO";
		}
		else
		{
			if (Achilles_var_zeusLanguage == language) then
			{
				_actionNameFormatString = STR_AMAE_TELEPORT_TO;
			};
		};
		private _tpMarkerCounter = count Ares_TeleportMarkers;
		for "_idx_tpMarkerA" from 0 to (_tpMarkerCounter - 1) do
		{
			private _tpMarkerA = Ares_TeleportMarkers select _idx_tpMarkerA;
			private _actionNameToA = format [_actionNameFormatString, _tpMarkerA getVariable ["teleportMarkerName", "??"]];
			removeAllActions _tpMarkerA;
			for "_idx_tpMarkerB" from 0 to (_idx_tpMarkerA - 1) do
			{
				private _tpMarkerB = Ares_TeleportMarkers select _idx_tpMarkerB;
				private _actionNameToB = format [_actionNameFormatString, _tpMarkerB getVariable ["teleportMarkerName", "??"]];
				_tpMarkerA addAction [_actionNameToB, _actionCode, _tpMarkerB];
				_tpMarkerB addAction [_actionNameToA, _actionCode, _tpMarkerA];
			};
		};
	};
	publicVariable "Ares_fnc_updateTeleportMarkerActions";
	STR_AMAE_NO_TELEPORT_DESTINATION = localize "STR_AMAE_NO_TELEPORT_DESTINATION";
	publicVariable "STR_AMAE_NO_TELEPORT_DESTINATION";
	STR_AMAE_YOU_ARE_BEING_TELEPORTED = localize "STR_AMAE_YOU_ARE_BEING_TELEPORTED";
	publicVariable "STR_AMAE_YOU_ARE_BEING_TELEPORTED";
	STR_AMAE_TELEPORT_TO = localize "STR_AMAE_TELEPORT_TO";
	publicVariable "STR_AMAE_TELEPORT_TO";
	Achilles_var_zeusLanguage = language;
	publicVariable "Achilles_var_zeusLanguage";
	_isFirstCallToCreateTeleporter = true;
};

// update teleport marker list
Ares_TeleportMarkers = Ares_TeleportMarkers select {alive _x};
Ares_TeleportMarkers pushBack _teleportMarker;
publicVariable "Ares_TeleportMarkers";

// set teleporter name
_dialogResult params ["_teleportMarkerName"];
_teleportMarker setVariable ["teleportMarkerName", _teleportMarkerName, true];

// Call this to add the teleport marker actions on all machines. Persistent for JIP people as well.
remoteExecCall ["Ares_fnc_updateTeleportMarkerActions", 0, _isFirstCallToCreateTeleporter];

// Make the teleport marker editable in Zeus (needs to run on server)
[[_teleportMarker]] call Ares_fnc_AddUnitsToCurator;

[objNull, format[localize "STR_AMAE_CREATED_TELEPORT", _teleportMarkerName]] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.inc.sqf"
