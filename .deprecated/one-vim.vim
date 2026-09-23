" Name: one-nvim
" Description: Atom One theme for Vim
" Author: Converted from Neovim Lua version
" Maintainer:
" License: MIT

hi clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "one-vim"

" Color definitions
if &background == "dark"
  " Dark Colors
  let s:mono_1        = {"gui": "#abb2bf", "cterm": "145"}
  let s:mono_2        = {"gui": "#828997", "cterm": "102"}
  let s:mono_3        = {"gui": "#5c6370", "cterm": "59"}
  let s:mono_4        = {"gui": "#4b5263", "cterm": "240"}
  let s:hue_1         = {"gui": "#56b6c2", "cterm": "247"}
  let s:hue_2         = {"gui": "#61afef", "cterm": "75"}
  let s:hue_3         = {"gui": "#c678dd", "cterm": "176"}
  let s:hue_4         = {"gui": "#98c379", "cterm": "114"}
  let s:hue_5         = {"gui": "#e06c75", "cterm": "168"}
  let s:hue_5_2       = {"gui": "#be5046", "cterm": "131"}
  let s:hue_6         = {"gui": "#d19a66", "cterm": "247"}
  let s:hue_6_2       = {"gui": "#e5c07b", "cterm": "180"}
  let s:syntax_bg     = {"gui": "#282c34", "cterm": "17"}
  let s:syntax_gutter = {"gui": "#636d83", "cterm": "241"}
  let s:syntax_cursor = {"gui": "#2c323c", "cterm": "23"}
  let s:syntax_accent = {"gui": "#528bff", "cterm": "69"}
  let s:vertsplit     = {"gui": "#181a1f", "cterm": "234"}
  let s:special_grey  = {"gui": "#3b4048", "cterm": "238"}
  let s:visual_grey   = {"gui": "#3e4452", "cterm": "59"}
  let s:pmenu         = {"gui": "#333841", "cterm": "59"}
  let s:term_black    = {"gui": "#282c34", "cterm": "17"}
  let s:term_blue     = {"gui": "#61afef", "cterm": "75"}
  let s:term_cyan     = {"gui": "#56b6c2", "cterm": "247"}
  let s:term_white    = {"gui": "#dcdfe4", "cterm": "188"}
  let s:term_8        = {"gui": "#5d677a", "cterm": "242"}
  let s:syntax_color_added    = {"gui": "#43d08a", "cterm": "78"}
  let s:syntax_color_modified = {"gui": "#e0c285", "cterm": "250"}
  let s:syntax_color_removed  = {"gui": "#e05252", "cterm": "244"}
else
  " Light Colors
  let s:mono_1        = {"gui": "#383A42", "cterm": "59"}
  let s:mono_2        = {"gui": "#696c77", "cterm": "60"}
  let s:mono_3        = {"gui": "#a0a1a7", "cterm": "247"}
  let s:mono_4        = {"gui": "#c2c2c3", "cterm": "251"}
  let s:hue_1         = {"gui": "#0184bc", "cterm": "31"}
  let s:hue_2         = {"gui": "#4078f2", "cterm": "69"}
  let s:hue_3         = {"gui": "#a626a4", "cterm": "243"}
  let s:hue_4         = {"gui": "#50a14f", "cterm": "242"}
  let s:hue_5         = {"gui": "#e45649", "cterm": "244"}
  let s:hue_5_2       = {"gui": "#ca1243", "cterm": "241"}
  let s:hue_6         = {"gui": "#986801", "cterm": "94"}
  let s:hue_6_2       = {"gui": "#c18401", "cterm": "242"}
  let s:syntax_bg     = {"gui": "#fafafa", "cterm": "231"}
  let s:syntax_gutter = {"gui": "#9e9e9e", "cterm": "247"}
  let s:syntax_cursor = {"gui": "#f0f0f0", "cterm": "255"}
  let s:syntax_accent = {"gui": "#526fff", "cterm": "246"}
  let s:vertsplit     = {"gui": "#e7e9e1", "cterm": "254"}
  let s:special_grey  = {"gui": "#d3d3d3", "cterm": "252"}
  let s:visual_grey   = {"gui": "#d0d0d0", "cterm": "252"}
  let s:pmenu         = {"gui": "#dfdfdf", "cterm": "254"}
  let s:term_black    = {"gui": "#383a42", "cterm": "237"}
  let s:term_blue     = {"gui": "#0184bc", "cterm": "31"}
  let s:term_cyan     = {"gui": "#0997b3", "cterm": "243"}
  let s:term_white    = {"gui": "#fafafa", "cterm": "231"}
  let s:term_8        = {"gui": "#4f525e", "cterm": "240"}
  let s:syntax_color_added    = {"gui": "#2db448", "cterm": "65"}
  let s:syntax_color_modified = {"gui": "#f2a60d", "cterm": "137"}
  let s:syntax_color_removed  = {"gui": "#ff1414", "cterm": "88"}
