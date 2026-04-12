" Vim syntax file
" Language:     C
" Maintainer:   Custom
" Last Change:  2026 Feb 05

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" ==============================================================================
" 1. OPERATORS (Prioridade Baixa)
" ==============================================================================
" Definimos operadores cedo. Comentários (definidos no final) vão sobrepor isso.
syn match cOperator    display "--\|++"
syn match cOperator    display "[!=<>]=\|<<=\|>>=\|[-+/%|^\~]="
syn match cOperator    display "[][!/^|~%<>=?.:+-]"

" Novo grupo para operadores aritméticos/bitwise que podem conflitar com ponteiros
syn match cArithmeticOperator display "[*/%&]"

" Novo grupo para ponteiros e operadores relacionados (estilo diferente)
" Isso destaca apenas os símbolos ->, * e & em qualquer contexto
syn match cPointerOperator    display "->\|[*&]"

" ==============================================================================
" 2. KEYWORDS & TYPES (Prioridade Média)
" ==============================================================================

syn keyword cStatement      case goto return continue asm
syn keyword cLabel          default
syn keyword cConditional    while if else switch endif
syn keyword cRepeat         for do break

" Tipos Primitivos
syn keyword cType           int long short char void
syn keyword cType           signed unsigned float double
syn keyword cType           size_t ssize_t off_t wchar_t ptrdiff_t sig_atomic_t
syn keyword cType           fpos_t clock_t time_t va_list jmp_buf FILE DIR div_t
syn keyword cType           ldiv_t mbstate_t wctrans_t wint_t wctype_t
syn keyword cType           bool _Bool _Complex _Imaginary

" Tipos stdint.h
syn keyword cType           int8_t int16_t int32_t int64_t
syn keyword cType           uint8_t uint16_t uint32_t uint64_t
syn keyword cType           int_least8_t int_least16_t int_least32_t int_least64_t
syn keyword cType           uint_least8_t uint_least16_t uint_least32_t uint_least64_t
syn keyword cType           int_fast8_t int_fast16_t int_fast32_t int_fast64_t
syn keyword cType           uint_fast8_t uint_fast16_t uint_fast32_t uint_fast64_t
syn keyword cType           intptr_t uintptr_t intmax_t uintmax_t

" Tipos BSD (O seu u_long está aqui)
syn keyword cType           u_char u_short u_int u_long u_quad_t quad_t
syn keyword cType           u_int8_t u_int16_t u_int32_t u_int64_t

syn keyword cStorageClass   static register auto volatile extern const
syn keyword cStorageClass   inline restrict _Atomic _Thread_local
syn keyword cStorageClass   _Alignas _Alignof

syn keyword cStructure      struct union enum typedef

syn keyword cOperatorKeyword sizeof typeof offsetof alignof
syn keyword cOperatorKeyword _Generic _Static_assert _Noreturn

syn keyword cBoolean        true false TRUE FALSE
syn keyword cConstant       NULL EOF SEEK_SET SEEK_CUR SEEK_END
syn keyword cConstant       EXIT_SUCCESS EXIT_FAILURE
syn keyword cConstant       __LINE__ __FILE__ __DATE__ __TIME__ __STDC__

" ==============================================================================
" 3. CONTEXT MATCHES (Prioridade Alta - Detalhes Específicos)
" ==============================================================================

" Funções: Identificador seguido de (
syn match cFunction "\<\h\w*\>\ze\s*("

" Membros de Struct: Identificador PRECEDIDO por . ou ->
" Isso vai colorir o 'domain' em 'server.domain', mas não na declaração 'int domain'
syn match cMember   "\(\.\|->\)\@<=\h\w*"

" Tipos definidos pelo usuário (Convenção PascalCase ou terminados em _t)
syn match cUserType "\<\h\w*_t\>"
syn match cUserType "\<[A-Z][a-zA-Z0-9_]*\>"

" Números
syn match cNumber   display "\<0[xX]\x\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match cNumber   display "\<0[xX]\x\+\.\x*\(p[+-]\=\d\+\)\=[fl]\=\>"
syn match cNumber   display "\<\d\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match cFloat    display "\<\d\+\.\d*\(e[+-]\=\d\+\)\=[fl]\=\>"

