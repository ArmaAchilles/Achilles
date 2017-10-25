/*
	Reads through the loaded mod configs and generates a list of all the objects that are valid to be added to an arsenal box.
	
	Parameters:
		0 - (Optional) Array of strings - List of class names to blacklist (not include) in all generated lists.
		1 - (Optional) String - Option for limiting side of the items added. One of { 'All', 'Blufor', 'Opfor', 'Greenfor', 'Civilian', 'None' }

	Returns:
		An array of arrays of all class names that can be added to arsenal in the following format:
			[
				[ "", "", ... ], // Backpacks
				[ "", "", ... ], // Items
				[ "", "", ... ], // Magazines
				[ "", "", ... ]  // Weapons
			]
*/

#define CFG_TYPE_WEAPON 1
#define CFG_TYPE_HANDGUN 2
#define CFG_TYPE_LAUNCHER 4
#define CFG_TYPE_BINOC 4096
#define CFG_TYPE_ITEM 131072
#define CFG_TYPE_SCOPED 0

// Indexes for the side overrides in the Ares_Arsenal_Side_Overrides array.
#define SIDE_CSAT 0
#define SIDE_NATO 1
#define SIDE_AAF 2
#define SIDE_CIV 3

params[["_blacklist", []], ["_limitItemsToSide", "All"]];

// Go through and gather all the items declared in 'CfgWeapons'. This includes most items, vests
// and uniforms.
private _allWeaponsClasses = (configFile >> "CfgWeapons") call BIS_fnc_getCfgSubClasses;
private _weapons = [];
private _items = [];
{
	private _weaponClassName = _x;
	private _weaponConfig = configFile >> "CfgWeapons" >> _weaponClassName;
	private _weaponType = getNumber (_weaponConfig >> "type");
	private _weaponScope = getNumber (_weaponConfig >> "scope");
	private _weaponDisplayName = getText (_weaponConfig >> "displayName");
	[format ["Processing weapon %1 (%2)", _weaponClassName, _weaponDisplayName]] call Achilles_fnc_logMessage;

	// Assume we'll include the weapon by default. If this never gets set to false then we'll add it.
	private _includeItem = true;

	if (_weaponScope < 2) then
	{
		["Excluding weapon due to privacy."] call Achilles_fnc_logMessage;
		_includeItem = false;
	};
	
	// If we're using a side filter, we need to try to discover the side and apply the filter.
	if (_includeItem && _limitItemsToSide != 'All') then
	{
		// Not all things define a side - if they do we can filter it by side.
		private _side = -1;
		if (isNumber (_weaponConfig >> "side")) then
		{
			_side = getNumber (_weaponConfig >> "side");
		};
		
		// Special case hack since the ECH helmet is the base of EVERYTHING we can't
		// override the 'side' value for it in Ares without also making all other
		// hats default to the same side.
		if ((_side == -1) && (_weaponDisplayName == "ECH")) then
		{
			_side = 1;
		};
		
		// Special case hack for uniforms - they define their side on the actual uniform class not on the
		// object here in the weaponconfig.
		if ((_side == -1) && (_weaponType == CFG_TYPE_ITEM) && (isClass (_weaponConfig >> "ItemInfo"))) then
		{
			private _uniformVehicle = getText (_weaponConfig >> "ItemInfo" >> "uniformClass");
			if (_uniformVehicle != "") then
			{
				// Check the side of the uniform.
				private _uniformVehicleConfig = configFile >> "CfgVehicles" >> _uniformVehicle;
				_side = getNumber (_uniformVehicleConfig >> "side");
			};
		};

		// Check that the objects are on the correct side (if we could find one)
		if (_side != -1) then
		{
			switch (_limitItemsToSide) do
			{
				case 'None' : { _includeItem = false; };
				case 'Opfor': { _includeItem = (_side == SIDE_CSAT); };
				case 'Blufor': { _includeItem = (_side == SIDE_NATO); };
				case 'Greenfor': { _includeItem = (_side == SIDE_AAF); };
				case 'Civilian' : { _includeItem = (_side == SIDE_CIV); };
			};
			if (!_includeItem) then
			{
				["Excluding weapon due to side restriction."] call Achilles_fnc_logMessage;
			};
		};
	};
	
	// Check the blacklist
	if (_includeItem) then
	{
		if (_weaponClassName in _blacklist) then
		{
			["Excluding weapon due to blacklist."] call Achilles_fnc_logMessage;
			_includeItem = false;
		}
		else
		{
			switch (_weaponType) do
			{
				case CFG_TYPE_WEAPON;
				case CFG_TYPE_HANDGUN;
				case CFG_TYPE_LAUNCHER:
				{
					if (isClass (_weaponConfig >> "LinkedItems")) then
					{
						_includeItem = false;
						["Excluding weapon due to linked items."] call Achilles_fnc_logMessage;
					};
				};
				case CFG_TYPE_BINOC;
				case CFG_TYPE_ITEM:
				{
					// Include these....
				};
				default
				{
					["Excluding due to unsupported type."] call Achilles_fnc_logMessage;
					_includeItem = false;
				};
			};
		};
	};

	// Actually add the item to the list of weapons.
	if (_includeItem) then
	{
		[format ["Included weapon %1 (%2)", _weaponClassName, _weaponDisplayName]] call Achilles_fnc_logMessage;
		_items pushBack _weaponClassName;
	}
	else
	{
		[format ["Excluded weapon %1 (%2)", _weaponClassName, _weaponDisplayName]] call Achilles_fnc_logMessage;
	};
} forEach _allWeaponsClasses;

