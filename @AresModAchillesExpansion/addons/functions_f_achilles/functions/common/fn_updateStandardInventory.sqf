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
{_object additemcargoglobal _x} forEach _items;
{_object addweaponcargoglobal _x} forEach _weapons;
{_object addmagazinecargoglobal _x} forEach _magazines;
{_object addbackpackcargoglobal _x} forEach _backpacks;