" Strings e Caracteres
syn match cFormat   display "%\(\d\+\$\)\=[-+' #0*]*\(\d*\|\*\|\*\d\+\$\)\(\.\(\d*\|\*\|\*\d\+\$\)\)\=\([hlLjzt]\|ll\|hh\)\=\([aAbdiuoxXDOUfFeEgGcCsSpn]\)" contained
syn region cString  start=+\(L\|u8\=\|U\)\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ contains=cSpecial,cFormat extend
syn region cCharacter start=+[LuU]'+ skip=+\\'+ end=+'+ contains=cSpecial
syn match cSpecial  display contained "\\[abefnrtv'\"\\?]"

" Preprocessor
syn region cPreCondit       start="^\s*\zs\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\|else\|endif\)\>" skip="\\$" end="$" keepend
" syn match  cPreConditMatch  display "^\s*\zs\(%:\|#\)\s*\(else\|endif\)\>"
syn region cIncluded        display contained start=+"+ skip=+\\\\\|\\"\|\\$+ end=+"+
syn match  cIncluded        display contained "<[^>]*>"
syn match  cInclude         display "^\s*\zs\(%:\|#\)\s*include\>\s*["<]" contains=cIncluded
syn region cDefine          start="^\s*\zs\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,cDefine
syn region cPreProc         start="^\s*\zs\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend

" Novo: Destaque para declarações de ponteiros (prioridade alta para sobrepor tipos)
" Isso tenta capturar 'tipo * var' em contextos de declaração (após storage class ou tipo, antes de ;)
" Use \zs para destacar apenas o '*' e possivelmente o nome da var como ponteiro
syn match cPointerDecl "\(\<cType\>\|\<cUserType\>\|\<cStorageClass\>\|\<cStructure\>\)\@<=\s\+\zs\*\ze\s\+\h\w*" containedin=ALL

" Para destacar o nome da variável ponteiro de forma única
syn match cPointerVar "\*\s\+\zs\h\w*\ze\>\(\s*[,=;)]\)" containedin=ALL

" Para uso de ponteiros em expressões (ex.: *ptr), destaque o *
syn match cPointerDeref "\zs\*\ze\h\w*" containedin=ALL

" Para & em endereço (ex.: &var)
syn match cPointerAddr "&\zs\h\w*\ze" containedin=ALL

" ==============================================================================
" 4. COMMENTS (Prioridade Máxima)
" ==============================================================================
" Mantemos no final para que // ganhe do operador /
syn keyword cTodo           contained TODO FIXME XXX NOTE
syn region  cComment        start="/\*" end="\*/" contains=cTodo
syn match   cComment        "//.*" contains=cTodo

" ==============================================================================
" HIGHLIGHT LINKING
" ==============================================================================

hi def link cStatement      Statement
hi def link cLabel          Label
hi def link cConditional    Conditional
hi def link cRepeat         Special
hi def link cType           Type
hi def link cStorageClass   StorageClass
hi def link cStructure      Structure
hi def link cOperatorKeyword Keyword
hi def link cBoolean        Boolean
hi def link cConstant       Constant
hi def link cComment        Comment
hi def link cTodo           Todo
hi def link cPreCondit      PreCondit
hi def link cInclude        Include
hi def link cDefine         Macro
hi def link cPreProc        PreProc
hi def link cIncluded       String
hi def link cNumber         Number
hi def link cFloat          Float
hi def link cString         String
hi def link cCharacter      Character
hi def link cSpecial        SpecialChar
hi def link cFormat         SpecialChar
hi def link cFunction       Function
hi def link cUserType       Type

" Highlight específico para membros de struct (Identifier ou Special)
hi def link cMember         Identifier

" Links para operadores e ponteiros (usando grupos built-in do colorscheme)
hi def link cOperator       Special  " Operadores gerais herdam do Operator do tema
hi def link cArithmeticOperator Operator  " Aritméticos/bitwise também Operator

" Para ponteiros: Use Special para estilo diferente (geralmente magenta ou destacado)
hi def link cPointerOperator String
hi def link cPointerDecl     String  " * em declarações
hi def link cPointerVar      Underlined  " Nome da var ponteiro (sublinhado para destaque único)
hi def link cPointerDeref    String  " * em dereferência
hi def link cPointerAddr     String  " &var (destaca a var)

let b:current_syntax = "c"
let &cpo = s:cpo_save
unlet s:cpo_save
