
googleSearchInSelectingString(){
    run,% "https://www.google.com/search?q=" GetSelectionString(true)
}

amazonSearchInSelectingString(){
    run,% "https://www.amazon.co.jp/s?k=" GetSelectionString(true)
}

deepLTranslationInSelectingString(){
    run,% "https://www.deepl.com/translator#" TransParameter("en/ja/","ja/en/")
}

googleTranslationInSelectingString(){
    run,% "https://translate.google.com/#view=home&op=translate&sl=auto&tl="
          . TransParameter("ja&text=","en&text=")
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

everythingSearchInSelectingString(){
    run,% "C:\Program Files\Everything\Everything.exe -s " GetSelectionString()
}