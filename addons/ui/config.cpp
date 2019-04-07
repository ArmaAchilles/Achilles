#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"achilles_common"};
        author = AUTHOR_NAME;
        authors[] = {AUTHOR_NAME};
        url = AUTHOR_URL;
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"

#include "resources/RscBaseClasses.hpp"
#include "resources/RscDynamicDialog.hpp"
