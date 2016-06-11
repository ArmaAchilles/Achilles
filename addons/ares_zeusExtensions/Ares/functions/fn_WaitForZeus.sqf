/*
	Blocks until there is a curator in the game that is associated with a player.
*/

//We can't be the curator if there are no curators...
while {(count allCurators) < 1} do {
	sleep 10;
};

// Wait until at least one of the curators is associated with a unit
_curatorHasUnit = false;
while {!_curatorHasUnit} do {
	{
		if(!isNull getassignedcuratorunit _x) then
		{
			_curatorHasUnit = true;
		};
	} foreach allCurators;

	sleep 2;
};