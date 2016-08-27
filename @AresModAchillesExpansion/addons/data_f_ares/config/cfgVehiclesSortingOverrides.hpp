// A bunch of defines to set the 'side' of equipment so that Arsenal code can
// sort it more effectivley. This is a lot faster and more reliable than trying to
// special-case sort everything based on display name.
#define SIDE_CSAT 0
#define SIDE_NATO 1
#define SIDE_AAF 2
#define SIDE_CIV 3

// Some forward defines for base classes we're not overriding
class B_AssaultPack_Base;
class B_Bergen_Base;
class B_Carryall_Base;
class B_FieldPack_Base;
class B_Kitbag_Base;
class B_TacticalPack_Base;

// NATO
class B_AssaultPack_mcamo : B_AssaultPack_Base { side = SIDE_NATO; };
class B_Bergen_mcamo : B_Bergen_Base { side = SIDE_NATO; };
class B_Carryall_mcamo : B_Carryall_Base { side = SIDE_NATO; };
class B_Kitbag_mcamo : B_Kitbag_Base { side = SIDE_NATO; };
class B_TacticalPack_mcamo : B_TacticalPack_Base { side = SIDE_NATO; };

// OPFOR
class B_AssaultPack_ocamo : B_AssaultPack_Base { side = SIDE_CSAT; };
class B_Carryall_ocamo : B_Carryall_Base { side = SIDE_CSAT; };
class B_Carryall_oucamo : B_Carryall_Base { side = SIDE_CSAT; };
class B_FieldPack_ocamo : B_FieldPack_Base { side = SIDE_CSAT; };
class B_FieldPack_oucamo : B_FieldPack_Base { side = SIDE_CSAT; };
class B_TacticalPack_ocamo : B_TacticalPack_Base { side = SIDE_CSAT; };

// AAF
class B_AssaultPack_dgtl : B_AssaultPack_Base { side = SIDE_AAF; };

// CIVILIAN
// EVERYTHING is civilian by default. Thanks BIS.

