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

#NoEnv
#UseHook
#InstallKeybdHook
#SingleInstance,Force

SendMode Input
SetTitleMatchMode,2
CoordMode,caret,Screen

#Include, %A_ScriptDir%\lib\searches.ahk
#Include, %A_ScriptDir%\lib\components.ahk
#Include, %A_ScriptDir%\lib\symbol_sand.ahk
#Include, %A_ScriptDir%\lib\window_controller.ahk

~VK1C & 0::AhkReload()
~VK1C & 9::AhkExit()

; everythingで検索
#S::SelectStrEverythingSerth()
; 選択した文字をgoogle検索する
~VK1D & s::SelectStrGoogleSerch()
; 選択した文字をAmazon検索する
~VK1D & a::SelectStrAmazonSerch()
; 選択した文字を翻訳する
~VK1D & t::
    if GetKeyState("ctrl"){
        SelectStrGoogleTrans()
    }Else{
        SelectStrDeepLTrans()
    }
    Return


;クリップボード履歴
~VK1D & V::Send,#v

;コンテキストメニュー表示
~VK1D & r::Send,+{F10}

;記号ペア出力
~VK1D & 2 Up::Gosub,doubleQuotation
~VK1D & 3 Up::Gosub,hash
~VK1D & 7 Up::Gosub,singleQuotation
~VK1D & 8 Up::Gosub,roundBrackets
~VK1D & 5 Up::Gosub,percent
~VK1D & 9 Up::Gosub,kagikakko ;カギ括弧
~VK1D & [ Up::Gosub,squareBrackets ;角括弧
~VK1D & ] Up::Gosub,curlyBrackets ;波括弧
~VK1D & i Up::Gosub,inp ; 任意の文字
~VK1D & M Up::ViewSandMenu()


;ウィンドウ操作
~VK1D & 4::!F4

; ウィンドウ最小化
~VK1D & 1::WinMinimize,A

;ウィンドウサイズ変更
~VK1D & w Up::
    if GetKeyState("VK1C"){
        ViewWinsizeMenu()
    }Else{
        AutoWinReSize()
    }
    Return

;ウィンドウを画面中央に移動する
~VK1D & e::winMoveCenter()

; window移動
~VK1D & Left::WindowMove(-25,0)
~VK1D & Right::WindowMove(25,0)
~VK1D & Up::WindowMove(0,-25)
~VK1D & Down::WindowMove(0,25)


;カーソル移動
~VK1D & sc027::Send,{Blind}{Left}	; ;
~VK1D & sc028::Send,{Blind}{Right}	; :
~VK1D & @::Send,{Blind}{Up}
~VK1D & /::Send,{Blind}{Down}
~VK1D & l::Send,{Blind}{PgUp}
~VK1D & .::Send,{Blind}{PgDn}
~VK1D & k::Send,{Blind}{Home}
~VK1D & ,::Send,{Blind}{End}

;マウス操作
~VK1C & sc027::MouseCursorMove("left")
~VK1C & sc028::MouseCursorMove("right")
~VK1C & @::MouseCursorMove("up")
~VK1C & /::MouseCursorMove("down")

~VK1C & l::Click,Left
~VK1C & r::Click,Right
~VK1C & k::Click,WheelUp
~VK1C & j::Click,WheelDown


;文字列操作

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
~VK1D & q::Send,{End}{Home}{Home}+{Down}

;日付出力
~VK1C & d::CurrentDate()

#IFWinActive ahk_exe Explorer.EXE
    F1::send,!vsf
#IFWinActive

;VBE
#IfWinActive ahk_class wndclass_desked_gsk
    ; & _
    ~VK1D & 6::Send,{Space}{&}{Space}{_}

    ;Ctrl + G → Del → F7
    ~VK1D & g::Send,^g^a{Del}{F7}
#IfWinActive

#IfWinActive ahk_class VBFloatingPalette
    ~VK1D & g::Send,^a{Del}{F7}
#IfWinActive

;CamtasiaStudio
#IfWinActive ahk_exe CamtasiaStudio.exe
    ;ステッチ
    ~VK1D & s::Send,^!i

    ;リップル削除
    ~VK1D & d::Send,^{delete}

    ;倍率テキストボックスにフォーカス
    ~VK1D & g::MouseClick, Left , 2483, 211, 1,0, D
#IfWinActive