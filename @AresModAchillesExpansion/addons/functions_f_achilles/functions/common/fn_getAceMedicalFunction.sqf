/*
 * Author: DeliciousJaffa
 * Determines what function we need to call (are we ACE v3.13+? (medical rewrite)).
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Return Value <CODE>
 *
 * Example:
 * [] call Achilles_fnc_getAceMedicalFunction
 *
 * Public: No
 */

 private _function = switch (true) do {
	case (!isNil "ace_medical_treatment_fnc_fullHeal"): {ace_medical_treatment_fnc_fullHeal};
	case (!isNil "ace_medical_fnc_treatmentAdvanced_fullHeal"): {ace_medical_fnc_treatmentAdvanced_fullHeal};
	default {{}};
};

_function