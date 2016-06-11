#include "\ares_zeusExtensions\Ares\module_header.hpp"

// Ask the user for the radius to copy from.
_dialogResult = ["Crate Compisition From Objects", ["Radius of copy", ["50m", "100m", "500m", "1km", "2km", "5km" ]]] call Ares_fnc_ShowChooseDialog;
[format["User chose radius with index '%1'", _dialogResult]] call Ares_fnc_LogMessage;
if (count _dialogResult > 0) then
{
	_radius = 100;
	switch (_dialogResult select 0) do
	{
		case 0: { _radius = 50; };
		case 1: { _radius = 100; };
		case 2: { _radius = 500; };
		case 3: { _radius = 1000; };
		case 4: { _radius = 2000; };
		case 5: { _radius = 5000; };
		default { _radius = 100; };
	};
	
	_text = [_logic, _radius] call Ares_fnc_CompositionGrabber;

	//missionNamespace setVariable ['Ares_CopyPaste_Dialog_Text', _text];
	//_dialog = createDialog "Ares_CopyPaste_Dialog";

	[objNull, format["Created from objects in %1 metre radius. Check RPT.", _radius]] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
