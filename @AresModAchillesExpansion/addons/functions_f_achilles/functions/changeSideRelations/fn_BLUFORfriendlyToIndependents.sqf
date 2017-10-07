/*
	Author: CreepPork_LV

	Description:
		Sets BLUFOR to be friendly to Independents

	Parameters:
    	_this select 0: BOOL - is friendly

	Returns:
    	Nothing
*/

if (_this select 0) then
{
	blufor setFriend [independent, 1];
	independent setFriend [blufor, 1];
}
else
{
	blufor setFriend [independent, 0];
	independent setFriend [blufor, 0];	
}