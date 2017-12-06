﻿Known issues				<br>
─────────────────────────────────── 	<br>
* Switch Unit for non-local units: Notable delay observed before control works.
* CUP planes are not working properly for vanilla CAS module.
* Reinforcement module may mix up groups of 3rd pary add-ons.

Versioning (introduced with 0.0.8)	<br>
───────────────────────────────────	<br>
X.X.Xc					<br>
│ │ │└ hotfixes (optional)		<br>
│ │ └─ "small" update			<br>
│ └─── "major" update			<br>
└───── stage (alpha, beta, ...)		<br>

Change log				<br>
───────────────────────────────────	<br>
V.0.0.9c
* Fix:		Fixed a critical issue that causes stances not to work.

V.0.0.9
* Change:	Locked vehicles can be entered by remote controlled AI (same as "Locked for Players" in Eden).
* Change:	Advanced Weather Module: Takes current weather data as default values; Rainbow slider.
* Change:	Add objects to Zeus: Only adds objects to the Zeus player that used the module.
* Change:	Adjusted name of Patrol/Loiter module to emphasize that loiter is not restricted to choppers.
* Change:	displayName config parameter is now used when selecting ammo types when using the Fire Mission module. This improves user-friendliness and allows easier selection of muntion types.
* Feature:	Attribute window: Sliders show actual value as a tooltip.
* Feature:	Achilles_fnc_showChooseDialog, a revised version of Ares_fnc_showChooseDialog (the latter is kept for compatibility reasons).
* Feature:	New useful global veriable: Achilles_var_latestModuleLogic.
* Feature:	Option to give suicide bombers vests to make it look more realistic.
** Fix:		CAS Bomb Strike: Module was listed twice and cluster bombs were not available.
* Fix:		Hotkey for remote control and switch unit features did not work while the map was open.
* Fix:		Set map position to camera position after loading interface.
* Fix:		Fix weapons not being removed when Pylon Loadout is changed (by @CoxLedere).
* Fix:		Fixed an error when suicide bombers were used when the disabling type was selected.

