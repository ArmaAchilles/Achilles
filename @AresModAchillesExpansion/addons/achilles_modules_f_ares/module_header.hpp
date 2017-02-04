// Define a scope so that inner calls can break to it if necessary to exit the logic while
// still performing cleanup. The #define is visible in all module code that #includes this.
#define MAIN_SCOPE_NAME "module_cleanup"
scopeName MAIN_SCOPE_NAME;

// Define a variable that determines if we will remove the module when we complete the
// module logic. In most cases this is desired, but some persistent objects (e.g. LZ's)
// will stick around for longer.
// TODO we should be able to just delete the module here in the header, except that there is a bunch of
// code that either (1) gets the position of _logic while executing or (2) requires the
// module to be left around (e.g. LZ's)
private ["_deleteModuleOnExit"];
_deleteModuleOnExit = true;

[format["Starting module code '%1','%2','%3' (%4)", (_this select 0), (_this select 1), (_this select 2), typename _this]] call Ares_fnc_LogMessage;

// Start a new scope, passing in the variables passed to us on creation. This scope will
// be closed in the footer, and is intentionally left open so we can break out of it
// safely.
[_this select 0, _this select 1, _this select 2] call
{
	// Store some local variables. These will be available in any module
	// script that #includes this.
	private ["_logic"];
	_logic = _this select 0;
	// _units = _this select 1; // This is never really used. We don't link these modules with anything.
	// _activated = _this select 2; // This is only used here. Dump it.
	
	[format["Inner logic running - %1,%2", _logic, (_this select 2)]], call Ares_fnc_LogMessage;

	// Stop running the module script if the module wasn't created by this instance.
	// Fixes issues where the server would delete modules before the position of the 
	// module could be determined - causing things to happen at [0,0,0]
	if (!local _logic) then { _deleteModuleOnExit = false; breakTo MAIN_SCOPE_NAME; };
	if (!(_this select 2)) then { _deleteModuleOnExit = false; breakTo MAIN_SCOPE_NAME; };
	
	// HACK - Some modules seem to fire twice. This way we don't get a race condition where they
	// are both executing their code. Assume the REAL module logic will cleanup the module if
	// necessary.
	if (_logic getVariable ["ares_hasRunModuleLogicAlready", false]) then { _deleteModuleOnExit = false; breakTo MAIN_SCOPE_NAME; };
	_logic setVariable ["ares_hasRunModuleLogicAlready", true];
	
	// The code inside the module will actually run here...
