//////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 9.5.18
//	VERSION: 1.1,0
//  DESCRIPTION: Unlocks animations for the ambient animation module
//////////////////////////////////////////////////////////////////////////////////

class CfgMovesBasic
{
	class Default {};
	class StandBase : Default {};
	class AgonyBase : Default {};
};
class CfgMovesMaleSdr : CfgMovesBasic
{
	class States
	{
		class HubTemplateU : StandBase {};
		class HubTemplate : HubTemplateU {};
		class HubTemplate_Briefing : HubTemplateU {};
		class AmovPercMstpSnonWnonDnon : StandBase {};
		class CutSceneAnimationBase : AmovPercMstpSnonWnonDnon {};
		class Campaign_Base : AmovPercMstpSnonWnonDnon {};
		class AidlPercMstpSnonWnonDnon_G0S : AmovPercMstpSnonWnonDnon {};
		class AmovPpneMstpSnonWnonDnon_injured : AgonyBase {};
		class AmovPercMstpSlowWrflDnon : StandBase
		{
			displayName = "$STR_AMAE_STAND_IDLE";
			Achilles_var_animGroupName = "STAND_1";
			Achilles_var_isAmbient = 1;
		};
		class AmovPknlMstpSlowWrflDnon : AmovPercMstpSlowWrflDnon {};
		class AidlPknlMstpSlowWrflDnon_G0S : AmovPknlMstpSlowWrflDnon
		{
			displayName = "$STR_AMAE_KNEEL";
			Achilles_var_isAmbient = 1;
		};
		class HubStanding_idle1 : HubTemplate
		{
			displayName = "$STR_AMAE_STAND_IDLE";
			Achilles_var_animGroupName = "STAND_2";
			Achilles_var_isAmbient = 1;
		};
		class HubStandingUA_idle1 : HubTemplateU
		{
			displayName = "$STR_AMAE_STAND_IDLE_NO_WEAPON";
			Achilles_var_animGroupName = "STAND_NO_WEAP_1";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class HubStandingUB_idle1 : HubTemplateU
		{
			displayName = "$STR_AMAE_STAND_IDLE_NO_WEAPON";
			Achilles_var_animGroupName = "STAND_NO_WEAP_2";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class HubStandingUC_idle1 : HubTemplateU
		{
			displayName = "$STR_AMAE_STAND_IDLE_NO_WEAPON";
			Achilles_var_animGroupName = "STAND_NO_WEAP_3";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class HubBriefing_loop : HubTemplate_Briefing
		{
			displayName = "$STR_AMAE_BRIEFING";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class HubBriefing_lookAround1 : HubTemplate_Briefing
		{
			displayName = "$STR_AMAE_BRIEFING";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class HubBriefing_lookAround2 : HubTemplate_Briefing
		{
			displayName = "$STR_AMAE_BRIEFING";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class HubBriefing_scratch : HubTemplate_Briefing
		{
			displayName = "$STR_AMAE_BRIEFING";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class hubbriefing_stretch : HubTemplate_Briefing
		{
			displayName = "$STR_AMAE_BRIEFING";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class hubbriefing_talkaround : HubTemplate_Briefing
		{
			displayName = "$STR_AMAE_BRIEFING";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class HubBriefing_think : HubTemplate_Briefing
		{
			displayName = "$STR_AMAE_BRIEFING";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class Acts_C_in1_briefing : CutSceneAnimationBase
		{
			displayName = "$STR_AMAE_BRIEFING_INTERACTIVE";
			Achilles_var_isAmbient = 1;
			Achilles_var_animGroupName = "BRIEFING_INTERACTIVE_1";
			Achilles_var_hideWeapon = 1;
		};
		class Acts_HUBABriefing : Campaign_Base
		{
			displayName = "$STR_AMAE_BRIEFING_INTERACTIVE";
			Achilles_var_isAmbient = 1;
			Achilles_var_animGroupName = "BRIEFING_INTERACTIVE_2";
			Achilles_var_hideWeapon = 1;
		};
		class Acts_listeningToRadio_Loop : Campaign_Base
		{
			displayName = "$STR_AMAE_LISTEN_TO_RADIO";
			Achilles_var_isAmbient = 1;
		};
		class Acts_NavigatingChopper_Loop : Campaign_Base
		{
			displayName = "$STR_AMAE_GUIDE_AIRCRAFT";
			Achilles_var_isAmbient = 1;
		};
		class InBaseMoves_assemblingVehicleErc : AidlPercMstpSnonWnonDnon_G0S
		{
			displayName = "$STR_AMAE_REPAIR_VEH_STAND";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class HubFixingVehicleProne_idle1 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_REPAIR_VEH_PRONE";
		};
		class inbasemoves_repairvehicleknl : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_REPAIR_VEH_KNEEL";
		};
		class InBaseMoves_Lean1 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_LEAN_ON_A_WALL";
			Achilles_var_hideWeapon = 0;
		};

		class InBaseMoves_patrolling1 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_WATCH";
			Achilles_var_animGroupName = "WATCH_1";
			Achilles_var_hideWeapon = 0;
		};
		class InBaseMoves_patrolling2 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_WATCH";
			Achilles_var_animGroupName = "WATCH_2";
			Achilles_var_hideWeapon = 0;
		};
		class InBaseMoves_HandsBehindBack1 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_GUARD";
		};
		class UnaErcPoslechVelitele1 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_LISTEN_BRIEFING";
		};
		class UnaErcPoslechVelitele2 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_LISTEN_BRIEFING";
		};
		class UnaErcPoslechVelitele3 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_LISTEN_BRIEFING";
		};
		class UnaErcPoslechVelitele4 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "$STR_AMAE_LISTEN_BRIEFING";
		};
		class class InBaseMoves_table1 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "";
			Achilles_var_isAmbient = 0;
		};
		class class InBaseMoves_HandsBehindBack1 : InBaseMoves_assemblingVehicleErc
		{
			displayName = "";
			Achilles_var_isAmbient = 0;
		};
		class AinjPpneMstpSnonWnonDnon : AmovPpneMstpSnonWnonDnon_injured
		{
			displayName = "STR_AMAE_WOUNDED_GENERAL";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
		class AinjPpneMstpSnonWnonDnon : AmovPpneMstpSnonWnonDnon_injured
		{
			displayName = "STR_AMAE_WOUNDED_GENERAL";
			Achilles_var_isAmbient = 1;
			Achilles_var_hideWeapon = 1;
		};
	};
};