#include "\ares_zeusExtensions\Ares\module_header.hpp"

#define CAPTURE_STATE_UNKNOWN -1
#define CAPTURE_STATE_SURRENDERED 0
#define CAPTURE_STATE_SECURED 1

_unitsToSurrender = [[_logic] call Ares_fnc_GetUnitUnderCursor];

if (isNull (_unitsToSurrender select 0)) then
{
	_unitsToSurrender = [localize "STR_UNITS"] call Achilles_fnc_SelectUnits;
};

// Check to see if we've ever called this before. If not, then broadcast the necessary code to the other clients.
if (isNil "Ares_AddSurrenderActionsFunction") then
{
	// Function that is executed on each machine to correctly call addAction to
	// set the actions available on each unit that is currently captured.
	Ares_AddSurrenderActionsFunction =
	{
		_unit = _this select 0; //For readability.

		if (alive _unit) then
		{
			if (_unit getVariable["AresHasCaputreActionsAdded", -1] == -1) then
			{
				_unit addAction ["Secure", { (_this select 0) setVariable["AresCaptureState", CAPTURE_STATE_SECURED, true]; [[_this select 0], "Ares_AddSurrenderActionsFunction", true] spawn BIS_fnc_MP; }, [], 0, false, true, "", "(alive _target) && (player distance _target < 3) && (_target getVariable ['AresCaptureState', -1] == 0)"];
				_unit addAction ["Release", { (_this select 0) setVariable["AresCaptureState", CAPTURE_STATE_UNKNOWN, true]; [[_this select 0], "Ares_AddSurrenderActionsFunction", true] spawn BIS_fnc_MP; }, [], 0, false, true, "", "(alive _target) && (player distance _target < 3) && (_target getVariable ['AresCaptureState', -1] == 0)"];
				_unit setVariable ["AresHasCaputreActionsAdded", 1];
			};
			
			// Set the animation states for the units based on their current capture state.
			switch (_unit getVariable["AresCaptureState", -1]) do
			{
				case CAPTURE_STATE_UNKNOWN:
				{
					// Release the unit again (he might have been captured)
					if (local _unit) then
					{
						// No longer a captive
						_unit setCaptive false;
						
						// Re-enable the AI
						_unit enableAI "ANIM";
						_unit enableAI "TARGET";
						_unit enableAI "AUTOTARGET";
					};
					_unit switchMove "";
				};
				case CAPTURE_STATE_SURRENDERED:
				{
					if (local _unit) then
					{
						_unit setCaptive true;			// Don't let other AI target them
						[_unit] join grpNull;			// Leave the group so they don't do stupid AI things.
						
						_unit disableAI "ANIM";		// Prevent him from leaving the Surrender animation after it finishes
						_unit disableAI "TARGET";		// Prevent the unit from reacting to existing targets. Otherwise they sometimes drop out of the captured animation.
						_unit disableAI "AUTOTARGET";	// Prevent the unit from reacting to new targets. Otherwise they sometimes drop out of the captured animation.
					};
					_unit switchMove "";
					_unit playActionNow "Surrender";
				};
				case CAPTURE_STATE_SECURED:
				{
					if (local _unit) then
					{
						removeAllWeapons _unit; // TODO have them drop their stuff instead of disappearing
						_unit enableAI "ANIM";
						_unit enableAI "TARGET";
						_unit enableAI "AUTOTARGET";
						
						_unit disableAI "MOVE";
					};
					_unit switchMove "";
					_unit playActionNow "SitDown";
				};
				default
				{
					// Unknown capture state!
				};
			};
		};
	};
	publicVariable "Ares_AddSurrenderActionsFunction";
};
private _nextCaptureStateDialogResult = nil;
{
	_unitToSurrender = _x;
	// Determine if we've already captured the unit in the past
	if (alive _unitToSurrender) then
	{
		if (!isPLayer _unitToSurrender) then
		{
			_surrenderState = _unitToSurrender getVariable ["AresCaptureState", -1];
			switch (_surrenderState) do
			{
				case CAPTURE_STATE_UNKNOWN: //Not yet surrendered
				{
					//Set this for all players so can add correct actions.
					_unitToSurrender setVariable ["AresCaptureState", 0, true];

					// Broadcast to all players that this unit is surrendered. Will update their anim states in the mission.
					// We use a persistant call because we want it to be called later for JIP.
					[[_unitToSurrender], "Ares_AddSurrenderActionsFunction", true, true] spawn BIS_fnc_MP;

					[objnull, "Unit surrendered."] call bis_fnc_showCuratorFeedbackMessage;
				};
				case CAPTURE_STATE_SURRENDERED: // Surrendered but not secured
				{
					if (isNil "_nextCaptureStateDialogResult") then
					{
						_dialogResult =
							[
								"Surrendered Unit",
								[
									["Action to take:", ["Secure Unit", "Release Unit"]]
								]
							] call Ares_fnc_ShowChooseDialog;
						if (count _dialogResult > 0) then
						{
							switch (_dialogResult select 0) do
							{
								case 0: { _nextCaptureStateDialogResult = CAPTURE_STATE_SECURED; };
								case 1: { _nextCaptureStateDialogResult = CAPTURE_STATE_UNKNOWN; };
							};
						} else
						{
							_nextCaptureStateDialogResult = CAPTURE_STATE_SURRENDERED;
						};
					};
					if (_nextCaptureStateDialogResult != CAPTURE_STATE_SURRENDERED) then
					{
						//Set this for all players so can add correct actions.
						_unitToSurrender setVariable ["AresCaptureState", _nextCaptureStateDialogResult, true];

						// Broadcast to all players that this unit is surrendered. Will update their anim states in the mission.
						// We use a persistant call because we want it to be called later for JIP.
						[[_unitToSurrender], "Ares_AddSurrenderActionsFunction", true, true] spawn BIS_fnc_MP;

						[objnull, "Unit secured."] call bis_fnc_showCuratorFeedbackMessage;
					};
				};
				default // Something else (secured maybe?)
				{
					[objnull, "Unit has already been secured."] call bis_fnc_showCuratorFeedbackMessage;
				};
			};
		}
		else
		{
			[objnull, "Cannot force players to surrender."] call bis_fnc_showCuratorFeedbackMessage;
		};
	}
	else
	{
		[objnull, format["Unit must be alive. (State: %1)", (_unitToSurrender getVariable ["AresCaptureState", -1])]] call bis_fnc_showCuratorFeedbackMessage;
	};
} forEach _unitsToSurrender;

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
