params [["_group", grpNull, [grpNull]], ["_position", [0,0,0], [[]]]];

(units _group) doMove _position;
waitUntil
{
	sleep 1; 
	(leader _group) distance _position < 20) or {{alive _x} count units _group > 0};
};
doStop (units _group);

[_group, 50, "NEAREST", _position, true, false, false, false] call Ares_fnc_SearchBuilding;