endif

" Common colors
let s:pink = {"gui": "#d291e4", "cterm": "251"}
let s:syntax_color_renamed = {"gui": "#33a0ff", "cterm": "75"}

" Function to apply highlight
function! s:hi(group, style)
  let l:ctermfg = has_key(a:style, 'fg') ? a:style.fg.cterm : 'NONE'
  let l:ctermbg = has_key(a:style, 'bg') ? a:style.bg.cterm : 'NONE'
  let l:guifg = has_key(a:style, 'fg') ? a:style.fg.gui : 'NONE'
  let l:guibg = has_key(a:style, 'bg') ? a:style.bg.gui : 'NONE'
  let l:attr = has_key(a:style, 'style') ? a:style.style : 'NONE'

  execute 'hi' a:group
    \ 'ctermfg=' . l:ctermfg
    \ 'ctermbg=' . l:ctermbg
    \ 'guifg=' . l:guifg
    \ 'guibg=' . l:guibg
    \ 'cterm=' . l:attr
    \ 'gui=' . l:attr
endfunction

" Check for transparent background
if exists('g:one_nvim_transparent_bg') && g:one_nvim_transparent_bg == 1
  let s:bg_normal = 'NONE'
else
  let s:bg_normal = s:syntax_bg
endif

" Base highlights
call s:hi('Normal', {'fg': s:mono_1, 'bg': s:bg_normal})
call s:hi('NormalFloat', {'fg': s:mono_1, 'bg': s:bg_normal})

" Editor highlights
call s:hi('ColorColumn', {'bg': s:syntax_cursor})
call s:hi('Conceal', {'fg': s:mono_4, 'bg': s:syntax_bg})
call s:hi('Cursor', {'bg': s:syntax_accent})
call s:hi('CursorColumn', {'bg': s:syntax_cursor})
call s:hi('CursorLine', {'bg': s:syntax_cursor})
call s:hi('Directory', {'fg': s:hue_2})
call s:hi('ErrorMsg', {'fg': s:hue_5, 'bg': s:syntax_bg})
call s:hi('VertSplit', {'fg': s:vertsplit})
call s:hi('Folded', {'fg': s:mono_3, 'bg': s:syntax_bg})
call s:hi('FoldColumn', {'fg': s:mono_3, 'bg': s:syntax_cursor})
call s:hi('IncSearch', {'fg': s:hue_6, 'bg': s:mono_3})
call s:hi('LineNr', {'fg': s:mono_4})
call s:hi('CursorLineNr', {'fg': s:mono_1, 'bg': s:syntax_cursor})
call s:hi('MatchParen', {'fg': s:hue_5, 'bg': s:syntax_cursor, 'style': 'underline,bold'})
call s:hi('ModeMsg', {'fg': s:mono_1})
call s:hi('MoreMsg', {'fg': s:mono_1})
call s:hi('NonText', {'fg': s:mono_3})
call s:hi('Pmenu', {'bg': s:pmenu})
call s:hi('PmenuSel', {'bg': s:mono_4})
call s:hi('PmenuSbar', {'bg': s:syntax_bg})
call s:hi('PmenuThumb', {'bg': s:mono_1})
call s:hi('Question', {'fg': s:hue_2})
call s:hi('Search', {'fg': s:syntax_bg, 'bg': s:hue_6_2})
call s:hi('SpecialKey', {'fg': s:special_grey})
call s:hi('StatusLine', {'fg': s:mono_1, 'bg': s:syntax_cursor})
call s:hi('StatusLineNC', {'fg': s:mono_3})
call s:hi('TabLine', {'fg': s:mono_2, 'bg': s:visual_grey})
call s:hi('TabLineFill', {'fg': s:mono_3, 'bg': s:visual_grey})
call s:hi('TabLineSel', {'fg': s:syntax_bg, 'bg': s:hue_2})
call s:hi('Title', {'fg': s:mono_1, 'style': 'bold'})
call s:hi('Visual', {'bg': s:visual_grey})
call s:hi('VisualNOS', {'bg': s:visual_grey})
call s:hi('WarningMsg', {'fg': s:hue_5})
call s:hi('WildMenu', {'fg': s:mono_1, 'bg': s:mono_3})
call s:hi('SignColumn', {'bg': s:syntax_bg})

