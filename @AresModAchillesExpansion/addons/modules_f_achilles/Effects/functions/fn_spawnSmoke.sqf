// These smoke templates based on code from the wiki: https://community.bistudio.com/wiki/ParticleTemplates

private ["_codeblock","_particleSources"];

private _smokeType = [_this, 0] call BIS_fnc_Param;
private _sourceObject = [_this, 1] call BIS_fnc_Param;

switch(_smokeType) do
{
	case 0: // Vehicle Fire Look-Alike
	{
		private _ps1 = "#particlesource" createVehicle (getPos _sourceObject);
		private _ps2 = "#particlesource" createVehicle (getPos _sourceObject);
		private _ps3 = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps1 = _this select 0;
			_ps2 = _this select 1;
			_ps3 = _this select 2;
			_sourceObject = _this select 3;

			// Fire
			_ps1 setParticleCircle [0, [0, 0, 0]];
			_ps1 setParticleRandom [0.2, [1, 1, 0], [0.5, 0.5, 0], 1, 0.5, [0, 0, 0, 0], 0, 0];
			_ps1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 2, 6], "", "Billboard", 1, 1, [0, 0, 0], [0, 0, 0.5], 1, 1, 0.9, 0.3, [1.5], [[1, 0.7, 0.7, 0.5]], [1], 0, 0, "", "", _sourceObject];
			_ps1 setDropInterval 0.03;

			// Smoke part 1
			_ps2 setParticleCircle [0, [0, 0, 0]];
			_ps2 setParticleRandom [0, [0, 0, 0], [0.33, 0.33, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
			_ps2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 0, 1], "", "Billboard", 1, 10, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10], [[0.3, 0.3, 0.3, 0.33], [0.4, 0.4, 0.4, 0.33], [0.2, 0.2, 0, 0]], [0, 1], 1, 0, "", "", _sourceObject];
			_ps2 setDropInterval 0.5;

			// Smoke part 2
			_ps3 setParticleCircle [0, [0, 0, 0]];
			_ps3 setParticleRandom [0, [0, 0, 0], [0.5, 0.5, 0], 0, 0.25, [0.05, 0.05, 0.05, 0.05], 0, 0];
			_ps3 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 15, [0, 0, 0.5], [0, 0, 2.9], 1, 1.275, 1, 0.066, [4, 5, 10, 10], [[0.1, 0.1, 0.1, 0.75], [0.4, 0.4, 0.4, 0.5], [1, 1, 1, 0.2]], [0], 1, 0, "", "", _sourceObject];
			_ps3 setDropInterval 0.25;
		};
		_particleSources = [_ps1,_ps2,_ps3];
	};

	case 1: // Small Oily Smoke
	{
		private _ps = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps = _this select 0;
			_sourceObject = _this select 1;

			_ps setParticleCircle [0, [0, 0, 0]];
			_ps setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps setDropInterval 0.05;
		};
		_particleSources = [_ps];
	};
	case 2: // Medium Oily Smoke
	{
		private _ps = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps = _this select 0;
			_sourceObject = _this select 1;

			_ps setParticleCircle [0, [0, 0, 0]];
			_ps setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [2, 6, 12], [[0.1, 0.1, 0.1, 1], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps setDropInterval 0.1;
		};
		_particleSources = [_ps];
	};
	case 3: // Large Oily Smoke
	{
		private _ps = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps = _this select 0;
			_sourceObject = _this select 1;

			_ps setParticleCircle [0, [0, 0, 0]];
			_ps setParticleRandom [0, [0.5, 0.5, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 6], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 4.5], 0, 10, 7.9, 0.5, [4, 12, 20], [[0.1, 0.1, 0.1, 0.8], [0.25, 0.25, 0.25, 0.5], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps setDropInterval 0.1;
		};
		_particleSources = [_ps];
	};
	case 4: // Large Wood Smoke
	{
		private _ps = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps = _this select 0;
			_sourceObject = _this select 1;

			_ps setParticleCircle [0, [0, 0, 0]];
			_ps setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6], [[0.5, 0.5, 0.5, 0.15], [0.75, 0.75, 0.75, 0.075], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps setDropInterval 0.05;
		};

		_particleSources = [_ps];
	};
	case 5: // Large Wood Smoke
	{
		private _ps = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps = _this select 0;
			_sourceObject = _this select 1;

			_ps setParticleCircle [0, [0, 0, 0]];
			_ps setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [2, 6, 12], [[0.5, 0.5, 0.5, 0.3], [0.75, 0.75, 0.75, 0.15], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps setDropInterval 0.1;
		};

		_particleSources = [_ps];
	};
	case 6: // Large Wood Smoke
	{
		private _ps = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps = _this select 0;
			_sourceObject = _this select 1;

			_ps setParticleCircle [0, [0, 0, 0]];
			_ps setParticleRandom [0, [0.5, 0.5, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 4.5], 0, 10, 7.9, 0.5, [4, 12, 20], [[0.5, 0.5, 0.5, 0.5], [0.75, 0.75, 0.75, 0.25], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps setDropInterval 0.1;
		};

		_particleSources = [_ps];
	};
	case 7: // Small Mixed Smoke
	{
		private _ps1 = "#particlesource" createVehicle (getPos _sourceObject);
		private _ps2 = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps1 = _this select 0;
			_ps2 = _this select 1;
			_sourceObject = _this select 2;

			_ps1 setParticleCircle [0, [0, 0, 0]];
			_ps1 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6], [[0.2, 0.2, 0.2, 0.45], [0.35, 0.35, 0.35, 0.225], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps1 setDropInterval 0.1;

			_ps2 setParticleCircle [0, [0, 0, 0]];
			_ps2 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 1.5], 0, 10, 7.9, 0.066, [1, 3, 6], [[0.33, 0.33, 0.33, 0.8], [0.66, 0.66, 0.66, 0.4], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps2 setDropInterval 0.1;
		};

		_particleSources = [_ps1,_ps2];
	};
	case 8: // Large Mixed Smoke
	{
		private _ps1 = "#particlesource" createVehicle (getPos _sourceObject);
		private _ps2 = "#particlesource" createVehicle (getPos _sourceObject);

		_codeblock =
		{
			_ps1 = _this select 0;
			_ps2 = _this select 1;
			_sourceObject = _this select 2;

			_ps1 setParticleCircle [0, [0, 0, 0]];
			_ps1 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps1 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 1, 8], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [2, 6, 12], [[0.2, 0.2, 0.2, 0.3], [0.35, 0.35, 0.35, 0.2], [0.5, 0.5, 0.5, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps1 setDropInterval 0.2;

			_ps2 setParticleCircle [0, [0, 0, 0]];
			_ps2 setParticleRandom [0, [0.25, 0.25, 0], [0.2, 0.2, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
			_ps2 setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal_02", 8, 3, 1], "", "Billboard", 1, 8, [0, 0, 0], [0, 0, 2.5], 0, 10, 7.9, 0.066, [2, 6, 12], [[0.33, 0.33, 0.33, 0.8], [0.66, 0.66, 0.66, 0.4], [1, 1, 1, 0]], [0.125], 1, 0, "", "", _sourceObject];
			_ps2 setDropInterval 0.2;
		};

		_particleSources = [_ps1,_ps2];
	};
};

[_particleSources + [_sourceObject], _codeblock, 0, _sourceObject] call Achilles_fnc_spawn;
_particleSources
