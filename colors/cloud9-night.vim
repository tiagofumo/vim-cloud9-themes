" Tomorrow Night Bright - Full Colour and 256 Colour
" http://chriskempson.com
"
" Hex colour conversion functions borrowed from the theme "Desert256""

" Default GUI Colours
let s:foreground = "eaeaea"
let s:background = "141414"
let s:linenr = "242424"
let s:selection = "424242"
let s:line = "2a2a2a"
let s:comment = "969896"
let s:red = "d54e53"
let s:orange = "e78c45"
"let s:yellow = "e7c547"
let s:yellow = "e7bF47"
let s:green = "b9ca4a"
let s:darkerGreen = "99ca2a"
let s:aqua = "70c0b1"
let s:blue = "7aa6da"
let s:purple = "c397d8"
let s:white = "ffffff"
let s:window = "4d5057"

set background=dark
hi clear
syntax reset

let g:colors_name = "cloud9-night"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
  " Returns an approximate grey index for the given grey level
  fun <SID>grey_number(x)
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " Returns the actual grey level represented by the grey index
  fun <SID>grey_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun

  " Returns the palette index for the given grey index
  fun <SID>grey_colour(n)
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun

  " Returns an approximate colour index for the given colour level
  fun <SID>rgb_number(x)
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " Returns the actual colour level for the given colour index
  fun <SID>rgb_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun

  " Returns the palette index for the given R/G/B colour indices
  fun <SID>rgb_colour(x, y, z)
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun

  " Returns the palette index to approximate the given R/G/B colour levels
  fun <SID>colour(r, g, b)
    " Get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " Get the closest colour
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
      " There are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " Use the grey
        return <SID>grey_colour(l:gx)
      else
        " Use the colour
        return <SID>rgb_colour(l:x, l:y, l:z)
      endif
    else
      " Only one possibility
      return <SID>rgb_colour(l:x, l:y, l:z)
    endif
  endfun

  " Returns the palette index to approximate the 'rrggbb' hex string
  fun <SID>rgb(rgb)
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

    return <SID>colour(l:r, l:g, l:b)
  endfun

  " Sets the highlighting for the given group
  fun <SID>X(group, fg, bg, attr)
    if a:fg != ""
      exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
    endif
    if a:bg != ""
      exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
    endif
    if a:attr != ""
      exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
    endif
  endfun

  " Vim Highlighting
  call <SID>X("Normal", s:foreground, s:background, "")
