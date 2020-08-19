return

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

ClipPast(string){
    Clipboard := string
    send,^v
    sleep, % 100 ; sleepしないとうまく出力されない
    Clipboard := saveClip
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
    ToolTip, % "Bye!"
    SetTimer, exitLabel, 1000
}
exitLabel:
    ExitApp
    return

MouseCursorMove(direction){
    mouseSpeed := 30
    Switch  direction
    {
        case "left":
            x:=-mouseSpeed
            y:=0
        case "right":
            x:=mouseSpeed
            y:=0
        case "up":
            x:=0
            y:=-mouseSpeed
        case "down":
            x:=0
            y:=mouseSpeed
    }
    If GetKeyState("shift"){
        OutputDebug ok
        cursorSpeed := 10
        x *= cursorSpeed
        y *= cursorSpeed
    }
    MouseClick,Left,x,y,1,0,U,R
}

CurrentDate(){
    currentClip := Clipboard
    FormatTime,timeString,,% "ShortDate"
    ClipPast(timeString)
    Clipboard := currentClip
}