"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: MZhou <zmmbreeze0825 at gmail.com>
" Last Change: 2014-08-15 00:01:24
"
" Sections:
"    -> Plugins
"
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Command mode related
"    -> Moving around, tabs and buffers
"    -> Statusline
"    -> Parenthesis/bracket expanding
"    -> General Abbrevs
"    -> Editing mappings
"    -> Session
"
"    -> emmet
"    -> Tabular
"    -> NERDTree
"    -> neocomplcache
"    -> vim-airline
"
"  Revisions:
"     > 0.1: release :)
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mattn/emmet-vim'
Plugin 'chriskempson/base16-vim'
Plugin 'scrooloose/NERDTree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'rking/ag.vim'
Plugin 'taiansu/nerdtree-ag'
Plugin 'godlygeek/tabular'
Plugin 'ap/vim-css-color'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/yajs.vim'
Plugin 'mxw/vim-jsx'
Plugin 'groenewege/vim-less'
Plugin 'wavded/vim-stylus'
Plugin 'digitaltoad/vim-jade'
Plugin 'juvenn/mustache.vim'
Plugin 'marijnh/tern_for_vim'
"Plugin 'majutsushi/tagbar'
Plugin 'Shougo/neocomplcache.vim'
Plugin 'Bling/vim-airline'
Plugin 'kristijanhusak/vim-hybrid-material'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/syntastic'



" All of your Plugins must be added before the following line
call vundle#end()            " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd! bufwritepost vimrc source ~/.vimrc

" Platform
function! MySys()
    if has("win32") || has("win64")
        return "windows"
    elseif has("mac")
        return "mac"
    else
        return "linux"
    endif
endfunction


"自动切换路径为当前窗口的路径
set autochdir

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the curors - when moving vertical..
set so=7

set wildmenu "Turn on WiLd menu

set ruler "Always show current position

set cmdheight=2 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system
if MySys() == "mac"
  set gfn=Source\ Code\ Pro\ for\ Powerline:h16
  set linespace=2
  set shell=/bin/bash
elseif MySys() == "windows"
  set gfn=Bitstream\ Vera\ Sans\ Mono:h10
elseif MySys() == "linux"
  set gfn=Source\ Code\ Pro\ for\ Powerline\ 13
  set shell=/bin/bash
endif

if has("gui_running")
  set guioptions-=T
  set guioptions-=m
  set t_Co=256
  if MySys() == "mac"
    set transparency=8
  endif
  set nonu
  " colorscheme base16-default
  colorscheme hybrid_material
else
  syntax on
  set nonu
  colorscheme nazca
endif



syntax enable
set background=dark

set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

" 去掉背景的设置
hi Normal ctermbg=NONE


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set number

"设置当前行和列高亮
:se cursorline
:se cursorcolumn

"设置页面的tab为4个空格和行尾空格可见
set list
set listchars=tab:>\ ,trail:_

set lbr
set tw=80
autocmd FileType html set tw=100000

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

nmap <tab> 		v>
nmap <s-tab> 	v<
vmap <tab> 		>gv
vmap <s-tab> 	<gv
map <leader>t. :tabnext<cr>
map <leader>t, :tabprevious<cr>


"tab setting
if has("gui_running")
	nmap <c-tab> :tabnext<CR>
endif


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" $q is super useful when browsing on the command line
cno $q <C-\>eDeleteTillSlash()<cr>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>

" Useful on some European keyboards
map ½ $
imap ½ $
vmap ½ $
cmap ½ $


func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><cr> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>

" Tab configuration
map <leader>tn :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>


command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    else
        return ''
    endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%Y/%m/%d %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
    " cmd to ctrl
    map <D-y> <C-y>
    map <D-e> <C-e>
    map <D-f> <C-f>
    map <D-b> <C-b>
    map <D-u> <C-u>
    map <D-d> <C-d>
    map <D-w> <C-w>
    map <D-r> <C-r>
    map <D-o> <C-o>
    map <D-i> <C-i>
    map <D-g> <C-g>
    map <D-a> <C-a>
    map <D-]> <C-]>
    cmap <D-d> <C-d>
    imap <D-e> <C-e>
    imap <D-y> <C-y>
endif



"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

set guitablabel=%t


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Session
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Session Save/Restore
function! GetProjectName()
    " Get the current editing file list, Unix only
    let edit_files = split(system("ps -o command= -p " . getpid()))
    if len(edit_files) >= 2
        let project_path = edit_files[1]
        if project_path[0] != '/'
            let project_path = getcwd() . project_path
        endif
    else
        let project_path = getcwd()
    endif

    return shellescape(substitute(project_path, '[/]', '', 'g'))
endfunction

function! SaveSession()
    "NERDTree doesn't support session, so close before saving
    execute ':NERDTreeClose'
    let project_name = GetProjectName()
    execute 'mksession! ~/.vim/sessions/' . project_name
endfunction

function! RestoreSession()
    let session_path = expand('~/.vim/sessions/' . GetProjectName())
    if filereadable(session_path)
        execute 'so ' . session_path
        if bufexists(1)
            for l in range(1, bufnr('$'))
                if bufwinnr(l) == -1
                    exec 'sbuffer ' . l
                endif
            endfor
        endif
    endif
    "Make sure the syntax is on
    syntax on
endfunction

" Persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => emmet
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:user_emmet_settings = {
\  'php' : {
\    'extends' : 'html',
\    'filters' : 'c',
\  },
\  'xml' : {
\    'extends' : 'html',
\  },
\  'haml' : {
\    'extends' : 'html',
\  },
\}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabular
" http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists(":Tabularize")
  nmap <Leader>== :Tabularize /=<CR>
  vmap <Leader>== :Tabularize /=<CR>
  nmap <Leader>=: :Tabularize /:\zs<CR>
  vmap <Leader>=: :Tabularize /:\zs<CR>
  nmap <Leader>=/ :Tabularize /\/\/<CR>
  vmap <Leader>=/ :Tabularize /\/\/<CR>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>nt :NERDTree<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplcache
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplcache_enable_at_startup = 1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nmap <F8> :TagbarToggle<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
  let g:airline_powerline_fonts=1
else
  let g:airline_left_sep=''
  let g:airline_right_sep=''
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrip.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
if MySys() == "mac"
  map <D-p> <C-p>
endif
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove trailing whitespace in vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre * :%s/\s\+$//e


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_javascript_checkers = ['eslint']
