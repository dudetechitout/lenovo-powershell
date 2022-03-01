try {

	[string]$cur_user = $env:UserName

	if (!(Test-Path "C:\Users\$cur_user\Documents\scripts\storage.ini")) {
	   New-Item -Path "C:\Users\$cur_user\Documents\scripts\storage.ini" -ItemType File
	}

	[string]$path = "C:\ProgramData\Lenovo\ImController\Plugins\ThinkKeyboardPlugin\x86\";

	[string]$file_data = Get-Content "C:\Users\$cur_user\Documents\scripts\storage.ini"

	if((Get-CimInstance win32_KEYBOARD | Select-String -Pattern "USB").length -ge 2) {
		[int]$level = 0; # Backlight level: 0 - Off, 1 - Dim, 2 - On
	} else {
		[int]$level = 2; # Backlight level: 0 - Off, 1 - Dim, 2 - On
	}

	[string]$grab_param = $args[0]

	if($grab_param) {
		[int]$level = 0;
	}

	if($level -ne $file_data -Or $grab_param) {
		# Don't modify below
		[string]$core = $path + 'Keyboard_Core.dll';
		[string]$contract = $path + 'Contract_Keyboard.dll';

		Add-Type -Path $core;
		Add-Type -Path $contract;

		[Keyboard_Core.KeyboardControl]$control =  New-Object -TypeName  'Keyboard_Core.KeyboardControl';

		$control.SetKeyboardBackLightStatus($level, $null);
	}

	Set-Content -Path "C:\Users\$cur_user\Documents\scripts\storage.ini" -Value $level

	throw "exit"

} catch { exit }
