/*
*/
Achilles_var_excludedFactions = [];

private _factions = ([configfile >> "CfgFactionClasses"] call BIS_fnc_getCfgSubClasses);
_factions =
[
	_factions,
	[],
	{
		private _faction = _x;
		private _factionCfg = (configfile >> "CfgFactionClasses" >> _faction);
		getText (_factionCfg >> "displayName");
	}
] call BIS_fnc_sortBy;

{
	private _faction = _x;
	private _factionCfg = (configfile >> "CfgFactionClasses" >> _faction);
	private _sideId = [_factionCfg, "side", -1] call BIS_fnc_returnConfigEntry;
	if (_sideId in [0,1,2,3]) then
	{
		private _factionName = getText (_factionCfg >> "displayName");
		private _sideName = [_sideId] call BIS_fnc_sideName;
		[
			format ["Achilles_var_%1", _faction],
			"CHECKBOX",
			_factionName,
			[localize "STR_AMAE_AVAILABLE_FACTIONS", _sideName],
			true,
			false,
			compile 
			("
				params [""_value""]; 
				if (_value) then 
				{
					Achilles_var_excludedFactions = Achilles_var_excludedFactions - [""" + _factionName + """]
				} else
				{
					Achilles_var_excludedFactions pushBackUnique """ + _factionName + """;
				};
				Achilles_var_reloadDisplay = true;
				uiNamespace setVariable [""Achilles_var_nestedList_vehicleFactions"", []];
				uiNamespace setVariable [""Achilles_var_supplyDrop_factions"", []];
			")
		] call cba_settings_fnc_init;
	};
} forEach _factions;
