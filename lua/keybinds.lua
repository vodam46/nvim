vim.keymap.set('n', '<leader>tt', ':!todo \'\'<Left>', { noremap=true, desc='add to gloal todo' })
vim.keymap.set('n', '<leader>te', ':tabe ~/todo<cr>', { noremap=true, desc='edit global todo' })
vim.keymap.set('n', '<leader>tll', ':!lodo \'\'<Left>', { noremap=true, desc='add to local todo' })
vim.keymap.set('n', '<leader>tle', ':tabe todo<cr>', { noremap=true, desc='edit local todo'})

vim.keymap.set('n', '<leader>wc', ':echo \'lines, words, chars\'|%w !wc <cr>', { noremap=true, silent=true, desc='count'})
vim.keymap.set('v', '<leader>wc', ':\'<,\'>w !wc <cr>', { noremap=true, silent=true, desc='visual count'})

vim.keymap.set('n', '<leader>c', ':', { noremap=true, desc='start command'})

-- vim.keymap.set('n', '<leader>R', ':source $MYVIMRC<cr>', { noremap=true, silent=true})
-- vim.keymap.set('n', '<leader>E', ':tabedit $MYVIMRC<cr>:cd $XDG_CONFIG_HOME/nvim/<cr>', { noremap=true, silent=true, desc='open config'})

vim.cmd.cnoreabbrev'wqa wa|qa'

function Trans(args)
	vim.cmd('!trans -no-ansi ' .. args.args)
end
vim.api.nvim_create_user_command('Trans', Trans, { nargs='?' })

local function Colorscheme(offset)
	local colors = vim.fn.getcompletion('', 'color')
	for i,v in ipairs(colors) do
		if v == vim.g.colors_name then
			if i == table.maxn(colors) then i = 1 else i = i + offset end
			vim.cmd('colorscheme ' .. colors[i])
			return 1
		end
	end
	return 0
end
math.randomseed(os.time())
local function RandomColorscheme()
	local colors = vim.fn.getcompletion('', 'color')
	vim.cmd('colorscheme ' .. colors[math.random(table.maxn(colors))])
	vim.notify('changed to '..vim.g.colors_name)
end
local function NextColorscheme() if Colorscheme(1) then vim.notify('changed to '..vim.g.colors_name) else vim.notify('Error') end end
local function PrevColorscheme() if Colorscheme(-1) then vim.notify('changed to '..vim.g.colors_name) else vim.notify('Error') end end
vim.api.nvim_create_user_command('NextColorscheme', NextColorscheme, {})
vim.keymap.set('n', '<leader>Cn', NextColorscheme, {desc='NextColorscheme'})
vim.api.nvim_create_user_command('PrevColorscheme', PrevColorscheme, {})
vim.keymap.set('n', '<leader>Cp', PrevColorscheme, {desc='PrevColorscheme'})
vim.keymap.set('n', '<leader>Cr', RandomColorscheme, {desc='RandomColorscheme'})
vim.api.nvim_create_user_command('RandomColorscheme', RandomColorscheme, {})
