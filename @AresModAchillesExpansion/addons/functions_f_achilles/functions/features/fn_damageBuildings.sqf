/*
	Function:
		Achilles_fnc_damageBuildings
	
	Authors:
		Kex
	
	Description:
		Damages/Reinstates buildings
	
	Parameters:
		_buildings		- <ARRAY> of <OBJECT> List of buildings to be processed
		_meanMode		- <SCALAR> Mean damage type: 0 => none; 1 => slight; 2 => severe; 3 => full
		_distMode		- <SCALAR> Type of distribution: 0 => delta; 1 => uniform; 2 => normal
		_doSimulate		- <BOOL> If false, then destruction transition effects are disabled
	
	Returns:
		Nothing
	
	Examples:
		(begin example)
			[_buildings, 2, 2] call Achilles_fnc_damageBuildings;
		(end)
*/
params
[
	["_buildings", [], [[]]],
	["_meanMode", 0, [0]],
	["_distMode", 0, [0]],
	["_doSimulate", true, [true]]
];

private _fnc_getDamageType = switch (_distMode) do
{
	case 0: {compile (str _meanMode)};
	case 1: {round (random 3)};
	// Normally distributes mean damage for buildings
	case 2: {compile ("round (random [0," + (str _meanMode) + ",3])")};
};

{
	private _building = _x;
	private _damageType = [] call _fnc_getDamageType;
	switch (_damageType) do
	{
		case 0: {_building setDamage [0, _doSimulate]};
		case 1: {_building setDamage [0.8, _doSimulate]};
		case 2:
		{
			_building setDamage [0.5, _doSimulate];
			private _allHitPoints = getAllHitPointsDamage _building;
			if (count _allHitPoints > 0) then
			{
				private _hitzones = [];
				private _other = [];
				{
					private _index  = _x find "Hitzone";
                    if (_index == -1) then {_other pushBack _forEachIndex} else {_hitzones pushBack _forEachIndex};
				} forEach (_allHitPoints select 0);

				if (count _other > 0) then
				{
					{
						[_building, [_x, 1, _doSimulate]] remoteExecCall ["setHitIndex", 0];
					} forEach _other;
				};
				private _counter = count _hitzones;
				if (_counter > 0) then
				{
					private _extendCount = ceil ((random 1) * _counter);
					for "_i" from 1 to _extendCount do
					{
						private _hitzone = selectRandom _hitzones;
						[_building,  [_hitzone, 1, _doSimulate]] remoteExecCall ["setHitIndex", 0];
						_hitzones = _hitzones - [_hitzone];
					};
				};
			};
		};
		case 3: {_building setDamage [1, _doSimulate]};
	};
} forEach (_buildings select {!isNull _x});
