// Infantry Occupy House
// by Zenophon
// Released under Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
// http://creativecommons.org/licenses/by-nc/4.0/

// Teleports the units to random windows of the building(s) within the distance
// Faces units in the right direction and orders them to stand up or crouch on a roof
// Units will only fill the building to as many positions as are at windows
// Multiple buildings can be filled either evenly or to the limit of each sequentially
// Usage : Call
// Params: 1. Array, the building(s) nearest this position is used
//         2. Array of objects, the units that will garrison the building(s)
//         3. Scalar, radius in which to fill building(s), -1 for only nearest building
//         4. Boolean, true to put units on the roof, false for only inside
//         5. Boolean, true to fill all buildings in radius evenly, false for one by one
// Return: Array of objects, the units that were not garrisoned

#define I(X) X = X + 1;
#define EYE_HEIGHT 1.53
#define CHECK_DISTANCE 5
#define FOV_ANGLE 10
#define ROOF_CHECK 4
#define ROOF_EDGE 2

private [];

params ["_center", "_units", "_buildingRadius", "_putOnRoof", "_fillEvenly"];

private _Zen_ExtendPosition = {
    params ["_center", "_dist", "_phi"];

    ([(_center select 0) + (_dist * (cos _phi)),(_center select 1) + (_dist * (sin _phi)), (_this select 3)])
};

private _buildingsArray = [];
_buildingsArray = if (_buildingRadius < 0) then {[nearestBuilding _center]} else {nearestObjects [_center, ["building"], _buildingRadius, true]};

private _buildingPosArray = [];
{
    private _buildingPositions = 0;
    for "_i" from 0 to 100 do {
        if ((_x buildingPos _buildingPositions) isEqualTo [0,0,0]) exitWith {};
        I(_buildingPositions)
    };

    private _posArray = [];
    for "_i" from 0 to (_buildingPositions - 1) do {
        _posArray pushBack _i;
    };

    _buildingPosArray set [_forEachIndex, _posArray];
} forEach _buildingsArray;

private _unitIndex = 0;
private _j = 0;
for [{_j = 0}, {(_unitIndex < count _units) && {(count _buildingPosArray > 0)}}, {I(_j)}] do {
    scopeName "for";

    private _building = _buildingsArray select (_j % (count _buildingsArray));
    private _posArray = _buildingPosArray select (_j % (count _buildingsArray));

    if (_posArray isEqualTo []) then {
        _buildingsArray set [(_j % (count _buildingsArray)), 0];
        _buildingPosArray set [(_j % (count _buildingPosArray)), 0];
        _buildingsArray = _buildingsArray - [0];
        _buildingPosArray = _buildingPosArray - [0];
    };

    while {(count _posArray) > 0} do {
        scopeName "while";
        if (_unitIndex >= count _units) exitWith {};

        private _randomIndex = floor random count _posArray;
        private _housePos = _building buildingPos (_posArray select _randomIndex);
        _housePos = [(_housePos select 0), (_housePos select 1), (_housePos select 2) + (getTerrainHeightASL _housePos) + EYE_HEIGHT];

        _posArray set [_randomIndex, _posArray select (count _posArray - 1)];
        _posArray resize (count _posArray - 1);

        private _startAngle = (round random 10) * (round random 36);
        for "_i" from _startAngle to (_startAngle + 350) step 10 do {
            private _checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2)] call _Zen_ExtendPosition;
            if !(lineIntersects [_checkPos, [_checkPos select 0, _checkPos select 1, (_checkPos select 2) + 25], objNull, objNull]) then {
                if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                    _checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) + (CHECK_DISTANCE * sin FOV_ANGLE / cos FOV_ANGLE)] call _Zen_ExtendPosition;
                    if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                        private _hitCount = 0;
                        for "_k" from 30 to 360 step 30 do {
                            _checkPos = [_housePos, 20, (90 - _k), (_housePos select 2)] call _Zen_ExtendPosition;
                            if (lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                                I(_hitCount)
                            };

                            if (_hitCount >= ROOF_CHECK) exitWith {};
                        };

                        private _isRoof = (_hitCount < ROOF_CHECK) && {!(lineIntersects [_housePos, [_housePos select 0, _housePos select 1, (_housePos select 2) + 25], objNull, objNull])};
                        if (!(_isRoof) || {((_isRoof) && {(_putOnRoof)})}) then {
                            private _edge = false;
                            if (_isRoof) then {
                                for "_k" from 30 to 360 step 30 do {
                                    _checkPos = [_housePos, ROOF_EDGE, (90 - _k), (_housePos select 2)] call _Zen_ExtendPosition;
                                    _edge = !(lineIntersects [_checkPos, [(_checkPos select 0), (_checkPos select 1), (_checkPos select 2) - EYE_HEIGHT - 1], objNull, objNull]);

                                    if (_edge) exitWith {
                                        _i = _k;
                                    };
                                };
                            };

                            if (!(_isRoof) || {_edge}) then {
                                (_units select _unitIndex) setPosASL [(_housePos select 0), (_housePos select 1), (_housePos select 2) - EYE_HEIGHT];
                                (_units select _unitIndex) setDir (_i );

                                if (_isRoof) then {(_units select _unitIndex) setUnitPos "MIDDLE"} else {(_units select _unitIndex) setUnitPos "UP"};
                                (_units select _unitIndex) doWatch ([_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) - (getTerrainHeightASL _housePos)] call _Zen_ExtendPosition);
                                //doStop (_units select _unitIndex);
								//(_units select _unitIndex) disableAI "MOVE";
								(_units select _unitIndex) forceSpeed 0;

                                I(_unitIndex)
                                [breakTo "while", breakTo "for"] select _fillEvenly;
                            };
                        };
                    };
                };
            };
        };
    };
};

private _unUsedUnits = [];

for "_i" from _unitIndex to (count _units) - 1 do {
    _unUsedUnits pushBack (_units select _i);
};

(_unUsedUnits)

// Changelog

// 7/31/14
    // 1. Added: Parameter to cycle through each building in the radius, giving units to each one
    // 2. Improved: Units on roof are only placed at the edge, and face the edge
    // 3. Improved: Optimized roof check
    // 4. Improved: General script cleanup

// 7/28/14
    // 1. Fixed: Units facing the wrong window
    // 2. Added: Parameter for distance to select multiple buildings
    // 3. Added: Parameter for units being on a roof
    // 4. Improved: Now checks that unit has a good FOV from the windows
    // 5. Improved: Units can no longer face a windows greater than 5 meters away
    // 6. Improved: Units on a roof now crouch
    // 7. Tweaked: Height of human eye to the exact value in ArmA

// 7/24/14
    // Initial Release

// Known Issues
    // None
