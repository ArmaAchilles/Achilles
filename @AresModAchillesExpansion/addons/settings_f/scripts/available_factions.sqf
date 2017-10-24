/*
*/
Achilles_var_excludedFactions = [];

private _factions = ([configfile >> "CfgFactionClasses"] call BIS_fnc_getCfgSubClasses);
private _faction_names = [];

{
	private _faction = _x;
	private _faction_cfg_path = (configfile >> "CfgFactionClasses" >> _faction);
	if (([_faction_cfg_path, "side", -1] call BIS_fnc_returnConfigEntry) in [0,1,2]) then
	{
		private _faction_name = [_faction_cfg_path, "displayName", ""] call BIS_fnc_returnConfigEntry;
		if (not (_faction_name in _faction_names)) then
		{
			_faction_names pushBack _faction_name;
			[
				format ["Achilles_var_%1",_faction],
				"CHECKBOX",
				_faction_name,
				localize "STR_AVAILABLE_FACTIONS",
				true,
				false,
				compile 
				("
					params [""_value""]; 
					if (_value) then 
					{
						Achilles_var_excludedFactions = Achilles_var_excludedFactions - [""" + _faction_name + """]
					} else
					{
						Achilles_var_excludedFactions pushBack """ + _faction_name + """;
					};
					Achilles_var_reloadDisplay = true;
				")
			] call cba_settings_fnc_init;
		};
	};
} forEach _factions;
