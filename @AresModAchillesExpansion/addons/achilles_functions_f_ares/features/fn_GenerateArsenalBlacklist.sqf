/*
	Generates a list of items that should be blacklisted based on some parameters provided.
	
	Note: The fields that take a 'String' parameter accept one of the following:
		'All' - No items of this type will be blacklisted (all these items are allowed)
		'Blufor' - All items of this type EXCEPT bluefor variants will be blacklisted.
		'Opfor' - All items of this type EXCEPT opfor variants will be blacklisted.
		'Greenfor' - All items of this type EXCEPT greenfor variants will be blacklisted.
		'None' - All of the items of this type will be blacklisted (none of these items are allowed)
	
	Parameters:
		0 - Allow GPS (Boolean) - True to allow GPS receivers, false to blacklist them. Default 'False'.
		1 - Allow Thermals (Boolean) - True to allow scopes and items with thermals, false to blacklist them. Default 'False'.
		2 - Allow NVG's (Boolean) - True to allow NVG's, false to blacklist them. Default 'False'.
		3 - Allowed static weapons (String) - The type of general static weapons to allow. Default 'None'.
		4 - Allowed UAV's (String) - The type of UAV's and UAV terminals to allow. Default 'None'.
		5 - Allowed Automated Static Weapons (String) - The type of automated static weapon backpacks to allow. Default 'None'.
		6 - Allow respawn tents - False to blacklist the respawn tents. True to allow them. Default is 'False'.
		
	Returns:
		A list containing all of the item classnames that should be blacklisted.
*/

#define SIDE_FILTER_ALL 'All'
#define SIDE_FILTER_BLUFOR 'Blufor'
#define SIDE_FILTER_OPFOR 'Opfor'
#define SIDE_FILTER_GREENFOR 'Greenfor'
#define SIDE_FILTER_NONE 'None'

_allowGPS =                      [_this, 0, False] call BIS_fnc_Param;
_allowThermals =                 [_this, 1, False] call BIS_fnc_Param;
_allowNvg =                      [_this, 2, False] call BIS_fnc_Param;
_allowedStaticWeapons =          [_this, 3, SIDE_FILTER_NONE] call BIS_fnc_Param;
_allowedUav =                    [_this, 4, SIDE_FILTER_NONE] call BIS_fnc_Param;
_allowedAutomatedStaticWeapons = [_this, 5, SIDE_FILTER_NONE] call BIS_fnc_Param;
_allowRespawnTents =             [_this, 6, False] call BIS_fnc_Param;

// diag_log format["Generating blacklist: %1, %2, %3, %4, %5, %6", _allowGPS, _allowThermals, _allowNvg, _allowedStaticWeapons, _allowedUav, _allowedAutomatedStaticWeapons];

// Generates a list of the blacklisted items based on a filter.
private ["_applyFilter"];
_applyFilter =
	{
		_side = _this select 0;
		_blueItems = _this select 1;
		_redItems = _this select 2;
		_greenItems = _this select 3;
		
		_itemsToBlacklist = [];
		switch (_side) do
		{
			case SIDE_FILTER_BLUFOR:
			{
				_itemsToBlacklist = _redItems + _greenItems;
			};
			case SIDE_FILTER_OPFOR:
			{
				_itemsToBlacklist = _blueItems + _greenItems;
			};
			case SIDE_FILTER_GREENFOR:
			{
				_itemsToBlacklist = _blueItems + _redItems;
			};
			case SIDE_FILTER_NONE:
			{
				_itemsToBlacklist = _blueItems + _redItems + _greenItems;
			};
		};
		_itemsToBlacklist;
	};

_blacklist = [];
if (not _allowGPS) then
{
	_blacklist pushback "ItemGPS";
	// diag_log format["Blacklist after GPS: %1", _blacklist];
};

if (not _allowThermals) then
{
	_blacklist = _blacklist + [
			"Laserdesignator",
			"optic_Nightstalker",
			"optic_tws",
			"optic_tws_mg"
		];
	// diag_log format["Blacklist after thermals: %1", _blacklist];
};

if (not _allowNvg) then
{
	_blacklist = _blacklist + [
			"acc_pointer_IR",
			"NVGoggles",
			"NVGoggles_OPFOR",
			"NVGoggles_INDEP",
			"optic_NVS"
		];
	// diag_log format["Blacklist after NVG: %1", _blacklist];
};

// Filter the 'normal' static weapons
_blacklist = _blacklist +
	([
		_allowedStaticWeapons,
		["B_HMG_01_support_F", "B_HMG_01_support_high_F", "B_HMG_01_weapon_F", "B_GMG_01_weapon_F", "B_HMG_01_high_weapon_F", "B_GMG_01_high_weapon_F", "B_Mortar_01_support_F", "B_Mortar_01_weapon_F", "B_AA_01_weapon_F", "B_AT_01_weapon_F"],
		["O_HMG_01_support_F", "O_HMG_01_support_high_F", "O_HMG_01_weapon_F", "O_GMG_01_weapon_F", "O_HMG_01_high_weapon_F", "O_GMG_01_high_weapon_F", "O_Mortar_01_support_F", "O_Mortar_01_weapon_F", "O_AA_01_weapon_F", "O_AT_01_weapon_F"],
		["I_HMG_01_support_F", "I_HMG_01_support_high_F", "I_HMG_01_weapon_F", "I_GMG_01_weapon_F", "I_HMG_01_high_weapon_F", "I_GMG_01_high_weapon_F", "I_Mortar_01_support_F", "I_Mortar_01_weapon_F", "I_AA_01_weapon_F", "I_AT_01_weapon_F"]
	] call _applyFilter);
// diag_log format["Blacklist after Statics: %1", _blacklist];

// Filter the UAV's
_blacklist = _blacklist +
	([
		_allowedUav,
		["B_UavTerminal", "B_UAV_01_backpack_F"],
		["O_UavTerminal", "O_UAV_01_backpack_F"],
		["I_UavTerminal", "I_UAV_01_backpack_F"]
	] call _applyFilter);
// diag_log format["Blacklist after UAV: %1", _blacklist];

// Filter the automated static weapons
_blacklist = _blacklist +
	([
		_allowedAutomatedStaticWeapons,
		["B_HMG_01_A_weapon_F", "B_GMG_01_A_weapon_F", "B_HMG_01_A_high_weapon_F", "B_GMG_01_A_high_weapon_F"],
		["O_HMG_01_A_weapon_F", "O_GMG_01_A_weapon_F", "O_HMG_01_A_high_weapon_F", "O_GMG_01_A_high_weapon_F"],
		["I_HMG_01_A_weapon_F", "I_GMG_01_A_weapon_F", "I_HMG_01_A_high_weapon_F", "I_GMG_01_A_high_weapon_F"]
	] call _applyFilter);
// diag_log format["Blacklist after AutoStatics: %1", _blacklist];

if (not _allowRespawnTents) then
{
	_blacklist = _blacklist +
		[
			"B_Respawn_TentDome_F",
			"B_Respawn_TentA_F",
			"B_Respawn_Sleeping_bag_F",
			"B_Respawn_Sleeping_bag_blue_F",
			"B_Respawn_Sleeping_bag_brown_F"
		];
	// diag_log format["Blacklist after tents: %1", _blacklist];
};

_blacklist;