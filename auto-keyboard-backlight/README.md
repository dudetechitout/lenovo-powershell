# auto-keyboard-backlight.ps1
Enables or disables the keyboard backlight

## Requirements
- [Lenovo System Interface Foundation](https://pcsupport.lenovo.com/es/es/downloads/ds105970-lenovo-system-interface-foundation-for-windows-10-32-bit-64-bit-thinkpad-thinkcentre-ideapad-ideacentre-thinkstation)

## Usage:
- Run script with Powershell 32-bit (x86) located '**C:\Windows\syswow64\WindowsPowerShell\v1.0\powershell.exe**'

## Installation
The script has a storage file it needs to read and write. The location path is hardcoded to the user's documents folder in the 'scripts' directory, you can change it or just place this script in your '**Documents**' directory within the '**scripts**' directory.

If you want to schedule the script, we'll need to do this with task scheduler. This will cover:
- Boot
- Sleep & wakeup
- Hibernation & wakeup
- Idle
- Lock & Unlock

To schedule with Task Scheduler:
1. Click '**Create Task**'.
2. Choose '**Run whether user is logged in or not**'. (Make use sure user that executes script has permissions to run on this machine.)
3. Add a trigger '**At startup**'.
4. Add a trigger '**On workstation unlock**'.
5. Add a trigger '**On an event**' if you want to support detection of USB keyboard (unfortunately no convenient way of detecting USB removal/insertion - have to use Audio as a tick):
    1. Make sure '**Microsoft-Windows-Audio/Informational**' is enabled:
            1. Start > Event Viewer > Applications and Services Logs > Microsoft > Windows > Audio > Informational
            2. Right click '**Informational**' and select '**Enable Log**'
    3. Log: 'Microsoft-Windows-Audio/Informational'
    4. Source: 'Audio'
    5. EventID: '155'
6. Add a trigger '**On an event**' if you want to support sleep and hibernation. You'll need to find the EventID in Windows Event Manager.
    1. Log: 'System'
    2. Source: 'Power-Troubleshooter'
    3. EventID: 1
7. Add an action with '**Program/script**' location set to '**C:\Windows\syswow64\WindowsPowerShell\v1.0\powershell.exe**' and parameters '**-File path\to\script\auto-keyboard-backlight.ps1**'

To schedule with Task Scheduler for idle:
1. Click '**Create Task**'.
2. Choose '**Run whether user is logged in or not**'. (Make use sure user that executes script has permissions to run on this machine.)
3. Add a trigger '**On idle**'.
4. Go to the **Conditions** tab and select '**Start the task only if the computer is idle for:**' to '**1 minute**' with '**Wait for idle for:**' '**Do not wait**', uncheck '**Stop if the computer ceases to be idle**'.
5. Add an action with '**Program/script**' location set to '**C:\Windows\syswow64\WindowsPowerShell\v1.0\powershell.exe**' and parameters '**-File path\to\script\auto-keyboard-backlight.ps1 true**'

To schedule with Task Scheduler for lock:
1. Click '**Create Task**'.
2. Choose '**Run whether user is logged in or not**'. (Make use sure user that executes script has permissions to run on this machine.)
3. Add a trigger '**On workstation lock**'.
5. Add an action with '**Program/script**' location set to '**C:\Windows\syswow64\WindowsPowerShell\v1.0\powershell.exe**' and parameters '**-File path\to\script\auto-keyboard-backlight.ps1 true**'

## Note
You may need to either adjust the Powershell execution policies or sign the Powershell script if you plan on safely deploying this in your company. Find out more: [ThinkPads & The Keyboard Backlight](https://selfo.io/posts/linux-increase-swapfile.html)
