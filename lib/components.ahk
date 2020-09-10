keyNagaoshi(key, proc){ ; keyは文字列で渡す procはFunc関数で渡す
    keyWait,% key,T0.5
    if (ErrorLevel = 1) {
        proc.call()
    }
}

keyRenda(proc, parms){
    OutputDebug, % A_PriorHotKey A_ThisHotKey
    If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 250) {
        proc.call(parms)
    }
}
;キー連打でエンターキー
; ~LShift Up::keyRenda(Func("sendEnterkey"))
; sendEnterkey(){
;     Send,{Enter}
; }

return

AhkReload(){
    ToolTip, % "Reload"
    SetTimer, reloadLabel, 1000
}

reloadLabel:
    Reload
    tooltip
    return

AhkExit(){
    ToolTip, % "Bye!"
    SetTimer, exitLabel, 1000
}
exitLabel:
    ExitApp
    return

CurrentDate(){
    currentClip := Clipboard
    FormatTime,timeString,,% "ShortDate"
    StringPast(timeString)
    Clipboard := currentClip
}