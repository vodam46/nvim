return {
		'glacambre/firenvim',
		init=function()
			vim.api.nvim_create_autocmd({'UIEnter'}, {
				callback = function()
					local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
					if client ~= nil and client.name == "Firenvim" then
						if vim.o.lines < 10 then
							vim.o.lines = 10
						end
					end
				end
			})
			vim.g.firenvim_config = {
				globalSettings = { alt = 'all' },
				localSettings = {
					['.*'] = {
						cmdline = 'neovim',
						content = 'text',
						priority = 0,
						selector = 'textarea',
						takeover = 'never'
					}
				}
			}
		end,
		lazy=not vim.g.started_by_firenvim,
		build = function()
			vim.fn['firenvim#install'](0)
		end
	}
