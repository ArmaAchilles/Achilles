// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX z
#define PREFIX achilles

#include "script_version.hpp"

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define ACHILLES_TAG Achilles

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.90

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(achilles - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(achilles - COMPONENT)
#endif
