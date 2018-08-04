params
[
	["_unit", objNull, [objNull]],
	["_params", [], [[]]]
];
{
	_x params
	[
		"_ability", 
		["_enabled", true, [false]]
	];
	if (_enabled) then
	{
		if (local _unit) then
		{
			_unit enableAI _ability;
		}
		else
		{
			[_unit, _ability] remoteExecCall ["enableAI", _unit];
		};
	}
	else
	{
		if (local _unit) then
		{
			_unit disableAI _ability;
		}
		else
		{
			[_unit, _ability] remoteExecCall ["disableAI", _unit];
		};
	};
} forEach _params;
