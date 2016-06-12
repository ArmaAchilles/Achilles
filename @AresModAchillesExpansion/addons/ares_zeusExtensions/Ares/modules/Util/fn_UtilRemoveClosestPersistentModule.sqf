#include "\ares_zeusExtensions\Ares\module_header.hpp"

_allObjects =
	(allMissionObjects "Ares_Module_Behaviour_Create_Artillery_Target")
	+ (allMissionObjects "Ares_Module_Reinforcements_Create_Lz")
	+ (allMissionObjects "Ares_Module_Reinforcements_Create_Rp");

_itemToDelete = [position _logic, _allObjects] call Ares_fnc_GetNearest;
if (isNull _itemToDelete || (_itemToDelete distance _logic) > 15) then
{
	[objNull, "No Nearby Module Found"] call bis_fnc_showCuratorFeedbackMessage;
}
else
{
	deleteVehicle _itemToDelete;
	[objNull, "Deleted Module"] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
