" Vim syntax file
" Language:    Praxis Lisp
" Maintainer:  Sergio Bonatto
" Latest Revision: 2026-01-22
" Description: Syntax Highlighting based on MPCA Grammar & C implementation

if exists("b:current_syntax")
  finish
endif

" A gramática do Praxis permite muitos símbolos em nomes (ex: take-while, +, etc)
" Adicionamos os símbolos permitidos ao iskeyword para que o Vim entenda palavras inteiras
setlocal iskeyword+=-
setlocal iskeyword+=!
setlocal iskeyword+=?
setlocal iskeyword+=$
setlocal iskeyword+=%
setlocal iskeyword+=&
setlocal iskeyword+=*
setlocal iskeyword+=+
setlocal iskeyword+=/
setlocal iskeyword+==
setlocal iskeyword+=<
setlocal iskeyword+=>
setlocal iskeyword+=\\
setlocal iskeyword+=^
setlocal iskeyword+=_

" -----------------------------------------------------------------------------
" 1. Comentários e TODOs
" -----------------------------------------------------------------------------
syn keyword praxisTodo    contained TODO FIXME XXX NOTE OPTIMIZE
syn match   praxisComment ";.*$" contains=praxisTodo,@Spell

" -----------------------------------------------------------------------------
" 2. Literais (Básicos)
" -----------------------------------------------------------------------------
syn match   praxisNumber  "\<-\?\d\+\>"
syn region  praxisString  start=/"/ skip=/\\./ end=/"/ contains=@Spell
syn keyword praxisBoolean true false
syn keyword praxisNull    nil

" -----------------------------------------------------------------------------
" 3. O "Core" (Funções definidas em C - lenv_add_builtins)
" -----------------------------------------------------------------------------
" Estas são as primitivas da linguagem. Devem ter um destaque de "Keyword" ou "Statement"
syn keyword praxisCoreFunc  list head tail join eval
syn keyword praxisCoreFunc  load print error

" Definições e Atribuições Primitivas
syn keyword praxisDefine    def

" Lógica Primitiva
syn keyword praxisCoreCond  if

" -----------------------------------------------------------------------------
" 4. Standard Library (Funções definidas em Praxis)
" -----------------------------------------------------------------------------
" Estas são funções de alto nível. Devem ter cor de "Function" normal.
syn keyword praxisStdLib    fun unpack pack curry uncurry
syn keyword praxisStdLib    len nth fst snd trd last init reverse
syn keyword praxisStdLib    take drop split take-while drop-while
syn keyword praxisStdLib    elem lookup zip unzip
syn keyword praxisStdLib    min max sum product
syn keyword praxisStdLib    flip ghost comp
syn keyword praxisStdLib    map filter foldl foldr

" Estruturas de controle de alto nível
syn keyword praxisFlow      select case otherwise do let

" -----------------------------------------------------------------------------
" 5. Operadores e Símbolos Especiais (Baseado na gramática MPCA)
" -----------------------------------------------------------------------------

" Operadores Matemáticos (Importante: match boundary para não pegar hífens em nomes)
syn match   praxisOperator  "[-+*/]"

" Comparadores (C builtins)
syn match   praxisComparator "==\|!=\|>=\|<=\|>\|<"
" No seu código C, o '=' sozinho é o 'builtin_put' (atribuição)
syn match   praxisDefineOp   "="

" Operadores Lógicos (StdLib)
syn keyword praxisLogic     not or and

" Símbolos Especiais
" Lambda: No C está definido como "\", mas na sintaxe é "\\" por causa do escape
syn match   praxisLambda    "\\"

" Variadic Argument (&)
syn match   praxisVarArg    "&" 

" Ignored Variable (_)
syn match   praxisIgnored   "\<_\>"

" -----------------------------------------------------------------------------
" 6. Delimitadores (S-Expr vs Q-Expr)
" -----------------------------------------------------------------------------
" Essa é a parte mais importante para o seu Lisp.
" S-Expressions () -> Código a ser avaliado
syn match   praxisParen     "[()]"

" Q-Expressions {} -> Listas de símbolos/código quotado
" Vamos dar uma cor de 'Type' ou 'String' para as chaves, indicando que o conteúdo é dados/código latente.
syn match   praxisBrace     "[{}]"

" -----------------------------------------------------------------------------
" 7. Highlight Links (Onde a mágica das cores acontece)
" -----------------------------------------------------------------------------

hi def link praxisComment      Comment
hi def link praxisTodo         Todo

" Dados
hi def link praxisNumber       Number
hi def link praxisString       String
hi def link praxisBoolean      Boolean
hi def link praxisNull         Constant       " nil em vermelho/laranja

" Estrutura de Definição (Core)
hi def link praxisDefine       Structure      " def (Verde/Ciano)
hi def link praxisDefineOp     Structure      " =   (Verde/Ciano)
hi def link praxisCoreCond     Special    " if  (Rosa/Vermelho)

" Funções
hi def link praxisCoreFunc     Statement      " head, tail, eval (Amarelo/Bold - Core C)
hi def link praxisStdLib       Function       " map, filter (Azul - StdLib)
hi def link praxisFlow         PreProc        " select, case, let (Roxo - Macros/Flow)

" Operadores e Lógica
hi def link praxisOperator     Operator       " +, -, * (Laranja)
hi def link praxisComparator   Operator       " ==, != (Laranja)
hi def link praxisLogic        Type           " and, or, not (Verde Claro ou Amarelo)

" Símbolos Especiais
hi def link praxisLambda       SpecialChar    " \ (Muito destaque visual)
hi def link praxisVarArg       Special        " & (Destaque para args)
hi def link praxisIgnored      Comment        " _ (Apagado/Cinza, pois é ignorado)

" Delimitadores - Contraste () vs {}
hi def link praxisParen        Delimiter      " () Cor suave
hi def link praxisBrace        StorageClass   " {} Cor forte (Diferencia Q-Expr de S-Expr)

let b:current_syntax = "praxis"
