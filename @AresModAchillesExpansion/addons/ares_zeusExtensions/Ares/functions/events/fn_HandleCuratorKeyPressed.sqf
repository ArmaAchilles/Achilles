private ["_key","_handled"];
_key = _this select 1;
_handled = false;
switch (_key) do
{
	case 29: // CTRL
	{
		Ares_Ctrl_Key_Pressed = true;
	};
	case 42: // SHIFT
	{
		Ares_Shift_Key_Pressed = true;
	};
	case 34: // G
	{
		if (Ares_Ctrl_Key_Pressed) then
		{
			if (Ares_Shift_Key_Pressed) then
			{
				// CTRL + SHIFT + G ¦---> ungroup objects
				(curatorSelected select 0) call Achilles_fnc_ungroup_objects;
			} else
			{
				// CTRL + G ¦---> group obects
				(curatorSelected select 0) call Achilles_fnc_group_objects;
			};
		};
		if (Ares_Shift_Key_Pressed) then
		{
			// SHIFT + G ¦---> eject passengers
			hint str (curatorSelected select 0);
			(curatorSelected select 0) call Achilles_fnc_eject_passengers;
			_handled = true;
		};
	};
	case 46: // C
	{
		// CTRL + SHIFT + C ¦---> deep copy function
		if (Ares_Ctrl_Key_Pressed and Ares_Shift_Key_Pressed) then
		{
			curatorSelected call Achilles_fnc_CopyObjectsToClipboard;
			_handled = true;
		};
	};
	case 47: // V
	{
		// CTRL + SHIFT + V ¦---> deep paste function
		if (Ares_Ctrl_Key_Pressed and Ares_Shift_Key_Pressed) then
		{
			[] call Achilles_fnc_PasteObjectsFromClipboard;
			_handled = true;
		};
	};
};

switch (true) do
{
	case (_key in actionKeys "LaunchCM"): // countermeasure key
	{
		if (not Ares_Ctrl_Key_Pressed) then
		{
			_vehicle = vehicle (curatorSelected select 0 select 0);
			[_vehicle] call Achilles_fnc_LaunchCM;
			_handled = true;
		};
	};
};

_handled
