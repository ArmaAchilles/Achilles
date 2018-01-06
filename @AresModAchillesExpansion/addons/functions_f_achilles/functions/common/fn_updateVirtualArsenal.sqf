params
[
	["_crate",objNull,[objNull]],
	["_cargo",[],[[]]],
	["_replace",true,[true]]
];
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
	systemChat str _cargoNotNested;
	if (_replace) then
	{
		systemChat "remove";
		[_crate, true] call ace_arsenal_fnc_removeBox;
	};
	if (not (_cargoNotNested isEqualTo [])) then
	{
		systemChat "add";
		[_crate, [], true] call ace_arsenal_fnc_initBox;
		[_crate, _cargoNotNested, true] call ace_arsenal_fnc_addVirtualItems;
	};
}
else
{
	private _items = [];
	private _weapons = [];
	private _magazines = [];
	private _backpacks = [];
	
	if (not (_cargo isEqualTo []) and {(_cargo select 0) isEqualType []}) then
	{
		// split the array if it is nested
		_items = _cargo select 0;
		_weapons = _cargo select 1;
		_magazines = _cargo select 2;
		_backpacks = _cargo select 3;
	}
	else
	{
		// assort the items if the array is not nested.
		{
			switch true do
			{
				case (getnumber (configfile >> "cfgweapons" >> _x >> "type") in [4096,131072] or isClass (configfile >> "CfgGlasses" >> _x)):
				{
					_items pushBack _x;
				};
				case (isclass (configfile >> "cfgweapons" >> _x)):
				{
					_weapons pushBack _x;
				};
				case (isclass (configfile >> "cfgmagazines" >> _x)):
				{
					_magazines pushBack _x;
				};
				case (isclass (configfile >> "cfgvehicles" >> _x)):
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
	
	[_crate, _items, true] call bis_fnc_addVirtualItemCargo;
	[_crate, _weapons, true] call bis_fnc_addVirtualWeaponCargo;
	[_crate, _magazines, true] call bis_fnc_addVirtualMagazineCargo;
	[_crate, _backpacks, true] call bis_fnc_addVirtualBackpackCargo;
};