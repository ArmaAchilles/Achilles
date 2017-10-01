@echo off
set startDir=%cd%

REM /******************************************************************************/
REM Addon Builder script for windows (by Kex)
REM /******************************************************************************/
REM
REM Packs all folders in sourceDir and creates corresponding *.pbo in targetDir.
REM The script is parallelized and will create a window for each source folder.
REM
REM Arguments:
REM 1) (optional) version for bikey e.g. "0.0.1" ("dev" by default)
REM
REM Returns:
REM nothing (procedure)
REM
REM Examples:
REM 1) AddonBuilder.bat 0.0.1
REM 2) AddonBuilder.bat
REM
REM /******************************************************************************/

REM optional argument: version of bikey: <prefix>_<version>.biprivatekey
set keyVersion=%1

REM Path for the folder where the source folders are located
set sourceDir=E:\Programme\Games\Steam\steamapps\common\Arma 3\AresModAchillesExpansion\@AresModAchillesExpansion\addons
REM Path for the folder where the *.pbo's shall be moved
set targetDir=E:\Programme\Games\Steam\steamapps\common\Arma 3\AresModAchillesExpansion\@AresModAchillesExpansion\addons
REM Prefix: you can access your addon files via \<prefix>\<pbo name>\<file>
REM Prefix: if projPrefix is "" then \<pbo name>\<file>
set projPrefix=achilles
REM Prefix for your bikey: <prefix>_<version>.biprivatekey
set privKeyPrefix=achilles
REM Default version (if you don't specify the version as an argument): <prefix>_dev.biprivatekey
set keyVersionDefault=dev
REM Folder where the biprivatekey is located
set privKeyDir=E:\Programme\Games\Steam\steamapps\common\Arma 3 Tools\DSSignFile\privateKey
REM Temporary folder
set tmpDir=C:\Users\%username%\AppData\Local\Temp

REM biprivatekey file name
if "%keyVersion%"=="" (
	set privKey=%privKeyPrefix%_%keyVersionDefault%.biprivatekey
) else (
	set privKey=%privKeyPrefix%_%keyVersion%.biprivatekey
)

REM Check if given folders and biprivateky exist
if not exist "%privKeyDir%\%privKey%" (
	call:PERROR "Did not found %privKey% in %privKeyDir%!"
	goto EOS
)
if not exist "%sourceDir%" (
	call:PERROR "%sourceDir% does not exist!"
	goto EOS
)
if not exist "%targetDir%" (
	call:PERROR "%targetDir% does not exist!"
	goto EOS
)
if not exist "%tmpDir%" (
	call:PERROR "%tmpDir% does not exist!"
	goto EOS
)

cd /d %sourceDir%
for /d %%D in (*) do (
	REM start "AddonBuilder: %%D" cmd /c "AddonBuilder "%sourceDir%\%%D" "%targetDir%" -packonly -temp="%tmpDir%" -sign="%privKeyDir%\%privKey%" -prefix="%projPrefix%\%%D" -binarizeFullLogs & echo. & pause"
	start "AddonBuilder: %%D" cmd /c "AddonBuilder "%sourceDir%\%%D" "%targetDir%" -packonly -temp="%tmpDir%" -sign="%privKeyDir%\%privKey%" -prefix="%projPrefix%\%%D" -binarizeFullLogs"
)

goto EOS

:PERROR
echo.
%Windir%\System32\WindowsPowerShell\v1.0\Powershell.exe write-host -foregroundcolor Red "ERROR: %1"
echo.
pause
GOTO:EOF

:EOS
cd /d %startDir%
@echo on
