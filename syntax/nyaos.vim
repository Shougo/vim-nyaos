"=============================================================================
" FILE: syntax/nyaos.vim
" AUTHOR: Shougo Matsushita <Shougo.Matsu@gmail.com>
" Last Modified: 23 Oct 2011.
" Usage: Just source this file.
" License: MIT license  {{{
"     Permission is hereby granted, free of charge, to any person obtaining
"     a copy of this software and associated documentation files (the
"     "Software"), to deal in the Software without restriction, including
"     without limitation the rights to use, copy, modify, merge, publish,
"     distribute, sublicense, and/or sell copies of the Software, and to
"     permit persons to whom the Software is furnished to do so, subject to
"     the following conditions:
"
"     The above copyright notice and this permission notice shall be included
"     in all copies or substantial portions of the Software.
"
"     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
"     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
"     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
"     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
"     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
"     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
"     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
" }}}
"=============================================================================

if version < 700
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

syn match   nyaosCommand               '\%(^\|[;|]\)\s*\zs[[:alnum:]_.][[:alnum:]_.-]\+' contained
syn match   nyaosVariable          '$\h\w*\|%\h\w*\%(\.\h\w*\)*%'
syn region   nyaosVariable  start=+${+ end=+}+
syn region   nyaosString   start=+'+ end=+'+ oneline contained
syn region   nyaosString   start=+"+ end=+"+ contains=nyaosQuoted oneline contained
syn region   nyaosString   start=+`+ end=+`+ oneline contained
syn match   nyaosString   '[''"`]$' contained
syn match   nyaosComment   '#.*$' contained
syn match   nyaosConstants         '[+-]\=\<\d\+\>' contained
syn match   nyaosConstants         '[+-]\=\<0x\x\+\>' contained
syn match   nyaosConstants         '[+-]\=\<0\o\+\>' contained
syn match   nyaosConstants         '[+-]\=\d\+#[-+]\=\w\+\>' contained
syn match   nyaosConstants         '[+-]\=\d\+\.\d\+\([eE][+-]\?\d\+\)\?\>' contained
syn match   nyaosArguments         '\s-\=-[[:alnum:]-]\+=\=' contained
syn match   nyaosQuoted            '\\.' contained
syn match   nyaosSpecial           '[|<>;&;]' contained
if has('win32') || has('win64')
    syn match   nyaosArguments         '\s/[?:,_[:alnum:]]\+\ze\%(\s\|$\)' contained
    syn match   nyaosDirectory         '\%(\f\s\?\)\+[/\\]\ze\%(\s\|$\)'
else
    syn match   nyaosDirectory         '\%(\f\s\?\)\+/\ze\%(\s\|$\)'
endif

syntax keyword nyaosKeyword
      \ alias bindkey cd dirs eval folder foreach end history if else endif ls
      \ lua_e open option popd pushd pwd set source suffix
      \ unalias unsuffix unoption

syntax keyword nyaosOption
      \ backquote bracexp dots glob ls_colors lnkexp mineditwidth nullcomplete
      \ nyatype history histfilesize prompt savehist term_clear term_cursor_on
      \ tilde uncompletechar width

syntax keyword nyaosSpecialDirectory
      \ desktop sendto startmenu startup mydocuments favorites
      \ programs program_files appdata
      \ allusersdesktop allusersprograms allusersstartmenu allusersstartup

unlet! b:current_syntax
syn include @nyaosLuaScript syntax/lua.vim
syn region nyaosLuaScriptRegion start=-\<lua_e\s\+\z(["']\)\zs$- end=+\z1\zs$+ contains=@nyaosLuaScript
syn cluster nyaosBodyList contains=nyaosLuaScriptRegion

syn region   nyaosScriptRegion start='\zs\<\f\+' end='\zs$'
      \ contains=nyaosCommand,nyaosVariable,nyaosString,nyaosComment,nyaosConstants,nyaosArguments,nyaosQuoted,nyaosSpecial,nyaosDirectory
syn region   nyaosCommentRegion  start='#' end='\zs$'
syn cluster  nyaosBodyList add=nyaosScriptRegion,nyaosComment

hi def link nyaosQuoted Special
hi def link nyaosString Constant
hi def link nyaosArguments Type
hi def link nyaosConstants Constant
hi def link nyaosSpecial PreProc
hi def link nyaosVariable Identifier
hi def link nyaosComment Comment
hi def link nyaosCommentRegion Comment
hi def link nyaosNormal Normal

hi def link nyaosCommand Statement
hi def link nyaosKeyword Statement
hi def link nyaosOption Type
hi def link nyaosDirectory Preproc
hi def link nyaosSpecialDirectory Preproc

let b:current_syntax = 'nyaos'
