class CfgPatches
{
	class achilles_data_f_achilles
	{
		weapons[] = {};
		requiredVersion = 0.1;
		author = "Kex";
		authorUrl = "https://github.com/oOKexOo/AresModAchillesExpansion";
		version = 0.0.1;
		versionStr = "0.0.1";
		versionAr[] = {0,0,1};
		
		units[] = {};

		requiredAddons[] = {"A3_Structures_F","A3_Structures_F_Mil"};
	};
};

class CfgVehicles 
{
	class All;
	class FloatingStructure_F : All {};
	class RoadCone_L_F : FloatingStructure_F
	{
		scopeCurator = 2;
	};
	class RoadBarrier_small_F : RoadCone_L_F
	{
		scopeCurator = 2;
	};
	
	class Static : All {};
	
	class HBarrier_base_F : Static {};
	class Land_HBarrierTower_F : HBarrier_base_F 
	{
		scopeCurator = 2;
	};
	class Land_HBarrier_1_F : HBarrier_base_F 
	{
		scopeCurator = 2;
	};
	class Land_HBarrierWall_corridor_F : HBarrier_base_F 
	{
		scopeCurator = 2;
	};
	class Land_HBarrierWall6_F : HBarrier_base_F 
	{
		scopeCurator = 2;
	};
	class Land_HBarrierWall_corner_F : HBarrier_base_F 
	{
		scopeCurator = 2;
	};
	class Land_HBarrierBig_F : HBarrier_base_F {};
	class Land_HBarrier_Big_F : Land_HBarrierBig_F
	{
		scopeCurator = 2;
	};
	class Land_HBarrier_3_F : HBarrier_base_F 
	{
		scopeCurator = 2;
	};
	class Land_HBarrier_5_F : HBarrier_base_F 
	{
		scopeCurator = 2;
	};
	class Land_HBarrierWall4_F : HBarrier_base_F 
	{
		scopeCurator = 2;
	};
	
	class BagFence_base_F : Static {};
	class Land_BagFence_Short_F : BagFence_base_F 
	{
		scopeCurator = 2;
	};
	class Land_BagFence_Round_F : BagFence_base_F 
	{
		scopeCurator = 2;
	};
	class Land_BagFence_Long_F : BagFence_base_F 
	{
		scopeCurator = 2;
	};
	class Land_BagFence_End_F : BagFence_base_F 
	{
		scopeCurator = 2;
	};
	class Land_BagFence_Corner_F : BagFence_base_F 
	{
		scopeCurator = 2;
	};
};


















#include "cfgMusic.hpp"