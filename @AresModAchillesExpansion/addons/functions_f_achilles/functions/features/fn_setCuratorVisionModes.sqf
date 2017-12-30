// Get settings

private _modes = [-1]; // default view

if (achilles_curator_vision_nvg)               then { _modes pushBack -2; };
if (achilles_curator_vision_whitehot)          then { _modes pushBack 0; };
if (achilles_curator_vision_blackhot)          then { _modes pushBack 1; };
if (achilles_curator_vision_greenhotcold)      then { _modes pushBack 2; };
if (achilles_curator_vision_blackhotgreencold) then { _modes pushBack 3; };
if (achilles_curator_vision_redhot)            then { _modes pushBack 4; };
if (achilles_curator_vision_blackhotredcold)   then { _modes pushBack 5; };
if (achilles_curator_vision_whitehotredcold)   then { _modes pushBack 6; };
if (achilles_curator_vision_redgreen)          then { _modes pushBack -7; };

private _curatorLogic = (getAssignedCuratorLogic player);

[_curatorLogic, _modes] call bis_fnc_setcuratorvisionmodes;
