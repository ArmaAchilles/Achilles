/*
	Author: CreepPork_LV

	Description:
		Sets OPFOR to be friendly to Independents

	Parameters:
    	_this select 0: BOOL - is friendly

	Returns:
    	Nothing
*/

if (_this select 0) then
{
	opfor setFriend [independent, 1];
	independent setFriend [opfor, 1];
}
else
{
	opfor setFriend [independent, 0];
	independent setFriend [opfor, 0];
}