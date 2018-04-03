@ECHO OFF

WHERE mintty.exe > NUL
IF %ERRORLEVEL% NEQ 0 (
	ECHO Error: Cygwin;s mintty.exe not found!
	PAUSE
	GOTO :EOF
)

WHERE tmux.exe > NUL
IF %ERRORLEVEL% NEQ 1 (
	mintty -i /Cygwin-Terminal.ico -e tmux new-session "cd ../@AresModAchillesExpansion/addons; $SHELL"; split-window -v -t 0 "cd ../@AresModAchillesExpansion/addons; $SHELL"; split-window -v -t 1
) else (
	mintty -i /Cygwin-Terminal.ico -e /bin/bash
)
@ECHO ON
