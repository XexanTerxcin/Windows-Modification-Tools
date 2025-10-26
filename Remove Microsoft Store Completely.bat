@echo off
:: ================================================
:: Remove Microsoft Store Completely (Advanced)
:: ================================================

:: Run as admin
if not "%1"=="admin" (
    powershell -command "Start-Process -Verb RunAs -FilePath '%~f0' -ArgumentList 'admin'"
    exit /b
)

echo Removing Microsoft Store completely...

:: 1. Remove for all users
powershell -command "Get-AppxPackage -Name Microsoft.WindowsStore | Remove-AppxPackage -AllUsers"

:: 2. Remove provisioned package
powershell -command "Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*WindowsStore*'} | Remove-AppxProvisionedPackage -Online"

:: 3. Block future installation
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Appx\AppxAllUserStore\Deprovisioned" /v "Microsoft.WindowsStore_8wekyb3d8bbwe" /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f

:: 4. Delete residual files
takeown /f "%ProgramFiles%\WindowsApps\Microsoft.WindowsStore*" /r /d y >nul
icacls "%ProgramFiles%\WindowsApps\Microsoft.WindowsStore*" /grant administrators:F /t >nul
rd /s /q "%ProgramFiles%\WindowsApps\Microsoft.WindowsStore*" >nul 2>&1

echo Microsoft Store has been removed. REBOOT REQUIRED.
pause