/*
	Blocks until there is a curator in the game that is associated with a player.
*/

//We can't be the curator if there are no curators...
while {(count allCurators) < 1} do {
	sleep 10;
};

// Wait until at least one of the curators is associated with a unit
private _curatorHasUnit = false;
while {!_curatorHasUnit} do {
    _curatorHasUnit = (count (allCurators select {!isNull getassignedcuratorunit _x}) > 0);

	sleep 2;
};