" Syntax highlighting
call s:hi('Comment', {'fg': s:mono_3, 'style': 'italic'})
call s:hi('Constant', {'fg': s:hue_4})
call s:hi('String', {'fg': s:hue_4})
call s:hi('Character', {'fg': s:hue_4})
call s:hi('Number', {'fg': s:hue_6})
call s:hi('Boolean', {'fg': s:hue_6})
call s:hi('Float', {'fg': s:hue_6})
call s:hi('Identifier', {'fg': s:hue_5})
call s:hi('Function', {'fg': s:hue_2})
call s:hi('Statement', {'fg': s:hue_3})
call s:hi('Conditional', {'fg': s:hue_3})
call s:hi('Repeat', {'fg': s:hue_3})
call s:hi('Label', {'fg': s:hue_3})
call s:hi('Operator', {'fg': s:syntax_accent})
call s:hi('Keyword', {'fg': s:hue_3})
call s:hi('Exception', {'fg': s:hue_3})
call s:hi('PreProc', {'fg': s:hue_6_2})
call s:hi('Include', {'fg': s:hue_2})
call s:hi('Define', {'fg': s:hue_3})
call s:hi('Macro', {'fg': s:hue_3})
call s:hi('PreCondit', {'fg': s:hue_6_2})
call s:hi('Type', {'fg': s:hue_6})
call s:hi('StorageClass', {'fg': s:hue_6})
call s:hi('Structure', {'fg': s:hue_6})
call s:hi('Typedef', {'fg': s:hue_6})
call s:hi('Special', {'fg': s:hue_2})
call s:hi('Underlined', {'style': 'underline'})
call s:hi('Error', {'fg': s:hue_5, 'bg': s:mono_3, 'style': 'bold'})
call s:hi('Todo', {'fg': s:hue_3, 'bg': s:mono_3})

" Diff highlighting
call s:hi('DiffAdd', {'fg': s:syntax_color_added, 'bg': s:visual_grey})
call s:hi('DiffChange', {'fg': s:syntax_color_modified, 'bg': s:visual_grey})
call s:hi('DiffDelete', {'fg': s:syntax_color_removed, 'bg': s:visual_grey})
call s:hi('DiffText', {'fg': s:hue_2, 'bg': s:visual_grey})

" Language specific highlights
" HTML
call s:hi('htmlArg', {'fg': s:hue_6})
call s:hi('htmlTagName', {'fg': s:hue_5})
call s:hi('htmlTag', {'fg': s:mono_2})
call s:hi('htmlEndTag', {'fg': s:mono_2})

" CSS
call s:hi('cssClassName', {'fg': s:hue_6})
call s:hi('cssProp', {'fg': s:hue_1})
call s:hi('cssTagName', {'fg': s:hue_5})
call s:hi('cssStringQ', {'fg': s:hue_4})
call s:hi('cssStringQQ', {'fg': s:hue_4})

" JavaScript
call s:hi('javaScriptFunction', {'fg': s:hue_3})
call s:hi('javaScriptIdentifier', {'fg': s:hue_3})
call s:hi('javaScriptBraces', {'fg': s:mono_2})
call s:hi('javaScriptNumber', {'fg': s:hue_6})
call s:hi('javaScriptNull', {'fg': s:hue_6})
call s:hi('jsVariableDef', {'fg': s:hue_6_2})
call s:hi('jsFunction', {'fg': s:hue_3})
call s:hi('jsFuncName', {'fg': s:hue_3})
call s:hi('jsIfElse', {'fg': s:hue_5})
call s:hi('jsReturn', {'fg': s:hue_5})
call s:hi('jsOperator', {'fg': s:syntax_accent})
call s:hi('jsLet', {'fg': s:hue_3})

" JSON
call s:hi('jsonKeyword', {'fg': s:hue_5})
call s:hi('jsonString', {'fg': s:hue_4})
call s:hi('jsonNumber', {'fg': s:hue_6})
call s:hi('jsonBoolean', {'fg': s:hue_3})

