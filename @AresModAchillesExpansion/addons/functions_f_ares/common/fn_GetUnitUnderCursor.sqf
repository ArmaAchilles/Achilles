/*
	Gets the unit under the mouse cursor.

	Params:
		0 - [Object] The module's logic unit that is trying to get the unit under the cursor.
		1 - Boolean - True to remove the object passed in [0] if there is no unit under the cursor. False to leave it. (Default: True)
	Returns:
		The unit under the cursor (if any). Otherwise the logic unit parameter is deleted.
*/
private ["_logic", "_unitUnderCursor"];
_logic = _this select 0;
private _shouldRemoveLogicIfNoUnitFound = [_this, 1, true] call BIS_fnc_Param;

_unitUnderCursor = objNull;

// We use the value we set when the last object was created. This is because when we call this
// (inside the module's logic) the object under the mouse is always going to be the newly created
// logic module, and not the actual object that is underneath it. We want to know what the object
// was under the mouse when the module itself was created - under the assumption that the last object
// created was the module, and that the mouse was actually on the object we want when the event
// got fired.
// TODO we could eliminate this issue if we always deleted the logic BEFORE we tried to get
// the item under the cursor.
if (isNil "Ares_CuratorObjectPlaced_UnitUnderCursor") then
{
	["GetUnitUnderCursor: Ares_CuratorObjectPlaced_UnitUnderCursor is null. Probably the fn_HandleCuratorObjectPlaced callback did not happen."] call Achilles_fnc_logMessage;
}
else
{
	private _mouseOverUnit = Ares_CuratorObjectPlaced_UnitUnderCursor;
	if (_mouseOverUnit isEqualTo []) then
	{
		["GetUnitUnderCursor: Not in curator mode"] call Achilles_fnc_logMessage;
		// Not in curator mode.
	}
	else
	{
		["GetUnitUnderCursor: In curator mode!"] call Achilles_fnc_logMessage;
		if (_mouseOverUnit select 0 == "") then
		{
			["GetUnitUnderCursor: No unit under cursor"] call Achilles_fnc_logMessage;
			// Mouse not over anything editable (value should be [""])
		}
		else
		{
			["GetUnitUnderCursor: Elements in select array!"] call Achilles_fnc_logMessage;
			if (count _mouseOverUnit == 2) then
			{
				if (_mouseOverUnit select 0 == "OBJECT") then
				{
					// value should be [typeName, object]
					_unitUnderCursor = _mouseOverUnit select 1;
					[format ["GetUnitUnderCursor: Got unit under cursor: %1 (@%2)", _unitUnderCursor, position _unitUnderCursor]] call Achilles_fnc_logMessage;
				}
				else
				{
					[format ["GetUnitUnderCursor: Unit under cursor was of type '%1' (non-Object). Ignored."]] call Achilles_fnc_logMessage;
				}
			}
			else
			{
				["GetUnitUnderCursor: Unexpected number of array options"] call Achilles_fnc_logMessage;
			};
		};
	};
};

if (_shouldRemoveLogicIfNoUnitFound && isNull _unitUnderCursor) then
{
	playSound "FD_Start_F";
	[objNull, localize "STR_NOT_PLACED_ON_UNIT"] call bis_fnc_showCuratorFeedbackMessage;
	deleteVehicle _logic;
};

_unitUnderCursor;
