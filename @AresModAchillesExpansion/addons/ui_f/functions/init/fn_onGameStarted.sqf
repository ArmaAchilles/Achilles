
disableSerialization;
private _display = _this;

//_currentVersion = getText (configFile >> "CfgPatches" >> "achilles_ui_f" >> "versionStr");

/*if (_currentVersion != profileNamespace getVariable ["Achilles_var_lastVersion", ""]) then*/
if (true) then
{
	_display createDisplay "Ares_Welcome_Dialog";
	//profileNamespace setVariable ["Achilles_var_lastVersion", _currentVersion];
	//saveProfileNamespace;
};
