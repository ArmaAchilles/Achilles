/*
	Author: CreepPork_LV

	Description:
		Sets BLUFOR to be friendly to OPFOR

	Parameters:
    	_this select 0: BOOL - is friendly

	Returns:
    	Nothing
*/

if (_this select 0) then
{
	blufor setFriend [opfor, 1];
	opfor setFriend [blufor, 1];
}
else
{
	blufor setFriend [opfor, 0];
	opfor setFriend [blufor, 0];
}