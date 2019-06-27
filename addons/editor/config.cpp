#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"achilles_main"};
        author = AUTHOR_NAME;
        authors[] = {AUTHOR_NAME};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
