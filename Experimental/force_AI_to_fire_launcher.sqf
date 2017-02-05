_u = _this select 1; 
_w = secondaryWeapon _u;

_u reveal [tt,4];
_u doTarget tt;

_u forceWeaponFire [_w,"single"];
sleep 0.1;
_u disableAI "ANIM";
systemChat str _w;

_u disableAI "AUTOTARGET";
_u disableAI "TARGET";
sleep 4;
_u forceWeaponFire [_w,"single"];
sleep 4;

_u enableAI "AUTOTARGET";
_u enableAI "TARGET";
_u enableAI "ANIM";
systemChat str "JJ"



_u = _this select 1;  
_w = secondaryWeapon _u; 
_u reveal [tt,4]; 
_u doTarget tt; 
sleep 4;
_u forceWeaponFire [_w,"single"]; 
sleep 0.1; 
_u disableAI "ANIM"; 
systemChat str _w; 
 
sleep 4; 
_u forceWeaponFire [_w,"single"]; 
sleep 4; 
_u doWatch ObjNull;
_u doTarget ObjNull;_u enableAI "ANIM"; 
systemChat str "JJ"


[group (_this select 1),_this select 0,_this select 0] call BIS_fnc_unpackStaticWeapon
_gunner action ["Assemble",unitbackpack _gunner];