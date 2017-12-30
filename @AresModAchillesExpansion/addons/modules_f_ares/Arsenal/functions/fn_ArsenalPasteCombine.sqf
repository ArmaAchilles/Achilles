#include "\achilles\modules_f_ares\module_header.hpp"

private _ammoBox = [_logic] call Ares_fnc_GetUnitUnderCursor;
if (!isnull _ammoBox) then
{
	// Clear out any previous text from the dialog. We do this so it behaves consistently
	// in dedicated and local servers.
	Ares_CopyPaste_Dialog_Text = '';

	private _parsedValue = [] call Ares_fnc_GetArrayDataFromUser;
	if (_parsedValue isEqualType []) then
	{
		[_ammoBox, _parsedValue, false] call Ares_fnc_ArsenalSetup;
		[objNull, "Arsenal objects added."] call bis_fnc_showCuratorFeedbackMessage;
	}
	else
	{
		if (_parsedValue != "CANCELLED") then
		{
			[objNull, format ["%1. Was the data in the right format?", _parsedValue]] call bis_fnc_showCuratorFeedbackMessage;
		};
	};
};

#include "\achilles\modules_f_ares\module_footer.hpp"
