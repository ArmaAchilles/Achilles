/*
	Author: CreepPork_LV

	Description:
    Creates a dummy object that attaches to the logic that then can be broadcasted to the server.

  Parameters:
    _this select: 0 - OBJECT - Logic

  Returns:
    OBJECT - Dummy object
*/

params [["_logic", objNull, [objNull]]];

if (isNull _logic) exitWith {};

private _dummyObject = (createGroup sideLogic) createUnit ["Module_f", (getPos _logic), [], 0, "CAN_COLLIDE"];

_logic setVariable ["slave", _dummyObject];
_dummyObject setVariable ["master", _logic];

_dummyObject;