" Vim syntax file for FsLex (.fsl) lexer files.
" Embeds F# syntax inside the header and { ... } action blocks.

if exists("b:current_syntax")
  finish
endif

syn include @fsharpCode syntax/fsharp.vim
unlet! b:current_syntax

" Top-level comments (outside { ... } blocks).
syn match  fslexLineComment  "//.*$"
syn region fslexBlockComment start="(\*" end="\*)" contains=fslexBlockComment

" Lexer-rule keywords.
syn keyword fslexKeyword rule parse and let eof

" Pattern literals at the top level.
syn region fslexString start=+"+ skip=+\\.+ end=+"+ oneline
syn match  fslexChar   "'\(\\.\|[^']\)'"

" F# code blocks: { ... } with nested-brace support (header & actions).
syn region fslexAction matchgroup=fslexDelim
      \ start="{" end="}" contains=@fsharpCode,fslexActionNested keepend
syn region fslexActionNested
      \ start="{" end="}" contained transparent
      \ contains=@fsharpCode,fslexActionNested

" Pattern punctuation.
syn match fslexPunct "[|=]"

highlight link fslexKeyword      Keyword
highlight link fslexDelim        Delimiter
highlight link fslexString       String
highlight link fslexChar         Character
highlight link fslexPunct        Operator
highlight link fslexLineComment  Comment
highlight link fslexBlockComment Comment

let b:current_syntax = "fslex"
