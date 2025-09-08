# Script: Install British English Voice (Hazel) and Speech Components

Write-Host "Step 1: Adding British English (en-GB) language pack..." -ForegroundColor Cyan

# Get current language list
$LangList = Get-WinUserLanguageList

# Check if en-GB is already installed
if ($LangList.LanguageTag -contains 'en-GB') {
    Write-Host "British English (en-GB) is already installed." -ForegroundColor Yellow
} else {
    # Add British English
    $LangList.Add("en-GB")
    Set-WinUserLanguageList $LangList -Force
    Write-Host "Added British English (en-GB) to language list." -ForegroundColor Green
}

Write-Host "`nStep 2: Installing required speech and TTS components..." -ForegroundColor Cyan

# Install components using DISM
$capabilities = @(
    "Language.Basic~~~en-GB~0.0.1.0",
    "Language.Speech~~~en-GB~0.0.1.0",
    "Language.TextToSpeech~~~en-GB~0.0.1.0"
)

foreach ($cap in $capabilities) {
    Write-Host "Installing capability: $cap ..."
    $result = dism.exe /Online /Add-Capability /CapabilityName:$cap /Quiet /NoRestart
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Successfully installed $cap" -ForegroundColor Green
    } else {
        Write-Host "Failed to install $cap" -ForegroundColor Red
    }
}

Write-Host "`nInstallation complete."

Write-Host "`nIMPORTANT: You need to restart your computer to apply changes." -ForegroundColor Yellow
$answer = Read-Host "Do you want to restart now? (Y/N)"

if ($answer.ToUpper() -eq 'Y') {
    Write-Host "Restarting now..." -ForegroundColor Cyan
    shutdown /r /t 0
} else {
    Write-Host "Please remember to restart later for the changes to take effect." -ForegroundColor Yellow
}

Write-Host "`nAfter reboot, run the following PowerShell snippet to list installed female voices and test Hazel:"

@"
Add-Type -AssemblyName System.Speech
\$voiceSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer

# List installed female voices
\$voices = \$voiceSynth.GetInstalledVoices() |
    Where-Object { \$_.VoiceInfo.Gender -eq 'Female' } |
    Select-Object Name, Culture, Description

\$voices | Format-Table -AutoSize

# Speak a test phrase with Hazel (if available)
if (\$voices.Name -contains "Microsoft Hazel Desktop") {
    \$voiceSynth.SelectVoice("Microsoft Hazel Desktop")
    \$voiceSynth.Speak("Hello! I am Hazel, your British English voice.")
} else {
    Write-Host "Hazel voice not found. Please check if the installation was successful." -ForegroundColor Red
}
"@
