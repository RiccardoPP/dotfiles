" Riccardo Palombo - https://riccardo.im
" Preparato per la community Patreon: patreon.com/riccardopalombo

set t_Co=256
set background=dark
syntax enable
colorscheme pencil

set nocompatible
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set wrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set number
set history=1000
set autoread

let g:fzf_layout = { 'down': '~40%' }
let g:pencil#wrapModeDefault = 'soft'
let g:limelight_conceal_ctermfg = 241

nnoremap <silent> <C-f> :Files<CR>
map <F4> :Goyo <bar> :TogglePencil <CR>
" map <F5> :setlocal spell! spelllang=it_IT<CR>
map <F6> :NERDTreeToggle<CR>

" nnoremap <Space> za

" Fix per uscire con :q dopo :Goyo

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd User GoyoEnter call <SID>goyo_enter()
autocmd User GoyoLeave call <SID>goyo_leave()
