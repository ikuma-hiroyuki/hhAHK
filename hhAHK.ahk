/*修飾キー
^ = Ctrl
+ = shIft
! = Alt
# = win
VK1D = 無変換
VK1C = 変換
VKF2 = かな
sc027 = ;
sc028 = :
sc033 = ,
*/

#InstallKeybdHook
#UseHook
#NoEnv
#SingleInstance,Force
SendMode Input
SetWorkingDir,%A_ScriptDir%
SetTitleMatchMode,2
CoordMode,caret,Screen

googlSearch := "https://www.google.com/search?q="
amazonSerch := "https://www.amazon.co.jp/s?k="
deeplTrans := "https://www.deepl.com/translator#"
googleTrans := "https://translate.google.com/#view=home&op=translate&sl=auto&tl="
everythingCommand := "C:\Program Files\Everything\Everything.exe -s "
waitTime := 0.2 ; second
sleepTime := 100 ; millisecond


; 汎用関数=======================================================================================
keyNagaoshi(key, proc){ ; keyは文字列で渡す procはFunc関数で渡す
    keyWait,% key,T0.3
    if (ErrorLevel = 1) {
        proc.call()
    }
}

keyRenda(proc) {
    If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 180) {
        proc.call()
    }
}

;ユーティリティ==================================================================================

~VK1D & 0::RelodCommand()
~VK1C & 0::RelodCommand()

RelodCommand(){
    ToolTip, Reload
    Sleep, 1000
    ToolTip
    Reload
    Return
}

;クリップボード履歴
~VK1D & V::Send,#v

;コンテキストメニュー表示
~VK1D & r::Send,+{F10}

;記号入力=======================================================================================
~VK1D & 2 Up::Gosub,doubleQuotation ;""
~VK1D & 3 Up::Gosub,sharp ;##
~VK1D & 7 Up::Gosub,singleQuotation ;''
~VK1D & 8 Up::Gosub,brackets ;括弧
~VK1D & 5 Up::Gosub,percent ;%
~VK1D & 9 Up::Gosub,kakko ;カギ括弧
~VK1D & [ Up::Gosub,squareBrackets ;角括弧
~VK1D & ] Up::Gosub,curlyBrackets ;波括弧
~VK1D & i Up::Gosub,inp
~VK1D & M Up:: ; メニュー表示
    Menu,sand,add," "`t &2,	doubleQuotation
    Menu,sand,add,# #`t &3,	sharp
    Menu,sand,add,`% `%`t &5, percent
    Menu,sand,add,' '`t &7,	singleQuotation
    Menu,sand,add,( )`t &8,	brackets
    Menu,sand,add,「 」`t &9,	kakko
    Menu,sand,add,[ ]`t &[,	squareBrackets
    Menu,sand,add,{ }`t &},	curlyBrackets
    Menu,sand,add,< >`t &a,	arrow
    Menu,sand,add,<kbd >`t &k,	kbd
    Menu,sand,add,【】`t &s,	sumiKakko
    Menu,sand,add,??`t &i,	inp
    Menu,sand,Show,% A_CaretX, % A_CaretY + 25
Return

brackets:
    SymbolSandwich("(",")")
Return

doubleQuotation:
    SymbolSandwich("""","""")
Return

curlyBrackets:
    SymbolSandwich("{{}","{}}")
Return

squareBrackets:
    SymbolSandwich("[","]")
Return

sharp:
    SymbolSandwich("#","#")
Return

percent:
    SymbolSandwich("%","%")
Return

singleQuotation:
    SymbolSandwich("'","'")
Return

kakko:
    SymbolSandwich("「","」")
Return

arrow:
    SymbolSandwich("<",">")
Return

sumiKakko:
    SymbolSandwich("【","】")
Return

kbd:
    SymbolSandwich("<kbd>","</kbd>")
Return

inp:
    InputBox,val,任意文字,`,で前後を区別,,150,120
    If (ErrorLevel = 0) { ;OKが押された
        StringSplit,ary,val,"`,",% A_Space
        If (ary0 = 2) {
            SymbolSandwich(ary1,ary2)
        } Else {
            SymbolSandwich(val,val)
        }
    }
Return

SymbolSandwich(p1,p2){
    global sleepTime
	saveClip := Clipboard
    selectionString := GetSelectionString()
    isCRCF := InStr(selectionString,"`r`n") > 0 or (selectionString = "")
    If isCrCf { ; vs code等のIDEは文字列を選択しないでCtrl+Cを押すと行全体をコピーするので回避
        Clipboard := p1 p2
    } Else {
        Clipboard := p1 selectionString p2
    }
    send,^v
    sleep, % sleepTime ; sleepしないとうまく出力されない
    if isCrCf {
        Send,{Left}
    }
	Clipboard := saveClip
}

;ウィンドウ操作==================================================================================
~VK1D & 4::!F4

; ウィンドウ最小化
~VK1D & 1::WinMinimize,A

;ウィンドウサイズ変更
~VK1D & w Up::
    if GetKeyState("vk1c"){
        viewWinsizeMenu()
    }Else{
        autoWinReSize()
    }
    Return

