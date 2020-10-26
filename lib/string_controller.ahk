GetSelectionString(urlEncode := false){
    Clipboard := ""
    SendEvent,^{Insert}
    ClipWait,0.5
    selectionStr := Clipboard
    if urlEncode {
        selectionStr := StrReplace(selectionStr, A_Space, "`%20")
        selectionStr := StrReplace(selectionStr, "#", "`%23")
        selectionStr := StrReplace(selectionStr, "&", "`%26")
        selectionStr := StrReplace(selectionStr, "`r`n", "%0A")
    }
    Return selectionStr
}

RunTrans(baseUrl){
    if instr(baseUrl, "translate.google.com") > 0 {
        ; waei := "ja&text="
        waei := "sl=en&tl=ja&text="
        eiwa := "sl=ja&tl=en&text="
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
    SetKeyDelay, 10
    SendEvent, +{Insert}
    sleep 30
}
