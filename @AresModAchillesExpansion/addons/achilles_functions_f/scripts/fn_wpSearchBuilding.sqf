
_group = param [0,grpNull,[grpNull]];
_position = param [1,[0,0,0],[[]]];

(units _group) doMove _position;
waitUntil {sleep 1; (leader _group) distance _position < 20};
doStop (units _group);

_codeBlock = compile preprocessFileLineNumbers '\achilles\functions_f_ares\features\fn_SearchBuilding.sqf';
_test = [_group, 50, "NEAREST", _position, true, false, false, false] call _codeBlock;