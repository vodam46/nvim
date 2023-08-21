local lazypath = vim.fn.stdpath'data' .. '/lazy/lazy.nvim'
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
	{
		'ellisonleao/gruvbox.nvim', config=function()
			vim.o.termguicolors=true
			vim.cmd.colorscheme'gruvbox'
		end
	},
	{import = 'plugins.lualine'},
	'kyazdani42/nvim-web-devicons',
	'tpope/vim-fugitive',
	{'nvim-treesitter/nvim-treesitter', build=':TSUpdate' },
	{
		'masukomi/vim-markdown-folding',
		ft='md',
		init=function()
			vim.cmd'set foldexpr=NestedMarkdownFolds()'
		end
	},
	'anuvyklack/pretty-fold.nvim',
	{import = 'plugins.firenvim'},
	'chikamichi/mediawiki.vim',
	'nvim-lua/plenary.nvim',
	'junegunn/fzf',
	'junegunn/fzf.vim',
	{import = 'plugins.telescope'},
	-- 	'serenevoid/kiwi.nvim',
	{import = 'plugins.vimwiki'},
	{
		'folke/zen-mode.nvim',
		config=function()
			vim.keymap.set('n', '<C-G>', function() require'zen-mode'.toggle{window={width=90}} end)
		end
	},
	{import = 'plugins.lsp'},
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
			vim.keymap.set({'n', 'o', 'x'}, 'w', function() require'spider'.motion'w' end, { desc = 'Spider-w' })
			vim.keymap.set({'n', 'o', 'x'}, 'e', function() require'spider'.motion'e' end, { desc = 'Spider-e' })
			vim.keymap.set({'n', 'o', 'x'}, 'b', function() require'spider'.motion'b' end, { desc = 'Spider-b' })
			vim.keymap.set({'n', 'o', 'x'}, 'ge',function() require'spider'.motion'ge'end, { desc = 'Spider-ge' })
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
				direction = 'float',
			}
		end,
		keys='<C-T>'
	},
	{
		'stevearc/dressing.nvim',
		opts = {},
	},
	{import = 'plugins.mini'},
}
