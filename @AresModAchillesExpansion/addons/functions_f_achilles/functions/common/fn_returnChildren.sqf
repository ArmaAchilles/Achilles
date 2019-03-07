/*
	Authors:
		NeilZar

	DESCRIPTION:
		Similar to BIS_fnc_returnChildren, but more efficient and depth is always 0.

	Parameters:
	   _this:  CONFIG - Parent config.

	Returns:
	   ARRAY - List of configs of all children

	Examples:
		(begin example)
			(configFile >> "CfgVehicles") call Achilles_fnc_returnChildren;
		(end)
*/
params [["_parentCfg", configFile, [configFile]]];

configProperties [_parentCfg, "isClass _x"];
