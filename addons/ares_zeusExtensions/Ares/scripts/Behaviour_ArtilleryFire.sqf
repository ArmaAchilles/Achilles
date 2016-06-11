#define FIRST_SPECIFIC_ARTILLERY_TARGET_INDEX 3
[
	"AI Behaviours",
	"Fire Artillery",
	{
		_artillery = _this select 1;

		// Choose the kind of ammunition to fire
		_allAmmunition = getArtilleryAmmo [_artillery];

		if (count _allAmmunition > 0) then
		{
			_allTargetsUnsorted = allMissionObjects "Ares_Module_Behaviour_Create_Artillery_Target";
			_allTargets = [_allTargetsUnsorted, [], { _x getVariable ["SortOrder", 0]; }, "ASCEND"] call BIS_fnc_sortBy;
			_targetChoices = ["Random", "Nearest", "Farthest"];
			{
				_targetChoices pushBack (name _x);
			} forEach _allTargets;
			
			_dialogResult = [
				"Artillery Options",
				[
					["Ammunition Type", _allAmmunition],
					["Rounds", ["1", "2", "3", "4", "5"]],
					["Choose Target", _targetChoices, 1]
				]] call Ares_fnc_ShowChooseDialog;
			if (count _dialogResult > 0) then
			{
				// Get the data that the dialog set.
				_selectedAmmoType = _allAmmunition select (_dialogResult select 0);
				_roundsToFire = (_dialogResult select 1) + 1; // +1 since the options are 0-based. (0 actually fires a whole clip)
				_targetChooseAlgorithm = _dialogResult select 2;
				
				// Make sure we only consider targets that are in range.
				_targetsInRange = [];
				{
					if ((position _x) inRangeOfArtillery [[_artillery], _selectedAmmoType]) then
					{
						_targetsInRange set [count _targetsInRange, _x];
					};
				} forEach _allTargets;
				
				if (count _targetsInRange > 0) then
				{
					// Choose a target to fire at
					_selectedTarget = objNull;
					switch (_targetChooseAlgorithm) do
					{
						case 0: // Random
						{
							_selectedTarget = _targetsInRange call BIS_fnc_selectRandom;
						};
						case 1: // Nearest
						{
							_selectedTarget = [position _logic, _targetsInRange] call Ares_fnc_GetNearest;
						};
						case 2: // Furthest
						{
							_selectedTarget = [position _logic, _targetsInRange] call Ares_fnc_GetFarthest;
						};
						default // Specific target
						{
							_selectedTarget = _allTargets select (_targetChooseAlgorithm - FIRST_SPECIFIC_ARTILLERY_TARGET_INDEX);
						};
					};

					// Fire at the target where the unit is local (See #129)
					enableEngineArtillery true;
					_roundEta = _artillery getArtilleryETA [position _selectedTarget, _selectedAmmoType];
					[[_artillery, (position _selectedTarget), _selectedAmmoType, _roundsToFire], "Ares_FireArtilleryFunction", _artillery] call BIS_fnc_MP;
					
					[objNull, format ["Firing %1 rounds of '%2' at target. ETA %3", _roundsToFire, _selectedAmmoType, _roundEta]] call bis_fnc_showCuratorFeedbackMessage;
				}
				else
				{
					[objNull, "No targets in range"] call bis_fnc_showCuratorFeedbackMessage;
				};
			};
		};
	}
] call Ares_fnc_RegisterCustomModule;

