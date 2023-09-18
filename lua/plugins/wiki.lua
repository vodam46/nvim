-- return {
-- 	{
-- 		'vimwiki/vimwiki',
-- 		init=function()
-- 			vim.g.vimwiki_list = {
-- 				{
-- 					path = '/home/vodam/data/ZALOHY/writing',
-- 					template_path = '/home/vodam/data/ZALOHY/writing/templates/',
-- 					template_default = 'default',
-- 					path_html = '/home/vodam/data/ZALOHY/writing/html',
-- 					syntax = 'markdown',
-- 					ext = '.md',
-- 					custom_wiki2html = 'vimwiki_markdown',
-- 					template_ext = '.html'
-- 				},
-- 				{
-- 					path = '/home/vodam/data/ZALOHY/school',
-- 					template_path = '/home/vodam/data/ZALOHY/writing/templates/',
-- 					template_default = 'default',
-- 					path_html = '/home/vodam/data/ZALOHY/writing/html',
-- 					syntax = 'markdown',
-- 					ext = '.md',
-- 					custom_wiki2html = 'vimwiki_markdown',
-- 					template_ext = '.html'
-- 				}
-- 			}
-- 			vim.g.vimwiki_global_ext = 0
-- 			vim.g.vimwiki_folding = ''
-- 			vim.g.vimwiki_auto_chdir = 1
-- 			vim.api.nvim_create_autocmd({ 'BufEnter' }, { pattern = { 'diary.md' }, command = 'VimwikiDiaryGenerateLinks' })
-- 			vim.g.vimwiki_filetypes={ 'markdown' }
-- 		end
-- 	},
-- 	{
-- 		'michal-h21/vim-zettel',
-- 		config=function()
-- 			vim.g.zettel_fzf_command = 1
-- 			vim.g.zettel_default_mappings = 0
-- 			vim.g.zettel_options = { { front_matter = { { 'tags', '' }, { 'type', 'note' } } } }
-- 			vim.g.zettel_format = '/zettel/%y%m%d-%H%M-%title'
-- 			vim.keymap.set('n', '<leader>wz', ':tabnew<cr>:ZettelNew<cr>', { noremap = true })
-- 		end
-- 	}
-- }

-- return {
-- 	'serenevoid/kiwi.nvim', dependencies = { 'nvim-lua/plenary.nvim' },
-- 	init=function()
-- 		require'kiwi'.setup{
-- 			{
-- 				name = "personal",
-- 				path = "/home/vodam/writing"
-- 			},
-- 		}
-- 		local kiwi = require'kiwi'
-- 		vim.keymap.set('n', '<leader>ww', kiwi.open_wiki_index, {desc='wiki index'})
-- 		vim.keymap.set('n', '<leader>wt', function()
-- 			vim.cmd.tabnew()
-- 			kiwi.open_wiki_index()
-- 		end, {desc='wiki index in new tab'})
-- 		vim.keymap.set('n', '<leader>wd', kiwi.open_diary_index, {desc='diary index'})
-- 		vim.keymap.set('n', '<leader>wn', kiwi.open_diary_new, {desc='new diary'})
-- 		vim.keymap.set('n', '<C-Space>', kiwi.todo.toggle, {desc='toggle todo status'})
-- 		vim.api.nvim_create_user_command('Wiki', 'lua require\'kiwi\'.open_wiki_index()', {desc='wiki index'})
-- 	end
-- }

