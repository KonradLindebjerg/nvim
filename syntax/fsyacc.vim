" Vim syntax file for FsYacc (.fsp) grammar files.
" Embeds F# syntax inside the %{ ... %} header and { ... } action blocks.

if exists("b:current_syntax")
  finish
endif

" Pull in F# syntax under a cluster so we can embed it in regions.
syn include @fsharpCode syntax/fsharp.vim
unlet! b:current_syntax

" Grammar-shell comments (outside F# blocks).
syn match  fsyaccLineComment  "//.*$"
syn region fsyaccBlockComment start="(\*" end="\*)" contains=fsyaccBlockComment

" Section separator (%%) and directives.
syn match fsyaccSeparator "^%%"
syn match fsyaccDirective "%\(token\|type\|start\|left\|right\|nonassoc\|prec\)\>"

" F# header block: %{ ... %}
syn region fsyaccHeader matchgroup=fsyaccDelim
      \ start="%{" end="%}" contains=@fsharpCode keepend

" Type annotations after %token / %type: < ... >
syn region fsyaccTypeAnnot matchgroup=fsyaccDelim
      \ start="<" end=">" oneline contains=@fsharpCode

" F# action blocks: { ... } with nested-brace support (F# records etc.).
syn region fsyaccAction matchgroup=fsyaccDelim
      \ start="{" end="}" contains=@fsharpCode,fsyaccActionNested keepend
syn region fsyaccActionNested
      \ start="{" end="}" contained transparent
      \ contains=@fsharpCode,fsyaccActionNested

" Tokens are UPPERCASE identifiers in the rules section.
syn match fsyaccToken "\<[A-Z][A-Z0-9_]*\>"

" Rule punctuation.
syn match fsyaccPunct "[:;|]"

highlight link fsyaccDirective    Keyword
highlight link fsyaccSeparator    PreProc
highlight link fsyaccDelim        Delimiter
highlight link fsyaccToken        Constant
highlight link fsyaccPunct        Operator
highlight link fsyaccLineComment  Comment
highlight link fsyaccBlockComment Comment

let b:current_syntax = "fsyacc"
