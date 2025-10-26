@echo off
:: ================================================
:: Silent Admin Cleanup - Zero Prompts
:: ================================================

:: Check if already running as admin
fltmc >nul 2>&1 || (
    :: If not admin, create scheduled task for admin execution
    schtasks /create /tn "PC_Cleanup" /tr "'%0'" /sc onstart /ru SYSTEM /rl HIGHEST /f >nul
    schtasks /run /tn "PC_Cleanup" >nul
    exit
)

:: MAIN CLEANUP (runs as SYSTEM/admin)
:: 1. Temp files
rd /s /q "%TEMP%" 2>nul & md "%TEMP%" >nul
del /f /s /q "%SystemRoot%\Temp\*.*" 2>nul

:: 2. Browser caches
for %%b in ("Google\Chrome" "Microsoft\Edge" "Mozilla\Firefox") do (
    rd /s /q "%LOCALAPPDATA%\%%b\User Data\Default\Cache" 2>nul
)

:: 3. System caches
net stop wuauserv 2>nul
rd /s /q "%SystemRoot%\SoftwareDistribution\Download" 2>nul
net start wuauserv 2>nul

:: 4. Self-destruct task
schtasks /delete /tn "PC_Cleanup" /f >nul 2>&1

:: 5. Silent exit
exit