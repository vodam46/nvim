return {
	'echasnovski/mini.nvim',
	init=function()
		local animate = require'mini.animate'
		animate.setup({
			cursor = {
				timing = animate.gen_timing.exponential{duration=200,unit='total'}
			},
			scroll = {
				timing = animate.gen_timing.exponential{duration=200,unit='total'}
			}
		})
		vim.g.minianimate_disable=false
		vim.keymap.set('n', '<leader>ma', function()
			vim.g.minianimate_disable=not vim.g.minianimate_disable
		end, {noremap=true, silent=true, desc='animation'})

		require'mini.basics'.setup{
			mappings={
				option_toggle_prefix='<leader>mt',
				windows=true,
				move_with_alt=true
			},
		}

		require'mini.comment'.setup{
			options = {
				ignore_blank_line = true,
				custom_commentstring = function() return vim.bo.commentstring end,
			}
		}
		vim.api.nvim_create_autocmd({'BufEnter', 'BufWinEnter'}, {
			pattern={'*.c', '*.h', '*.hpp', '*.cpp'},
			command = "setlocal commentstring=//%s"
		})

		require'mini.completion'.setup{}

		require'mini.indentscope'.setup{symbol='│'}

		require'mini.jump'.setup{}

		require'mini.jump2d'.setup{
			view={
				dim=true,
				n_steps_ahead=3
			},
			allowed_windows={not_current=false},
			mappings={start_jumping='<leader>f'}
		}

		local miniclue = require'mini.clue'
		miniclue.setup{
			triggers = {
				-- Leader triggers
				{ mode = 'n', keys = '<Leader>' },
				{ mode = 'x', keys = '<Leader>' },
				{ mode = 'v', keys = '<Leader>' },
				-- Built-in completion
				{ mode = 'i', keys = '<C-x>' },
				-- `g` key
				{ mode = 'n', keys = 'g' },
				{ mode = 'x', keys = 'g' },
				-- Marks
				{ mode = 'n', keys = "'" },
				{ mode = 'n', keys = '`' },
				{ mode = 'x', keys = "'" },
				{ mode = 'x', keys = '`' },
				-- Registers
				{ mode = 'n', keys = '"' },
				{ mode = 'x', keys = '"' },
				{ mode = 'i', keys = '<C-r>' },
				{ mode = 'c', keys = '<C-r>' },
				-- Window commands
				{ mode = 'n', keys = '<C-w>' },
				-- `z` key
				{ mode = 'n', keys = 'z' },
				{ mode = 'x', keys = 'z' },
				-- { mode = 'n', keys = 's' },
			},
			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
				{ mode = 'n', keys = '<leader>l', desc = 'LSP'},
				{ mode = 'n', keys = '<leader>m', desc = 'mini.nvim'},
				{ mode = 'n', keys = '<leader>T', desc = 'Telescope'},
				{ mode = 'n', keys = '<leader>t', desc = 'todo files and tmux'},
				{ mode = 'n', keys = '<leader>tl',desc = 'local todo files'},
				{ mode = 'n', keys = '<leader>w', desc = 'writing'},
				{ mode = 'n', keys = '<leader>w<leader>', desc = 'diary'},
				{ mode = 'n', keys = '<leader>mt',desc = 'toggle options'},
				{ mode = 'n', keys = '<leader>C', desc = 'colorschemes'},
			},
			window = {
				config = {
					width = 'auto'
				}
			}
		}

		local starter = require'mini.starter'
		starter.setup{
			header=vim.fn.system'fortune -n 160',
			items={
				starter.sections.builtin_actions(),
				{ name = 'telescope', action = require'telescope.builtin'.builtin, section = 'Telescope' },
				{ name = 'files', action = require'telescope.builtin'.find_files, section = 'Telescope' },
				{ name = 'projects', action = require'telescope'.extensions.project.project, section = 'Telescope' },
				{ name = 'recent files', action = require'telescope.builtin'.oldfiles, section = 'Telescope' },
				{ name = 'browser', action = 'RnvimrToggle', section = 'Other' },
				{ name = 'config', action = function() vim.cmd.cd'$XDG_CONFIG_HOME/nvim' vim.cmd.edit'init.lua' end, section = 'Other'},
			},
			query_updaters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-.',
			footer='That\'s all folks!'
		}

		require'mini.move'.setup{
			mappings={
				left='H',
				right='L',
				down='J',
				up='K'
			}
		}

		require'mini.pairs'.setup{}
		vim.api.nvim_create_autocmd({'FileType'}, {
			pattern='lisp',
			callback=function()
				MiniPairs.unmap('i', '\'', '\'\'')
			end
		})

		require'mini.splitjoin'.setup{}

		require'mini.surround'.setup{}

		require'mini.trailspace'.setup{}

	end
}
