params
[
	["_uncompiledCode","",[""]],
	["_firstOnly",false,[false]]
];
private _uncompiledCodeLen = count _uncompiledCode;
private _blacklist = 
[
	#include "blacklist.hpp"
];
private _matchedList = [];
scopeName "main_scope";
private _candidateList = _blacklist apply {[_x, count _x]};
// for each character in the code
for "_i" from 0 to (_uncompiledCodeLen - 1) do
{
	{
		_x params ["_blacklistEntry", "_blacklistEntryLen"];
		if (_blacklistEntry == _uncompiledCode select [_i, _blacklistEntryLen]) then
		{
			// matched
			_matchedList pushBack _blacklistEntry;
			if (_firstOnly) then {breakTo "main_scope"};
		};
	} forEach _candidateList;
};
_matchedList;
