////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex (based on BIS_fnc_ambientAnimGetParams)
//	DATE: 6/29/16
//	VERSION: 1.0
//	FILE: Achilles\functions\fn_ambientAnimGetParams.sqf
//  DESCRIPTION: Returns the details of an animation set
//
//	ARGUMENTS:
//	_this select 0:			STRING	- animation set name
//
//	RETURNS:
//	_this select 0:			ARRAY	- array of animation names (string)
//	_this select 1:			BOOL	- true: no weapon during the animation
//
//	Example:
//	_animation_set_details = "GUARD" call Achilles_fnc_ambientAnimGetParams;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

private ["_anims","_noWeapon"];
_anim_set = _this;

_anims = [];
_noWeapon = false;

switch (_anim_set) do
{
	case "STAND_1":
	{
		_anims 	= ["HubStanding_idle1","HubStanding_idle2","HubStanding_idle3"];
	};
	case "STAND_2":
	{
		_anims 	= ["amovpercmstpslowwrfldnon","amovpercmstpslowwrfldnon","aidlpercmstpslowwrfldnon_g01","aidlpercmstpslowwrfldnon_g02","aidlpercmstpslowwrfldnon_g03","aidlpercmstpslowwrfldnon_g05"];
	};
	case "STAND_NO_WEAP_1":
	{
		_anims 	= ["HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3","HubStandingUA_move1","HubStandingUA_move2"];
		_noWeapon = true;
	};
	case "STAND_NO_WEAP_2":
	{
		_anims = ["HubStandingUB_idle1","HubStandingUB_idle2","HubStandingUB_idle3","HubStandingUB_move1"];
		_noWeapon = true;
	};
	case "STAND_NO_WEAP_3":
	{
		_anims 	= ["HubStandingUC_idle1","HubStandingUC_idle2","HubStandingUC_idle3","HubStandingUC_move1","HubStandingUC_move2"];
		_noWeapon = true;
	};
	case "WATCH_1":
	{
		_anims = ["inbasemoves_patrolling1"];
	};
	case "WATCH_2":
	{
		_anims = ["inbasemoves_patrolling2"];
	};
	case "GUARD":
	{
		_anims = 
		["inbasemoves_handsbehindback1","inbasemoves_handsbehindback2"];
		_noWeapon = true;
	};
	case "LISTEN_BRIEFING":
	{
		_anims = ["unaercposlechvelitele1","unaercposlechvelitele2","unaercposlechvelitele3","unaercposlechvelitele4"];
		_noWeapon = true;
	};
	case "BRIEFING":
	{
		_anims = ["hubbriefing_loop","hubbriefing_loop","hubbriefing_loop","hubbriefing_lookaround1","hubbriefing_lookaround2","hubbriefing_scratch","hubbriefing_stretch","hubbriefing_talkaround"];
		_noWeapon = true;
	};
	case "BRIEFING_INTERACTIVE_1":
	{
		_anims = ["Acts_C_in1_briefing"];
		_noWeapon = true;
	};
	case "BRIEFING_INTERACTIVE_2":
	{
		_anims = ["Acts_HUBABriefing"];
		_noWeapon = true;
	};
	case "LISTEN_TO_RADIO":
	{
		_anims = ["Acts_listeningToRadio_Loop"];
	};
	case "NAVIGATE":
	{
		_anims = ["Acts_NavigatingChopper_Loop"];
	};
	case "LEAN":
	{
		_anims = ["inbasemoves_lean1"];
		_noBackpack = true;
	};
	case "KNEEL":
	{
		_anims = ["amovpknlmstpslowwrfldnon","aidlpknlmstpslowwrfldnon_ai","aidlpknlmstpslowwrfldnon_g01","aidlpknlmstpslowwrfldnon_g02","aidlpknlmstpslowwrfldnon_g03","aidlpknlmstpslowwrfldnon_g0s"];
	};
	case "REPAIR_VEH_PRONE":
	{
		_anims = ["hubfixingvehicleprone_idle1"];
		_noWeapon = true;
	};
	case "REPAIR_VEH_KNEEL":
	{
		_anims = ["inbasemoves_repairvehicleknl"];
		_noWeapon = true;
	};
	case "REPAIR_VEH_STAND":
	{
		_anims = ["inbasemoves_assemblingvehicleerc"];
		_noWeapon = true;
	};
	case "PRONE_INJURED_NO_WEAP_1":
	{
		_anims = ["ainjppnemstpsnonwnondnon"];
		_noWeapon = true;
	};
	case "PRONE_INJURED_NO_WEAP_2":
	{
		_anims = ["hubwoundedprone_idle1","hubwoundedprone_idle2"];
		_noWeapon = true;
	};
	case "PRONE_INJURED":
	{
		_anims = ["acts_injuredangryrifle01","acts_injuredcoughrifle02","acts_injuredlookingrifle01","acts_injuredlookingrifle02","acts_injuredlookingrifle03","acts_injuredlookingrifle04","acts_injuredlookingrifle05","acts_injuredlyingrifle01"];
	};
	case "KNEEL_TREAT_1":
	{
		_anims = ["ainvpknlmstpsnonwnondnon_medic","ainvpknlmstpsnonwnondnon_medic0","ainvpknlmstpsnonwnondnon_medic1","ainvpknlmstpsnonwnondnon_medic2","ainvpknlmstpsnonwnondnon_medic3","ainvpknlmstpsnonwnondnon_medic4","ainvpknlmstpsnonwnondnon_medic5"];
		_noWeapon = true;
	};
	case "KNEEL_TREAT_2":
	{
		_anims = ["acts_treatingwounded01","acts_treatingwounded02","acts_treatingwounded03","acts_treatingwounded04","acts_treatingwounded05","acts_treatingwounded06"];
		_noWeapon = true;
	};
	case "CAPTURED_SIT":
	{	
		_anims = ["Acts_AidlPsitMstpSsurWnonDnon03","Acts_AidlPsitMstpSsurWnonDnon04","Acts_AidlPsitMstpSsurWnonDnon05"];
		_noWeapon = true;
	};
	case "SURRENDER":
	{	
		_anims = ["AmovPercMstpSsurWnonDnon"];
	};
	case "SIT_LOW":
	{	
		_anims = ["amovpsitmstpslowwrfldnon","amovpsitmstpslowwrfldnon_weaponcheck1","amovpsitmstpslowwrfldnon_weaponcheck2"];
	};
	case "INJURY_CHEST":
	{
		_anims = ["Acts_CivilinjuredChest_1"];
	};
	case "INJURY_HEAD":
	{
		_anims = ["Acts_CivilInjuredHead_1"];
	};
	case "INJURY_ARM":
	{
		_anims = ["Acts_CivilInjuredArms_1"];
	};
	case "INJURY_LEG":
	{
		_anims = ["Acts_CivilInjuredLegs_1"];
	};
	case "CIV_HIDE":
	{
		_anims = ["Acts_CivilHiding_1","Acts_CivilHiding_2"];
		_noWeapon = true;
	};
	case "CIV_SHOCK":
	{
		_anims = ["Acts_CivilShocked_1","Acts_CivilShocked_2"];
		_noWeapon = true;
	};
	case "TALK_CIV":
	{
		_anims = ["Acts_CivilTalking_1","Acts_CivilTalking_2"];
		_noWeapon = true;		
	};
	case "LISTEN_CIV":
	{
		_anims = ["Acts_CivilListening_1","Acts_CivilListening_2"];
		_noWeapon = true;
		
	};
	case "SHIELD_FROM_SUN":
	{
		_anims = ["Acts_ShieldFromSun_Loop"];
	};
	case "SHOWING_THE_WAY":
	{
		_anims = ["Acts_ShowingTheRightWay_loop"];
	};
};

[_anims,_noWeapon]