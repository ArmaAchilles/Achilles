/*
	Author: Joris-Jan van 't Land Modified by Eightysix & Anton Struyk

	Description:
		Function to retrieve and dynamic position in the world according to several parameters.

	Parameter(s):
		0 : Position
			ARRAY - [x,y,z] co-ordinates
		1 : ARRAY
			0 : NUMBER - minimum distance from the center
			1 : NUMBER - maximum distance from the center
		2 (Optional) : NUMBER
			minimum distance from the nearest object
		3 (Optional) : NUMBER
			0: cannot be in water
			1: can either be in water or not (Default)
			2: must be in water
		4 (Optional) : Number
			maximum terrain gradient (average altitude difference in meters - Number)

	Returns:
		Coordinate array with a position solution.
*/

scopeName "main";

params [["_pos", [], [[]]], ["_range", "", [""]], ["_objDist", getNumber(configFile >> "CfgWorlds" >> worldName >> "safePositionRadius"), [0]], ["_waterMode", 1, [0]], ["_maxGradient", 1, [0]]];

private _minDist = -1;
private _maxDist = -1;
switch (typeName _range) do {
	case (typeName []) : {
		_minDist = _range select 0;
		_maxDist = _range select 1;
	};
	case (typeName 0) : {
		_minDist = 0;
		_maxDist = _range;
	};
	default {
		_minDist = 0;
		_maxDist = getNumber(configFile >> "CfgWorlds" >> worldName >> "safePositionRadius");
	};
};

if(_objDist < 0) then {
	_objDist = getNumber(configFile >> "CfgWorlds" >> worldName >> "safePositionRadius");
};

private _newPos = [];
private _posX = _pos select 0;
private _posY = _pos select 1;
private _attempts = 0;

while {_attempts < 1000} do {
	private _newX = _posX + (_maxDist - (random (_maxDist * 2)));
	private _newY = _posY + (_maxDist - (random (_maxDist * 2)));
	private _testPos = [_newX, _newY];

	if ( (_pos distance _testPos) >= _minDist) then {
		if ! ( count(_testPos isFlatEmpty [_objDist, 0,_maxGradient,_objDist max 5,_waterMode,if(_waterMode == 0) then {false}else{true}, objNull]) == 0 ) exitWith {
			_newPos = _testPos;
		};
	};
	_attempts = _attempts + 1;
};

if ( (count _newPos) == 0 ) then {
	_newPos = _pos;
};

_newPos
