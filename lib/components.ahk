GetSelectionString(replace := false){
    Clipboard := ""
    Send,^c
    ClipWait, 0.2
    query := Clipboard
    if replace {
        query := StrReplace(query, A_Space, "`%20")
        query := StrReplace(query, "`r`n", "%0A")
    }
    Return query
}

keyNagaoshi(key, proc){ ; keyは文字列で渡す procはFunc関数で渡す
    keyWait,% key,T0.3
    if (ErrorLevel = 1) {
        proc.call()
    }
}

keyRenda(proc){
    If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 180) {
        proc.call()
    }
}

AhkReload(){
    ToolTip, % "Reload"
    SetTimer, reloadLabel, 1000
}
reloadLabel:
    Reload
    tooltip
    return

AhkExit(){
    ToolTip, % "Exit"
    SetTimer, exitLabel, 1000
}
exitLabel:
    ExitApp
    return
