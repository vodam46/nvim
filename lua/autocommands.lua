
-- change shell directory after exiting
vim.fn.mkdir(vim.fn.expand('~/tmp/vim'), 'p')
vim.api.nvim_create_autocmd({'VimLeave'}, {
	-- command='call writefile([getcwd()], expand("~/tmp/vim/cwd"))',
	callback=function()
		vim.fn.writefile({vim.fn.getcwd()}, vim.fn.expand('~/tmp/vim/cwd'))
	end
})
