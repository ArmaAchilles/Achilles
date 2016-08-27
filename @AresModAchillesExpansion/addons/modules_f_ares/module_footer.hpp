	// ...
	// End of the 'inner' scope that was opened in the header where
	// all of the module logic actuall executes.
};

// Cleanup the module if the script logic didn't tell us not to.
if (_deleteModuleOnExit) then
{
	["Deleting %1", (_this select 0)] call Ares_fnc_LogMessage;
	deleteVehicle (_this select 0);
}
else
{
	["Not deleting logic module."] call Ares_fnc_LogMessage;
};

[format["Finished module code '%1','%2','%3' (%4)", (_this select 0), (_this select 1), (_this select 2), typename _this]] call Ares_fnc_LogMessage;

// Return how happy we are (best practice)
true