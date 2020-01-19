<p align="center">
    <img src="https://github.com/ArmaAchilles/AresModAchillesExpansion/blob/master/Pictures/logo/achilles_logo_whiteBackground.png" width="140" alt="AMAE Logo">
    <h1 align="center">Achilles</h1>
</p>

<p align="center">
    <a href="https://github.com/ArmaAchilles/Achilles/releases/latest">
        <img src="https://img.shields.io/github/release/ArmaAchilles/Achilles.svg?label=Version&colorB=007EC6&style=flat-square" alt="AMAE version">
    </a>
    <a href="https://github.com/ArmaAchilles/Achilles/issues">
        <img src="https://img.shields.io/github/issues-raw/ArmaAchilles/Achilles.svg?style=flat-square&label=Issues" alt="AMAE issues">
    </a>
    <a href="https://github.com/ArmaAchilles/Achilles/releases">
        <img src="https://img.shields.io/github/downloads/ArmaAchilles/Achilles/total.svg?label=GitHub%20Downloads&colorB=brightgreen&style=flat-square" alt="AMAE Downloads">
    </a>
    <a href="https://forums.bistudio.com/forums/topic/191113-ares-mod-achilles-expansion/">
        <img src="https://img.shields.io/badge/BIF-Thread-lightgrey.svg?style=flat-square" alt="BIF thread">
    </a>
    <a href="https://github.com/ArmaAchilles/Achilles/blob/master/LICENSE">
        <img src="https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-orange.svg?style=flat-square" alt="AMAE license">
    </a>
    <a href="https://discord.gg/kN7Jnhr">
        <img src="https://img.shields.io/discord/364823341506363392.svg?label=Discord&style=flat-square&colorB=7683D5" alt="AMAE Discord">
    </a>
    <a href="https://dev.azure.com/ArmaAchilles/Achilles/_build?definitionId=1">
        <img src="https://img.shields.io/azure-devops/build/ArmaAchilles/7d6bce6e-5f76-4479-ac2f-548b367f7f56/1.svg?style=flat-square&label=Build" alt="AMAE Builds">
    </a>
</p>

**Achilles** is a gameplay modification for Arma 3. It expands the Zeus real-time editor with many new additions as well as provides bug fixes.

