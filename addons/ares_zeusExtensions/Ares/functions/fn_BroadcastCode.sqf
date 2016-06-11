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

_codeBlock = _this select 0;
_params = param [1, []];
_targetMachines = param [2, 0, [0]];

Ares_oneshotCodeBlock = _codeBlock;
if (_targetMachines == 2) then {publicVariableServer "Ares_oneshotCodeBlock";} else {publicVariable "Ares_oneshotCodeBlock";};

_params remoteExec ["Ares_oneshotCodeBlock",_targetMachines];

true;
