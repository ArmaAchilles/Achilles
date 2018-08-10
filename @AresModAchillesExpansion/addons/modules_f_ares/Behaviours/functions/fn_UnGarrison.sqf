#include "\achilles\modules_f_ares\module_header.h"

private _groupUnderCursor = [_logic] call Ares_fnc_GetGroupUnderCursor;

private _codeBlock =
{
	_groupUnderCursor = _this select 0;
	if (local (leader _groupUnderCursor)) then
	{
		// Give the units a move order since that cancels the 'stop' order we gave them when
		// garrisoning. Choose a point outside so they try to leave the building.
		private _outsidePos = [getPos (leader _groupUnderCursor), [3,15], 2, 0] call Ares_fnc_GetSafePos;

		{
			_x setUnitPos "AUTO";
			_x forceSpeed -1;
			_x doWatch objNull;
			_x doMove _outsidePos;
		} forEach(units _groupUnderCursor);
	};
};

_groupUnderCursor setVariable ["Achilles_var_inGarrison", nil, true];

if (local _groupUnderCursor) then {[_groupUnderCursor] spawn _codeBlock} else {[[_groupUnderCursor], _codeBlock, leader _groupUnderCursor] call Achilles_fnc_spawn};

[localize "STR_AMAE_RELEASE_GARRISON_UNITS"] call Ares_fnc_showZeusMessage;

#include "\achilles\modules_f_ares\module_footer.h"