function stripChars(str)
	local tableAccents = {}
	tableAccents["À"] = "A"
	tableAccents["Á"] = "A"
	tableAccents["Â"] = "A"
	tableAccents["Ã"] = "A"
	tableAccents["Ä"] = "A"
	tableAccents["Å"] = "A"
	tableAccents["Æ"] = "AE"
	tableAccents["Ç"] = "C"
	tableAccents["È"] = "E"
	tableAccents["É"] = "E"
	tableAccents["Ê"] = "E"
	tableAccents["Ë"] = "E"
	tableAccents["Ì"] = "I"
	tableAccents["Í"] = "I"
	tableAccents["Î"] = "I"
	tableAccents["Ï"] = "I"
	tableAccents["Ð"] = "D"
	tableAccents["Ñ"] = "N"
	tableAccents["Ò"] = "O"
	tableAccents["Ó"] = "O"
	tableAccents["Ô"] = "O"
	tableAccents["Õ"] = "O"
	tableAccents["Ö"] = "O"
	tableAccents["Ø"] = "O"
	tableAccents["Ù"] = "U"
	tableAccents["Ú"] = "U"
	tableAccents["Û"] = "U"
	tableAccents["Ü"] = "U"
	tableAccents["Ý"] = "Y"
	tableAccents["Þ"] = "P"
	tableAccents["ß"] = "s"
	tableAccents["à"] = "a"
	tableAccents["á"] = "a"
	tableAccents["â"] = "a"
	tableAccents["ã"] = "a"
	tableAccents["ä"] = "a"
	tableAccents["å"] = "a"
	tableAccents["æ"] = "ae"
	tableAccents["ç"] = "c"
	tableAccents["è"] = "e"
	tableAccents["é"] = "e"
	tableAccents["ê"] = "e"
	tableAccents["ë"] = "e"
	tableAccents["ě"] = "e"
	tableAccents["ì"] = "i"
	tableAccents["í"] = "i"
	tableAccents["î"] = "i"
	tableAccents["ï"] = "i"
	tableAccents["ð"] = "eth"
	tableAccents["ñ"] = "n"
	tableAccents["ò"] = "o"
	tableAccents["ó"] = "o"
	tableAccents["ô"] = "o"
	tableAccents["õ"] = "o"
	tableAccents["ö"] = "o"
	tableAccents["ø"] = "o"
	tableAccents["ù"] = "u"
	tableAccents["ú"] = "u"
	tableAccents["û"] = "u"
	tableAccents["ü"] = "u"
	tableAccents["ý"] = "y"
	tableAccents["þ"] = "p"
	tableAccents["ÿ"] = "y"
	local normalisedString = str: gsub("[%z\1-\127\194-\244][\128-\191]*", tableAccents)
	return normalisedString
end

return {
	{
		'jakewvincent/mkdnflow.nvim',
		config=function()
			require'mkdnflow'.setup{
				modules = {
					bib = false,
				},
				links = {
					conceal = true,
					context = 0,
					transform_explicit = function(text)
						text = text:gsub(" ", "-")
						text = text:lower()
						text = stripChars(text)
						return(text)
					end
				},
				to_do = {
					symbols = {' ', 'o', 'X'},
					in_progress = 'o',
				},
				mappings = {
					MkdnEnter = {{'n', 'v', 'i'}, '<CR>'},
					MkdnTab = false,
					MkdnSTab = false,
					MkdnNextLink = {'n', '<Tab>'},
					MkdnPrevLink = {'n', '<S-Tab>'},
					MkdnNextHeading = {'n', ']]'},
					MkdnPrevHeading = {'n', '[['},
					MkdnGoBack = {'n', '<BS>'},
					MkdnGoForward = {'n', '<Del>'},
					MkdnFollowLink = false, -- see MkdnEnter
					MkdnCreateLink = false, -- see MkdnEnter
					MkdnCreateLinkFromClipboard = false, --{{'n', 'v'}, '<leader>p'}, -- see MkdnEnter
					MkdnDestroyLink = {'n', '<M-CR>'},
					MkdnMoveSource = {'n', '<F2>'},
					MkdnYankAnchorLink = {'n', 'ya'},
					MkdnYankFileAnchorLink = {'n', 'yfa'},
					MkdnIncreaseHeading = {'n', '+'},
					MkdnDecreaseHeading = {'n', '-'},
					MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
					MkdnNewListItem = false,
					MkdnNewListItemBelowInsert = {'n', 'o'},
					MkdnNewListItemAboveInsert = {'n', 'O'},
					MkdnExtendList = false,
					MkdnUpdateNumbering = false, --{'n', '<leader>nn'},
					MkdnTableNextCell = {'i', '<Tab>'},
					MkdnTablePrevCell = {'i', '<S-Tab>'},
					MkdnTableNextRow = false,
					MkdnTablePrevRow = {'i', '<M-CR>'},
					MkdnTableNewRowBelow = false, --{'n', '<leader>ir'},
					MkdnTableNewRowAbove = false, --{'n', '<leader>iR'},
					MkdnTableNewColAfter = false, --{'n', '<leader>ic'},
					MkdnTableNewColBefore = false, --{'n', '<leader>iC'},
					MkdnFoldSection = false, --{'n', '<leader>f'},
					MkdnUnfoldSection = false, --{'n', '<leader>F'}
				},
				perspective={
					priority='current',
					fallback='firt'
				},
			}
			vim.o.expandtab=false
		end,
		init=function()
			vim.keymap.set('n', '<leader>ww', ':edit ~/writing/index.md<cr>', {desc='open wiki'})
			vim.api.nvim_create_user_command('Wiki', 'edit ~/writing/index.md', {desc='wiki index'})
		end,
		ft='markdown',
	}
}
