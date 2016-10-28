////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on BIS_fnc_ambientAnim and BIS_fnc_ambientAnimCombat)
//	DATE: 8/26/16
//	VERSION: 1.0
//	FILE: 
//  DESCRIPTION: THIS FUNCTION HAS TO BE EXECUTED WHERE THE UNIT IS LOCAL!!!
//				 this function force AI to execute an animation in loop
//
//	ARGUMENTS:
//	_this select 0:			OBJECT	- unit that surrenders/is freed
//	_this select 1:			OBJECT  - client that call the function (objNull in case for zeus)
//	_this select 2:			ARRAY	- _param
//		_param select 0:		SCALAR	- -1 => free unit; 0 => surrender animation; 1 => sit tied animation
//		_param select 1:		SCALAR	- Interaction with the unit avaiable: -1 => none; 0 => free and lead; 1 => free; 2 => tie
//
//
//	RETURNS:
//	nothing (procedure)
//
//	Example:
//	[_unit,"GUARD",true] call Achilles_fnc_ambientAnim;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define UNTIE_ICON				"\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa"


_unit =					_this select 0;
_caller =				_this select 1;
_param = 				_this select 2;
_animIndex = 			_param select 0;
_interactionIndex = 	_param select 1;

if (_animIndex == -1) then
{
	_termination = if(isNull _caller) then {-1} else {_unit getVariable ["AresCaptureState",1]};
	
	// unit gets freed
	
	// No longer a captive
	_unit setCaptive false;

	// terminate animation
	//[_unit,""] remoteExec ["switchMove",0];
	[_unit,"TERMINATE",false] call Achilles_fnc_ambientAnim;
	
	if (_termination == 0) then 
	{
		[_unit] join _caller;
	};
	_unit setVariable ["AresCaptureState",-1,true];
	
	if (_termination == 2) then
	{
		// unit gets tied
		[_unit,_caller,[1,0]] call Ares_fnc_surrenderUnit;
	};
} else
{
	_anim = ["SURRENDER","CAPTURED_SIT"] select _animIndex;
	_actionName = [localize "STR_RELEASE_UNIT",localize "STR_RELEASE_UNIT",localize "STR_TIE_UNIT"] select _interactionIndex;
	
	// Set unit captive
	_unit setCaptive true;
	
	[_unit,_anim,false] call Achilles_fnc_ambientAnim;
	
	[
		_unit,				// Object the action is attached to
		_actionName,	// Title of the action
		UNTIE_ICON,			// Idle icon shown on screen
		UNTIE_ICON,			// Progress icon shown on screen
		"_this distance _target < 3",	// Condition for the action to be shown
		"_caller distance _target < 3",	// Condition for the action to progress
		{},		// Code executed when action starts
		{},		// Code executed on every progress tick
		{
			_unit = _this select 0;
			_caller = _this select 1;
			_id = _this select 2;
			
			// remove the action
			remoteExec ["",_unit];	// remove from JIP queue
			[_unit,_id] remoteExec ["BIS_fnc_holdActionRemove",0];
			
			[_unit,_caller,[-1,-1]] remoteExec ["Ares_fnc_surrenderUnit",_unit];
			
		},		// Code executed on completion
		{},		// Code executed on interrupted
		[],		// Arguments passed to the scripts
		7,		// Action duration
		0,		// Priority
		false,	// Remove on completion
		false	// Show in unconscious state 
	] remoteExec ["BIS_fnc_holdActionAdd",0,_unit];
	
	_unit setVariable ["AresCaptureState",_interactionIndex,true];	
};

