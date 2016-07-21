/*
	Runs a block of code on remote machines in a one-off function. Not suitable for calls that must happen for
	JIP players, but good to execute things on the server or as a one-time operation for everyone connected.

	If this function will be called frequently, consider making a custom function for it so we can only sync the
	code block one time. (e.g. Ares_fnc_AddUnitsToCurator).

	Params:
		0 - Code - The block of code to execute remotely.
		1 - Anything - (Optional) The parameters to pass to the code. Default: [].
		2 - Bool - (Optional) False if this should run only on the server, true if it should be run everywhere (including this machine). Default: true.
*/

params ["_codeBlock", ["_params", []], ["_target", 0], ["_jipReady", false, [false]]];
[_params, _codeBlock] remoteExec ["bis_fnc_call", _target, _jipReady];
true;
