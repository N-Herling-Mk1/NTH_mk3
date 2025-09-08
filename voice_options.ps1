# Load the required speech assembly
Add-Type -AssemblyName System.Speech

# Create a SpeechSynthesizer instance
$voiceSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer

# Get all installed voices
$voices = $voiceSynth.GetInstalledVoices() | Select-Object -ExpandProperty VoiceInfo

# Filter and list only female voices
$femaleVoices = $voices | Where-Object { $_.Gender -eq 'Female' }

if ($femaleVoices.Count -eq 0) {
    Write-Host "❌ No female voices found."
} else {
    Write-Host "`n🎤 Installed Female Voices:`n"
    $index = 0
    foreach ($voice in $femaleVoices) {
        Write-Host "$index. Name: $($voice.Name)"
        Write-Host "    Language: $($voice.Culture)"
        Write-Host "    Age: $($voice.Age)"
        Write-Host "    Description: $($voice.Description)"
        Write-Host ""
        $index++
    }
}
