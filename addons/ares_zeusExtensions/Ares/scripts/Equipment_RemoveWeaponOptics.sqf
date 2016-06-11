[
	"Equipment",
	"Remove Weapon Optics",
	{
		if (isNil "Ares_RemoveOpitcsCodeBlock") then
		{
			Ares_RemoveOpitcsCodeBlock =
			{
				_unitsToModify = _this select 0;
				{
					if (local _x && not (isPlayer _x)) then
					{
						_optic = (primaryWeaponItems _x) select 2;
						if (_optic != '') then
						{
							_x removePrimaryWeaponItem _optic;
						}
					};
				} forEach _unitsToModify;
			};
			publicVariable "Ares_RemoveOpitcsCodeBlock";
		};
		
		_unitUnderCursor = _this select 1;
		_units = [];
		if (isNull _unitUnderCursor) then
		{
			_dialogResult = [
				"Remove Optics",
				[
					["Remove optics for:", ["All Units On Map", "All Blufor (NATO) units", "All Greenfor (Independent) units", "All Redfor (East) units", "All Civilians"]]
				]
			] call Ares_fnc_ShowChooseDialog;
			
			if (count _dialogResult > 0) then
			{
				_dialogUnitsToAffect = _dialogResult select 0;
				if (_dialogUnitsToAffect == 0) then
				{
					_units = allUnits;
				}
				else
				{
					private ["_desiredSide"];
					switch (_dialogUnitsToAffect) do
					{
						case 1: { _desiredSide = west; };
						case 2: { _desiredSide = independent; };
						case 3: { _desiredSide = east; };
						case 4: { _desiredSide = civilian; };
					};
					
					{
						if (side _x == _desiredSide) then
						{
							_units pushBack _x;
						};
					} forEach allUnits;
				};
			};
		}
		else
		{
			_units = units (group _unitUnderCursor);
		};
		
		if (count _units > 0) then
		{
			[[_units], "Ares_RemoveOpitcsCodeBlock", true, true] call BIS_fnc_MP;
			["Removed optics on %1 objects.", (count _units)] call Ares_fnc_ShowZeusMessage;
		};
	}
] call Ares_fnc_RegisterCustomModule;