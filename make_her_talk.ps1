Add-Type -AssemblyName System.Speech

$synthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer

# Explicitly select Hazel voice
$synthesizer.SelectVoice("Microsoft Hazel Desktop")

$synthesizer.Speak("Hello! This is Microsoft Hazel, the British female voice. Testing, testing, one, two, three.")
