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
; SetWinDelay, -1
; SetMouseDelay, -1
; SetBatchLines, -1
SetTitleMatchMode, 2
SysGet, MonitorPrimary, MonitorPrimary
SysGet, MonitorWorkArea, MonitorWorkArea, % MonitorPrimary

googlSearch := "https://www.google.com/search?q="
amazonSerch := "https://www.amazon.co.jp/s?k="
deeplTrans := "https://www.deepl.com/translator#"
googleTrans := "https://translate.google.com/#view=home&op=translate&sl=auto&tl="
everythingCommand := "C:\Program Files\Everything\Everything.exe -s "

#Include, %A_ScriptDir%\lib\IME.ahk
#Include, %A_ScriptDir%\lib\components.ahk
#Include, %A_ScriptDir%\lib\symbol_sand.ahk
#Include, %A_ScriptDir%\lib\mouse_controller.ahk
#Include, %A_ScriptDir%\lib\string_controller.ahk
#Include, %A_ScriptDir%\lib\window_controller.ahk

~VK1C & 0::AhkReload()
~VK1C & 9::AhkExit()

; クリップボード履歴
~VK1D & V::Send,#v

; コンテキストメニュー表示
~VK1D & r::Send,+{F10}

~VK1C::keyRenda(Func("IME_SET"), 1)
~VK1D::keyRenda(Func("IME_SET"), 0)

; 検索--------------------------------------------------------------------------------
#s::run,% everythingCommand " """ GetSelectionString() """"
~VK1D & s::run,% googlSearch GetSelectionString()
~VK1D & a::run,% amazonSerch GetSelectionString()
~VK1D & t::
    if GetKeyState("ctrl"){
        RunTrans(deeplTrans)
    }Else{
        RunTrans(googleTrans)
    }
Return

; ウィンドウ操作--------------------------------------------------------------------------------
~VK1D & 1::WinMinimize,A
~VK1D & 4::WindowClose()

; アクティブウィンドウを常に全面にする
#t::WinOnTop()

; ウィンドウサイズ変更
~VK1D & w Up::
    if GetKeyState("VK1C"){
        ViewWinsizeMenu()
    }Else{
        AutoWinReSize()
    }
Return

; ウィンドウを画面中央に移動する
~VK1D & e::winMoveCenter()

; ウィンドウをちょっとずつ移動
~VK1D & Left::WindowMove("left")
~VK1D & Right::WindowMove("right")
~VK1D & Up::WindowMove("up")
~VK1D & Down::WindowMove("down")

~VK1C & d::WinActivate, % "Dynalist"

; カーソル移動--------------------------------------------------------------------------------
~VK1D & sc027::Send,{Blind}{Left}	; ;
~VK1D & sc028::Send,{Blind}{Right}	; :
~VK1D & @::Send,{Blind}{Up}
~VK1D & /::Send,{Blind}{Down}
~VK1D & l::Send,{Blind}{PgUp}
~VK1D & .::Send,{Blind}{PgDn}
~VK1D & k::Send,{Blind}{Home}
~VK1D & ,::Send,{Blind}{End}

; キーボードでマウス操作--------------------------------------------------------------------------------
; カーソル移動
~VK1C & sc027::MouseCursorMove("left") ; ;
~VK1C & sc028::MouseCursorMove("right") ; :
~VK1C & @::MouseCursorMove("up")
~VK1C & /::MouseCursorMove("down")
~VK1D & b::MouseCursorMoveAppCenter()

~VK1C & l::Click,Left
~VK1C & r::Click,Right
~VK1C & k::Click,WheelUp
~VK1C & j::Click,WheelDown

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
~VK1D & f::send,{Enter}
; カーソルが途中でも下に一行挿入
#Enter::Send,{End}{Enter}
; 一行削除
~VK1D & x::Send,{End}{Home}{Home}+{Down}{Delete}
; delete
~VK1D & d::Send,{delete}
; Backspace
~VK1D & g::Send,{Backspace}
; 1行選択
~VK1D & q::Send,{End}{Home}{Home}+{Down}
; 日付出力
~VK1C & c::CurrentDate()

; 記号ペア出力
~VK1D & M Up::ViewSandMenu()
~VK1D & 2 Up::Gosub, doubleQuotation
~VK1D & 3 Up::Gosub, hash
~VK1D & 7 Up::Gosub, singleQuotation
~VK1D & 8 Up::Gosub, roundBrackets
~VK1D & 5 Up::Gosub, percent
~VK1D & 9 Up::Gosub, kagikakko
~VK1D & i Up::Gosub, anyChar
~VK1D & [ Up::
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
    ~VK1D & 6::Send,{Space}{&}{Space}{_}

    ;Ctrl + G → Del → F7
    ~VK1D & g::Send,^g^a{Del}{F7}
#IfWinActive

#IfWinActive ahk_class VBFloatingPalette
    ~VK1D & g::Send,^a{Del}{F7}
#IfWinActive

; CamtasiaStudio
#IfWinActive ahk_exe CamtasiaStudio.exe
    ;ステッチ
    ~VK1D & s::Send,^!i

    ;リップル削除
    ~VK1D & d::Send,^{delete}

    ;倍率テキストボックスにフォーカス
    ~VK1D & g::MouseClick, Left , 2483, 211, 1,0, D
#IfWinActive