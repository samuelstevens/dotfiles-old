" show line numbers
set number		
" show command in bottom bar
set showcmd		
" highlight the current line
set cursorline		
" highlight search results
set hlsearch		
" show search results as you type
set incsearch   
" enable syntax highlighting
syntax enable		
" new lines respect current indent
set autoindent		

let g:netrw_liststyle = 3	" forces netrw to use tree view
let g:netrw_banner = 0  " removes the help banner at the top of netrw

set tabstop=2		" number of visual spaces per TAB
set softtabstop=2	" number of spaces to insert for a TAB when editing
set expandtab		" causes TAB to be inserted as spaces
set shiftwidth=2 " when indenting with '<', use 2 spaces.


" themes
set background=light
colorscheme solarized

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Disable the default Vim startup message.
set shortmess+=I

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
" set noerrorbells visualbell t_vb=

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" performance issues
set timeoutlen=1000
set ttimeoutlen=50


" === shortcuts ===

" leader
let mapleader = "\\"
let localleader = "\\"

nnoremap o o<esc>
nnoremap O O<esc>

nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" common typos
iabbrev adn and
iabbrev waht what
iabbrev tehn then

" expansions
iabbrev @@ samuel.robert.stevens@gmail.com

" === end shortcuts ====

" === navigation ===

" window splits
set splitbelow
set splitright

" window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" buffer navigation
nnoremap <leader>b :buffers<CR>:buffer<Space>

" === end navigation ===

" === filetypes ===

augroup filetype_javascript
  autocmd!
  
  " comments
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
augroup END

augroup filetype_python
  autocmd!
  
  " comments
  autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>

  " makes python files use 4 spaces
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4   
augroup END

augroup filetype_c
  autocmd!
  
  " makes c files use 4 spaces
  autocmd FileType c setlocal tabstop=4 shiftwidth=4 softtabstop=4 
augroup END

augroup filetype_elm
  autocmd!

  " comments
  autocmd FileType elm nnoremap <buffer> <localleader>c I--<esc>

  " 4 spaces for tabs
  autocmd FileType elm setlocal tabstop=4 shiftwidth=4 softtabstop=4
augroup END
" === end filetypes ===


" === plugins ===

call plug#begin('~/.vim/plugins')

Plug 'easymotion/vim-easymotion'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'psf/black'

call plug#end()

" === end plugins ===


" === language servers (lsp) ===

let g:lsp_signs_enabled = 1
let g:lsp_signature_help_enabled=0 
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 1000

nnoremap gd :LspDefinition<CR> 
nnoremap gr :LspReferences<CR>
nnoremap K :LspHover<CR>
nnoremap [g :LspPreviousDiagnostic<CR>
nnoremap ]g :LspNextDiagnostic<CR>
nnoremap <leader>f :LspDocumentFormat<CR>:write<CR>

" === end language servers ===


" === statusline :) ===

set statusline=%f " path to the file
set statusline+=\ -\  " separator
set statusline+=%y " filetype
set statusline+=%= " switch to right side
set statusline+=line\ %l " current line
set statusline+=\ of\  " separator
set statusline+=%L " total lines

" === end statuslines ===