" call <SID>X("LineNr", s:selection, "", "")
  call <SID>X("LineNr", s:foreground, s:linenr, "")
  call <SID>X("NonText", s:selection, "", "")
  call <SID>X("SpecialKey", s:selection, "", "")
  call <SID>X("Search", s:background, s:yellow, "")
  call <SID>X("TabLine", s:foreground, s:background, "reverse")
  call <SID>X("StatusLine", s:window, s:yellow, "reverse")
  call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
  call <SID>X("VertSplit", s:window, s:window, "none")
  call <SID>X("Visual", "", s:selection, "")
  call <SID>X("Directory", s:blue, "", "")
  call <SID>X("ModeMsg", s:green, "", "")
  call <SID>X("MoreMsg", s:green, "", "")
  call <SID>X("Question", s:green, "", "")
  call <SID>X("WarningMsg", s:red, "", "")
  call <SID>X("MatchParen", "", s:selection, "")
  call <SID>X("Folded", s:comment, s:background, "")
  call <SID>X("FoldColumn", "", s:background, "")
  if version >= 700
    call <SID>X("CursorLine", "", s:line, "none")
    call <SID>X("CursorColumn", "", s:line, "none")
    call <SID>X("PMenu", s:foreground, s:selection, "none")
    call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
    call <SID>X("SignColumn", "", s:background, "none")
  end
  if version >= 703
    call <SID>X("ColorColumn", "", s:line, "none")
  end

  " Standard Highlighting
  call <SID>X("Comment", s:comment, "", "")
  call <SID>X("Todo", s:comment, s:background, "")
  call <SID>X("Title", s:white, "", "")
  call <SID>X("Identifier", s:red, "", "none")
  call <SID>X("Statement", s:foreground, "", "")
  call <SID>X("Conditional", s:foreground, "", "")
  call <SID>X("Repeat", s:foreground, "", "")
  call <SID>X("Structure", s:purple, "", "")
  call <SID>X("Function", s:white, "", "")
  call <SID>X("Constant", s:orange, "", "")
  call <SID>X("String", s:green, "", "")
  call <SID>X("Special", s:foreground, "", "")
  call <SID>X("PreProc", s:purple, "", "")
  call <SID>X("Operator", s:aqua, "", "none")
  call <SID>X("OperatorChars", s:aqua, "", "none")
  call <SID>X("Type", s:blue, "", "none")
  call <SID>X("Define", s:purple, "", "none")
  call <SID>X("Include", s:blue, "", "")
  "call <SID>X("Ignore", "666666", "", "")

  " Vim Highlighting
  call <SID>X("vimCommand", s:red, "", "none")

  " C Highlighting
  call <SID>X("cType", s:yellow, "", "")
  call <SID>X("cStorageClass", s:purple, "", "")
  call <SID>X("cConditional", s:purple, "", "")
  call <SID>X("cRepeat", s:purple, "", "")

  " PHP Highlighting
  call <SID>X("phpVarSelector", s:red, "", "")
  call <SID>X("phpKeyword", s:purple, "", "")
  call <SID>X("phpRepeat", s:purple, "", "")
  call <SID>X("phpConditional", s:purple, "", "")
  call <SID>X("phpStatement", s:purple, "", "")
  call <SID>X("phpMemberSelector", s:foreground, "", "")

  " Ruby Highlighting
  call <SID>X("rubySymbol", s:white, "", "")
  call <SID>X("rubyConstant", s:yellow, "", "")
  call <SID>X("rubyAttribute", s:blue, "", "")
  call <SID>X("rubyInclude", s:blue, "", "")
  call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
  call <SID>X("rubyCurlyBlock", s:white, "", "")
  call <SID>X("rubyStringDelimiter", s:green, "", "")
  call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
  call <SID>X("rubyConditional", s:purple, "", "")
  call <SID>X("rubyRepeat", s:purple, "", "")
