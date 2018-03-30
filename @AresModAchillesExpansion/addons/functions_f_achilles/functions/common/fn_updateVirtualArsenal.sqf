////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Kex
// DATE: 			06.01.18
// VERSION: 		AMAE.1.0.1
// DESCRIPTION:		Updates the virtual arsenal of an object. Supports vanilla as well as ACE arsenal.
//					This function can also be used for initializing/removing the virtual arsenal.
//
// ARGUMENTS:		0: OBJECT - The object of which the virtual arsenal is updated.
//					1: ARRAY - (Default: []) The new cargo that is added or replaces the old. 
//						Either a nested array of weapon/magazine/backpack/item class names as string of the form
//						[<item list>, <weapon list>, <magazine list>, <backpack list>] or a single array with all class names.
//					2: BOOLEAN - (Default: true) True: replaces the old virtual arsenal, false: combines.
//
//
// RETURNS:			NOTHING
//
// Example:			[_ammoBox, _cargo, true] call Achilles_fnc_updateVirtualArsenal;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params
[
	["_crate",objNull,[objNull]],
	["_cargo",[],[[]]],
	["_replace",true,[true]]
];

// Update ACE arsenal
if (["arsenal"] call Achilles_fnc_isACELoaded) then
{
	private _cargoNotNested = [];
	if (not (_cargo isEqualTo []) and {(_cargo select 0) isEqualType []}) then
	{
		// flatten the array if it is nested
		{_cargoNotNested append _x} forEach _cargo;
	}
	else
	{
		_cargoNotNested = _cargo;
	};
	if (_replace) then
	{
		[_crate, true] call ace_arsenal_fnc_removeBox;
	};
	if (not (_cargoNotNested isEqualTo [])) then
	{
		[_crate, [], true] call ace_arsenal_fnc_initBox;
		[_crate, _cargoNotNested, true] call ace_arsenal_fnc_addVirtualItems;
	};
};


private _items = [];
private _weapons = [];
private _magazines = [];
private _backpacks = [];
if (not (_cargo isEqualTo []) and {(_cargo select 0) isEqualType []}) then
{
	// split the array if it is nested
	_cargo params ["_items", "_weapons", "_magazines", "_backpacks"];
}
else
{
	// assort the items if the array is not nested.
	{
		switch true do
		{
			// weapons of the type 4096 or 131072 are assignable items (e.g. NVG)
			case (getnumber (configfile >> "cfgWeapons" >> _x >> "type") in [4096,131072] or isClass (configfile >> "CfgGlasses" >> _x)):
			{
				_items pushBack _x;
			};
			case (isclass (configfile >> "cfgWeapons" >> _x)):
			{
				_weapons pushBack _x;
			};
			case (isclass (configfile >> "cfgMagazines" >> _x)):
			{
				_magazines pushBack _x;
			};
			case (isclass (configfile >> "cfgVehicles" >> _x)):
			{
				_backpacks pushBack _x;
			};
		};
	} forEach _cargo;
};
if (_replace) then
{
	_crate call bis_fnc_removeVirtualItemCargo;
	_crate call bis_fnc_removeVirtualWeaponCargo;
	_crate call bis_fnc_removeVirtualMagazineCargo;
	_crate call bis_fnc_removeVirtualBackpackCargo;
};
// Update vanilla arsenal
[_crate, _items, true] call bis_fnc_addVirtualItemCargo;
[_crate, _weapons, true] call bis_fnc_addVirtualWeaponCargo;
[_crate, _magazines, true] call bis_fnc_addVirtualMagazineCargo;
[_crate, _backpacks, true] call bis_fnc_addVirtualBackpackCargo;
