////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Kex
// DATE: 			12/26/17
// VERSION: 		AMAE.1.0.0
// DESCRIPTION:		Similar to BIS_fnc_returnChildren, but more efficient and depth is always 0.
//
// ARGUMENTS:		0: CONFIG - Parent config.
//
// RETURNS:			ARRAY - List of configs of all children
//
// Example:			(configFile >> "CfgVehicles") call Achilles_fnc_returnChildren;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params [["_parent_cfg",configFile,[configFile]]];
private _cfg_list = [];

for "_i" from 0 to (count _parent_cfg - 1) do
{
	private _child_cfg = _parent_cfg select _i;
	if(isClass _child_cfg) then {_cfg_list pushBack _child_cfg};
};
_cfg_list;
