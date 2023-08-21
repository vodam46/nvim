return {{
	'nvim-telescope/telescope.nvim',
		config = function()
			local project_actions = require'telescope._extensions.project.actions'
			require'telescope'.setup{
				extensions={
					undo={ diff_context_lines=4 },
					fzf = {
						fuzzy = true,                    -- false will only do exact matching
							override_generic_sorter = true,  -- override the generic sorter
							override_file_sorter = true,     -- override the file sorter
							case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
							-- the default case_mode is 'smart_case'
					},
					project = {
						base_dirs = {
							{'~/code', max_depth = 5},
						},
						hidden_files = true, -- default: false
							theme = 'dropdown',
						order_by = 'asc',
						search_by = 'title',
						sync_with_nvim_tree = true, -- default false
							-- default for on_project_selected = find project files
							on_project_selected = function(prompt_bufnr)
							-- Do anything you want in here. For example:
							project_actions.change_working_directory(prompt_bufnr, false)
							-- require'harpoon.ui'.nav_file(1)
							end
					},
					tabs = {},
					glyph = {
						action = function(glyph)
							vim.fn.setreg('*', glyph.value)
							print('*: '..glyph.value)
							end
					},
					neoclip = {},
					adjacent={
						level=1
					}
				}
			}
	local builtin = require'telescope.builtin'
		vim.keymap.set('n', '<leader>TT', builtin.builtin, {desc='Telescope'})
		vim.keymap.set('n', '<leader>Tf', builtin.find_files, {desc='find files'})
		vim.keymap.set('n', '<leader>Tg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>Tb', builtin.buffers, {desc='buffers'})
		vim.keymap.set('n', '<leader>Th', builtin.help_tags, {desc='help tags'})
		vim.keymap.set('n', '<leader>Tl', builtin.current_buffer_fuzzy_find, {desc='lines'})
		vim.keymap.set('n', '<leader>To', builtin.oldfiles, {desc='old files'})
		vim.keymap.set('n', '<leader>Tr', builtin.registers, {desc='registers'})
		end
},
	{
		'debugloop/telescope-undo.nvim',
		config=function()
			require'telescope'.load_extension'undo'
		end,
		init=function()
			vim.keymap.set('n', '<leader>Tu', require'telescope'.extensions.undo.undo, {noremap=true, silent=true, desc='undo'})
		end
	},
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		init=function()
			require'telescope'.load_extension'fzf'
		end
	},
	{
		'nvim-telescope/telescope-project.nvim',
		config=function()
			require'telescope'.load_extension'project'
		end,
		init=function()
			vim.keymap.set('n', '<leader>Tp', require'telescope'.extensions.project.project, {noremap=true, silent=true, desc='projects'})
		end
	},
	{
		'LukasPietzschmann/telescope-tabs',
		config=function()
			require'telescope-tabs'.setup{}
		end,
		init=function()
			vim.keymap.set('n', '<leader>Tt', require'telescope-tabs'.list_tabs, {noremap=true, silent=true, desc='tabs'})
		end
	},
	{
		'ghassan0/telescope-glyph.nvim',
		config=function()
			require'telescope'.load_extension'glyph'
		end,
		init=function()
			vim.keymap.set('n', '<leader>Te', require'telescope'.extensions.glyph.glyph, {noremap=true, silent=true, desc='glyphs'})
		end
	},
	{
		'AckslD/nvim-neoclip.lua',
		dependencies={
			'nvim-telescope/telescope.nvim',
			'kkharji/sqlite.lua'
		},
		init=function()
			require'neoclip'.setup{
				enable_persistent_history=true,
			}
			vim.keymap.set('n', '<leader>Tc', function()
				local reg = vim.fn.input'Register: '
				if string.len(reg) == 1 then
					vim.cmd('Telescope neoclip ' .. reg)
				else
					vim.cmd'Telescope neoclip "'
				end
			end, {noremap=true, silent=false, desc='clipboard management'})
		end,
		config=function()
			require'telescope'.load_extension'neoclip'
		end
	},
	{
		'MaximilianLloyd/adjacent.nvim',
		init=function()
			vim.keymap.set('n', '<leader>Ta', require'telescope'.extensions.adjacent.adjacent, {noremap=true, silent=true, desc='adjacent'})
		end,
		config=function()
			require'telescope'.load_extension'adjacent'
		end
	},
}
