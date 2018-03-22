@ECHO OFF
WHICH git-bash.exe > NUL
IF %ERRORLEVEL% NEQ 0 (
	ECHO Error: git-bash.exe not found!
	PAUSE
	GOTO :EOF
)

WHICH tmux.exe > NUL
IF %ERRORLEVEL% NEQ 1 (
	start "" git-bash.exe -c "tmux new-session \"bash -c 'cd ../@achilles/addons;$SHELL'\"\; split-window -v -t 0 \"bash -c 'cd ../@achilles/addons;$SHELL'\"\; split-window -v -t 1"
) else (
	start "" git-bash.exe -c "bash -c 'cd ../@achilles/addons;$SHELL'"
)
@ECHO ON