V.0.0.8c
* Change:	Removed Zeus wind sound effect for remote control (by @CreepPork).
* Change:	If Ares is enabled at the same time, Achilles will just spawn a warning message and not block Zeus entirely.
* Change:	Skill slider range is no longer hard-coded. It takes the range as in 3den instead (see [BIS forum](https://forums.bistudio.com/forums/topic/191113-ares-mod-achilles-expansion/?do=findComment&comment=3204945)).
* Change:	Renamed vehicle attribute button "AMMO" to "LOADOUT" to make clear that ammo has to be adjusted with the slider.
* Change:	Dynamic Loadout interface makes use of the new getCompatiblePylonMagazines command (=> better preformance).
* Change:	Faction whitelist option was temporarly removed due to instabilities (actually it was already removed in 0.0.8, but not mentioned).
* Change:	Swich Unit hotkey was changed due to conflict with MCC (new hotkey: Alt + 2xLMB).
* Change:	Improved Achilles initialization for Zeus Game Master missions.
* Change:	Replaced Achilles_fnc_addCuratorInterfaceEventHandler by CBA event handler system with "Achilles_onLoadCuratorInterface" and "Achilles_onUnloadCuratorInterface" as keywords.
* Fix:		"Switch Unit" module does not work properly for drones  => introduced exception handling.
* Fix:		"Switch Unit" and "Remote Control" were triggered by 2xLMB without an additional key in certain cases.
* Fix:		"Switch Unit": face of the controlled unit were overwritten by the player's settings.
* Fix:		Debug logging was still present for the bomb strike module.
* Fix:		Achilles_fnc_arrayMean had no exception handling for empty arrays.
* Fix:		Paradrop: Exception handling did not work for 3rd party add-on chutes (= unit had 2 chutes instead of one; see [Steam](http://steamcommunity.com/workshop/filedetails/discussion/723217262/1291817208487058671/)).

V.0.0.8
* Change:	Carrier base gets added automatically; Deletion will affect all carrier parts (the carrier is not movable though).
* Change:	Intel: The map only opens for the player that picked it up. Who actually gets the intel as well still depends on the settings.
* Change:	Heal and injury modules check for ace_medical instead of ace_main (by @CreepPork).
* Feature:	Promote player to Zeus; This module is only available for admins when the execute code module is disabled; The rights are lost when the player respawns or disconnects (by @CreepPork).
* Feature:	Function Viewer Module (Dev Tools).
* Feature:	Switch Unit, an alternative to remote control, which gives full control over the unit (hotkey: LSHIFT + 2xLMB).
* Feature:	Side as a group attribute (new attribute button).
* Feature:	Change Zeus vision mode brightness (feature inspired by ACE3; ALT+PAGE UP/DOWN by default)
* Feature:	IED and Suicide Bomber modules (by @CreepPork).
* Feature:	Implemented Achilles_fnc_addCuratorInterfaceEventHandler.
* Feature:	Added "allow fleeing" parameter to AI ability module.
* Fix:		USS Freedom: Spawned twice in certain cases.
* Fix:		Vanilla cycle waypoint issue for copied units (waypoint ended up on map origin).
* Fix:		Ammo slider (vehicle attributes): Did not handle dynamic loadouts correctly.
* Fix:		Align object horizontal (default key: X): Did not execute Achilles_fnc_HandleCuratorObjectEdited.
* Fix:		Dynamic Dialog Side Control: Clicking on current selected side led to unintended behaviour.
* Fix:		Canceling selection option: Did not work properly for a few modules.
* Fix:		"Selection option" and "specify position" modes missed exception handling: Exiting Zeus interface.
* Fix:		"Specify position" in recent tab was also executed for Zeus modules and multiple times for groups.
* Fix:		"Create/Edit Intel" did not handle newline characters (Hotkey: LSHIFT+RETURN).
* Fix:		Create/Edit Intel: Dialog title did not describe the exact action (create, spawn or edit). 

V.0.0.7d (Achilles Expansion (alpha version))
* Change:	Several critical modules can no longer be added to Zeus (prevents unintended deletion).
* Change:	Specify position (spawn attribute) was improved (it is now a valuable tool for placing objects on a carrier).
* Feature:	Dynamic loadout as a vehicle attribute (ammo button).
* Feature:	Deep copy works for dynamic loadouts.
* Feature:	Spawn USS Freedom.
* Fix:		Specify position (spawn attribute): Did not work for "Recent" tab.
* Fix:		Vehicle respawn system was broken after 1.70 update.
* Fix:		Set Date module was broken after 1.70 update.
* Fix:		CAS modules: Most planes did not show up after 1.70 update.
* Fix:		CAS modules did not support planes with dynamic loadouts.
* Fix:		Earthquake module: Missing text in dialog (by @CreepPork)

V.0.0.7c (Achilles Expansion (alpha version))
* Change:	Removed versioning form the steam workshop title.
* Change:	Add Simple Objects to Zeus was removed, since it is not reliable atm (will be reintroduced when ready).
* Fix:		Lock door module: Timing issue with add lock door logics (logics ended up at [0,0,0] at low performance).
* Fix:		Lock door module: Exception handling in the case not sufficient lock door logics could be allocated was missing.
* Fix:		Lock door module: Houses that the module was reapplied were no longer locked.
* Fix:		Zeus interface: Scrolling down to the bottom of the right module tree shifted the entire right tool bar.
* Fix:		Un-garrison module was broken.
* Fix:		CAS modules were broken in certain cases (e.g. Achilles was loaded to the server).

V.0.0.7 (Achilles Expansion (alpha version))
* Change:	ACE injury module: Adjusted damage levels.
* Change:	Removed side restriction for vanilla CAS modules.
* Change:	Radial searches are now conducted in 2D (ignoring z) instead of 3D (e.g. damage buidlings).
* Change:	All dialog windows are movable now.
* Change:	Module "Hint" makes use of "MESSAGE" control type.
* Change:	Forced advanced hint window for selection option.
* Change:	Cargo Attributes: Larger dialog window.
* Change:	Replace icon for CAS Target.
* Change:	Replace waitUnit delete by "deleted" event handler (e.g. advanced compositions).
* Feature:	Make object invincible module.
* Feature:	Suppressive fire module: Line-up is now an option and no longer handled automatically.
* Feature:	ACE injury module: injury types, pain level, blood volume and hearth rate.
* Feature:	Add/remove Zeus objects can now handle simple objects (EXPERIMENTAL - DO NOT YET SUPPORT FEATURES SUCH AS COPY/PASTE, ADV. COMPOSITIONS, SAVE MISSION SQF, ...).
* Feature:	Show config and animation viewer modules.
* Feature:	Vehicle garage from Eden editor.
* Feature:	Create TPs: Custom names can be given to teleport flags.
* Feature:	Hint Module: Support XML syntax (allows including images).
* Feature:	Recovered vanilla CAS bomb strike module (dunno why it was hidden).
* Feature:	Vanilla CAS modules: Implemented general config solution => support any 3rd party add-on.
* Feature:	Implement additional ambient animations (see comment by [GHC] RandomMusic).
* Feature:	Set date module.
* Feature:	Attribute window for light sources: RGB, radius and attenuation.
* Feature:	"Lock door" module (including breach option, inspired by [Sushi Breach Script](http://www.armaholic.com/page.php?id=30573)).
Went missing in previous versions: Instant occupation does distribute large group (>8 members) on different buildings (@Grezvany13).
* Fix:		ACE injury module: Untreatable unconsciousness.
* Fix:		Suppressive fire module: Did not work for non-local units.
* Fix:		Add/remove Zeus objects: Exclude curator module from being added to Zeus interface.
* Fix:		Locality issue with vectordir and -up changes (e.g. Spawn Advanced Compositions).
* Fix:		Pressing attribute buttons (e.g. arsenal) undid changes of attributes in the main window.
* Fix:		Effect modules were placed by setVehiclePosition algorithm (inaccurate position).
* Fix:		Punishment module was missing.
* Fix:		Force AI to chute: Exception handling for units that already have a chute was missing.
* Fix:		Syntax error in dynamic dialog cfg   (fixed by @shukari)
* Fix:		Missing error message for modules such as "Hava a seat".

V.0.0.6d (Achilles Expansion (alpha version))
* Change:	Artillery fire support module: Removed workaround (BIS fixed it).
* Fix:		Add/Remove objects to Zeus: Type "Unit" did not select soldiers. Moreover, it did select empty vehicles.
* Fix:		Ares Compositions did not work properly in 1.68.
* Fix:		Damage Vehicle Components: Did not work for local units.
* Fix:		Cange Skills/Traits: EOD label was missing in ACE version.
* Fix:		Cange Skills/Traits: EOD and engineer did not work for ACE.

V.0.0.6c (Achilles Expansion (alpha version))
* Fix:		Spawn attributes ticks were not updated after reopening zeus interface.
* Fix:		Target/LZ/RP logics default value was always the same & wrong message.
* Fix:		Static artillery from third-party add-ons did not fire multiple rounds.

Changelists
V.0.0.6 (Achilles Expansion (alpha version))
* Change:	Create Intel: Simulation of new created intel is no longer enabled.
* Change:	Ammo box inventory is no longer opened automatically on spawn.
* Change:	Add/Remove editable objects: Extend search pattern to static turrets for type "units" and "vehicles".
* Change:	Update ACE module category name to ACE3 3.9.0.
* Change:	"Bind variable to object" module: Global variable is optional.
* Change:	Enlarge Attributes window to prevent the need of scroll bars.
* Change:	Intel: enlarge description section.
* Change:	Maximal # rounds for arty changed to 10.
* Change:	Improve inventory dialog (improved performance by caching data; separated virtual arsenal (VA) from normal inventory; numpad keybinding: +/- (useful to make fast changes), * = VA, / = weapon sepecific); double click on weapon => weapon specific; sorted alphabetic, press letter/number to switch between entries; include faceware)
* Feature:	Fire Support: Attack chopper CAS (target logic + module; might be laggy)
* Feature:	Names of target/LZ/RP logics can be specified.
* Feature:	Ares_fnc_showChooseDialog: New control type: "MESSAGE" (see [Achilles Wiki](https://github.com/oOKexOo/AresModAchillesExpansion/wiki/Custom-Modules))
* Feature:	Settings: Auto-collapse module tree is optional
* Feature:	Implement scroll bar for Ares_fnc_showChooseDialog
* Feature:	Pre-placing mode (Allows defining spawn position prior to spawning the asset/module; especially useful for carriers).
* Feature:	Additional way to spawn vehicles without crew.
* Feature:	Edit unit attributes: Change unit traits (Medic, EOD, engineer); Vanilla & ACE3 version.
* Feature:	Change Ability: PATH (by @Grezvany13).
* Feature:	Attributes window: Changed attributes are applied on all selected units/vehicles/ammo boxes/groups (as in Eden editor; real game changer!).
* Fix:		Healing module did not work for non-local units.
* Fix:		Patrol/Loiter Module: Fails when chopper is not in the air.
* Fix:		Ares_fnc_ShowChooseDialog: Variable scope issue ([BIS forum](https://forums.bistudio.com/topic/191113-ares-mod-achilles-expansion/?do=findComment&comment=3157509))
* Fix:		If fog decay was set to 0 a strange behaviour was observed (see [youtube](https://www.youtube.com/watch?v=vksk_BiC3o4)).
* Fix:		Achilles object attributes are incomptatible with "Set Attributes - X" modules.
* Fix:		Damage vehicle components: Not all components were available and some component names went missing.
* Fix:		Translation corrections for German (by @KiritoKun223)
* Fix:		Factions with apostrophe in the name lead to errors (fixed by @shukari).
* Fix:		Unessecary creation of dependency on achilles_data_f_achilles when placing compositions in Eden ([BIS Forum](https://forums.bistudio.com/topic/191113-ares-mod-achilles-expansion/?do=findComment&comment=3140115)).
* Fix:		Mines were still revealed to players (0.0.5 only removed the map markers...).

V.0.0.5 (Achilles Expansion (alpha version))
* Change:	Garrison module: Replace searching pattern "House" by "Building" (=> more buildings are available e.g. Tanoa WW2 bunkers).
* Change:	Moved "Create/Edit intel" module from "spawn" to "scenario flow" category (see #40)
* Change:	"Destroy Buildings" Module was changed to "Damage Buildings" Module (=more options).
* Change:	"Patrol" module was changed to "Patrol/Loiter (Heli)" => Loiter waypoint for aircrafts.
* Change:	Default assigned hotkey to eject passengers has changed from `LEFT SHIFT` + `G` to `V`.
* Change:	For logged-in admins the "execute code" module is in any case available.
* Change:	"Bind variable to object" variable is no longer public, but still global.
* Change:	Postpone initialization of global functions to the point they are needed (like CED version).
* Feature:	Toggle street lamps module
* Feature:	Autocollapse Tree (see #26) 
* Feature:	Apex symbol in front of apex objects and warning message.
* Feature:	CBA settings framework (by @Grezvany13).
* Feature:	Settings: Helmet & DLC icons for module tree (by @Grezvany13).
* Feature:	Settings: Zeus vison modes (by @Grezvany13).
* Feature:	Settings: Set available factions for module tree (especially useful for addons like CUP).
* Feature:	Settings: Customizable hotkeys.
* Feature:	Waypoint: Paradrop waypoint.
* Feature:	Waypoint: Improved fastroping waypoint; ACE3 or Advanced Rappeling (AR) is needed. The latter is used if both are loaded. (Note that ACE3 fastroping does not work properly in MP in contrast to AR)
* Feature:	Reinforcement Module: Type of waypoint can be selected: Land, fastroping or paradrop.
* Feature:	JIP option for execute code.
* Feature:	Module "Change Altitude": Change altitude for aircrafts, divers and submarines (Note: In some cases you have to place a waypoint to get the desired effect!).
* Feature:	Improve "Add objects to Zeus" module (shorter radius, Filters)
* Fix:		Non-local surrendered units stuck after release in cetain cases.
* Fix:		Implement solution similar to CED (see #27).
* Fix:		Player manned vehicles cannot be edited (see [BIS forum](https://forums.bistudio.com/topic/191113-ares-mod-achilles-expansion/?do=findComment&comment=3132117))
* Fix:		Advanced attributes do not work for non-local units (see #38)
* Fix:		"Garrison building instant" module does not work for non-local units.
* Fix:		Suppressive fire does not work properly with move waypoints.
* Fix:		Mines were marked on map (check ACE3 solution?)
* Fix:		Mortar only fire one shell (see #36)

V.0.0.4d (Achilles Expansion (alpha version))
* Feature: Updated Russian Translation (by Igor Nikolaev).
* Fix:     Single unit player teleport option was broken.

V.0.0.4c (Achilles Expansion (alpha version))
* Fix:     Player edit menu was broken.

V.0.0.4 (Achilles Expansion (alpha version))
* Change:  Teleport player: Teleport entire vehcile is now optional.
* Change:  Instant occupation does distribute large group (>8 members) on different buildings (by Grezvany13)
* Change:  Revised equipment module category.
* Change:  Chatter module now sets mouse cursor on text box automatically.
* Change:  Remote control chatter: Acces to zeus chat was not avialabel.
* Change:  Sort player and group lists in alphabetic order (Player Module Category).
* Change:  Suppressive fire: group lines up perpendicular to target direction (except in combat).
* Feature: A few new Advanced Compositions from Apex Protocol campaign.
* Feature: Updated Russian Translation (by Igor Nikolaev).
* Feature: Achilles Dialog windows can be moved.
* Feature: Damage vehicle components button is implemented (edit vehicle menu).
* Feature: Behaviour careless and combat modes (from "hold fire" to "fire and engage at will").
* Feature: Set ammunition slider (vehicle and unit edit menu).
* Feature: Headlight/Searchlight option (vehicle edit menu)
* Feature: Unit edit menu: Arsenal and Skill button; set unit name for chatter module
* Fix:     Suppressive fire: 
           - Broke down when more than 2 "suppression target modules" were available. 
           - Unit did not cease fire if group mate is in line of fire.
           - Suppressive fire: Units went "crazy" in mechanized and motorized groups.
* Fix:     Logger for loading achilles modules was not removed.
* Fix:     Client side script errors reported in RPT log file.
* Fix:     Wind force of 0 is no longer possible (prevents flares from being stuck in the air).
* Fix:     Remote controlled units were not able to untie a surrendered unit or pick up an intel.
* Fix:     Create intel Module:
           - Issues that occure when multiple intels were created (not fully proven to be fixed).
           - Script error due to wrong variable locality.
* Fix:     Compatibility issues between Ares and TFAR (not fully proven to be fixed)
* Fix:     Script errors in surrender unit module.



V.0.0.3 (Achilles Expansion (alpha version))
* Change:  Heavily reorganized scripts and compartmentalized pbo similar to vanilla add-ons
           This might lead to unintented losses of some functionalities (please report!)
* Change:  Optimized the way the add-on is initialized
           - No script runs at all when player is not Zeus.
           - Loading of modules is now directly coupled with the Zeus Display.
* Change:  Updated Russian Translation (by Igor Nikolaev).
* Change:  Warning message in case Ares is loaded too.
* Change:  Save SQF Module is now based on world positions (not final yet!!!)
* Change:  Replaced BIS_fnc_destroy City by the Achilles function in the earthquake module.
           (Fix: earthquake undid previous destruction)
* Feature: Create Advanced Compositions: Now supports turrets
* Feature: Options for suppresive fire module (Stance, Fire Mode, time)
* Feature: Surrender with Apex Progress Bar Action and more options
* Feature: Create Intel now supports Apex Progress Bar Action 
           => many new options are possible e.g. hacking laptop/get intel from enemy unit/pick up intel or whatever
* Feature: Option to teleport zeus instant in teleport player module
* Feature: toggle destroy buildings for earthquake
* Feature: Transfer ownership module (allows transfering units/objects to server)
* Fix:     Intels could not be properly edited
* Fix:     RHS reinforcements were broken due to renaming of Vehicle Classes in the last RHS update 
* Fix:     Switch player side was broken
* Fix:     Several functionalities did not work on non-local units (e.g. players):
           - "LEFT CTRL + G" - eject 
           - Ambient Animations
           Note: The functionalities should now even work on players.
* Fix:     Spawn Light Source and Peristent Smoke Pillar did work for clients without Achilles
* Fix:     Injury Module (Vanilla Version): random option led to death with high probabilty
* Fix:     Script errors caused by canceling selection option
* Fix:     Compositions were not accessible in Eden editor (fixed by S. Crowe)
* Fix:     Custom Modules could not be added in mission init phase (e.g. init.sqf)
* Fix:     Units could not properly have a seat on chairs from advanced compositions       
* Fix:     Animal Category is back, although it will be replaced as soon as the new animal spawn module is finished
* Fix:     ERROR IN FIELD MANUAL: Wrong hotkey for Deep Copy/Paste
* Fix:     Flagpole teleporter did not account for height.
* Fix:     There were several bugs in case custom add-ons were not unlocked for Zeus
           - Could not move and delete target logics
           - Ares modules were not avaiable in recent modules
* Fix:     Error message was missing when fire support modules had a lack of possible targets

V.0.0.2 (Achilles Expansion (alpha version))
* Feature: More ambient animations + combat ready option
* Feature: Spawn Mines/Explosives module.
* Feature: More waypoints are avaiable.
* Feature: Russian translation (by Igor Nikolaev)
* Feature: Advanced compositions system
* Feature: Object modification modules: change hight, attach to.
* Change:  Surrender Unit module can be applied on multiple units.
* Change:  List option for teleport dialog is aviable again.
* Fix:     Locality issues for ambient animations.
* Fix:     Ambient animations could not be terminated.
* Fix:     Errors in stringtable (Earthquake + Reinforcement).
* Fix:     Copy mission SQF module from Ares was missing.
* Fix:     Disable simulation module from Ares was missing.
* Fix:     Effect modules did not spawn at the exact defined position.
* Fix:     Teleport Module did not teleport vehicles.
* Fix:     Advanced Waypoints (ACE fast-roping, Land, ...) did not work.
* Fix:     BIS campaign compositions included vehicles and ammo boxes.
* Fix:     Search and occupy building script did not work anymore.
* Fix:     Last choices in some dialogs were not saved properly.
* Fix:     Cancle button was to small for german translation.

V.0.0.1 (Achilles Expansion (alpha version) - compared to Ares 1.8.1)
* Feature: Avaiable languages: English, French, German (not yet completed)
* Feature: More vanilla music is aviable in the "Play Music" module.
* Feature: Music defined in description.ext are added to "Play Music" module if a valid "musicClass" is defined (e.g. "Lead", "Action", "Stealth", "Calm")
* Feature: Some modules have a selection mode avaiable which allows applying a module selectively on multiple objects.
* Feature: Added some Advanced Hints for the Field Manual.
* Feature: Animation (Module)
* Feature: Chatter & HQ chat (Module + direct aviable for remote controlled units)
* Feature: Advanced Weather Settings (Module)
* Feature: Earthquake (Module)
* Feature: Suppressive Fire (Module)
* Feature: Destroy Buildings (Module)
* Feature: Bind variables on Objects (Module)
* Feature: "Execute Code" module has now built-in params (position and under cursor target)
* Feature: Create Light Source / Persistant Smoke Pillar (Effect Module, also avaiable in Eden Editor)
* Feature: Chatter Module (HQ and unit) + automatically open chatter window while remotecontrolling unit
* Feature: Sit / leave chair (Module)
* Feature: AI ability (Module)
* Feature: Access to vehicle cargo (extra button in edit vehicle dialog)
* Feature: Launch countermeasure / pop smoke by selecting a unit and hitting countermeasure key.
* Feature: Deep copy/paste units (CTRL + SHIFT + C / CTRL + SHIFT + V)
* Feature: Eject Passengers (including players) with SHIFT + G (or para drop in case of aircrafts)
* Feature: Zeus can write hints
* Feature: Zeus can switch side in order to talk with a specific side in side chat.
* Change:  Spawn Reinforcement Module is now based on configs => general compatibility with other mods (tested with RHS and CUP)
* Change:  Reorganized module categories (not final!).
* Change:  New Dynamic Dialog interface with more variety options.
* Change:  Summarized existing modules such as teleport and effects.
* Fix:     Module tree is no longer collapsed when switching the taps.
* Fix:     The modules will now show up as soon as "Zeus" module category shows up too
* Additional fixes and change in code structure

V.1.8.1 (basic version)
* Fix some broken inheritance for vests and hats that might have been interfering with other equipment mods
* Fix an issue where bad SQF was being generated by the for Guerilla and Civilian units when saving.
* Add enable/disable simulation modules.

V.1.8.0 (basic version)
* Artillery - Add 'Artillery Fire Mission' module to fire artillery using map coordinates and multiple artillery pieces. (Author JonasJurczok)
* Util - Pass 'Unit under cursor' and location to 'Execute Script' modules.
* Save/Load - Remove deprecated Save/Load modules (using old non-SQF format)
* NOTE - Ares now requires CBA_A3! Make sure it's running on any machine that had Ares loaded.

V.1.7.0 (basic version)
* Save/Load - Add module to export current mission objects to SQF script (including AI, Groups and markers).
* Util - Add module to execute custom code on the server, locally, or on all machines.
* General - Fixed an issue where custom modules that caused an error would leave a logic object around.
* Deprecated - 'Spawn Custom Mission Objects' was removed (use custom modules instead).
* Deprecated - New SQF saving will replace existing copy-paste functionality in 1.8.0.

V.1.6.1 (basic version)
* Util - Fixed an issue where player groups would be lost when switching sides
* Util - Added more options to the 'switch player sides' module (allowing single player, group, or side)

V.1.6.0 (basic version)
* Arsenal - Added ability to put full (unfiltered) Arsenal on an object.
* Arsenal - Renamed the 'Add All...' option to 'Add Filtered...'
* Behaviours - Fixed issue where AI units that were garrisoned wouldn't turn to shoot (#179)
* Equipment - Added ability to remove optics from enemy weapons.
* General - Fixed an issue where rejoining a dedicated server would sometimes prevent proper Ares registration.
* General - Totally revamped adding custom modules. Better than ever. (See https://github.com/astruyk/Ares/wiki/Extras#defining-custom-modules for details).
* Reinforcements - Armed technicals are no longer considered as transports (#172)
* Reinforcements - Fixed 'Least Used' RP's and LZ's not working (#167, #168)
* Util - Added 'Remove All Actions' module (can be used to remove Arsenal from objects).
* Util - Added module to change player sides during missions.
* Util - Added modules to enable/disable debug logs in RPT.
* Util - Replaced 'Go Invisible'/'Become Visible' action menu items with modules in the 'Util' section

V.1.5.1 (basic version)
* Fix a signing issue that prevented connection to servers running some other mods (see http://feedback.arma3.com/view.php?id=22133 )

V.1.5.0 (basic version)
* Arsenal - Copying to clipboard (and pasting) now includes non-virtual items as well
* Arsenal - Fixes a bunch of issues where side-filtering wasn't applying to Vests, Weapons and Backpacks when using 'Add All...'
* Arsenal - Performance improvements when using 'Add All...'
* Behaviours - When choosing where to fire artillery you can now select a specific target by name
* General - Attempt to fix an issue when getting items under mouse when reconnecting to a server after running ares
* General - When in Zeus UI holding left CTRL and double-clicking on a unit will immediately take control of that unit.
* Reinforcements - When choosing LZ's and RP's you can now select specific ones by name
* Save/Load - Snap placed objects to the ground when using 'Paste Into New Location'
* Spawn - Add 'Spawn Smoke' module for spawning persistent smoke stacks. They can be attached to existing objects or placed in empty space.
* Teleport - Dropping the 'Teleporter' module on an object will now make that object a teleporter instead of creating a new one.
* Util - Added first-pass at a 'Change Weather' module.

V.1.4.0 (basic version)
* Added a bunch more premade base compositions from Vernei's prebuilt pastable bases ( http://www.armaholic.com/page.php?id=27531 ). Used with permission.

V.1.3.0 (basic version)
* Util - Added module to dump composition code to RPT file (aimed at making it easier for me to generate compositions)
* Compositions - Re-organized the Ares composition menus to be a little more clear
* Compositions - Fixed some placement issues with a few existing compositions
* Compositions - Added a bunch more compsitions. Some of which are:
  * Wall sections - to make generating corners and long areas of walls a lot faster
  * Composite Walls - Added two kinds of walls, one for urban areas with chain fences and sandbags, and one for a defensive line of bunkers.
  * Minefields - Lines of mine markers, including variants with AT, AP and Mixed composition
  * Field Repair Base - Added field repair structure w/ decomissioned hunter
  * Roadblocks - Added three more kinds of roadblocks of varying size
  * FOB Helipad - Added a helipad for improvised bases with landing lights and some sandbags

V.1.2.1 (basic version)
* Arsenal - Change the wording in 'All...' module to be more clear and require fewer selections for common use cases (See #155)
* Arsenal - Fix an issue where magazines weren't being added when using the 'All...' module
* Arsenal - Uniforms and helmets are now filtered based on side selection when using 'All...' modules to populate arsenal.
* General - Supress the RPT log output by default. Use 'Ares_Debug_Output_Enabled = true;' to re-enable

V.1.2.0 (basic version)
* General - Fix an issue with some modules running twice when dedicated server had Ares mod loaded (See #144)
* Spawn - Add ability to spawn submarine
* Spawn - Add ability to spawn trawler
* Save/Load - Include some larger options when choosing the radius for saving to clipboard (1k, 2k, 5k)
* Util - Add module to delete closest LZ, RP or Artillery Target (hack fix in case they are not editable, see #145)

V.1.1.0 (basic version)
* Arsenal - Added an 'Add All ...' option to Arsenal that adds all items from loaded mods automatically.
* Behaviours - Add ability for players to 'Release' surrendered units (as alternative to 'Secure'). Can also be applied by Zeus when dropping the module on a surrendered unit.
* Behaviours - Artillery targets are now named phonetically (Alpha, Bravo, Charlie, etc...)
* Behaviours - Don't allow the surrender module to affect players
* Behaviours - Fix an issue where units garrisoned on a roof would not stand back up when un-garrisoned until they completed rejoining the squad.
* Equipment - Combined Enabling & Disabling thermals into a single module. Added ability to apply to sides as well as groups (when placed in empty space).
* Equipment - Combined flashlight control modules into a single module. Added ability to apply to sides as well as groups (when placed in empty space).
* Equipment - Created combined Enable/Disable NVG module (as opposed to just the 'Disable' that was previously present). Added ability to apply to sides as well as groups (when placed in empty space).
* General - Fix an issue where the item under the mouse cursor wasn't always being detected correctly.
* General - Fixed minor UI issue where 'Cancel' text in dialogs was wrapping incorrectly.
* General - Removed defunct CFB_AG script
* Reinforcements - Added ability for missions to specify custom reinforcement pools. See the wiki for details.
* Reinforcements - Added ability to set default behaviour of troops after they unload from transport
* Reinforcements - Added example scripts in the 'extras' folder showing how to define custom reinforcement pools.
* Reinforcements - LZ's and RP's are now named phonetically (Alpha, Bravo, Charlie, etc...)
* Reinforcements - Tweak the default reinforcement pools to include fewer 'Lite' soldiers
* Teleport - Improved 'Teleport Group' and 'Teleport Single Unit' modules to not require teleporters.
* Util - Add more distance options when adding/removing objects from curator.
* Util - Made behaviour of Copy/Paste dialog (for Save/Load & Arsenal functions) consistent on dedicated servers and local servers. You MUST copy and paste by hand in all cases now.

V.1.0.2 (basic version)
* Fix an issue where running Ares on a dedicated server or on more than one client would cause a race-condition that would break lots of modules.

V.1.0.1 - Bugfixes
* Behaviours - Fix issue where 'Fire Artillery' module wouldn't work with units that were spawned by dedicated server
* Behaviours - Garrisoned units should turn to fire at enemy units now
* Behaviours - Possible fix for issue where sometimes patrols would set wapoints around [0,0,0] instead of around selected unit
* Behaviours - Prevent 'Patrol' module from generating waypoints for players
* Experimental (Reinforcements) - Added some CFB_Skins units to reinforcement pools. Will be tweaked going forward.
* Experimental (Reinforcements) - Added some RHS units to reinforcement pools. Will be tweaked going forward.
* General - Fix conficts with some other mods (MCC, AGM)
* Reinforcements - Possible fix for issue where sometimes reinforcements would spawn at [0,0,0] instead of where module was placed
* Teleport - Fix issue where creating too many teleporters would cause script errors due to running out of phonetic names
* Util - Fixed some issues where adding objects to curator would grab ambient objects (rabbits, snakes, etc..)

V.1.0.0 - Public Release!
* Actions - Fix issue where invisible Zeus sometimes wasn't
* Arsenal - 'Paste & Replace' works again
* Behaviours - Added 'Artillery' module to control AI artillery firing.
* Behaviours - Added 'Patrol' module to automatically generate patrol paths.
* Behaviours - Fix issue where sometimes un-garrisoned units still wouldn't move
* Behaviours - Secured units no longer stand back up 90% of the time after finishing 'sit' animation
* Behaviours - Totally re-wrote 'Search' and 'Search and Garrison' module logic to fix lots of issues.
* Equipment - Fix issue where only NATO NVG's were being removed with the 'Remove NVG's' module
* Equipment - Removed NVG's from unit inventory (even if not equipped).
* Equipment - Replaced laser pointers with flashlights when removing NVG's
* Extras - Added script to convert copied object positions to composition class format (replaces 'Save For Composition' module)
* General - Fixed a bunch of RPT spam
* General - Standardized all 'Choose' dialogs into one common reusable class.
* General - Totally re-organized all the source files into more sensible hierarchy.
* Reinforcements - Add new helicopters to reinforcement vehicle pools.
* Reinforcements - Added new 'Furthest', 'Nearest' and 'Least Used' options to LZ and RP choosing in Reinforcements.
* Reinforcements - Fixed some issues with helicopters waiting too long at LZ's
* Reinforcements/Artillery - Persistent modules can now be directly manipulated after creation
* Save/Load - Added support for pasting back into original position exactly.
* Save/Load - Fixed a number of issues where stacked objects wouldn't be placed correctly.
* Save/Load - Fixed issue where ambient objects (fish, chickens, snakes, etc...) were being caputured as well
* Save/Load - Include version number in copied data (future-proofing)
* Save/Load - Massive cleanup to fix a number of issues where objects would change positions when pasted in new positions.
* Teleport - Use 'standard' flagpole for teleporter objects (I still think stone monolith is cooler)
* Util - Allowed you to choose radius when adding/removing objects from Zeus
* Experimental - Custom Map Objects - Added preliminary support for allowing maps to add custom objects spawnable through Ares.

V.0.1.1
* Fixed backgrounds on some UI elements being transparent
* Reinforcements - Expanded deletion radius of 'Delete LZ/RP' module to 15m (from 5m)
* Reinforcements - Helicopters no longer wait after unloading troops.
* Reinforcements - Units don't wait as long before deleting themselves.

V.0.1.0 - BETA!
* Add 'Reinforcements' module. 
* Fix backpacks not being removed when clearing inventory for Arsenal
* Fix pasting not working in MP (Affected Save/Load as well as Arsenal functions)
* Added the ability to paste saved objects into their original objects (instead of just relative to the cursor)
* Fixed issue where zeus teleporting himself would show the 'You are being teleported' message (was redundant)
* Added module to 'Save/Load' for Zeus to add all objects in the map to curator
* Added ability to teleport a group

V.0.0.2
* Added Arsenal functions

V.0.0.1
* Initial alpha release.
