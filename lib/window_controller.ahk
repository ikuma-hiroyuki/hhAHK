WindowClose(){
    ; WinCloseだと意図しないものまで閉じてしまうので自作
    SetKeyDelay, 100
    SendEvent, !{F4}
    Return
}

WinOnTop(){
    static toggle := true
    if (toggle = false){ ; ontopを全て解除
        WinGet, id, list, , , Program Manager
        Loop, % id {
            StringTrimRight, this_id, id%A_Index%, 0
            ; WinGetClass, this_class, ahk_id %this_id%
            ; WinGetTitle, this_title, ahk_id %this_id%
            WinSet, AlwaysOnTop, 0, ahk_id %this_id%
        }
    } Else {
        WinSet, AlwaysOnTop, % 1, A
    }
    toggle ^= 1
}

onTopLabel:
    Reload
    tooltip
    return

winMoveCenter(){
    WinGetPos,x,y,appWidth,appHeight,A
    appWidth /= 2
    appHeight /= 2
    x := (A_ScreenWidth / 2) - appWidth
    y := (A_ScreenHeight / 2) - appheight
    WinMove,A,,x,y
}

WindowMove(direction){
    winMoveSpeed := 25
    Switch  direction
    {
        case "left":
            moveX:=-winMoveSpeed
            moveY:=0
        case "right":
            moveX:=winMoveSpeed
            moveY:=0
        case "up":
            moveX:=0
            moveY:=-winMoveSpeed
        case "down":
            moveX:=0
            moveY:=winMoveSpeed
    }
    WinGetPos,x,y,,,A
    if GetKeyState("shift"){
        moveX *= 5
        moveY *= 5
    }
    x += moveX
    y += moveY
    WinMove,A,,x,y
}

WinResize(width,height){
    WinRestore,A
    WinMove,A,,,,width,height
}

AutoWinReSize(){
    WinGetTitle,winTitle,A
    IF (InStr(winTitle,"chrome") > 0) {
        Gosub,Large
    } Else If (InStr(winTitle,"Dynalist")>0) {
        Gosub,Medium
    } Else if (WinActive("ahk_exe dbeaver.exe")) {
        Gosub,Large
    } Else If WinActive("ahk_exe Code.exe") { ;vs code
        Gosub,Large
    } Else If WinActive("ahk_exe studio64.exe") { ;android studio
        Gosub,Large
    } Else If WinActive("ahk_class MozillaWindowClass") {
        Gosub,Medium
    } Else If WinActive("ahk_class XLMAIN") { ;excel
        Gosub,Fhd
    } Else If WinActive("ahk_class wndclass_desked_gsk") { ;vbe
        Gosub,Fhd
    } Else If WinActive("ahk_exe wdexpress.exe") { ;visual studio
        Gosub,Large
    } Else If WinActive("ahk_exe Explorer.EXE") {
        Gosub,Small
    } Else If WinActive("ahk_exe SearchUI.exe") { ;windows検索
        ; なにもしない
    } Else {
        Gosub,Medium
    }
}

ViewWinsizeMenu(){
    WinGetPos,,,appWidth, appHeight, A
    Menu,rSize,add,% "&Small", Small
    Menu,rSize,add,% "&Medium", Medium
    Menu,rSize,add,% "&Tate", Tate
    Menu,rSize,add,% "&Yoko", Yoko
    Menu,rSize,add,% "&Large", Large
    Menu,rSize,add,% "F&HD", Fhd
    Menu,rSize,add,% "Y&utube",YoutubeThumbnail
    Menu,rSize,Show, % appWidth / 2 - 100, % appHeight / 2 - 100
}

return ; Auto-execute終了

Small:
    WinResize(900,800)
    Return

Medium:
    WinResize(1100,1200)
    Return

Tate:
    WinMove,A,,MonitorWorkAreaRight / 4, 0
    WinResize(MonitorWorkAreaRight / 2, MonitorWorkAreaBottom)
    Return

Yoko:
    WinResize(MonitorWorkAreaRight / 2, 1000)
    Return

Large:
    WinResize(1600,1250)
    Return

Fhd:
    WinResize(1920,1080)
    Return

YoutubeThumbnail:
    WinResize(1280,720)
    Return
