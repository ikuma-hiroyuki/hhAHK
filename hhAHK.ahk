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

Critical
#NoEnv
#UseHook
#InstallKeybdHook
#HotkeyModifierTimeout 100
#SingleInstance,Force
ListLines, Off
SendMode input
SetKeyDelay, -1
SetTitleMatchMode, 2
SysGet, MonitorPrimary, MonitorPrimary
SysGet, MonitorWorkArea, MonitorWorkArea, % MonitorPrimary

deeplTrans := "https://www.deepl.com/translator#"
everythingCommand := "C:\Program Files\Everything\Everything.exe -s "
googlSearch := "https://www.google.com/search?q="
googleTrans := "https://translate.google.com/#view=home&op=translate&"
twitterSerch := "https://twitter.com/search?q="
quora := "quora.com/search?q="
duckgo := "https://duckduckgo.com/?q="
eijiro := "https://eow.alc.co.jp/search?q="

#Include, %A_ScriptDir%\lib\components.ahk
#Include, %A_ScriptDir%\lib\symbol_sand.ahk
#Include, %A_ScriptDir%\lib\mouse_controller.ahk
#Include, %A_ScriptDir%\lib\string_controller.ahk
#Include, %A_ScriptDir%\lib\window_controller.ahk

VK1C::VK1C
VK1D::VK1D

VK1C & 0::AhkReload()
VK1C & 9::AhkExit()

; クリップボード履歴
VK1D & V::Send,#v

; コンテキストメニュー表示
VK1D & r::Send,+{F10}

; #Include, %A_ScriptDir%\lib\IME.ahk
; VK1C::keyRenda(Func("IME_SET"), 1)
; VK1D::keyRenda(Func("IME_SET"), 0)

; 検索--------------------------------------------------------------------------------
#s::run,% everythingCommand " """ GetSelectionString() """"
VK1D & s::
    if GetKeyState("ctrl"){
        run,% duckgo GetSelectionString(true)
    }else{
        run,% googlSearch GetSelectionString(true)
    }
Return

VK1D & t::
    if GetKeyState("ctrl"){
        RunTrans(googleTrans)
    }Else if GetKeyState("shift"){
        run,% twitterSerch GetSelectionString(true) "&src=typed_query"
    }Else{
        RunTrans(eijiro)
    }
Return

; ウィンドウ操作--------------------------------------------------------------------------------
VK1D & 1::WinMinimize,A
VK1D & q::WindowClose()

; アクティブウィンドウを常に全面にする
#t::WinOnTop()

; ウィンドウサイズ変更
VK1D & w Up::
    if GetKeyState("VK1C"){
        ViewWinsizeMenu()
    }Else{
        AutoWinReSize()
    }
Return

; ウィンドウを画面中央に移動する
VK1D & e::winMoveCenter()

; ウィンドウを上下左右に移動する
VK1C & left::WindowMove("Left")
VK1C & right::WindowMove("right")
VK1C & up::WindowMove("up")
VK1C & down::WindowMove("down")

; アプリ選択
VK1C & d::WinActivate, % "Dynalist"
VK1C & v::WinActivate, % "Visual Studio Code"
VK1C & r::WinActivate, % "Android Studio"

; カーソル移動--------------------------------------------------------------------------------
VK1D & h::Send,{Blind}{Left}	; ;
VK1D & l::Send,{Blind}{Right}	; :
VK1D & k::Send,{Blind}{Up}
VK1D & j::Send,{Blind}{Down}
VK1D & i::Send,{Blind}{PgUp}
VK1D & u::Send,{Blind}{PgDn}
VK1D & y::Send,{Blind}{Home}
VK1D & o::Send,{Blind}{End}

; キーボードでマウス操作--------------------------------------------------------------------------------
; マウスカーソル移動
VK1C & sc027::MouseCursorMove("left") ; ;
VK1C & sc028::MouseCursorMove("right") ; :
VK1C & @::MouseCursorMove("up")
VK1C & /::MouseCursorMove("down")
VK1D & c::MouseCursorMoveAppCenter()

VK1C & l::Click,Left
VK1C & k::Click,WheelUp
VK1C & j::Click,WheelDown

; マウスを拡張--------------------------------------------------------------------------------
VK1D & RButton::Sendevent,{F2}
VK1D & LButton::Sendevent,{Enter}
VK1D & WheelUp::Sendevent,{up}
VK1D & WheelDown::Sendevent,{down}

+WheelUp::Sendevent,^{PgUp}
+WheelDown::Sendevent,^{PgDn}
!WheelUp::Sendevent,{left}
!WheelDown::Sendevent,{right}

; 文字列操作--------------------------------------------------------------------------------
VK1D & f::send,{Enter}
VK1C & space::send,{Enter}
VK1D & space::send,{Enter}

; カーソルが途中でも下に一行挿入
#Enter::Send,{End}{Enter}
; 一行削除
VK1D & x::Send,{End}{Home}{Home}+{Down}{Delete}
; delete & Backspace
VK1D & d::Send,{delete}
VK1D & a::Send,{Backspace}

; 日付出力
VK1C & c::CurrentDate()

; 記号ペア出力
VK1D & m::ViewSandMenu()
VK1D & 2::Gosub, doubleQuotation
VK1D & 3::Gosub, hash
VK1D & 5::Gosub, percent
VK1D & 7::Gosub, singleQuotation
VK1D & 8::Gosub, roundBrackets
VK1D & 9::Gosub, kagikakko
VK1D & n::Gosub, anyChar
VK1D & [::
    if GetKeyState("Shift"){
        Gosub,curlyBrackets
    }else{
        Gosub,squareBrackets
    }
Return

#IFWinActive ahk_exe Explorer.EXE
    F1::send,!vsf
#IFWinActive

; VBE
#IfWinActive ahk_class wndclass_desked_gsk
    ; & _
    VK1D & 6::Send,{Space}{&}{Space}{_}

    ;Ctrl + G → Del → F7
    VK1D & g::Send,^g^a{Del}{F7}
#IfWinActive

#IfWinActive ahk_class VBFloatingPalette
    VK1D & g::Send,^a{Del}{F7}
#IfWinActive

; CamtasiaStudio
#IfWinActive ahk_exe CamtasiaStudio.exe
    ;ステッチ
    VK1D & s::Send,^!i

    ;リップル削除
    VK1D & d::Send,^{delete}

    ;倍率テキストボックスにフォーカス
    VK1D & g::MouseClick, Left , 2483, 211, 1,0, D
#IfWinActive