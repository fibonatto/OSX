" Atom One Light (Matte) Color Scheme for Vim
" Baseado no tema oficial Atom One Light, ajustado para baixo contraste
" Mantém fidelidade às cores originais do Atom, mas com estética fosca/e-ink
" Autor: Bonatto (Matte Mod)
" Version: 2.1-matte

set background=light
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "atomonelight_matte"

" Verificação de compatibilidade
let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2

" Paleta de cores oficial do Atom One Light (Versão Matte/Dessaturada)
let s:mono_1    = "#4a4c54"  " Texto principal (mais suave)
let s:mono_2    = "#767985"  " Texto secundário
let s:mono_3    = "#a6a8ad"  " Comentários/desabilitado
let s:hue_1     = "#338ab3"  " Azul (funções)
let s:hue_2     = "#5d85de"  " Azul claro (tipos)
let s:hue_3     = "#a14a9f"  " Roxo (keywords)
let s:hue_4     = "#669e65"  " Verde (strings)
let s:hue_5     = "#cc6258"  " Vermelho (variáveis)
let s:hue_5_2   = "#b8375c"  " Vermelho escuro
let s:hue_6     = "#9c7a31"  " Laranja (números)
let s:hue_6_2   = "#b58928"  " Laranja claro

" Cores de fundo e interface (CORRIGIDAS PARA O ITERM #eceaeb)
let s:syntax_bg     = "#eceaeb"  " Fundo principal idêntico ao iTerm
let s:syntax_gutter = "#9ca0a4"  " Numeração de linha
let s:syntax_guide  = "#d8d6d7"  " Guias visuais
let s:syntax_accent = "#6e83e6"  " Acentos

" Função para definir highlights
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

" Mapeamento de cores forçado para o terminal (Matte)
let s:fg        = {"gui": s:mono_1,    "cterm": "NONE"}
let s:bg        = {"gui": s:syntax_bg, "cterm": "NONE"}
let s:comment   = {"gui": s:mono_3,    "cterm": "NONE"}
let s:keyword   = {"gui": s:hue_3,     "cterm": "NONE"}
let s:string    = {"gui": s:hue_4,     "cterm": "NONE"}
let s:function  = {"gui": s:hue_2,     "cterm": "NONE"}
let s:variable  = {"gui": s:hue_5,     "cterm": "NONE"}
let s:number    = {"gui": s:hue_6,     "cterm": "NONE"}
let s:visual    = {"gui": "#d8d6d7",   "cterm": "NONE"}
let s:gutter    = {"gui": s:syntax_gutter, "cterm": "NONE"}

" ===================================================================
" EDITOR SETTINGS
" ===================================================================
call s:h("Normal",        {"fg": s:fg,      "bg": s:bg})
call s:h("Cursor",        {"fg": s:bg,      "bg": s:fg})
call s:h("CursorLine",    {"bg": {"gui": "#e2e0e1", "cterm": "254"}})
call s:h("CursorLineNr",  {"fg": s:fg,      "gui": "bold", "cterm": "bold"})
call s:h("CursorColumn",  {"bg": {"gui": "#e2e0e1", "cterm": "254"}})
call s:h("ColorColumn",   {"bg": {"gui": "#e2e0e1", "cterm": "254"}})
call s:h("LineNr",        {"fg": s:gutter})
call s:h("VertSplit",     {"fg": {"gui": "#d8d6d7", "cterm": "252"}, "bg": s:bg})
call s:h("Folded",        {"fg": s:comment, "bg": {"gui": "#d8d6d7", "cterm": "252"}, "gui": "italic"})
call s:h("FoldColumn",    {"fg": s:comment, "bg": s:bg})
call s:h("SignColumn",    {"fg": s:gutter,  "bg": s:bg})

" ===================================================================
" SYNTAX HIGHLIGHTING
" ===================================================================
call s:h("Comment",       {"fg": s:comment, "gui": "italic", "cterm": "italic"})
call s:h("Constant",      {"fg": s:number})
call s:h("String",        {"fg": s:string})
call s:h("Character",     {"fg": s:string})
call s:h("Number",        {"fg": s:number})
call s:h("Boolean",       {"fg": s:number})
call s:h("Float",         {"fg": s:number})

call s:h("Identifier",    {"fg": s:variable})
call s:h("Function",      {"fg": s:function, "gui": "bold", "cterm": "bold"})

