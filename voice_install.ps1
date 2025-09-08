# List available language packs with TTS support
Get-WinUserLanguageList

# Example: Add a British English voice (Hazel)
$LangList = Get-WinUserLanguageList
$LangList.Add("en-GB")
Set-WinUserLanguageList $LangList -Force
