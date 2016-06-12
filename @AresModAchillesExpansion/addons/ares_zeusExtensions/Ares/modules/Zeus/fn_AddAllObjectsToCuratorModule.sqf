#include "\ares_zeusExtensions\Ares\module_header.hpp"

_dialogResult = [
	"Add Objects To Curator",
	[
		[
			"Add...",
			[
				"All units in mission",
				"All units within 50m",
				"All units within 100m",
				"All units within 500m",
				"All units within 1km",
				"All units within 2km",
				"All units within 5km"
			],
			1
		]
	]] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult > 0) then
{
	// Grab the objects in the chosen radius
	_objectsToAdd = [];
	if (_dialogResult select 0 == 0) then
	{
		_objectsToAdd = allMissionObjects "All";
	}
	else
	{
		_radius = 50;
		switch (_dialogResult select 0) do
		{
			case 1: { _radius = 50; };
			case 2: { _radius = 100; };
			case 3: { _radius = 500; };
			case 4: { _radius = 1000; };
			case 5: { _radius = 2000; };
			case 6: { _radius = 5000; };
			default { _radius = 50; };
		};
		_objectsToAdd = nearestObjects [(position _logic), ["All"], _radius];
	};

	// Filter the list to remove items in the blacklist
	if (_dialogResult select 0 != 0) then
	{
		_filteredList = [];
		{
			if (not ((typeOf _x) in Ares_EditableObjectBlacklist)) then
			{
				_filteredList pushBack _x;
			};
		} forEach _objectsToAdd;
		_objectsToAdd = _filteredList;
	};
	
	[_objectsToAdd] call Ares_fnc_AddUnitsToCurator;

	[objNull, format["Added %1 objects to curator.", count _objectsToAdd]] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
