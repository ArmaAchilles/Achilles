////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTHOR: 			Kex
// DATE: 			06.01.18
// VERSION: 		AMAE.1.0.1
// DESCRIPTION:		Returns the virtual arsenal of an object. Supports vanilla as well as ACE arsenal.
//
// ARGUMENTS:		0: OBJECT - The object of which the virtual arsenal is inspected.
//					1: BOOLEAN - (Default: true) True: returns a nested array of weapon/magazine/backpack/item class names as string
//						of the form [<item list>, <weapon list>, <magazine list>, <backpack list>], false: returns a single array with
//						all class names.
//
//
// RETURNS:			ARRAY - Returns the cargo in a format that depends on argument _this select 1.
//
// Example:			_cargo = [_ammoBox, true] call Achilles_fnc_getVirtualArsenal;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params
[
	["_crate",objNull,[objNull]],
	["_returnNested",true,[true]]
];

private _return = [];


if (["arsenal"] call Achilles_fnc_isACELoaded) then
{
	private _cargo = _crate getVariable ["ace_arsenal_virtualItems", []];

	if (_returnNested) then
	{
		if (_cargo isEqualTo []) exitWith {_return = [[],[],[],[]]};
		
		private _weapons = [];
		private _magazines = [];
		private _items = [];
		private _backpacks = [];
		
		// assort the cargo objects
		{
			_weapons append _x;
		} forEach (_cargo select 0);
		{
			_weapons append (_cargo select _x);
		} forEach [15,16];
		_magazines append (_cargo select 2);
		{
			_items append _x;
		} forEach (_cargo select 1);
		{
			_items append (_cargo select _x);
		} forEach [3,4,5,7,8,9,10,11,12,13,14,17];
		_backpacks append (_cargo select 6);
		
		_return = [_items, _weapons, _magazines, _backpacks];
	}
	else
	{
		if (_cargo isEqualTo []) exitWith {_return = []};
		
		for "_i_cargoCategory" from 0 to 1 do
		{
			{
				_return append _x;
			} forEach (_cargo select _i_cargoCategory);
		};
		for "_i_cargoCategory" from 2 to 17 do
		{
			_return append (_cargo select _i_cargoCategory);
		};
	};
}
else
{
	if (_returnNested) then
	{
		_return =
		[
			_crate call bis_fnc_getVirtualItemCargo,
			_crate call bis_fnc_getVirtualWeaponCargo,
			_crate call bis_fnc_getVirtualMagazineCargo,
			_crate call bis_fnc_getVirtualBackpackCargo
		];
	} else
	{
		_return append (_crate call bis_fnc_getVirtualItemCargo);
		_return append (_crate call bis_fnc_getVirtualWeaponCargo);
		_return append (_crate call bis_fnc_getVirtualMagazineCargo);
		_return append (_crate call bis_fnc_getVirtualBackpackCargo);
	};
};
_return;