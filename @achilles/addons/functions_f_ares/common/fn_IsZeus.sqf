/*
	Determines if the specified unit is the Curator (Zeus).

	Parameters:
		0 - [Object] The unit to test for zeusness

	Returns:
		True if the provided unit was associated with a curator module, false otherwise.
*/

private _candidateUnit = _this select 0;

_candidateUnit in (allCurators apply {getAssignedCuratorUnit _x});
