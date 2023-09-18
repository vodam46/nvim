return {
	'pocco81/true-zen.nvim',
	config=function()
		require'true-zen'.setup{
			modes={
				ataraxis={
					minimum_writing_area = {
						width=80
					},
					callbacks={
						open_pre=function()
							vim.g.foldmethod=vim.wo.foldmethod
							vim.wo.foldmethod='manual'
							vim.g.colorscheme=vim.g.colors_name
						end,
						open_pos=function()
							vim.cmd.colorscheme(vim.g.zen_colorscheme)
							vim.cmd'Limelight'
						end,
						close_pre=function()
							vim.g.buffer_name=vim.api.nvim_buf_get_name(0)
							vim.g.zen_colorscheme=vim.g.colors_name
							vim.wo.foldmethod=vim.g.foldmethod
						end,
						close_pos=function()
							vim.cmd.colorscheme(vim.g.colorscheme)
							if vim.g.buffer_name~=nil and  string.len(vim.g.buffer_name)~=0 then vim.cmd('edit '..vim.g.buffer_name) end
							vim.cmd'Limelight!'
						end,
					}
				},
			}
		}
	end,
	init=function()
		vim.g.zen_colorscheme='candle-grey'
		vim.keymap.set('n', '<C-G>', require'true-zen.ataraxis'.toggle)
		vim.keymap.set('v', '<C-G>', function()
			vim.cmd.normal''
			require'true-zen.narrow'.toggle(
			vim.fn.getpos('\'<')[2],
			vim.fn.getpos('\'>')[2]
			)
		end)
	end
}
