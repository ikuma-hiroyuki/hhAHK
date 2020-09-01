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

MouseCursorMoveAppCenter(){
    WinGetPos,,,appWidth,appHeight,A
    MouseMove, appWidth/2, appHeight/2
}