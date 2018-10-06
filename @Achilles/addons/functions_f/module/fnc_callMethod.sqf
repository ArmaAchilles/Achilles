private _module = [_module, objNull] select (isNil "_module");
params
[
	"_params",
	["_module", _module, [objNull]]
];
_params params
[
	"_attribute",
	["_methodParams", [], [[]]]
];
if (isNull _module || _attribute isEqualTo "") exitWith {nil};
private _previousReturn = [];
{
	_previousReturn = [_module, _methodParams, _previousReturn] call _x;
} forEach (_module getVariable [format ["#fnc_%1", _method], []]);
// return
_previousReturn;
