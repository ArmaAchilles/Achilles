/////////////////////////////////////////////////////////////////////////////////////////////
// 	AUTHOR: Kex
// 	DATE: 4/30/16
//	VERSION: 1.0
//	FILE: Achilles\congig\cfgWeaponsCAS.hpp 
//  DESCRIPTION: Unlocks the R-77M launcher for Fire Support Module for the Sukhoi T-50
//	NOTE: The classes defined here are children of cfgWeapons
/////////////////////////////////////////////////////////////////////////////////////////////

class Default
{
};

class CannonCore : Default
{
};

class rhs_weap_r77m_launcher : CannonCore
{
	cursor = "missile";		// cursor has to be "missle" in order to be used in Missile Strikes
};