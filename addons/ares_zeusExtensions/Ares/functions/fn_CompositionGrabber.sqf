/*
	Converts a set of placed objects in the world into some text that can be
	pasted into a composition definition in a mod.

	Parameter(s):
	_this select 0: position of the anchor point (Array)
	_this select 1: size of the covered area (Scalar)

	Returns:
	Ouput text (String)
*/

private ["_anchorObject", "_anchorDim", "_grabOrientation"];
_anchorObject = [_this, 0] call BIS_fnc_Param;
_anchorDim = [_this, 1, 50, [-1]] call BIS_fnc_Param;

private ["_objs"];
_anchorPos = position _anchorObject;
_objs = nearestObjects [_anchorPos, ["All"], _anchorDim];

//First filter illegal objects
 private ["_allDynamic"];
_allDynamic = allMissionObjects "All";
{
	//Exclude non-dynamic objects (world objects)
	private ["_excludeFlag"];

	_excludeFlag = false;
	if (_x in _allDynamic) then
	{
		//Exclude characters
		private ["_sim"];
		_sim = getText (configFile >> "CfgVehicles" >> (typeOf _x) >> "simulation");

		if (_sim in ["soldier"]) then
		{
			_excludeFlag = true;
		};
	}
	else
	{
		_excludeFlag = true;
	};

	if ((typeOf _x) in Ares_EditableObjectBlacklist || _x == player) then
	{
		_excludeFlag = true;
	};
	
	if (_excludeFlag) then
	{
		_objs set [_forEachIndex, -1];
	};
} forEach _objs;

_objs = _objs - [-1];

//Formatting for output
private ["_br", "_tab", "_outputText"];
_br = "
";
_tab = " ";

// Start the output


//Process non-filtered objects
_objectsToSave = [];
_linesOfText = [];
_currentObjectNumber = 0;
{
	_type = typeOf _x;
	_offset = (position _x) vectorDiff _anchorPos;
	if (_offset select 2 < 0.01) then
	{
		// Round off things less than a cm different from the Z-pos of the anchor
		_offset set [2, 0];
	};
	_azimuth = direction _x;
	
	_classText = format ["class Object%1 {side=8;rank="""";vehicle=""%2"";position[]={%3,%4,%5};dir=%6;};",
		_currentObjectNumber, _type, _offset select 0,	_offset select 1, _offset select 2, _azimuth];
	_linesOfText pushBack _classText;
	
	_currentObjectNumber = _currentObjectNumber + 1;
} forEach _objs;

_outputText = "
class NEW_COMPOSITION_NAME
{
    name=""Zeus Display Name"";
";
{
	_outputText = _outputText + "    ";
	_outputText = _outputText + _x;
	_outputText = _outputText + _br;
	diag_log _x;
} forEach _linesOfText;
_outputText = _outputText + _br;
_outputText = _outputText + "};";
diag_log _outputText;
_outputText;