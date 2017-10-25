////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 6/23/16
//	VERSION: 1.0
//	FILE: Ares\functions\fn_addIntel.sqf
//  DESCRIPTION: Add intel to the diary of the player where the script is executed.
//
//	ARGUMENTS:
//	_this select 0:		STRING	- title of the intel
//  _this select 1:		STRING	- intel text
//	_this select 2:		STRING	- marker
//	_this select 3:		STRING	- (optional); name of finder
//	_this select 3:		SCALAR	- (optional); default = 0; 0: intel was shared with side; 1: intel was shared with group; 2: intel was shared with NO ONE at all.
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	["Secret NATO Documents","NATO supply convoy is expected to pass the checkpoint at 9 am.","marker001","Kex",0] call Ares_fnc_addIntel;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

params["_title", "_text", "_marker", ["_finder", ""], ["_shared", 0]];

private _fnc_scriptName = "Achilles_Intel";
private _shared_hint = if (isLocalized "STR_INTEL_WAS_SHARED_WITH_SIDE") then
{
	[localize "STR_INTEL_WAS_SHARED_WITH_SIDE",localize "STR_INTEL_WAS_SHARED_WITH_GROUP", localize "STR_INTEL_WAS_SHARED_WITH_NONE"] select _shared;
} else
{
	["(The intel was shared with your side)","(The intel was shared with your group)", "(The intel was shared with no one)"] select _shared;
};
 

// Add location and shared hint information
_text = format 
[
	"<font color='#99ffffff' face='PuristaLight'>" + localize "STR_A3_BIS_fnc_initIntelObject_found" + "</font><br />",
	format ["<marker name='%1'>%2</marker>",_marker,(markerpos _marker)call bis_fnc_locationDescription],
	_finder
] 
+ _text 
+ "<br />" + "<font color='#99ffffff' face='PuristaLight'>" + _shared_hint + "</font>";

// Add the intel to the diary
["intelAdded",[format [localize "STR_INTEL_FOUND",_finder,_title] ,"\A3\ui_f\data\map\markers\military\warning_ca.paa"]] call bis_fnc_showNotification;
if !(player diarysubjectexists _fnc_scriptName) then 
{
	player creatediarysubject [_fnc_scriptName,"Ares " + localize "STR_A3_BIS_fnc_initIntelObject_intel"];
};
player creatediaryrecord [_fnc_scriptName,[_title,_text]];

if (name player == _finder) then {openmap [true,false]};
deleteMarker _marker;
