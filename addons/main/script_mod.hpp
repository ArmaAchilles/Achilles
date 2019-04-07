// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp

#define MAINPREFIX z
#define PREFIX achilles
#define PROJECT_NAME "Achilles"
#define PROJECT_DIR @achilles
#define AUTHOR_NAME "The Achilles Dev Team"
#define AUTHOR_URL "https://github.com/ArmaAchilles/Achilles"

#include "script_version.hpp"

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.90

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(achilles - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(achilles - COMPONENT)
#endif