" call <SID>X("rubyBlock", s:aqua, "", "")
  call <SID>X("rubyRailsRenderMethod", s:blue, "", "")
  call <SID>X("rubyControl", s:purple, "", "")
  call <SID>X("rubyBlockParameter", s:white, "", "")
  call <SID>X("rubyPredefinedConstant", s:yellow, "", "")
  call <SID>X("rubyRailsTestMethod", s:blue, "", "")
  call <SID>X("rubyKeyword", s:purple, "", "")
  call <SID>X("rubyRailsMethod", s:red, "", "")
  call <SID>X("rubyRailsARAssociationMethod", s:blue, "", "")
  call <SID>X("rubyRailsControllerMethod", s:blue, "", "")
  call <SID>X("rubyRailsARCallbackMethod", s:white, "", "")
  call <SID>X("rubyRailsARValidationMethod", s:white, "", "")
  call <SID>X("rubyRailsARClassMethod", s:white, "", "")
  call <SID>X("rubyRailsARMethod", s:white, "", "")
  call <SID>X("rubyRailsFilterMethod", s:white, "", "")
  call <SID>X("rubyRailsRootUrl", s:red, "", "")
  call <SID>X("rubyRegexpComment", s:red, "", "")
  call <SID>X("rubyRegexpParens", s:red, "", "")
  call <SID>X("rubyRegexpBrackets", s:red, "", "")
  call <SID>X("rubyRegexpCharClass", s:red, "", "")
  call <SID>X("rubyRegexpEscape", s:red, "", "")
  call <SID>X("rubyRegexpQuantifier", s:red, "", "")
  call <SID>X("rubyRegexpAnchor", s:red, "", "")
  call <SID>X("rubyRegexpDot", s:red, "", "")
  call <SID>X("rubyRegexpSpecial", s:red, "", "")
  call <SID>X("rubyRegexp", s:red, "", "")
  call <SID>X("rubyRegexpDelimiter", s:red, "", "")
  call <SID>X("rubyPseudoVariable", s:red, "", "")
  call <SID>X("rubyInterpolationDelimiter", s:white, "", "")
  call <SID>X("rubyAccess", s:purple, "", "")
  call <SID>X("rubyException", s:blue, "", "")
  call <SID>X("rubyClass", s:purple, "", "")
  call <SID>X("rubyInstanceVariable", s:red, "", "")

  " ERuby Highlighting
  call <SID>X("erubyDelimiter", s:white, "", "")
  call <SID>X("erubyRailsHelperMethod", s:blue, "", "")
  call <SID>X("erubyRailsRenderMethod", s:blue, "", "")

  " CSS highlighting
  call <SID>X("sassInclude", s:purple, "", "")
  call <SID>X("cssVendor", s:white, "", "")
  call <SID>X("cssUIProp", s:yellow, "", "")
  call <SID>X("cssBoxProp", s:yellow, "", "")
  call <SID>X("cssTextProp", s:yellow, "", "")
  call <SID>X("cssFontProp", s:yellow, "", "")
  call <SID>X("cssIEUIProp", s:yellow, "", "")
  call <SID>X("cssColorProp", s:yellow, "", "")
  call <SID>X("cssBorderProp", s:yellow, "", "")
  call <SID>X("cssDimensionProp", s:yellow, "", "")
  call <SID>X("cssListProp", s:yellow, "", "")
  call <SID>X("cssPositioningProp", s:yellow, "", "")
  call <SID>X("cssPageProp", s:yellow, "", "")
  call <SID>X("cssPositioningAttr", s:yellow, "", "")
  call <SID>X("cssFontAttr", s:orange, "", "")
  call <SID>X("cssTagName", s:red, "", "")
  call <SID>X("cssAttrRegion", s:red, "", "")
  call <SID>X("cssBackgroundProp", s:yellow, "", "")
  call <SID>X("cssNoise", s:red, "", "")
  call <SID>X("cssPseudoClassId", s:red, "", "")
  call <SID>X("sassAmpersand", s:white, "", "")
  call <SID>X("sassClass", s:red, "", "")
  call <SID>X("sassIdChar", s:red, "", "")
  call <SID>X("sassProperty", s:yellow, "", "")
  call <SID>X("sassCssAttribute", s:yellow, "", "")


  "NERDtree Highlighting
  if exists('g:HighlightFolders')
    call <SID>X("NERDTreeDir", s:darkerGreen, "", "")
    "call <SID>X("NERDTreeDir", s:white, "", "")
    call <SID>X("NERDTreeDirSlash", s:white, "", "")
  endif

  " Cucumber Highlighting
  call <SID>X("cucumberThen", s:purple, "", "")
  call <SID>X("cucumberGiven", s:purple, "", "")
  call <SID>X("cucumberWhen", s:purple, "", "")

  " Python Highlighting
  call <SID>X("pythonInclude", s:purple, "", "")
  call <SID>X("pythonStatement", s:purple, "", "")
  call <SID>X("pythonConditional", s:purple, "", "")
  call <SID>X("pythonRepeat", s:purple, "", "")
  call <SID>X("pythonException", s:purple, "", "")
  call <SID>X("pythonFunction", s:blue, "", "")

  " Go Highlighting
  call <SID>X("goStatement", s:purple, "", "")
  call <SID>X("goConditional", s:purple, "", "")
  call <SID>X("goRepeat", s:purple, "", "")
  call <SID>X("goException", s:purple, "", "")
  call <SID>X("goDeclaration", s:blue, "", "")
  call <SID>X("goConstants", s:yellow, "", "")
  call <SID>X("goBuiltins", s:orange, "", "")

  " CoffeeScript Highlighting
  call <SID>X("coffeeKeyword", s:purple, "", "")
  call <SID>X("coffeeConditional", s:purple, "", "")

  " JavaScript Highlighting
  call <SID>X("jsReturn", s:purple, "", "")
  call <SID>X("jsStorageClass", s:purple, "", "")
  call <SID>X("jsClassMethodType", s:purple, "", "")
  call <SID>X("jsModules", s:purple, "", "")
  call <SID>X("jsModuleDefault", s:purple, "", "")
  call <SID>X("jsModuleWords", s:purple, "", "")
  call <SID>X("jsModuleKeywords", s:purple, "", "")
  call <SID>X("jsModuleOperators", s:purple, "", "")
  call <SID>X("jsSuper", s:purple, "", "")
  call <SID>X("jsLabel", s:purple, "", "")
  call <SID>X("jsStatement", s:purple, "", "")
  call <SID>X("jsNew", s:purple, "", "")
  call <SID>X("jsDelete", s:purple, "", "")
  call <SID>X("jsTypeOf", s:purple, "", "")
  call <SID>X("jsConditional", s:purple, "", "")
  call <SID>X("jsFunction", s:purple, "", "")
  call <SID>X("jsException", s:purple, "", "")
  call <SID>X("jsTry", s:purple, "", "")
  call <SID>X("jsCatch", s:purple, "", "")
  call <SID>X("jsFinally", s:purple, "", "")
  call <SID>X("jsArrowFunction", s:aqua, "", "")
  call <SID>X("jsExceptions", s:red, "", "")
  call <SID>X("jsGlobalObjects", s:red, "", "")
  call <SID>X("jsThis", s:red, "", "")
  call <SID>X("jsDomElemFuncs", s:blue, "", "")
  call <SID>X("jsNull", s:orange, "", "")
  call <SID>X("jsUndefined", s:orange, "", "")

  call <SID>X("javaScriptBraces", s:foreground, "", "")
  call <SID>X("javascriptReturn", s:purple, "", "")
  call <SID>X("javascriptImport", s:purple, "", "")
  call <SID>X("javascriptClassKeyword", s:purple, "", "")
  call <SID>X("javascriptClassExtends", s:purple, "", "")
  call <SID>X("javaScriptFunction", s:purple, "", "")
  call <SID>X("javaScriptConditional", s:purple, "", "")
  call <SID>X("javaScriptRepeat", s:purple, "", "")
  call <SID>X("javaScriptNumber", s:orange, "", "")
  call <SID>X("javaScriptMember", s:orange, "", "")
  call <SID>X("javascriptParens", s:white, "", "")
  call <SID>X("javascriptEndColons", s:white, "", "")
  call <SID>X("javascriptNull", s:orange, "", "")
  call <SID>X("javascriptIdentifier", s:purple, "", "")
  call <SID>X("javascriptHtmlElemAttrs", s:orange, "", "")
  call <SID>X("javascriptLabel", s:purple, "", "")
  call <SID>X("javascriptBranch", s:purple, "", "")
  call <SID>X("javascriptFuncKeyword", s:purple, "", "")
  call <SID>X("javascriptFuncArg", s:orange, "", "")
  call <SID>X("javascriptFuncDef", s:blue, "", "")
  call <SID>X("javascriptStatement", s:purple, "", "")
  call <SID>X("javascriptBrowserObjects", s:red, "", "")
  call <SID>X("javascriptMessage", s:blue, "", "")
  call <SID>X("javascriptFuncExp", s:blue, "", "")
  call <SID>X("javascriptGlobalObjects", s:red, "", "")
  call <SID>X("javascriptFuncComma", s:white, "", "")
  call <SID>X("javascriptOperator", s:purple, "", "")
  call <SID>X("javascriptOperator", s:purple, "", "")
  call <SID>X("javascriptFunctionKey", s:blue, "", "")
  call <SID>X("javascriptPrototype", s:orange, "", "") " String.prototype is blue

  " JSX Highlighting
  call <SID>X("xmlTag", s:red, "", "")
  call <SID>X("xmlTagName", s:red, "", "")
  call <SID>X("jsxRegion", s:green, "", "")
  call <SID>X("xmlAttrib", s:red, "", "")
  call <SID>X("xmlEqual", s:aqua, "", "")

  " HTML Highlighting
  call <SID>X("htmlTag", s:red, "", "")
  call <SID>X("htmlH1", s:white, "", "")
  call <SID>X("htmlTagName", s:red, "", "")
  call <SID>X("htmlTagN", s:red, "", "")
  call <SID>X("htmlArg", s:red, "", "")
  call <SID>X("htmlScriptTag", s:red, "", "")
  call <SID>X("htmlTitle", s:white, "", "")
  call <SID>X("htmlLink", s:white, "", "")

  " Diff Highlighting
  call <SID>X("diffAdded", s:green, "", "")
  call <SID>X("diffRemoved", s:red, "", "")

  " Delete Functions
  delf <SID>X
  delf <SID>rgb
  delf <SID>colour
  delf <SID>rgb_colour
  delf <SID>rgb_level
  delf <SID>rgb_number
  delf <SID>grey_colour
  delf <SID>grey_level
  delf <SID>grey_number
endif
