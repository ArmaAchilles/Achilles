private _module = [_module, objNull] select (isNil "_module");
params
[
	"_params",
	["_module", _module, [objNull]]
];
_params params
[
	"_attribute",
	["_defaultValue", nil]
];
if (isNull _module || _attribute isEqualTo "") exitWith {_defaultValue};
// return
_module getVariable [format ["#%1", _method], _defaultValue];
