@ECHO OFF
WHERE mintty > NUL
IF %ERRORLEVEL% NEQ 0 (
	ECHO ERROR: mintty not found!
	ECHO        You need to add mintty to the PATH env variable.
	PAUSE
	GOTO :EOF
)

start "" mintty /bin/bash -lic "tmux new-session 'cd ../@AresModAchillesExpansion/addons;$SHELL'\; split-window -v -t 0 -p 1"
