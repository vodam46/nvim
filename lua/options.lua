vim.g.mapleader=' '

vim.o.guifont='JetBrains Mono:h14,Noto Color Emoji:h10'

vim.cmd.syntax'keyword Todo Note: NOTE Note note Notes note: NOTE: Notes:'
-- vim.cmd.highlight'Normal ctermbg=NONE guibg=NONE'

vim.o.relativenumber=true
vim.o.number=true
vim.o.colorcolumn='80'
vim.o.textwidth=79

vim.o.autoindent=true
vim.o.smartindent=true
vim.o.breakindent=true

vim.o.foldmethod='indent'
vim.o.foldcolumn='2'
vim.o.foldenable=false

vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.expandtab=false
-- vim.api.nvim_create_autocmd( { 'BufEnter', 'BufWinEnter' }, {
-- 	command='set noexpandtab'
-- })

vim.o.splitright=true
vim.o.splitbelow=true

vim.o.cursorline=true
-- vim.o.cursorcolumn=true

vim.o.incsearch=true
vim.o.hlsearch=true
vim.cmd.nohls()
vim.keymap.set('n', '<esc>', ':nohls<cr>', { noremap=true, silent=true })

vim.o.ignorecase=true
vim.o.smartcase=true

vim.o.showcmd=true
vim.o.showmode=false
vim.o.laststatus=3

vim.o.wildmode='list:longest,lastused'

vim.o.swapfile=false
vim.o.backup=false
vim.o.undofile=true
