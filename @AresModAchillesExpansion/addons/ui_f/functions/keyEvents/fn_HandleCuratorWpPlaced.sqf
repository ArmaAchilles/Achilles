params ["_", "_group", "_id"];
switch (true) do
{
	case (_id == 1):
	{
		[_group, 0] setWaypointPosition [position leader _group, 0];
	};
	case (waypointType [_group, _id] == "CYCLE"):
	{
		[_group, _id] setWaypointPosition [waypointPosition [_group, 0], 0];
	};
};