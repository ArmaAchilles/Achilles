private _module = [_module, objNull] select (isNil "_module");
params
[
	"_params",
	["_module", _module, [objNull]]
];
_params params
[
	"_attribute",
	"_value"
];
if (isNull _module || _attribute isEqualTo "") exitWith {false};
_module setVariable [format ["#%1", _attribute], _value];
true
