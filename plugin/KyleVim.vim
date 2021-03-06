
let g:kyle_vim_version = "0.0.0"

" Make sure this plugin is runnable
if !has("python3")
	echo "Vim must be compiled with +python3 to use KyleVim"
	finish
endif

if exists('g:KyleVim_plugin_loaded')
	finish
endif

if !exists('g:KyleVim_Disable_Colours')
	" Set colourscheme
	colorscheme codedark
	
	set hlsearch
        hi Search ctermbg=LightGray
        hi Search ctermfg=Red

        " Make double-<Esc> clear search highlights
        nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

endif


if !exists('g:KyleVim_Disable_Statusline')
	" Set statusline colours
	hi User1 ctermfg=75 ctermbg=NONE
	hi User2 ctermfg=9 ctermbg=NONE
	hi User3 ctermfg=65 ctermbg=NONE
	hi User4 ctermfg=65 ctermbg=NONE
	hi User5 ctermfg=226 ctermbg=NONE

	" Customize statusline
	set statusline=
	set statusline +=%1*%y%*                "file type
	set statusline +=%4*\ %<%F%*            "full path
	set statusline +=%2*%m%*                "modified flag
	set statusline +=%1*%=%5l%*             "current line
	set statusline +=%2*/%L%*               "total lines
	set statusline +=%1*%4v\ %*             "virtual column number
	set statusline +=%5*\ %(<%{b:gitstatus}>%)

	" Always display the status line
	 set laststatus=2
endif


if !exists('g:KyleVim_Disable_Tabs')
	
	" Control tabs with CTRL-left or right arrow  alt-arrow moves the tab
	nnoremap <C-Left> :tabprevious<CR>
	nnoremap <C-Right> :tabnext<CR>
	nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
	nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

endif

" Pressing <F3> will search the current folder for TODO statements
if !exists('g:KyleVim_Disable_TODO')
	imap <F3> <Esc>:grep -r --exclude=*~ TODO * <CR> :copen <CR>
	map <F3> :grep -r --exclude=*~ TODO * <CR> :copen <CR>
endif

" Double tapping semicolon will search the current file for {% %} and allow
" you to replace them
if !exists('g:KyleVim_Disable_Colon_Replace')
	inoremap ;; <esc>/{%[^%]*%}<cr>v/%}<cr><right>c
endif

" Enable fuzzy search using SHIFT-F

if !exists('g:KyleVim_Disable_Fuzzy_Search')
	set wildmenu
	nnoremap <S-F> :tabe **/*

	" Fuzzy search ignore
	set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
	set wildignore+=*.pdf,*.psd
	set wildignore+=*.log,*.aux,*.pdf
endif

"----------------------------------------------------------------
" Auto close matching characters
" ---------------------------------------------------------------

if !exists('g:KyleVim_Disable_Auto_Brackets')
	inoremap {      {}<Left>
	inoremap {<CR>  {<CR>}<Esc>O
	inoremap {{     {
	inoremap {}     {}

	inoremap (      ()<Left>
	inoremap (<CR>  (<CR>)<Esc>O
	inoremap ((     (
	inoremap ()     ()

	inoremap [      []<Left>
	inoremap [<CR>  [<CR>]<Esc>O
	inoremap [[     [
	inoremap []     []

	inoremap "      ""<Left>
	inoremap "<CR>  "<CR>"<Esc>O
	inoremap ""     "
endif

" Get the status of the current git repository
function! CurrentGitStatus()
    let gitoutput = split(system('git status --porcelain -b '.shellescape(expand('%')).' 2>/dev/null'),'\n')
    if len(gitoutput) > 0
	let b:gitstatus = strpart(get(gitoutput,0,''),3) . '/' . strpart(get(gitoutput,1,'  '),0,2)
	let b:gitstatus = split(b:gitstatus, '/')

	let b:gitstatus = get(b:gitstatus,1, '') . '/' . get(b:gitstatus,2, '  ')

    else
	let b:gitstatus = ''
    endif
endfunc

autocmd BufEnter,BufWritePost * call CurrentGitStatus()


let s:plugin_root_dir = fnamemodify(resolve(expand('<sfile>p')), ':h')


" Load the python modules
python3 << EOF

import sys
from os.path import normpath, join
import vim

plugin_root_dir = vim.eval('s:plugin_root_dir')
python_root_dir = normpath(join(plugin_root_dir, '..', 'python'))
sys.path.insert(0, python_root_dir)

import KyleVim

EOF


let g:KyleVim_plugin_loaded = 1