autoWinReSize(){
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

viewWinsizeMenu(){
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

WinResize(width,height){
    WinRestore,A
    WinMove,A,,,,width,height
}

;ウィンドウを画面中央に移動する
~VK1D & e::winMoveCenter()
winMoveCenter(){
    WinGetPos,x,y,appWidth,appHeight,A
    appWidth /= 2
    appHeight /= 2
    x := (A_ScreenWidth / 2) - appWidth
    y := (A_ScreenHeight / 2) - appheight
    WinMove,A,,x,y
}

; window移動
~VK1D & Left::WindowMove(-25,0)
~VK1D & Right::WindowMove(25,0)
~VK1D & Up::WindowMove(0,-25)
~VK1D & Down::WindowMove(0,25)

WindowMove(moveX,moveY) {
    WinGetPos,x,y,,,A
    if GetKeyState("ctrl"){
        moveX *= 5
        moveY *= 5
    }
    x += moveX
    y += moveY
    WinMove,A,,x,y
}

;カーソル移動====================================================================================
~VK1D & sc027::Send,{Blind}{Left}	; ;
~VK1D & sc028::Send,{Blind}{Right}	; :
~VK1D & @::Send,{Blind}{Up}
~VK1D & /::Send,{Blind}{Down}
~VK1D & l::Send,{Blind}{PgUp}
~VK1D & .::Send,{Blind}{PgDn}
~VK1D & k::Send,{Blind}{Home}
~VK1D & ,::Send,{Blind}{End}

;マウス操作======================================================================================
~VK1C & sc027::MouseCursorMove(-10,0) ;← ;キー
~VK1C & sc028::MouseCursorMove(10,0) ;→ ]キー
~VK1C & @::MouseCursorMove(0,-10) ;↑
~VK1C & /::MouseCursorMove(0,10) ;↓

MouseCursorMove(x,y){
    If GetKeyState("ctrl"){
        cursorSpeed := 10
        x *= cursorSpeed
        y *= cursorSpeed
    }
    MouseClick,Left,x,y,1,0,U,R
}

~VK1C & l::Click,Left
~VK1C & r::Click,Right
~VK1C & k::MouseWheel("U")
~VK1C & j::MouseWheel("D")

MouseWheel(direction){
    wheelSpeed := 1
    If GetKeyState("ctrl"){
        wheelSpeed := 3
    }
    If (direction = "U")
        Click,WheelUp,,,wheelSpeed
    Else If (direction = "D")
        Click,WheelDown,,,wheelSpeed
}

;文字列操作======================================================================================

;キー連打でエンターキー
; ~LShift Up::keyRenda(Func("sendEnterkey"))
; sendEnterkey(){
;     Send,{Enter}
; }

;カーソルが途中でも下に一行挿入
#Enter::Send,{End}{Enter}

;一行削除
~VK1D & x::Send,{End}{Home}{Home}+{Down}{Delete}
;delete
~VK1D & d::Send,{delete}

;Backspace
~VK1D & c::Send,{Backspace}

;1行選択
~VK1D & Q::Send,{End}{Home}{Home}+{Down}

;エンターキー
~VK1D & f::send,{Enter}


;ブラウザで検索する==============================================================================

; 選択した文字をgoogle検索する
~vk1d & s::run,% googlSearch GetSelectionString(true)
; 選択した文字をAmazon検索する
~vk1d & a::run,% amazonSerch GetSelectionString(true)
; 選択した文字を翻訳する
~VK1D & t::
    if GetKeyState("ctrl"){
        run,% googleTrans TransParameter("ja&text=","en&text=")
    }Else{
        run,% deeplTrans TransParameter("en/ja/","ja/en/")
    }
    Return

GetSelectionString(replace := false) {
    global waitTime
    Clipboard := ""
    Send,^c
    ClipWait, % waitTime
    query := Clipboard
    if replace {
        query := StrReplace(query, A_Space , "`%20")
        query := StrReplace(query, "`r`n" , "%0A")
    }
    Return query
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

; everythingで検索
#S::run,% everythingCommand GetSelectionString()

#IFWinActive ahk_exe Explorer.EXE
    F1::send,!vsf
#IFWinActive

;VBE=============================================================================================
#IfWinActive ahk_class wndclass_desked_gsk
    ; & _
    ~VK1D & 6::Send,{Space}{&}{Space}{_}

    ;Ctrl + G → Del → F7
    ~VK1D & g::Send,^g^a{Del}{F7}
#IfWinActive

#IfWinActive ahk_class VBFloatingPalette
    ~VK1D & g::Send,^a{Del}{F7}
#IfWinActive

;CamtasiaStudio===================================================================================
#IfWinActive ahk_exe CamtasiaStudio.exe
    ;ステッチ
    ~VK1D & s::Send,^!i

    ;リップル削除
    ~VK1D & d::Send,^{delete}

    ;倍率テキストボックスにフォーカス
    ~VK1D & g::MouseClick, Left , 2483, 211, 1,0, D
#IfWinActive