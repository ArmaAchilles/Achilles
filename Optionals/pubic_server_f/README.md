# Optionals: public_server_f
## Introduction
This optional addon can be placed as a PBO in @Achilles for the server.
In general Achilles is not required on the server, but it there are some advantages such as that old targets and LZs won't become invisible for Zeus when he reconnects to the server.
In order to make it not a mandatory mod for the clients, it should be loaded as a server mod (`-servermod`) rather than a mod (`-mod`) ([see startup parameters for arma3server](https://community.bistudio.com/wiki/Arma_3_Startup_Parameters)).
## Features
### Blacklist
#### General Aspects
Introduces a command/function blacklist for the execute code module.
The blacklisted commands/functions are specified in the blacklist.txt.
Note that the blacklist also applies to substrings in expressions, e.g. `EventHandler` also matches `addEventHandler`.
It is furthermore case-insensitive.
#### Recommended Strategy
Beside listing the potential harmful commands, one has to ensure that the blacklist cannot be tricked. The blacklist works with regular expressions.
One could therfore trick the blacklist by compliling "obfuscated" or "imported" string. Any command or function that compiles string consequently has to be blacklisted as well.
