"  Filetype
set nocompatible             " off compatibility with vi
filetype plugin indent on    " required
syntax enable                " required

" configure vundle https://github.com/gmarik/Vundle.vim
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'nemausus/vim-copyright'
Plugin 'nemausus/vim-cscope'
Plugin 'nemausus/vim-headerguard'
Plugin 'rhysd/vim-clang-format'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'

" All of your Plugins must be added before the following line
call vundle#end()

" configure ycm plugin
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_complete_in_comments = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_seed_identifiers_with_syntax = 1

" configure ctrlp plugin
let g:ctrlp_map = '<C-f>'
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_match_window = 'max:10,results:10'
let g:ctrlp_root_markers = ['pom.xml']
let g:ctrlp_user_command = 'cd %s && git ls-files -oc --exclude-standard | grep -vE ".(json|go|res|html|txt|prt)$"' 

" configure clang format plugin
let g:clang_format#command = 
  \ '/usr/local/scaligent/toolchain/crosstool/v2/clang/3.4/bin/clang-format'
set makeprg=scons

" configure solarized plugin
set background=dark
colorscheme solarized

" Indent style; override these explicitly to turn them off.
set shiftwidth=2    " two spaces per indent
set tabstop=2       " number of spaces per tab in display
set softtabstop=2   " number of spaces per tab when inserting
set expandtab       " substitute spaces for tabs
set autoindent      " carry indent over to new lines
autocmd Filetype java setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype javascript setlocal tabstop=4 shiftwidth=4 softtabstop=4

" better tab completion of file names
set wildmode=longest,list,full
set wildmenu

" Display.
set equalalways     " make sure that windows always remain equal in size.
set ruler           " show cursor position
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline
set cursorline      " underline current line
set number          " show line numbers
set nolist          " hide tabs and EOL chars
set showcmd         " show normal mode commands as they are entered
set showmode        " show editing mode in status (-- INSERT --)
set showmatch       " flash matching delimiters
set noerrorbells    " no bells in terminal
set showtabline=2
set laststatus=2    " always show status line
set colorcolumn=81,82  " mark column width to 80
autocmd Filetype java set colorcolumn=101,102

" Search.
set hlsearch        " don't persist search highlighting
set incsearch       " search with typeahead
set ignorecase      " case insensitive search
set smartcase
set tags=tags;/     " search up the directory tree for tags

" visual bell
set visualbell

" disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Increase limits
set undolevels=10000   " number of undos stored
set undodir=~/.vimundo
set undofile
" '=Maximum number of previously edited files for which the marks are remembered.
" "=Maximum number of lines saved for each register.
set viminfo='50,"50
set history=200       " save command history upto 200

" Other.
set backspace=indent,eol,start " backspace over everything
set modelines=0                " modelines are bad for your health
set splitright                 " open file to right in split view
set wildmode=list:full         " bash like tab completion in command mode
set path+=**                   " find file recursively
set scrolloff=999              " better scrolling
set clipboard=unnamed          " work with system clipboard
set mouse=a                    " set mouse scroll

" Define custom mappings with , as leader.
let mapleader = ","
nnoremap <leader>, ,
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <leader>a :e %:r.hpp<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
map      <leader>c :normal 0i//<CR>
nnoremap <leader>e :e %:h<CR>
nnoremap <leader>f :CtrlP 
nnoremap <leader>g mG :Ggrep <C-r><C-w> 
nnoremap <leader>h <C-w><C-h>
nnoremap <leader>j <C-w><C-j>
nnoremap <leader>k <C-w><C-k>
nnoremap <leader>l <C-w><C-l>
nnoremap <leader>n :NERDTreeFind<CR>
nnoremap <leader>p <C-w>}
nnoremap <leader>s :e %:r.cpp<CR>
nnoremap <leader>t :TagbarToggle<CR>
map      <leader>u :s/^\s*\/\///<CR>
nnoremap <leader>v :vs %:h<CR>
nnoremap <leader>w <C-w>W
map      <leader>z va}zf

" Overriding few default mappings.
" Enable filtering in command mode when going through history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
nnoremap <C-h> :tabp<CR>
nnoremap <C-l> :tabn<CR>
" Enable clang format
map <C-K> :ClangFormat<CR>
imap <C-K> <ESC>:ClangFormat<CR>i

" search for visual selection using * and #
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Autorefresh
set autoread
" Check for changes and autoload them after 2 seconds of inactivity.
au CursorHold * checktime 
" reload when entering the buffer or gaining focus
au FocusGained,BufEnter * :silent! !
"save when exiting the buffer or losing focus
au FocusLost,WinLeave * :silent! w

" Kill any trailing whitespace on save.
fu! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfu
autocmd FileType c,cc,cpp,h,hpp,haskell,javascript,php,python,ruby,thrift,proto
  \ autocmd BufWritePre <buffer>
  \ :call <SID>StripTrailingWhitespaces()

" show output of cmd in new tab
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    " use "new/vnew" instead of "tabnew" below if you prefer
    " split windows instead of tabs
    vnew
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)

"grep current file and open results in new tab.
command! -nargs=1 Filter execute 'tabnew /tmp/filter.log|%d|0r!grep <args> -sh #'

" Jump to address
function! GoToAddress()
  let addr=matchstr(getline("."), '0x\x\+')
  let outfile=bufname("%")
  let binary=strpart(outfile, 0, strlen(outfile) - 7)
  let line=system("addr2line -e ".binary." ".addr)
  let file=split(split(line)[0], ":")
  silent execute ':e +'.file[1]." ".file[0]
  echom line
endfunction
nmap <leader>gf :call GoToAddress()<CR>

command! -nargs=1 -complete=file Sdbg execute 'make -j20 mode=dbg <args> 2>&1 \| sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'

" Populate args from quickfix list
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" Enable syntax highlighting for scons files.
autocmd BufReadPre SConstruct set filetype=python
autocmd BufReadPre SConscript set filetype=python
" Enalble sytax highlighting for log files
autocmd BufReadPre *.INFO set filetype=glog
autocmd BufReadPre *.log set filetype=glog
" Enable syntax highlighting for proto files
autocmd BufReadPre *.proto set filetype=proto
" Enable syntax highlighting for thift files
autocmd BufReadPre *.thrift set filetype=cpp

