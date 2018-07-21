/*
*/
Achilles_var_excludedFactions = [];

private _factions = ([configfile >> "CfgFactionClasses"] call BIS_fnc_getCfgSubClasses);
private _factionNames = [];

{
	private _faction = _x;
	private _factionCfgPath = (configfile >> "CfgFactionClasses" >> _faction);
	if (([_factionCfgPath, "side", -1] call BIS_fnc_returnConfigEntry) in [0,1,2,3]) then
	{
		private _factionName = [_factionCfgPath, "displayName", ""] call BIS_fnc_returnConfigEntry;
		if (not (_factionName in _factionNames)) then
		{
			_factionNames pushBack _factionName;
			[
				format ["Achilles_var_%1",_faction],
				"CHECKBOX",
				_factionName,
				localize "STR_AMAE_AVAILABLE_FACTIONS",
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
						Achilles_var_excludedFactions pushBack """ + _factionName + """;
					};
					Achilles_var_reloadDisplay = true;
					uiNamespace setVariable [""Achilles_var_nestedList_vehicleFactions"", []];
					uiNamespace setVariable [""Achilles_var_supplyDrop_factions"", []];
				")
			] call cba_settings_fnc_init;
		};
	};
} forEach _factions;
