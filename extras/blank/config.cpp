#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"achilles_main"};
        author = "The Achilles Dev Team";
        authors[] = {"The Achilles Dev Team"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
