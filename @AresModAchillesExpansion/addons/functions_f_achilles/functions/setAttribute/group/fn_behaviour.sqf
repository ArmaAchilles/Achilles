params
[
	["_group", grpNull, [grpNull]],
	["_params", [], [[]]]
];
_params params
[
	["_combatMode", "", [""]],
	["_behaviour", "", [""]]
];
if (local _group) then
{
	_group setCombatMode _combatMode;
	_group setBehaviour _behaviour;
}
else
{
	[_group, _combatMode] remoteExecCall ["setCombatMode", _group];
	[_group, _behaviour] remoteExecCall ["setBehaviour", _group];
};
