Achilles_var_availableModuleClasses = [];

private _achillesModuleClasses = (getArray (configFile >> "cfgPatches" >> "achilles_modules_f_ares" >> "units"));
_achillesModuleClasses append (getArray (configFile >> "cfgPatches" >> "achilles_modules_f_achilles" >> "units"));
_achillesModuleClasses =
[
	_achillesModuleClasses,
	[], 
	{
		private _moduleClass = _x;
		private _moduleCfg = configFile >> "cfgVehicles" >> _moduleClass;
		getText (_moduleCfg >> "displayName");
	}
] call BIS_fnc_sortBy;

{
	private _moduleClass = _x;
	private _moduleCfg = configFile >> "cfgVehicles" >> _moduleClass;
	private _moduleName = getText (_moduleCfg >> "displayName");
	private _categoryClass = getText (_moduleCfg >> "category");
	private _categoryName = getText (configFile >> "CfgFactionClasses" >> _categoryClass >> "displayName");
	[
		format ["Achilles_var_%1", _moduleClass],
		"CHECKBOX",
		_moduleName,
		[localize "STR_AMAE_AVAILABLE_MODULES", _categoryName],
		true,
		false,
		compile 
		("
			params [""_value""];
			if (_value) then 
			{
				Achilles_var_availableModuleClasses pushBackUnique """ + _moduleClass + """;
			} else
			{
				Achilles_var_availableModuleClasses = Achilles_var_availableModuleClasses - [""" + _moduleClass + """];
			};
			Achilles_var_reloadDisplay = true;
		")
	] call cba_settings_fnc_init;
} forEach _achillesModuleClasses;
