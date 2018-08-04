params
[
	["_unit", objNull, [objNull]],
	["_loadout", [], [[]]]
];
if (local _unit) then
{
	_unit setUnitLoadout _loadout;
}
else
{
	[_unit, _loadout] remoteExecCall ["setUnitLoadout", _unit];
};
