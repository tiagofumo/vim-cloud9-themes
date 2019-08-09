"syntax match OperatorChars "?\|+\|-\|\*\|;\|:\|,\|<\|>\|&\||\|!\|\~\|%\|=\|)\|(\|{\|}\|\.\|\[\|\]\|/\(/\|*\)\@!"
" syntax match OperatorChars "+\|-\|\*\|<\|>\|&\||\|!\|\~\|%\|=\|/\(/\|*\)\@!"
syntax match OperatorChars "+\|-\|\*\|<\|>\|&\||\|!\|\~\|%\|=\|@!"
syntax match rubyRailsRootUrl "root_url"
syntax match rubyHashArrow "=>"
syn keyword rubyRailsMethod2 match get put patch post delete redirect root resource resources collection member nested scope namespace controller constraints mount concern concerns require fixtures assert_template test
syn region railsRouter start="\<Rails\.application\.routes\.draw do\>" matchgroup=rubyDoBlock end="\<end\>" contains=ALLBUT,@rubyNotTop fold

