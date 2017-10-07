/*
	Author: CreepPork_LV

	Description:
		Sets Independents to be friendly to nobody.

	Parameters:
    	None

	Returns:
    	Nothing
*/

independent setFriend [blufor, 0];
blufor setFriend [independent, 0];

independent setFriend [opfor, 0];
opfor setFriend [independent, 0];