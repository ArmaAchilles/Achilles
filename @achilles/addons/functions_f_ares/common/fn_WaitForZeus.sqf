/*
	Blocks until there is a curator in the game that is associated with a player.
*/

//We can't be the curator if there are no curators...
waitUntil {(count allCurators) > 0};

// Wait until at least one of the curators is associated with a unit
waitUntil {sleep 2; count (allCurators select {!isNull getassignedcuratorunit _x}) > 0};
