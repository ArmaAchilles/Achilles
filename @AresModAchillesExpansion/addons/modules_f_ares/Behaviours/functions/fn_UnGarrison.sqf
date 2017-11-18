#include "\achilles\modules_f_ares\module_header.hpp"

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
			_x doMove _outsidePos;
		} forEach(units _groupUnderCursor);
	};
};

[[[_groupUnderCursor], _codeBlock, leader _groupUnderCursor] call Achilles_fnc_spawn, [_groupUnderCursor] spawn _codeBlock] select (local _groupUnderCursor);

[objnull, "Units released from garrison."] call bis_fnc_showCuratorFeedbackMessage;

#include "\achilles\modules_f_ares\module_footer.hpp"
