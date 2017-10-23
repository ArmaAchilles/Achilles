////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/12/17
//	VERSION: 2.0
//  DESCRIPTION: remote function for "damage building" module
//
//	ARGUMENTS:
//	_this select 0		ARRAY  - Array of buildings to damage
//  _this select 1		SCALAR - mean damage type: 0 => none; 1 => slight; 2 => severe; 3 => full
//	_this select 2		SCALAR - type of distribution: 0 => delta; 1 => uniform; 2 => normal
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_buildings,2,2] call Achilles_fnc_damageBuildings;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// get params
private _buildings = param [0,[],[[]]];
private _mean_damage_type = param [1,0,[0]];
private _distribution_type = param [2,0,[0]];

private _fnc_getDamageType = switch (_distribution_type) do
{
	case 0: {compile (str _mean_damage_type)};
	case 1: {{round (random 3)}};
	case 2: {compile ("round (random [0," + (str _mean_damage_type) + ",3])")};
};

{
	private _building = _x;
	private _damage_type = [] call _fnc_getDamageType;
	switch (_damage_type) do
	{
		case 0: {_building setDamage 0};
		case 1: {_building setDamage 0.8};
		case 2:
		{
			_building setDamage 0.5;
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
						_building setHitIndex [_x,1];
					} forEach _other;
				};
				private _counter = count _hitzones;
				if (_counter > 0) then
				{
					_extend_count = ceil ((random 1) * _counter);
					for "_i" from 1 to _extend_count do
					{
						_hitzone = selectRandom _hitzones;
						_building setHitIndex [_hitzone,1];
						_hitzones = _hitzones - [_hitzone];
					};
				};
			};
		};
		case 3: {_building setDamage 1};
	}; 	
} forEach _buildings;