call s:h("Statement",     {"fg": s:keyword})
call s:h("Conditional",   {"fg": s:keyword})
call s:h("Repeat",        {"fg": s:keyword})
call s:h("Label",         {"fg": s:keyword})
call s:h("Operator",      {"fg": s:fg})
call s:h("Keyword",       {"fg": s:keyword, "gui": "bold", "cterm": "bold"})
call s:h("Exception",     {"fg": s:keyword})

call s:h("PreProc",       {"fg": s:function})
call s:h("Include",       {"fg": s:keyword})
call s:h("Define",        {"fg": s:keyword})
call s:h("Macro",         {"fg": s:function})
call s:h("PreCondit",     {"fg": s:keyword})

call s:h("Type",          {"fg": s:number})
call s:h("StorageClass",  {"fg": s:keyword})
call s:h("Structure",     {"fg": s:keyword})
call s:h("Typedef",       {"fg": s:keyword})

call s:h("Special",       {"fg": s:variable})
call s:h("SpecialChar",   {"fg": s:variable})
call s:h("Tag",           {"fg": s:variable})
call s:h("Delimiter",     {"fg": s:fg})
call s:h("SpecialComment", {"fg": s:comment, "gui": "italic", "cterm": "italic"})
call s:h("Debug",         {"fg": s:variable})

" ===================================================================
" VIM HIGHLIGHTING
" ===================================================================
call s:h("Error",         {"fg": s:variable, "bg": s:bg, "gui": "bold", "cterm": "bold"})
call s:h("ErrorMsg",      {"fg": s:variable, "bg": s:bg})
call s:h("Warning",       {"fg": s:number,   "bg": s:bg})
call s:h("WarningMsg",    {"fg": s:number,   "bg": s:bg})
call s:h("Todo",          {"fg": s:keyword,  "bg": s:bg, "gui": "bold,italic", "cterm": "bold"})
call s:h("MoreMsg",       {"fg": s:string,   "gui": "bold", "cterm": "bold"})
call s:h("Question",      {"fg": s:function, "gui": "bold", "cterm": "bold"})

call s:h("Search",        {"fg": s:fg, "bg": {"gui": "#e8dcab", "cterm": "187"}})
call s:h("IncSearch",     {"fg": s:fg, "bg": {"gui": "#e8dcab", "cterm": "187"}, "gui": "bold", "cterm": "bold"})
call s:h("Visual",        {"bg": s:visual})
call s:h("VisualNOS",     {"bg": s:visual})

call s:h("MatchParen",    {"fg": s:bg, "bg": s:function, "gui": "bold", "cterm": "bold"})
call s:h("Underlined",    {"fg": s:function, "gui": "underline", "cterm": "underline"})

