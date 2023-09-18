return {
	{
		'alexghergh/nvim-tmux-navigation',
		init=function()
			require'nvim-tmux-navigation'.setup{
				disable_when_zoomed=true,
				keybindings = {
					left = "<C-h>",
					down = "<C-j>",
					up = "<C-k>",
					right = "<C-l>",
					last_active = "<C-\\>",
					next = "<C-Space>",
				}
			}

			vim.keymap.set('n', '<leader>tm', function()
				local cwd = vim.fn.getcwd()
				vim.fn.system('tmux attach-session -t . -c '..cwd)
				vim.notify('changed to '..cwd)
			end, {desc='change tmux dir'})
		end
	}
}
