
#define SKILLS		["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"]


_entity = _this;

_constructor = [typeOf _entity];

if (not isNull (group _entity)) then
{
	_constructor append [groupID group _entity, side _entity];
};
_attributes = [["Contructor",_constructor]];

if (simulationEnabled _entity) then {_attributes pushBack ["Sim",false]};
_attributes append [["Pos",getPosWorld _entity],["Dir",direction _entity]];

if (damage _entity > 0) then {_attributes pushBack ["Damage",(getAllHitPointsDamage _entity) select 2]};

if (_entity isKindOf "Man") then
{
	_attributes pushBack ["Name",name _entity];
	
	if (skill _entity != 0.5) then {_attributes pushBack ["Skill",SKILLS apply {_entity skill _x}};
	
	_abilities = _entity getVariable ["Achilles_Ability",nil];
	if (not isNil "_abilities") then {_attributes pushBack ["Ability",_abilities};
	
	if (not isNil {_entity getVariable ["Achilles_Arsenal",nil]}) then {_attributes pushBack ["Loadout",getUnitLoadout _entity]};
	
	_stance = stance _entity;
	if (_stance != "UNDEFINED")	 then {_attributes pushBack ["Stance",_stance]};
	
	_light = _entity getVariable ["Achilles_GunLight",nil];
	if (not isNil "_light") then {_attributes pushBack ["Gunlight",_light]};
	
	_anim = _entity getVariable ["Achilles_Anim",nil];
	if (not IsNil "_anim") then {_attributes pushBack ["Anim",_anim]};
	
	_surrender = _entity getVariable ["Achilles_Surrender",nil];
	if (not IsNil "_surrender") then {_attributes pushBack ["Surrender",_surrender]};
};

if ()