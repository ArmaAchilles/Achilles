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

private _dummyObject = "Land_HelipadEmpty_F" createVehicle (getPos _logic);

_dummyObject attachTo [_logic];

_logic addEventHandler ["Deleted", {
	_logic removeEventHandler ["Deleted", 0];
	deleteVehicle _dummyObject;
}];

_dummyObject;