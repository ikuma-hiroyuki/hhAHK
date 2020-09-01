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

RunTrans(baseUrl){
    if instr(baseUrl, "translate.google.com") > 0 {
        waei := "ja&text="
        eiwa := "en&text="
    } else if instr(baseUrl, "deepl.com") > 0 {
        waei := "en/ja/"
        eiwa := "ja/en/"
    }

    clip := GetSelectionString(true)
    matchCount := RegExMatch(StrReplace(clip,"`%0A"), "[a-zA-Z]")
    If (matchCount > 0) {
        run,% baseUrl waei clip
    }Else{
        run,% baseUrl eiwa clip
    }
}

StringPast(string){
    Clipboard := string
    SetKeyDelay, 100
    SendEvent, ^v
}
