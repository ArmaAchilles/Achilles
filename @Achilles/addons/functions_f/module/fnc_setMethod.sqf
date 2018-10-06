private _module = [_module, objNull] select (isNil "_module");
params
[
	"_params",
	["_module", _module, [objNull]]
];
_params params
[
	"_method",
	"_code"
];
if (_code isEqualTo {}) exitWith {false};
if (isNull _module || _method isEqualTo "" exitWith {false};
private _code = [[], _code]  select (_code isEqualTo {});
private _newCodeArray = [[_code], _code]  select (_code isEqualType []);
private _codeArray = [_codeArray, nil] select (_code isEqualTo []);
_module setVariable [format ["#fnc_%1", _method], _codeArray];
true