" Haskell
call s:hi('haskellType', {'fg': s:hue_6})
call s:hi('haskellIdentifier', {'fg': s:hue_2})
call s:hi('haskellKeyword', {'fg': s:hue_3})
call s:hi('haskellNumber', {'fg': s:hue_6})
call s:hi('haskellString', {'fg': s:hue_4})
call s:hi('haskellComment', {'fg': s:mono_3, 'style': 'italic'})

" Rust
call s:hi('rustKeyword', {'fg': s:hue_3})
call s:hi('rustModPath', {'fg': s:hue_2})
call s:hi('rustType', {'fg': s:hue_6})
call s:hi('rustLifetime', {'fg': s:hue_1})
call s:hi('rustAttribute', {'fg': s:hue_6_2})
call s:hi('rustCommentLineDoc', {'fg': s:mono_3, 'style': 'italic'})

" Python
call s:hi('pythonStatement', {'fg': s:hue_3})
call s:hi('pythonBuiltin', {'fg': s:hue_1})
call s:hi('pythonFunction', {'fg': s:hue_2})
call s:hi('pythonClass', {'fg': s:hue_2})
call s:hi('pythonOperator', {'fg': s:hue_3})
call s:hi('pythonKeyword', {'fg': s:hue_2})
call s:hi('pythonDecorator', {'fg': s:hue_6_2})
call s:hi('pythonString', {'fg': s:hue_4})
call s:hi('pythonNumber', {'fg': s:hue_6})
call s:hi('pythonComment', {'fg': s:mono_3, 'style': 'italic'})

" Ruby
call s:hi('rubyClass', {'fg': s:hue_3})
call s:hi('rubyFunction', {'fg': s:hue_2})
call s:hi('rubyKeyword', {'fg': s:hue_2})
call s:hi('rubySymbol', {'fg': s:hue_1})
call s:hi('rubyConstant', {'fg': s:hue_6_2})
call s:hi('rubyString', {'fg': s:hue_4})
call s:hi('rubyNumber', {'fg': s:hue_6})
call s:hi('rubyComment', {'fg': s:mono_3, 'style': 'italic'})

" PHP
call s:hi('phpClass', {'fg': s:hue_6_2})
call s:hi('phpFunction', {'fg': s:hue_2})
call s:hi('phpKeyword', {'fg': s:hue_3})
call s:hi('phpType', {'fg': s:hue_3})

" Go
call s:hi('goDeclaration', {'fg': s:hue_3})
call s:hi('goType', {'fg': s:hue_3})
call s:hi('goMethod', {'fg': s:hue_1})

" Markdown
call s:hi('markdownCode', {'fg': s:hue_4})
call s:hi('markdownCodeBlock', {'fg': s:hue_5})
call s:hi('markdownH1', {'fg': s:hue_5})
call s:hi('markdownH2', {'fg': s:hue_5})
call s:hi('markdownH3', {'fg': s:hue_5})
call s:hi('markdownH4', {'fg': s:hue_5})
call s:hi('markdownH5', {'fg': s:hue_5})
call s:hi('markdownH6', {'fg': s:hue_5})
call s:hi('markdownBold', {'fg': s:hue_6, 'style': 'bold'})
call s:hi('markdownItalic', {'fg': s:hue_6, 'style': 'italic'})

" Vim script
call s:hi('vimCommand', {'fg': s:hue_3})
call s:hi('vimFunction', {'fg': s:hue_1})
call s:hi('vimFuncName', {'fg': s:hue_3})
call s:hi('vimHighlight', {'fg': s:hue_2})
call s:hi('vimVar', {'fg': s:hue_5})

" Git
call s:hi('gitcommitComment', {'fg': s:mono_3})
call s:hi('gitcommitBranch', {'fg': s:hue_3})
call s:hi('gitcommitSelectedFile', {'fg': s:hue_4})
call s:hi('gitcommitDiscardedFile', {'fg': s:hue_5})
call s:hi('gitcommitUnmergedFile', {'fg': s:hue_6_2})

" Spelling
call s:hi('SpellBad', {'fg': s:mono_3, 'style': 'undercurl'})
call s:hi('SpellLocal', {'fg': s:mono_3, 'style': 'undercurl'})
call s:hi('SpellCap', {'fg': s:mono_3, 'style': 'undercurl'})
call s:hi('SpellRare', {'fg': s:mono_3, 'style': 'undercurl'})

" Plugin support
" NERDTree
call s:hi('NERDTreeFile', {'fg': s:mono_1})

