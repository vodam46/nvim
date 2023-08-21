vim.keymap.set('n', '<leader>tt', ':!todo \'\'<Left>', { noremap=true, desc='add to gloal todo' })
vim.keymap.set('n', '<leader>te', ':tabe ~/todo<cr>', { noremap=true, desc='edit global todo' })
vim.keymap.set('n', '<leader>tll', ':!lodo \'\'<Left>', { noremap=true, desc='add to local todo' })
vim.keymap.set('n', '<leader>tle', ':tabe todo<cr>', { noremap=true, desc='edit local todo'})

vim.keymap.set('n', '<leader>c', ':echo \'lines, words, chars\'|%w !wc <cr>', { noremap=true, silent=true, desc='count'})
vim.keymap.set('v', '<leader>c', ':\'<,\'>w !wc <cr>', { noremap=true, silent=true, desc='visual count'})

-- vim.keymap.set('n', '<leader>R', ':source $MYVIMRC<cr>', { noremap=true, silent=true})
vim.keymap.set('n', '<leader>E', ':tabedit $MYVIMRC<cr>:cd $XDG_CONFIG_HOME/nvim/<cr>', { noremap=true, silent=true, desc='open config'})

function Trans(args)
	vim.cmd('!trans -no-ansi ' .. args.args)
end
vim.api.nvim_create_user_command('Trans', Trans, { nargs='?' })
