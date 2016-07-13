//////////////////////////////////////////////////////////////////////////////////
// 	AUTHOR: Kex
// 	DATE: 4/30/16
//	VERSION: 1.0
//	FILE: Achilles\config\cfgVehiclesCAS.hpp 
//  DESCRIPTION: Unlocks more CAS vehicles for Zeus Fire Mission Module
//	NOTE: The classes defined here are children of cfgVehicles
//////////////////////////////////////////////////////////////////////////////////


// Parent classes

class All {};
class AllVehicles : All {};
class Air : AllVehicles {};
class Plane : Air {};
class Plane_Base_F : Plane {};
class Plane_Fighter_03_Base_F : Plane_Base_F {};

// The standard machine gun for F-22A did not work properly so I changed it to GAU-8.

class rhsusf_f22 : Plane_Fighter_03_Base_F 
{
	weapons[] = {"RHS_weap_gau8","rhs_weap_SidewinderLauncher","rhs_weap_AIM120","rhsusf_weap_CMFlareLauncher"};
};

// Definition in ModuleCAS_F is needed to unlock an aircraft for CAS.

class ModuleCAS_F : Module_F
{
	class Arguments
	{
		class Vehicle
		{
			class Values
			{
				class O_Plane_CAS_SU_T50
				{
					name = "Sukhoi T-50";				// don't know what it does
					value = "RHS_T50_vvs_blueonblue";	// class name of vehicle
				};
				class B_Plane_CAS_F22A
				{
					name = "F-22A Raptor";
					value = "rhsusf_f22";
				};
			};
		};
	};
};