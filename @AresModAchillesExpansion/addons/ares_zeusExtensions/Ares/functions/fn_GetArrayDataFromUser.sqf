/*
	Displays a dialog that prompts the user to paste some data. If the data is parsed it will be
	returned. Otherwise a string will be returned with an error message.
	
	Params:
		0 - (Optional) [Integer] - The number of elements that should be in the pasted array. Default -1 (unknown).

	Returns:
		Success - The parsed array that was pasted in.
		Failure - A string containing the error message that indicates the reason the paste failed.
		Cancelled - The string "CANCELLED"
*/

_numberOfElements = [_this, 0, -1, [0]] call BIS_fnc_param;

// Show the paste dialog to the user
_returnValue = "CANCELLED";
missionNamespace setVariable ["Ares_CopyPaste_Dialog_Result", ""];
_dialog = createDialog "Ares_CopyPaste_Dialog";
waitUntil { dialog };
waitUntil { !dialog };
_dialogResult = missionNamespace getVariable ["Ares_CopyPaste_Dialog_Result", -1];
if (_dialogResult == 1) then
{
	_pastedText = missionNamespace getVariable ["Ares_CopyPaste_Dialog_Text", "[]"];
	try
	{
		if (isNil { call (compile _pastedText) }) then
		{
			throw "Failed to parse";
		};
		_objectArray = call (compile _pastedText);
		if (typeName _objectArray != typeName []) then
		{
			throw "Bad clipboard data";
		};
		if (_numberOfElements != -1 && ((count _objectArray) != _numberOfElements)) then
		{
			throw "Wrong number of elements in array";
		};
		_returnValue = _objectArray;
	}
	catch
	{
		_returnValue = _exception;
	};
};
_returnValue;
