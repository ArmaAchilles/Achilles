private _handled = false;

curatorMouseOver params ["_typeName","_clickedObject"];
if (_typeName == "OBJECT") then
{
	private _ctrlKeyPressed = param [5];
	private _altKeyPressed = param [6];

	switch (true) do
	{
		case (_ctrlKeyPressed):
		{
			missionnamespace setVariable ["bis_fnc_curatorObjectPlaced_mouseOver",[_typeName, _clickedObject]];
			_logic = [getPos _clickedObject, "LOGIC"] call Ares_fnc_CreateLogic;
			[_logic, [], true] call Achilles_fnc_moduleRemoteControl;
			_handled = true;
		};
		case (_altKeyPressed):
		{
			[_clickedObject] call Achilles_fnc_switchUnit_start;
			_handled = true;
		};
		case (_clickedObject isKindOf "Land_ClutterCutter_small_F"):
		{
			switch (true) do
			{
				case (!isNil {_clickedObject getVariable "source"}):
				{
					[_clickedObject] spawn Achilles_fnc_lightSourceAttributes;
					_handled = true;
				};
			};
		};
	};
};

_handled;
