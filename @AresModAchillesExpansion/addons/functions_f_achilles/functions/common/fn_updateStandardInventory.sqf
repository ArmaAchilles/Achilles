////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Kex
// DATE: 			30.03.18
// VERSION: 		AMAE.1.0.2
// DESCRIPTION:		Updates the standard inventory of an object.
//
// ARGUMENTS:		0: OBJECT - The object of which the inventory is updated.
//					1: ARRAY - (Default: []) The new cargo that is added or replaces the old. 
//						A nested array of weapon/magazine/backpack/item class names as string of the form
//						[[<item className list>,<item count list>], [<weapon className list>,<weapon count list>], [<magazine className list>,<magazine count list>], [<backpack className list>,<backpack count list>]].
//					2: BOOLEAN - (Default: true) True: replaces the old inventory, false: combines.
//
//
// RETURNS:			NOTHING
//
// Example:			[_ammoBox, _cargo, true] call Achilles_fnc_updateStandardInventory;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params
[
	["_object", objNull, [objNull]],
	["_cargo", [[],[],[],[]], [[]], 4],
	["_replace", true, [true]]
];

if (_replace) then
{
	clearitemcargoglobal _object;
	clearweaponcargoglobal _object;
	clearmagazinecargoglobal _object;
	clearbackpackcargoglobal _object;
};

_cargo params ["_items", "_weapons", "_magazines", "_backpacks"];

_items params ["_itemClassNames", "_itemCounts"];
for "_i" from 0 to (count _itemClassNames -1) do
{
	_object additemcargoglobal [_itemClassNames select _i, _itemCounts select _i];
};

_weapons params ["_weaponClassNames", "_weaponCounts"];
for "_i" from 0 to (count _weaponClassNames - 1) do
{
	_object addweaponcargoglobal [_weaponClassNames select _i, _weaponCounts select _i];
};

_magazines params ["_magazineClassNames", "_magazineCounts"];
for "_i" from 0 to (count _magazineClassNames - 1) do
{
	_object addmagazinecargoglobal [_magazineClassNames select _i, _magazineCounts select _i];
};

_backpacks params ["_backpackClassNames", "_backpackCounts"];
for "_i" from 0 to (count _backpackClassNames - 1) do
{
	_object addbackpackcargoglobal [_backpackClassNames select _i, _backpackCounts select _i];
};
