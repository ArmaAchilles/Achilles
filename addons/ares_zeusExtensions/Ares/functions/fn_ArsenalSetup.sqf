/*
	Sets up an object as an Arsenal config with a specific set of objects in it.

	All non-virtual items in the box will be removed along with any pre existing virtual items.

	Params:
		0 - Object - The object to configure as the arsenal object
		2 - Array of Arrays - A 4-item array containing arrays for the [<backpacks>, <items>, <magazines>, <weapons>].
		3 - Bool - (Optional) True to remove existing virtual and normal items from the box before adding the new items. Default true.
		4 - Bool - (Optional) True to automatically add glasses, false to leave them out. Default false.
*/

_ammoBox = [_this, 0] call BIS_fnc_Param;
_itemData = [_this, 1, [], [[]]] call BIS_fnc_Param;
_removeItems = [_this, 2, false, [false]] call BIS_fnc_Param;
_addGlasses = [_this, 3, false, [false]] call BIS_fnc_Param;

if (_removeItems) then
{
	// Remove all the non-virtual things from the box
	clearWeaponCargoGlobal _ammoBox;
	clearMagazineCargoGlobal _ammoBox;
	clearItemCargoGlobal _ammoBox;
	clearBackpackCargoGlobal _ammoBox;

	// Remove all the virtual things from the box
	[_ammoBox, ([_ammoBox] call BIS_fnc_getVirtualBackpackCargo), true] call BIS_fnc_removeVirtualBackpackCargo;
	[_ammoBox, ([_ammoBox] call BIS_fnc_getVirtualItemCargo), true] call BIS_fnc_removeVirtualItemCargo;
	[_ammoBox, ([_ammoBox] call BIS_fnc_getVirtualMagazineCargo), true] call BIS_fnc_removeVirtualMagazineCargo;
	[_ammoBox, ([_ammoBox] call BIS_fnc_getVirtualWeaponCargo), true] call BIS_fnc_removeVirtualWeaponCargo;
};

// Add the user supplied items
[_ammoBox, _itemData select 0, true] call BIS_fnc_addVirtualBackpackCargo;
[_ammoBox, _itemData select 1, true] call BIS_fnc_addVirtualItemCargo;
[_ammoBox, _itemData select 2, true] call BIS_fnc_addVirtualMagazineCargo;
[_ammoBox, _itemData select 3, true] call BIS_fnc_addVirtualWeaponCargo;

// Optionally add non-virtual items (if supplied)
if (count _itemData > 4) then
{
	{
		// The data for the non-virtual items should be in the format returned by 'getItemCargo' and its variants. That is:
		// [["SomeClassName", "SomeOtherClassName"], [10, 5]] <-- indicates 10 of "SomeClassName" and 5 of "SomeOtherClassName"
		_data = _itemData select _x;
		if (count _data == 2) then
		{
			_names = _data select 0;
			_counts = _data select 1;
			if (count _names > 0 && count _counts > 0 && (count _names) == (count _counts)) then
			{
				for "_index" from 0 to ((count _names) - 1) do
				{
					_currentName = _names select _index;
					_currentCount = _counts select _index;
					[format["Adding '%1' x %2", _currentName, _currentCount]] call Ares_fnc_LogMessage;
					switch (_x) do
					{
						case 4: { _ammoBox addBackpackCargoGlobal [_currentName, _currentCount]; };
						case 5: { _ammoBox addItemCargoGlobal [_currentName, _currentCount]; };
						case 6: { _ammoBox addMagazineCargoGlobal [_currentName, _currentCount]; };
						case 7: { _ammoBox addWeaponCargoGlobal [_currentName, _currentCount]; };
					};
				};
			};
		};
	} forEach [4,5,6,7];
};

if (_addGlasses) then
{
	// For some reason you can't add glasses in the ammo box config. Add them manually.
	_allGlasses = [
		"G_Diving",			//Diving Goggles
		"G_Shades_Black",		//Shades (Black)
		"G_Shades_Blue",		//Shades (Blue)
		"G_Sport_Blackred",	//Sport Shades (Vulcan)
		"G_Tactical_Clear",	//Tactical Glasses
		"G_Spectacles",		//Spectacle Glasses
		"G_Spectacles_Tinted",	//Tinted Spectacles
		"G_Combat",			//Combat Goggles
		"G_Lowprofile",		//Low Profile Goggles
		"G_Shades_Green",		//Shades (Green)
		"G_Shades_Red",		//Shades (Red)
		"G_Squares",			//Square Spectacles
		"G_Squares_Tinted",	//Square Shades
		"G_Sport_BlackWhite",	//Sport Shades (Shadow)
		"G_Sport_Blackyellow",	//Sport Shades (Poison)
		"G_Sport_Greenblack",	//Sport Shades (Yetti)
		"G_Sport_Checkered",	//Sport Shades (Style)
		"G_Sport_Red",		//Sport Shades (Fire)
		"G_Tactical_Black"	//Tactical Shades 
	];
	[_ammoBox, _allGlasses, true] call BIS_fnc_addVirtualItemCargo;
};

// Mark the object as an arsenal object
["AmmoboxInit", [_ammoBox, false, {true}]] call BIS_fnc_arsenal;

true