call s:h("StatusLine",    {"fg": s:fg, "bg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("StatusLineNC",  {"fg": s:comment, "bg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("WildMenu",      {"fg": s:bg, "bg": s:function})

call s:h("Pmenu",         {"fg": s:fg, "bg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("PmenuSel",      {"fg": s:bg, "bg": s:function})
call s:h("PmenuSbar",     {"bg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("PmenuThumb",    {"bg": s:comment})

call s:h("TabLine",       {"fg": s:comment, "bg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("TabLineSel",    {"fg": s:fg, "bg": s:bg})
call s:h("TabLineFill",   {"fg": s:comment, "bg": {"gui": "#d8d6d7", "cterm": "252"}})

" ===================================================================
" DIFF HIGHLIGHTING
" ===================================================================
call s:h("DiffAdd",       {"fg": s:string, "bg": {"gui": "#d8ecd9", "cterm": "194"}})
call s:h("DiffChange",    {"fg": s:number, "bg": {"gui": "#e5dfb8", "cterm": "229"}})
call s:h("DiffDelete",    {"fg": s:variable, "bg": {"gui": "#ebd6d6", "cterm": "224"}})
call s:h("DiffText",      {"fg": s:fg, "bg": {"gui": "#e5dfb8", "cterm": "229"}, "gui": "bold", "cterm": "bold"})

call s:h("diffAdded",     {"fg": s:string})
call s:h("diffRemoved",   {"fg": s:variable})
call s:h("diffChanged",   {"fg": s:number})
call s:h("diffFile",      {"fg": s:comment})
call s:h("diffLine",      {"fg": s:function})

" ===================================================================
" SPELLING
" ===================================================================
call s:h("SpellBad",      {"sp": s:variable, "gui": "undercurl", "cterm": "underline"})
call s:h("SpellCap",      {"sp": s:function, "gui": "undercurl", "cterm": "underline"})
call s:h("SpellLocal",    {"sp": s:number,   "gui": "undercurl", "cterm": "underline"})
call s:h("SpellRare",     {"sp": s:keyword,  "gui": "undercurl", "cterm": "underline"})

" ===================================================================
" LANGUAGE SPECIFIC
" ===================================================================

" HTML
call s:h("htmlTag",           {"fg": s:variable})
call s:h("htmlEndTag",        {"fg": s:variable})
call s:h("htmlTagName",       {"fg": s:variable})
call s:h("htmlArg",           {"fg": s:number})
call s:h("htmlSpecialChar",   {"fg": s:number})

" CSS
call s:h("cssProp",           {"fg": s:fg})
call s:h("cssUIAttr",         {"fg": s:number})
call s:h("cssAuralAttr",      {"fg": s:number})
call s:h("cssColor",          {"fg": s:number})
call s:h("cssBorderAttr",     {"fg": s:number})
call s:h("cssColorAttr",      {"fg": s:number})
call s:h("cssFontAttr",       {"fg": s:number})
call s:h("cssTextAttr",       {"fg": s:number})
call s:h("cssValueLength",    {"fg": s:number})
call s:h("cssValueInteger",   {"fg": s:number})
call s:h("cssValueNumber",    {"fg": s:number})
call s:h("cssIdentifier",     {"fg": s:function})
call s:h("cssIncludeKeyword", {"fg": s:keyword})
call s:h("cssClassName",      {"fg": s:number})

" JavaScript
call s:h("javaScriptBraces",     {"fg": s:fg})
call s:h("javaScriptFunction",   {"fg": s:keyword})
call s:h("javaScriptConditional", {"fg": s:keyword})
call s:h("javaScriptRepeat",     {"fg": s:keyword})
call s:h("javaScriptNumber",     {"fg": s:number})
call s:h("javaScriptMember",     {"fg": s:variable})
call s:h("javascriptNull",       {"fg": s:number})
call s:h("javascriptGlobal",     {"fg": s:variable})
call s:h("javascriptStatement",  {"fg": s:keyword})

" Python
call s:h("pythonOperator",       {"fg": s:keyword})
call s:h("pythonRepeat",         {"fg": s:keyword})
call s:h("pythonInclude",        {"fg": s:keyword})
call s:h("pythonStatement",      {"fg": s:keyword})

" Ruby
call s:h("rubyAttribute",               {"fg": s:function})
call s:h("rubyConstant",                {"fg": s:number})
call s:h("rubyInterpolationDelimiter",  {"fg": s:variable})
call s:h("rubyRegexp",                  {"fg": s:string})
call s:h("rubySymbol",                  {"fg": s:string})
call s:h("rubyStringDelimiter",         {"fg": s:string})

" PHP
call s:h("phpMemberSelector",    {"fg": s:fg})
call s:h("phpComparison",        {"fg": s:fg})
call s:h("phpParent",            {"fg": s:fg})
call s:h("phpMethodsVar",        {"fg": s:variable})

" Markdown
call s:h("markdownCode",              {"fg": s:string})
call s:h("markdownError",             {"fg": s:fg, "bg": s:bg})
call s:h("markdownCodeBlock",         {"fg": s:string})
call s:h("markdownHeadingDelimiter",  {"fg": s:variable})
call s:h("markdownRule",              {"fg": s:comment})
call s:h("markdownHeadingRule",       {"fg": s:comment})
call s:h("markdownH1",                {"fg": s:variable})
call s:h("markdownH2",                {"fg": s:variable})
call s:h("markdownH3",                {"fg": s:variable})
call s:h("markdownH4",                {"fg": s:variable})
call s:h("markdownH5",                {"fg": s:variable})
call s:h("markdownH6",                {"fg": s:variable})
call s:h("markdownIdDelimiter",       {"fg": s:keyword})
call s:h("markdownId",                {"fg": s:keyword})
call s:h("markdownBlockquote",        {"fg": s:comment})
call s:h("markdownItalic",            {"fg": s:keyword, "gui": "italic", "cterm": "italic"})
call s:h("markdownBold",              {"fg": s:number, "gui": "bold", "cterm": "bold"})
call s:h("markdownListMarker",        {"fg": s:variable})
call s:h("markdownOrderedListMarker", {"fg": s:variable})
call s:h("markdownIdDeclaration",     {"fg": s:function})
call s:h("markdownLinkText",          {"fg": s:function})
call s:h("markdownLinkDelimiter",     {"fg": s:fg})
call s:h("markdownUrl",               {"fg": s:number})

" ===================================================================
" PLUGIN SUPPORT
" ===================================================================

" NERDTree
call s:h("NERDTreeFile",        {"fg": s:fg})
call s:h("NERDTreeExecFile",    {"fg": s:string})
call s:h("NERDTreeDir",         {"fg": s:function, "gui": "bold", "cterm": "bold"})
call s:h("NERDTreeDirSlash",    {"fg": s:function})
call s:h("NERDTreeCWD",         {"fg": s:keyword, "gui": "bold", "cterm": "bold"})
call s:h("NERDTreeOpenable",    {"fg": s:string})
call s:h("NERDTreeClosable",    {"fg": s:variable})
call s:h("NERDTreeUp",          {"fg": s:comment})
call s:h("NERDTreeToggleOn",    {"fg": s:string})
call s:h("NERDTreeToggleOff",   {"fg": s:variable})

" GitGutter
call s:h("GitGutterAdd",        {"fg": s:string,   "bg": s:bg})
call s:h("GitGutterChange",     {"fg": s:number,   "bg": s:bg})
call s:h("GitGutterDelete",     {"fg": s:variable, "bg": s:bg})
call s:h("GitGutterChangeDelete", {"fg": s:number, "bg": s:bg})

" ALE (Asynchronous Lint Engine)
call s:h("ALEError",            {"fg": s:variable})
call s:h("ALEWarning",          {"fg": s:number})
call s:h("ALEErrorSign",        {"fg": s:variable, "bg": s:bg})
call s:h("ALEWarningSign",      {"fg": s:number,   "bg": s:bg})

" COC (Conquer of Completion)
call s:h("CocErrorSign",        {"fg": s:variable, "bg": s:bg})
call s:h("CocWarningSign",      {"fg": s:number,   "bg": s:bg})
call s:h("CocInfoSign",         {"fg": s:function, "bg": s:bg})
call s:h("CocHintSign",         {"fg": s:comment,  "bg": s:bg})

" FZF
call s:h("fzf1",                {"fg": s:variable, "bg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("fzf2",                {"fg": s:variable, "bg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("fzf3",                {"fg": s:variable, "bg": {"gui": "#d8d6d7", "cterm": "252"}})

" Telescope (Neovim)
call s:h("TelescopeBorder",         {"fg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("TelescopePromptBorder",   {"fg": s:function})
call s:h("TelescopeResultsBorder",  {"fg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("TelescopePreviewBorder",  {"fg": {"gui": "#d8d6d7", "cterm": "252"}})
call s:h("TelescopeMatching",       {"fg": s:function, "gui": "bold", "cterm": "bold"})
call s:h("TelescopePromptPrefix",   {"fg": s:variable})

" LSP Diagnostics (Neovim)
call s:h("DiagnosticError",         {"fg": s:variable})
call s:h("DiagnosticWarn",          {"fg": s:number})
call s:h("DiagnosticInfo",          {"fg": s:function})
call s:h("DiagnosticHint",          {"fg": s:comment})
call s:h("DiagnosticUnderlineError", {"sp": s:variable, "gui": "undercurl", "cterm": "underline"})
call s:h("DiagnosticUnderlineWarn",  {"sp": s:number, "gui": "undercurl", "cterm": "underline"})
call s:h("DiagnosticUnderlineInfo",  {"sp": s:function, "gui": "undercurl", "cterm": "underline"})
call s:h("DiagnosticUnderlineHint",  {"sp": s:comment, "gui": "undercurl", "cterm": "underline"})

" TreeSitter (Neovim)
call s:h("TSAnnotation",        {"fg": s:variable})
call s:h("TSAttribute",         {"fg": s:number})
call s:h("TSBoolean",           {"fg": s:number})
call s:h("TSCharacter",         {"fg": s:string})
call s:h("TSComment",           {"fg": s:comment, "gui": "italic", "cterm": "italic"})
call s:h("TSConditional",       {"fg": s:keyword})
call s:h("TSConstant",          {"fg": s:number})
call s:h("TSConstBuiltin",      {"fg": s:number})
call s:h("TSConstMacro",        {"fg": s:number})
call s:h("TSConstructor",       {"fg": s:function})
call s:h("TSError",             {"fg": s:variable})
call s:h("TSException",         {"fg": s:keyword})
call s:h("TSField",             {"fg": s:variable})
call s:h("TSFloat",             {"fg": s:number})
call s:h("TSFunction",          {"fg": s:function})
call s:h("TSFuncBuiltin",       {"fg": s:function})
call s:h("TSFuncMacro",         {"fg": s:function})
call s:h("TSInclude",           {"fg": s:keyword})
call s:h("TSKeyword",           {"fg": s:keyword})
call s:h("TSKeywordFunction",   {"fg": s:keyword})
call s:h("TSKeywordOperator",   {"fg": s:keyword})
call s:h("TSLabel",             {"fg": s:variable})
call s:h("TSMethod",            {"fg": s:function})
call s:h("TSNamespace",         {"fg": s:variable})
call s:h("TSNone",              {"fg": s:fg})
call s:h("TSNumber",            {"fg": s:number})
call s:h("TSOperator",          {"fg": s:fg})
call s:h("TSParameter",         {"fg": s:variable})
call s:h("TSParameterReference", {"fg": s:variable})
call s:h("TSProperty",          {"fg": s:variable})
call s:h("TSPunctDelimiter",    {"fg": s:fg})
call s:h("TSPunctBracket",      {"fg": s:fg})
call s:h("TSPunctSpecial",      {"fg": s:fg})
call s:h("TSRepeat",            {"fg": s:keyword})
call s:h("TSString",            {"fg": s:string})
call s:h("TSStringRegex",       {"fg": s:string})
call s:h("TSStringEscape",      {"fg": s:variable})
call s:h("TSSymbol",            {"fg": s:number})
call s:h("TSTag",               {"fg": s:variable})
call s:h("TSTagDelimiter",      {"fg": s:fg})
call s:h("TSText",              {"fg": s:fg})
call s:h("TSStrong",            {"fg": s:number, "gui": "bold", "cterm": "bold"})
call s:h("TSEmphasis",          {"fg": s:keyword, "gui": "italic", "cterm": "italic"})
call s:h("TSUnderline",         {"fg": s:fg, "gui": "underline", "cterm": "underline"})
call s:h("TSStrike",            {"fg": s:fg, "gui": "strikethrough"})
call s:h("TSTitle",             {"fg": s:variable, "gui": "bold", "cterm": "bold"})
call s:h("TSLiteral",           {"fg": s:string})
call s:h("TSURI",               {"fg": s:number, "gui": "underline", "cterm": "underline"})
call s:h("TSMath",              {"fg": s:function})
call s:h("TSTextReference",     {"fg": s:variable})
call s:h("TSEnvironment",       {"fg": s:keyword})
call s:h("TSEnvironmentName",   {"fg": s:number})
call s:h("TSNote",              {"fg": s:comment})
call s:h("TSWarning",           {"fg": s:number})
call s:h("TSDanger",            {"fg": s:variable})
call s:h("TSType",              {"fg": s:number})
call s:h("TSTypeBuiltin",       {"fg": s:number})
call s:h("TSVariable",          {"fg": s:fg})
call s:h("TSVariableBuiltin",   {"fg": s:variable})

" ===================================================================
" TERMINAL COLORS (for :terminal in Neovim)
" ===================================================================
if has('nvim')
  let g:terminal_color_0  = s:mono_1
  let g:terminal_color_1  = s:hue_5
  let g:terminal_color_2  = s:hue_4
  let g:terminal_color_3  = s:hue_6
  let g:terminal_color_4  = s:hue_2
  let g:terminal_color_5  = s:hue_3
  let g:terminal_color_6  = s:hue_1
  let g:terminal_color_7  = s:syntax_bg
  let g:terminal_color_8  = s:mono_3
  let g:terminal_color_9  = s:hue_5
  let g:terminal_color_10 = s:hue_4
  let g:terminal_color_11 = s:hue_6
  let g:terminal_color_12 = s:hue_2
  let g:terminal_color_13 = s:hue_3
  let g:terminal_color_14 = s:hue_1
  let g:terminal_color_15 = s:syntax_bg
endif

" ===================================================================
" LEGACY SUPPORT
" ===================================================================
if !has("gui_running") && &t_Co != 88 && &t_Co != 256
  finish
endif

" Cleanup
unlet s:t_Co
unlet s:mono_1 s:mono_2 s:mono_3
unlet s:hue_1 s:hue_2 s:hue_3 s:hue_4 s:hue_5 s:hue_5_2 s:hue_6 s:hue_6_2
unlet s:syntax_bg s:syntax_gutter s:syntax_guide s:syntax_accent
unlet s:fg s:bg s:comment s:keyword s:string s:function s:variable s:number s:visual s:gutter