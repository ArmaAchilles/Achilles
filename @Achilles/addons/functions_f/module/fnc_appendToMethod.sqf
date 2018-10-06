private _module = [_module, objNull] select (isNil "_module");
params
[
	"_params",
	["_module", _module, [objNull]]
];
_params params
[
	"_method",
	"_code",
	["_doAppend", true, [false]]
];
if (isNull _module || _method isEqualTo "") exitWith {false};
_code = [_code, []] select (_code isEqualTo {});
private _passedCodeArray = [[_code], _code]  select (_code isEqualType [])
private _oldCodeArray = _module getVariable [format ["#fnc_%1", _method], []];
private _newCodeArray = [];
if (_doAppend) then
{
	_newCodeArray = _oldCodeArray;
	_newCodeArray append _passedCodeArray;
}
else
{
	_newCodeArray = _passedCodeArray;
	_newCodeArray append _oldCodeArray;
};
_module setVariable [format ["#fnc_%1", _method], _newCodeArray];
true
