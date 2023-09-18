local lazypath=vim.fn.stdpath'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
require'lazy'.setup{
	'kyazdani42/nvim-web-devicons',
	'tpope/vim-fugitive',
	{'nvim-treesitter/nvim-treesitter', build=':TSUpdate' },
	'anuvyklack/pretty-fold.nvim',
	'chikamichi/mediawiki.vim',
	'nvim-lua/plenary.nvim',
	'junegunn/fzf',
	'junegunn/fzf.vim',
	-- 	'serenevoid/kiwi.nvim',
	-- 	'hrsh7th/nvim-cmp',
	{
		'kevinhwang91/rnvimr',
		init=function()
			vim.keymap.set('n', '<leader>r', ':RnvimrToggle<cr>', {noremap=true, silent=true, desc='ranger'})
			vim.g.rnvimr_enable_ex=1
			vim.g.rnvimr_enable_picker=1
		end
	},
	{
		'HiPhish/info.vim',
		ft='info',
		config=function()
			vim.keymap.set('n', 'gu', ':InfoUp<cr>', { noremap=true, silent=true})
			vim.keymap.set('n', 'gn', ':InfoNext<cr>', { noremap=true, silent=true})
			vim.keymap.set('n', 'gp', ':InfoPrev<cr>', { noremap=true, silent=true})
			vim.keymap.set('n', 'gm', ':Menu<cr>', { noremap=true, silent=true})
			vim.keymap.set('n', 'gf', ':Follow<cr>', { noremap=true, silent=true})
			vim.keymap.set('n', 'gO', ':Menu<cr>', { noremap=true, silent=true})
		end,
		cmd='Info'
	},
	{
		'chrisgrieser/nvim-spider',
		config=function()
			require'spider'.setup{skipInsignificantPunctuation=true}
		end,
		init=function()
			vim.keymap.set({'n', 'o', 'x'}, 'w', function() require'spider'.motion'w' end, { desc='Spider-w' })
			vim.keymap.set({'n', 'o', 'x'}, 'e', function() require'spider'.motion'e' end, { desc='Spider-e' })
			vim.keymap.set({'n', 'o', 'x'}, 'b', function() require'spider'.motion'b' end, { desc='Spider-b' })
			vim.keymap.set({'n', 'o', 'x'}, 'ge',function() require'spider'.motion'ge'end, { desc='Spider-ge' })
		end
	},
	'danilamihailov/vim-tips-wiki',
	{
		'akinsho/toggleterm.nvim',
		config=function()
			require'toggleterm'.setup{
				on_open=function()
					vim.cmd'startinsert!'
				end,
				autochdir=true,
				start_in_insert=true,
				persist_mode=true,
				open_mapping='<C-t>',
				direction='float',
			}
		end,
		keys='<C-T>'
	},
	'stevearc/dressing.nvim',
	{
		'rcarriga/nvim-notify',
		init=function()
			vim.notify=require'notify'
			vim.keymap.set('n', '<leader>n', require'notify'.dismiss, {desc='dismiss notifications'})
		end
	},
	{
		'junegunn/limelight.vim',
		config=function()
		end
	},
	{
		'preservim/vim-markdown',
		dependencies={'godlygeek/tabular'}
	},
	{
		'williamboman/mason.nvim',
		init=function()
			require'mason'.setup{}
		end
	},
	{
		'https://github.com/sQVe/sort.nvim',
	},
	{ import='plugins.tmux' },
	{ import='plugins.lsp'},
	{ import='plugins.colorscheme' },
	{ import='plugins.lualine' },
	{ import='plugins.firenvim' },
	{ import='plugins.telescope' },
	{ import='plugins.mini' },
	{ import='plugins.zen' },
	{ import='plugins.wiki' },
	-- { import='plugins.dap' },
}

local diary = require'plugins.diary'
diary.setup{
	path='~/writing/diary',
	file_extension='md',
	template_path='~/writing/diary/template.md',
}
vim.keymap.set('n', '<leader>w<leader>w', diary.open_diary_new, {desc='Open diary for today'})
vim.keymap.set('n', '<leader>w<leader>t', function() vim.cmd.tabnew() diary.open_diary_new() end, {desc='Open diary in new tab'})
vim.keymap.set('n', '<leader>w<leader>i', diary.open_diary_index, {desc='Open diary index'})
