@echo off
echo ================================
echo   Stopping unnecessary programs
echo ================================

:: Kill background apps if running
taskkill /f /im TouchpointAnalyticsClient.exe >nul 2>&1
taskkill /f /im EGMonitor.exe >nul 2>&1
taskkill /f /im DiagsCap.exe >nul 2>&1
taskkill /f /im AppHelperCap.exe >nul 2>&1
taskkill /f /im SysInfoCap.exe >nul 2>&1
taskkill /f /im NetworkCap.exe >nul 2>&1

:: Disable Windows services
sc stop WSearch
sc config WSearch start= disabled

sc stop SysMain
sc config SysMain start= disabled

sc stop DiagTrack
sc config DiagTrack start= disabled

echo.
echo All selected programs and services have been disabled!
echo Press any key to exit...
echo (Optimized by SMY GAMER ??)
pause >nul
exit
