GetSelectionString(urlEncode := false){
    Clipboard := ""
    Send,^c
    ClipWait, 0.2
    selectionStr := Clipboard
    if urlEncode {
        selectionStr := StrReplace(selectionStr, A_Space, "`%20")
        selectionStr := StrReplace(selectionStr, "`r`n", "%0A")
    }
    Return selectionStr
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

StringPast(string){
    Clipboard := string
    SetKeyDelay, 100
    SendEvent, ^v
}
