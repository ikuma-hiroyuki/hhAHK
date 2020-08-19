winDelayTime(){
    return 10
}

winMoveCenter(){
    SetWinDelay, winDelayTime()
    WinGetPos,x,y,appWidth,appHeight,A
    appWidth /= 2
    appHeight /= 2
    x := (A_ScreenWidth / 2) - appWidth
    y := (A_ScreenHeight / 2) - appheight
    WinMove,A,,x,y
}

WindowMove(moveX,moveY){
    SetWinDelay, winDelayTime()
    WinGetPos,x,y,,,A
    if GetKeyState("ctrl"){
        moveX *= 5
        moveY *= 5
    }
    x += moveX
    y += moveY
    WinMove,A,,x,y
}

WinResize(width,height){
    SetWinDelay, winDelayTime()
    WinRestore,A
    WinMove,A,,,,width,height
}

AutoWinReSize(){
    SetWinDelay, winDelayTime()
    WinGetTitle,winTitle,A
    IF (InStr(winTitle,"chrome") > 0) {
        Gosub,Large
    }Else If (InStr(winTitle,"Dynalist")>0) {
        Gosub,Tate
    }Else If WinActive("ahk_exe Code.exe") { ;vs code
        Gosub,Large
    }Else If WinActive("ahk_exe studio64.exe") { ;android studio
        Gosub,Large
    }Else If WinActive("ahk_class MozillaWindowClass") {
        Gosub,Tate
    }Else If WinActive("ahk_class XLMAIN") { ;excel
        Gosub,Fhd
    }Else If WinActive("ahk_class wndclass_desked_gsk") { ;vbe
        Gosub,Fhd
    }Else If WinActive("ahk_exe wdexpress.exe") { ;visual studio
        Gosub,Large
    }Else If WinActive("ahk_exe Explorer.EXE") {
        Gosub,Small
    }Else If WinActive("ahk_exe SearchUI.exe") { ;windows検索
        ; なにもしない
    }Else {
        Gosub,Yoko
    }
}

ViewWinsizeMenu(){
    WinGetPos, , , appWidth, appHeight, A
    Menu,rSize,add,&Mini, Mini
    Menu,rSize,add,&Small, Small
    Menu,rSize,add,&Tate, Tate
    Menu,rSize,add,&Yoko, Yoko
    Menu,rSize,add,&Large, Large
    Menu,rSize,add,F&HD, Fhd
    Menu,rSize,add,Y&utube,YoutubeThumbnail
    Menu,rSize,Show, % appWidth / 2 - 100 , % appHeight / 2 - 100
}

return ; Auto-execute終了

Mini:
    WinResize(765,650)
    Return

Small:
    WinResize(1000,850)
    Return

Tate:
    WinResize(1110,1200)
    Return

Yoko:
    WinResize(1300,1000)
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