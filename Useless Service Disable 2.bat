@echo off
REM Safer service disables (preserves critical functions)
setlocal enabledelayedexpansion

set "services=wlidsvc TrkWks dmwappushservice DiagTrack WMPNetworkSvc"

for %%s in (!services!) do (
    sc config "%%s" start= disabled >nul 2>&1
    if !errorlevel! equ 0 (
        echo Disabled: %%s
    ) else (
        echo [Skipped] Not present: %%s
    )
)

echo.
echo Safe optimizations applied! 
echo Reboot to complete changes.
pause