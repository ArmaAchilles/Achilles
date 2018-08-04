params
[
	["_unit", objNull, [objNull]],
	["_params", [], [[]]]
];
if (local _unit) then
{
	([_unit] + _params) spawn Achilles_fnc_ambientAnim;
}
else
{
	([_unit] + _params) remoteExec ["Achilles_fnc_ambientAnim", _unit];
};
