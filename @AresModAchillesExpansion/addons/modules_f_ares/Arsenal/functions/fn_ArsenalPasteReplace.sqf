#include "\achilles\modules_f_ares\module_header.hpp"

private _ammoBox = [_logic] call Ares_fnc_GetUnitUnderCursor;
if (not isnull _ammoBox) then
{
	// Clear out any previous text from the dialog. We do this so it behaves consistently
	// in dedicated and local servers.
	Ares_CopyPaste_Dialog_Text = '';

	private _parsedValue = [] call Ares_fnc_GetArrayDataFromUser;
	if (typeName _parsedValue == typeName []) then
	{
		[_ammoBox, _parsedValue, true] call Ares_fnc_ArsenalSetup;
		[objNull, "Arsenal objects added."] call bis_fnc_showCuratorFeedbackMessage;
	}
	else
	{
		if (_parsedValue == "CANCELLED") then
		{
			// Do nothing. The paste was cancelled by the user.
		}
		else
		{
			[objNull, format ["%1. Was the data in the right format?", _parsedValue]] call bis_fnc_showCuratorFeedbackMessage;
		};
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"
