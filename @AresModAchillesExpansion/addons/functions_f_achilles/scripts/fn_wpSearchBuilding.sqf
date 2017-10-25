params [["_group", 0, grpNull, [grpNull]], ["_position", 1, [0,0,0], [[]]]];

(units _group) doMove _position;
waitUntil {sleep 1; (leader _group) distance _position < 20};
doStop (units _group);

[_group, 50, "NEAREST", _position, true, false, false, false] call Ares_fnc_SearchBuilding;