**Achilles** started as an expansion to [Ares](https://github.com/astruyk/Ares) mod, which was created by [Anton Struyk](https://github.com/astruyk). Achilles became the _de facto_ successor to Ares at the point the latter was no longer updated. Achilles has already grown into a _splendid_ project, but new additions are still to come! 

* * *

## Table of Contents
- [Features](#features)
- [Language Localization](#language-localization)
- [Getting Started](#getting-started)
	- [Installing](#installing)
	- [Required Add-ons](#required-add-ons)
	- [Incompatible Add-ons](#incompatible-add-ons)
	- [Optional Add-ons](#optional-add-ons)
	- [Other Zeus Add-ons](#other-zeus-add-ons)
- [Documentation](#documentation)
- [Reporting Issues, Requesting Features and Changes](#reporting-issues-requesting-features-and-changes)
- [How to Contribute](#how-to-contribute)
	- [Basic Steps](#basic-steps)
	- [Setting up Your Local Development Environment](#setting-up-your-local-development-environment)
	- [Add a New Module](#add-a-new-module)
	- [Add a Translation](#add-a-translation)
- [Authors](#authors)
- [Contact](#contact)
- [License](#license)

## Features
- Visual changes to the Zeus interface
- Tons of new modules:
    - ACE Medical (_e.g._ heal, injury; also work in vanilla!)
    - AI Behaviour (_e.g._ animations, garrison buildings, surrender)
    - Arsenal (_e.g._ add/modify)
    - Buildings (_e.g._ destruction, breachable doors)
    - Development Tools (_e.g._ execute code, config/function viewer)
    - Environment (_e.g._ advanced weather, earthquakes)
    - Equipment (_e.g._ toggle tac light)
    - Fire Support (_e.g._ artillery, suppressive fire)
    - Objects (_e.g._ attach to, toggle simulation, IEDs)
    - Reinforcements (_e.g._ spawn reinforcements on the fly)
    - Scenario Flow (_e.g._ advanced intel, side relations)
    - Spawn (_e.g._ custom compositions, smoke pillar, USS Freedom)
    - Zeus (_e.g._ add/remove objects)
- Extended attribute window:
    - Groups (_e.g._ careless, hold fire)
    - Vehicles (_e.g._ cargo, pylons, garage, damage wheels)
    - _etc._
- New waypoint types:
    - _e.g._ seek and destroy, paradrop, sling load
- Hotkeys:
    - Copy/past units including the full loadouts
    - Remote Control
    - _etc._
- Customizations:
    - Settings (_e.g._ faction filter)

## Language Localization
Achilles is available for the following languages:
- English
- French
- German
- Japanese
- Russian
- Simplified Chinese
- Traditional Chinese

If your language is not on the list, the English localization will be used. We welcome any new translations (check out [How to Contribute](#how-to-contribute)).

## Getting Started
Below is what you need to know to get Achilles up and running:
- [Installing](#installing)
- [Required Add-ons](#required-addons)
- [Incompatible Add-ons](#incompatible-addons)
- [Optional Add-ons](#optional-addons)
- [Other Zeus Add-ons](#other-zeus-addons)

### Installing
You can download Achilles from:
- [GitHub](https://github.com/ArmaAchilles/AresModAchillesExpansion/releases)
- [Steam Workshop](http://steamcommunity.com/sharedfiles/filedetails/?id=723217262)
- [Armaholic](http://www.armaholic.com/page.php?id=31235)

If you are not familiar with installing ArmA 3 add-ons, check out the [Armaholic installation guide](http://www.armaholic.com/page.php?id=29755).

### Required Add-ons
Achilles requires:
- [Arma 3](http://arma3.com/)
- [Community Based Add-ons A3 (CBA_A3)](https://github.com/CBATeam/CBA_A3/releases)

### Incompatible Add-ons
Addons that you should **not** run when you use Achilles:
- [Ares](https://github.com/astruyk/Ares)

### Optional Add-ons
These mods below are required for certain features (_e.g._ fast-roping):
- [Advanced Combat Environment 3 (ACE3)](https://github.com/acemod/ACE3/)
- [Advanced Rappelling (AR)](https://github.com/sethduda/AdvancedRappelling)
- [Task Force Arrowhead Radio (TFAR)](https://github.com/michail-nikolaev/task-force-arma-3-radio)

### Other Zeus Add-ons
A list of other Zeus mods that are not required, but nice additions:
- [Zeus/Eden Compositions (ZEC)](https://github.com/LISTINGS09/ZEC)
- [Zeus/Eden Compositions for CUP (ZECCUP)](https://github.com/LISTINGS09/ZECCUP)
- [Zeus/Eden Interiors (ZEI)](https://github.com/LISTINGS09/ZEI)

## Documentation
Check out the [Achilles Wiki](https://github.com/ArmaAchilles/Achilles/wiki) and the [Achilles Tutorial Series on YouTube](https://www.youtube.com/watch?v=qjD2GX9rCA4&list=PL7del_lBYPTTNEmfPfzKVHxRx8Vx8DxHg). The documentation is rather limited at the time and thus, you will certainly have questions. We will gladly answer them on [our Discord server](https://discord.gg/kN7Jnhr).

## Reporting Issues, Requesting Features and Changes
Please use our [Issue Tracker](https://github.com/ArmaAchilles/Achilles/issues) for these kinds of purposes.
In the case of a bug report, please only use a minimal set of mods (_i.e._ only use other mods than the required ones if they are clearly related to the issue).

## How to Contribute
We always welcome contribution to the repository and thank you for your work! We will update the list of contributors.

What you need to know:
- [Basic Steps](#basic-steps)
- [Setting up Your Local Development Environment](#setting-up-your-local-development-environment)
- [Add a New Module](#add-a-new-module)
- [Add a Translation](#add-a-translation)

### Basic Steps
1. [Fork the Achilles repository](https://github.com/ArmaAchilles/Achilles/fork)
2. [Set up your local development environment](#setting-up-your-local-development-environment)
3. Do your stuff
4. [Create your pull request](https://help.github.com/articles/creating-a-pull-request-from-a-fork/)

And then we will have a look at your work!

### Setting up Your Local Development Environment
1. [Clone your forked repository](https://help.github.com/articles/cloning-a-repository/)
2. Set up your add-on builder (either get [Hephaestus](https://github.com/ArmaAchilles/Hephaestus) or use the [AchillesAddonBuilder.bat](https://github.com/ArmaAchilles/Achilles/blob/master/tools/AchillesAddonBuilder.bat.example ) in the repository)

### Add a New Module
A good starting point for your new module is the [custom module framework](https://github.com/ArmaAchilles/Achilles/wiki/Custom-Modules).
We will gladly help you to port your custom module to Achilles (message us on [our Discord server](https://discord.gg/kN7Jnhr)).

### Add a Translation
You have to edit the [stringtable.xml](https://github.com/ArmaAchilles/Achilles/blob/master/%40AresModAchillesExpansion/addons/language_f/stringtable.xml). The basics about string tables can be found on the [Bohemia Interactive Wiki](https://community.bistudio.com/wiki/Stringtable.xml). If you don't want to edit the file with a text editor, you can use a dedicated tool such as [Tabler](http://www.armaholic.com/page.php?id=26320).

## Authors
Check out the [list of contributors](https://github.com/ArmaAchilles/AresModAchillesExpansion/blob/master/%40AresModAchillesExpansion/credits.md).

## Contact
Find us on [our Discord server](https://discord.gg/kN7Jnhr).

## License
**Achilles** is licensed under the **[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International](https://github.com/ArmaAchilles/AresModAchillesExpansion/blob/master/LICENSE)** license.
