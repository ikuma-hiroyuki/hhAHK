Return

ViewSandMenu(){
    Menu,sand,add,% """ """ . "`t &2",	 doubleQuotation
    Menu,sand,add,% "# #`t &3",	 hash
    Menu,sand,add,% "`% `%`t &5", percent
    Menu,sand,add,% "' '`t &7",	 singleQuotation
    Menu,sand,add,% "( )`t &8",	 roundBrackets
    Menu,sand,add,% "「 」`t &9",	 kagiKakko
    Menu,sand,add,% "[ ]`t &[",	 squareBrackets
    Menu,sand,add,% "{ }`t &}",	 curlyBrackets
    Menu,sand,add,% "< >`t &a",	 arrow
    Menu,sand,add,% "<kbd >`t &k",	 kbd
    Menu,sand,add,% "【】`t &s",	 sumiKakko
    Menu,sand,add,% "??`t &i",	 anyChar
    Menu,sand,Show,% A_CaretX, % A_CaretY + 50
}

singleQuotation:
    SymbolSandwich("'","'")
Return

doubleQuotation:
    SymbolSandwich("""","""")
Return

roundBrackets:
    SymbolSandwich("(",")")
Return

curlyBrackets:
SymbolSandwich("{","}")
Return

squareBrackets:
    SymbolSandwich("[","]")
Return

hash:
    SymbolSandwich("#","#")
Return

percent:
    SymbolSandwich("%","%")
Return

kagiKakko:
    SymbolSandwich("「","」")
Return

sumiKakko:
    SymbolSandwich("【","】")
Return

arrow:
    SymbolSandwich("<",">")
Return

kbd:
    SymbolSandwich("<kbd>","</kbd>")
Return

anyChar:
    InputBox,val,% "任意文字",% ",で前後を区別",,150,120,% A_CaretX, % A_CaretY + 50
    If (ErrorLevel = 0) { ;OKが押された
        ary := StrSplit(val, ",")
        ary.Length() = 2 ? SymbolSandwich(ary[1],ary[2]) : SymbolSandwich(val,val)
    }
Return

SymbolSandwich(p1,p2){
    saveClip := Clipboard
    selectionString := GetSelectionString()
    isClipbordNothing := InStr(selectionString,"`r`n") > 0 or (selectionString = "")
    ; vs code等のIDEは文字列を選択しないでCtrl+Cを押すと行全体をコピーするので回避
    isClipbordNothing ? StringPast(p1 p2) : StringPast(p1 selectionString p2)
    if isClipbordNothing {
        Send,{Left}
    }
    Clipboard := saveClip
}