// Gather up all the magazines that are declared. This includes explosives and grenades.
private _allMagazineClasses = (configFile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses;
private _magazines = [];
{
	private _className = _x;
	[format["Processing magazine: %1", _className]] call Achilles_fnc_logMessage;
	private _config = configFile >> "CfgMagazines" >> _className;
	private _displayName = getText(_config >> "displayName");
	private _picture = getText(_config >> "picture");
	private _scope = getNumber(_config >> "scope");
	private _includeMagazine = true;

	if (_scope < 2 || _displayName == "" || _picture == "") then
	{
		["Magazine is not public or data is incomplete."] call Achilles_fnc_logMessage;
		_includeMagazine = false;
	};
	
	if (_includeMagazine && (_className in _blacklist)) then
	{
		["Magazine is blacklisted."] call Achilles_fnc_logMessage;
		_includeMagazine = false;
	};
	
	if (_includeMagazine) then
	{
		[format["Added magazine: %1", _className]] call Achilles_fnc_logMessage;
		_magazines pushBack _className;
	}
	else
	{
		[format["Rejected magazine: %1", _className]] call Achilles_fnc_logMessage;
	};
} forEach _allMagazineClasses;

// Gather up all the backpacks that are declared. They're vehicles. Awesome.
private _allVehicleClasses = (configFile >> "CfgVehicles") call BIS_fnc_getCfgSubClasses;
private _backpacks = [];
{
	private _className = _x;
	[format["Processing backpack: %1", _className]] call Achilles_fnc_logMessage;
	private _config = configFile >> "CfgVehicles" >> _className;
	private _displayName = getText(_config >> "displayName");
	private _picture = getText(_config >> "picture");
	private _scope = getNumber(_config >> "scope");
	private _isBackpack = getNumber(_config >> "isbackpack");
	
	private _includeBackpack = true;
	
	if (_scope < 2 || _isBackpack != 1 || _displayName == "" || _picture == "") then
	{
		[format ["Vehicle is nor backpack, is not public, or has incomplete data. (%1, %2, %3, %4)", _scope, _isBackpack, _displayName, _picture]] call Achilles_fnc_logMessage;
		_includeBackpack = false;
	};
	
	if (_includeBackpack && _limitItemsToSide != 'All') then
	{
		// Not all things define a side - if they do we can filter it by side.
		private _side = -1;
		if (isNumber (_config >> "side")) then
		{
			_side = getNumber (_config >> "side");
		};
		
		// Check that the objects are on the correct side (if we could find one)
		if (_side != -1) then
		{
			// HACK - Include civilian backpacks for all sides because ARMA is stupid and
			// classifies all backpacks as civilian apparently.
			switch (_limitItemsToSide) do
			{
				case 'None' : { _includeBackpack = false; };
				case 'Opfor': { _includeBackpack = (_side == SIDE_CSAT || _side == SIDE_CIV); };
				case 'Blufor': { _includeBackpack = (_side == SIDE_NATO || _side == SIDE_CIV); };
				case 'Greenfor': { _includeBackpack = (_side == SIDE_AAF || _side == SIDE_CIV); };
				case 'Civilian' : { _includeBackpack = (_side == SIDE_CIV); };
			};
			if (!_includeBackpack) then
			{
				["Excluding backpack due to side restriction."] call Achilles_fnc_logMessage;
			};
		};
	};
	
	if (_includeBackpack && (_className in _blacklist)) then
	{
		_includeBackpack = false;
		["Backpack blacklisted."] call Achilles_fnc_logMessage;
	};

	if (_includeBackpack) then
	{
		[format["Accepted backpack: %1", _className]] call Achilles_fnc_logMessage;
		_backpacks pushBack _className;
	}
	else
	{
		[format["Rejected backpack: %1", _className]] call Achilles_fnc_logMessage;
	};
} forEach _allVehicleClasses;

// Add all the glasses
private _allGlassesClasses = (configFile >> "CfgGlasses") call BIS_fnc_getCfgSubClasses;
private _glasses = [];
{
	private _className = _x;
	[format["Processing glasses: %1", _className]] call Achilles_fnc_logMessage;
	private _config = configFile >> "CfgGlasses" >> _className;
	private _displayName = getText(_config >> "displayName");
	private _picture = getText(_config >> "picture");
	private _scope = getNumber(_config >> "scope");
	private _includeGlasses = true;
	
	if (_scope < 2 || _displayName == "" || _picture == "") then
	{
		["Glasses not public or have incomplete data."] call Achilles_fnc_logMessage;
		_includeGlasses = false;
	};
	
	if (_includeGlasses && (_className in _blacklist)) then
	{
		["Glasses blacklisted."] call Achilles_fnc_logMessage;
		_includeGlasses = false;
	};
	
	if (_includeGlasses) then
	{
		[format["Accepted glasses: %1", _className]] call Achilles_fnc_logMessage;
		_glasses pushBack _className;
	}
	else
	{
		[format["Rejected glasses: %1", _className]] call Achilles_fnc_logMessage;
	};
} forEach _allGlassesClasses;

[_backpacks, _items + _glasses, _magazines, _weapons];
