/*
	Function:
		Achilles_fnc_module_init
	
	Authors:
		Kex
	
	Description:
		Init for Zeus modules (called from the module code)
		It will call the "postinit" mode of the module code after completion
		The local variable _logic must be defined in the caller scope!
	
	Parameters:
		_initType	- <STRING> ["basic"] Type of initialization
		_params		- <ANYTHING> [[]] Parameters for the init (depends on _initType)
					case "basic":
						none
					case "selection":
						_expectedTypeName		- <STRING> ["OBJECT"] expected type name for the selected entity
						_expectedParentClass	- <STRING> ["ALL"] expected parent class for the entity (only needed for type name "OBJECT")
	
	Returns:
		none
	
	Exampes:
		(begin example)
		params ["_logic"];
		["selection", ["OBJECT", "MAN"]] call Achilles_fnc_module_init;
		(end)
*/

params
[
	["_initType", "basic", [""]],
	["_params", [], []]
];

// add event handlers
// note that curator event handlers are not set here and are calling the "handle"
_logic setVariable ["handle", _fnc_scriptNameParent];

_logic addEventHandler ["Deleted",
{
	params ["_logic"];
	["onModuleDeleted", [_logic]] call (_logic getVariable ["handle", {}]);
}];

switch (_initType) do
{
	case "basic":
	{
		["postinit", [_logic, true, true]] call _fnc_scriptNameParent;
	};
	case "selection":
	{
		_params params
		[
			["_expectedTypeName", "OBJECT", [""]],
			["_expectedParentClass", "ALL", [""]]
		];
		Ares_CuratorObjectPlaced_UnitUnderCursor params
		[
			["_typeName", "", [""]],
			["_entity", objNull, []]
		];
		if (_typeName isEqualTo "") then
		{
			// selection option
		}
		else
		{
			if !(_typeName isEqualTo _expectedTypeName) exitWith
			{
				[[localize "STR_AMAE_WRONG_TYPE__X_WAS_GIVEN_Y_IS_EXPECTED", _typeName, _expectedTypeName]] call Achilles_fnc_printZeusError;
			};
			if (_typeName isEqualTo "OBJECT" && !(_entity isKindOf _expectedParentClass)) exitWith
			{
				[[localize "STR_AMAE_INVALID_CLASS__X_IS_NOT_A_CHILD_OF_Y", typeOf _entity, _expectedTypeName]] call Achilles_fnc_printZeusError;
			};
			_logic setVariable ["#selection", [_entity]];
			["postinit", [_logic, true, true]] call _fnc_scriptNameParent;
		};
	};
};
