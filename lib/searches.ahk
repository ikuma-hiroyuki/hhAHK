#Include, %A_ScriptDir%\lib\components.ahk

SelectStrGoogleSerch(){
    SetWinDelay, 10
    run,% "https://www.google.com/search?q=" GetSelectionString(true)
}

SelectStrAmazonSerch(){
    SetWinDelay, 10
    run,% "https://www.amazon.co.jp/s?k=" GetSelectionString(true)
}

SelectStrDeepLTrans(){
    SetWinDelay, 10
    run,% "https://www.deepl.com/translator#"s TransParameter("en/ja/","ja/en/")
}

SelectStrGoogleTrans(){
    SetWinDelay, 10
    run,% "https://translate.google.com/#view=home&op=translate&sl=auto&tl=" TransParameter("ja&text=","en&text=")
}

TransParameter(waei,eiwa){
    clip := GetSelectionString(true)
    matchCount := RegExMatch(StrReplace(clip,"`%0A"), "[a-zA-Z]")
    If (matchCount > 0) {
        Return waei clip
    }Else{
        Return eiwa clip
    }
}

SelectStrEverythingSerth(){
    run,% "C:\Program Files\Everything\Everything.exe -s " GetSelectionString()
}