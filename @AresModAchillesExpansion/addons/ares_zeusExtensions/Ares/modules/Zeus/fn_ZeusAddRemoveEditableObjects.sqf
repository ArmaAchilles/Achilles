#include "\ares_zeusExtensions\Ares\module_header.hpp"

_dialogResult = 
	[
		localize "STR_ADD_REMOVE_EDITABLE_OBJECTS",
		[
			[
				localize "STR_MODE", [localize "STR_ADD", localize "STR_REMOVE"]
			],
			[
				localize "STR_RANGE",
				[
					localize "STR_ALL_OBJECTS_IN_MISSION",
					localize "STR_ALL_OBJECTS_WITHIN" + " 50m",
					localize "STR_ALL_OBJECTS_WITHIN" + " 100m",
					localize "STR_ALL_OBJECTS_WITHIN" + " 500m",
					localize "STR_ALL_OBJECTS_WITHIN" + " 1km",
					localize "STR_ALL_OBJECTS_WITHIN" + " 2km",
					localize "STR_ALL_OBJECTS_WITHIN" + " 5km"
				], 
				1
			]
		]
	] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult > 0) then
{
	// Grab objects in the selected radius
	_objectsToRemove = [];
	if (_dialogResult select 1 == 0) then
	{
		_objectsToRemove = allMissionObjects "All";
	}
	else
	{
		_radius = 50;
		switch (_dialogResult select 1) do
		{
			case 1: { _radius = 50; };
			case 2: { _radius = 100; };
			case 3: { _radius = 500; };
			case 4: { _radius = 1000; };
			case 5: { _radius = 2000; };
			case 6: { _radius = 5000; };
			default { _radius = 50; };
		};
		_objectsToRemove = nearestObjects [(position _logic), ["All"], _radius];
	};
	_addObject = if ((_dialogResult select 0) == 0) then {true} else {false};
	
	// protect the main curator module from deletion
	_objectsToRemove = [{typeOf _this != "ModuleCurator_F"}, _objectsToRemove] call Achilles_fnc_filter;
	[_objectsToRemove, _addObject] call Ares_fnc_AddUnitsToCurator;

	_displayText = [localize "STR_ADD_OBJEKTE_TO_ZEUS", localize "STR_REMOVED_OBJEKTE_FROM_ZEUS"] select (_dialogResult select 0);
	[objNull, format [_displayText, count _objectsToRemove]] call bis_fnc_showCuratorFeedbackMessage;
};

#include "\ares_zeusExtensions\Ares\module_footer.hpp"