" ALE
call s:hi('ALEWarningSign', {'fg': s:hue_6_2})
call s:hi('ALEErrorSign', {'fg': s:hue_5})


" Terminal colors
if has('nvim')
  let g:terminal_color_0 = s:term_black.gui
  let g:terminal_color_1 = s:hue_5.gui
  let g:terminal_color_2 = s:hue_4.gui
  let g:terminal_color_3 = s:hue_6_2.gui
  let g:terminal_color_4 = s:term_blue.gui
  let g:terminal_color_5 = s:hue_3.gui
  let g:terminal_color_6 = s:term_cyan.gui
  let g:terminal_color_7 = s:term_white.gui
  let g:terminal_color_8 = s:term_8.gui
  let g:terminal_color_9 = s:hue_5.gui
  let g:terminal_color_10 = s:hue_4.gui
  let g:terminal_color_11 = s:hue_6_2.gui
  let g:terminal_color_12 = s:term_blue.gui
  let g:terminal_color_13 = s:hue_3.gui
  let g:terminal_color_14 = s:term_cyan.gui
  let g:terminal_color_15 = s:term_white.gui
endif

" === JavaScript Highlighting ===
hi link jsFunction         Function
hi link jsFuncCall         Function
hi link jsArrowFunction    Function
hi link jsClassKeyword     Keyword
hi link jsClassMethodType  Keyword
hi link jsReturn           Keyword
hi link jsThis             Keyword
hi link jsIfElse           Conditional
hi link jsTry              Keyword
hi link jsCatch            Keyword
hi link jsFinally          Keyword
hi link jsException        Exception
hi link jsVariableDef      Identifier
hi link jsObjectKey        Identifier
hi link jsObjectProp       Identifier
hi link jsNull             Constant
hi link jsUndefined        Constant
hi link jsBooleanTrue      Boolean
hi link jsBooleanFalse     Boolean
hi link jsNumber           Number
hi link jsString           String
hi link jsRegexpString     String
hi link jsImport           Include
hi link jsExport           Include
hi link jsLet              Keyword


" === JSX Highlighting (vim-jsx-pretty) ===
hi link jsxTagName         Keyword
hi link jsxComponentName   Type
hi link jsxCloseTag        Keyword
hi link jsxAttrib          Identifier
hi link jsxEqual           Operator
hi link jsxString          String
hi link jsxBraces          Delimiter
hi link jsxEscapeJs        Special

" === Rust Highlighting ===
hi link rustKeyword        Keyword
hi link rustModPath        Identifier
hi link rustType           Type
hi link rustLifetime       Identifier
hi link rustAttribute      PreProc
hi link rustCommentLineDoc Comment
hi link rustStructure      Structure
hi link rustEnum           Type
hi link rustTrait          Type
hi link rustMacro          Macro
hi link rustConstant       Constant
hi link rustString         String
hi link rustNumber         Number
hi link rustBoolean        Boolean
hi link rustError          Error
hi link rustWarning        WarningMsg

" === Haskell Highlighting ===
hi link haskellType        Type
hi link haskellIdentifier  Identifier
hi link haskellKeyword     Keyword
hi link haskellNumber      Number
hi link haskellString      String
hi link haskellComment     Comment
hi link haskellConstructor Type
hi link haskellOperator    Operator
hi link haskellPragma      PreProc
hi link haskellError       Error
hi link haskellWarning     WarningMsg

" === Python Highlighting ===
hi link pythonStatement    Statement
hi link pythonBuiltin      Function
hi link pythonFunction     Function
hi link pythonClass        Type
hi link pythonOperator     Operator
hi link pythonKeyword      Keyword
hi link pythonDecorator    PreProc
hi link pythonString       String
hi link pythonNumber       Number
hi link pythonComment      Comment
hi link pythonSelf         Identifier
hi link pythonDocstring    String
hi link pythonException    Exception
hi link pythonError        Error
hi link pythonWarning      WarningMsg
hi link pythonStrFormat Statement

" === Ruby Highlighting ===
hi link rubyClass          Type
hi link rubyFunction       Function
hi link rubyKeyword        Keyword
hi link rubySymbol         Identifier
hi link rubyConstant       Constant
hi link rubyString         String
hi link rubyNumber         Number
hi link rubyComment        Comment
hi link rubyModule         Type
hi link rubyTest           Statement
hi link rubyRegexp         String
hi link rubyError          Error
hi link rubyWarning        WarningMsg
