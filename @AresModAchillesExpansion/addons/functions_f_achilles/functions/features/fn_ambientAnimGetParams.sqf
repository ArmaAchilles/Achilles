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

private _anim_set = _this;

switch (_anim_set) do
{   // [anims, noWeapon]
	case "STAND_1":	{ [["HubStanding_idle1","HubStanding_idle2","HubStanding_idle3"], false] };
	case "STAND_2": { [["amovpercmstpslowwrfldnon","amovpercmstpslowwrfldnon","aidlpercmstpslowwrfldnon_g01","aidlpercmstpslowwrfldnon_g02","aidlpercmstpslowwrfldnon_g03","aidlpercmstpslowwrfldnon_g05"], false] };
	case "STAND_NO_WEAP_1": { [["HubStandingUA_idle1","HubStandingUA_idle2","HubStandingUA_idle3","HubStandingUA_move1","HubStandingUA_move2"], true] };
	case "STAND_NO_WEAP_2": { [["HubStandingUB_idle1","HubStandingUB_idle2","HubStandingUB_idle3","HubStandingUB_move1"], true]; };
	case "STAND_NO_WEAP_3": { [["HubStandingUC_idle1","HubStandingUC_idle2","HubStandingUC_idle3","HubStandingUC_move1","HubStandingUC_move2"], true] };
	case "WATCH_1": { [["inbasemoves_patrolling1"], false] };
	case "WATCH_2": { [["inbasemoves_patrolling2"], false] };
	case "GUARD": { [["inbasemoves_handsbehindback1","inbasemoves_handsbehindback2"], true] };
	case "LISTEN_BRIEFING": { [["unaercposlechvelitele1","unaercposlechvelitele2","unaercposlechvelitele3","unaercposlechvelitele4"], true] };
	case "BRIEFING": { [["hubbriefing_loop","hubbriefing_loop","hubbriefing_loop","hubbriefing_lookaround1","hubbriefing_lookaround2","hubbriefing_scratch","hubbriefing_stretch","hubbriefing_talkaround"], true] };
	case "BRIEFING_INTERACTIVE_1": { [["Acts_C_in1_briefing"], true] };
	case "BRIEFING_INTERACTIVE_2": { [["Acts_HUBABriefing"], true] };
	case "LISTEN_TO_RADIO": { [["Acts_listeningToRadio_Loop"], false] };
	case "NAVIGATE": { [["Acts_NavigatingChopper_Loop"], false] };
	case "LEAN":
	{
        [["inbasemoves_lean1"], false];
		private _noBackpack = true; // _noWeapon?
	};
	case "KNEEL": { [["amovpknlmstpslowwrfldnon","aidlpknlmstpslowwrfldnon_ai","aidlpknlmstpslowwrfldnon_g01","aidlpknlmstpslowwrfldnon_g02","aidlpknlmstpslowwrfldnon_g03","aidlpknlmstpslowwrfldnon_g0s"], false] };
	case "REPAIR_VEH_PRONE": { [["hubfixingvehicleprone_idle1"], true] };
	case "REPAIR_VEH_KNEEL": { [["inbasemoves_repairvehicleknl"], true] };
	case "REPAIR_VEH_STAND": { [["inbasemoves_assemblingvehicleerc"], true] };
	case "PRONE_INJURED_NO_WEAP_1": { [["ainjppnemstpsnonwnondnon"], true] };
	case "PRONE_INJURED_NO_WEAP_2": { [["hubwoundedprone_idle1","hubwoundedprone_idle2"], true] };
	case "PRONE_INJURED": { [["acts_injuredangryrifle01","acts_injuredcoughrifle02","acts_injuredlookingrifle01","acts_injuredlookingrifle02","acts_injuredlookingrifle03","acts_injuredlookingrifle04","acts_injuredlookingrifle05","acts_injuredlyingrifle01"], false] };
	case "KNEEL_TREAT_1": { [["ainvpknlmstpsnonwnondnon_medic","ainvpknlmstpsnonwnondnon_medic0","ainvpknlmstpsnonwnondnon_medic1","ainvpknlmstpsnonwnondnon_medic2","ainvpknlmstpsnonwnondnon_medic3","ainvpknlmstpsnonwnondnon_medic4","ainvpknlmstpsnonwnondnon_medic5"], true] };
	case "KNEEL_TREAT_2": { [["acts_treatingwounded01","acts_treatingwounded02","acts_treatingwounded03","acts_treatingwounded04","acts_treatingwounded05","acts_treatingwounded06"], true]	};
	case "CAPTURED_SIT": { [["Acts_AidlPsitMstpSsurWnonDnon03","Acts_AidlPsitMstpSsurWnonDnon04","Acts_AidlPsitMstpSsurWnonDnon05"], true] };
	case "SURRENDER": { [["AmovPercMstpSsurWnonDnon"], false] };
	case "SIT_LOW": { [["amovpsitmstpslowwrfldnon","amovpsitmstpslowwrfldnon_weaponcheck1","amovpsitmstpslowwrfldnon_weaponcheck2"], false]	};
	case "INJURY_CHEST": { [["Acts_CivilinjuredChest_1"], false] };
	case "INJURY_HEAD": { [["Acts_CivilInjuredHead_1"], false] };
	case "INJURY_ARM": { [["Acts_CivilInjuredArms_1"], false] };
	case "INJURY_LEG": { [["Acts_CivilInjuredLegs_1"], false] };
	case "CIV_HIDE": { [["Acts_CivilHiding_1","Acts_CivilHiding_2"], true] };
	case "CIV_SHOCK": { [["Acts_CivilShocked_1","Acts_CivilShocked_2"], true] };
	case "TALK_CIV": { [["Acts_CivilTalking_1","Acts_CivilTalking_2"], true] };
	case "LISTEN_CIV": { [["Acts_CivilListening_1","Acts_CivilListening_2"], true] };
	case "SHIELD_FROM_SUN": { [["Acts_ShieldFromSun_Loop"], false] };
	case "SHOWING_THE_WAY": { [["Acts_ShowingTheRightWay_loop"], false] };
};
