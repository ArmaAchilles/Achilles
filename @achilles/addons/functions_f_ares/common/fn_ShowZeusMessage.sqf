private _message = _this select 0;
if (count _this > 1) then
{
	_message = format _this;
};

[objNull, _message] call bis_fnc_showCuratorFeedbackMessage;
