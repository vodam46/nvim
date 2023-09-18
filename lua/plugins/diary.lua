--[[
todo

change into actual package
rewrite
--]]
local M = {}
local sep = require'plenary.path'.path.sep
local scan_dir = require'plenary.scandir'.scan_dir
M.default_config = {
	path='~/diary',
	date_format='%Y-%m-%d',
	index_path='index',
	file_extension='md',
	custom_generate_index=nil,
	template_path=nil
}

M.setup = function(config)
	M.config = vim.tbl_extend('force', M.default_config, config or {})
	vim.api.nvim_create_user_command('Diary', M.open_diary_new, {desc='Open diary for today'})
	vim.api.nvim_create_user_command('DiaryIndex', M.open_diary_index, {desc='Open diary for today'})
end

M.list_entries = function()
	local files = {}
	local file_names = scan_dir(vim.fn.expand(M.config.path), {})
	for _,file in ipairs(file_names) do
		file = string.gsub(file, vim.fn.expand(M.config.path)..sep, '')
		if file and file ~= M.config.index_name..'.'..M.config.file_extension then
			table.insert(files, file)
		end
	end
	return files
end

-- copied from kiwi.nvim, thank you very much, slightly modified
M.generate_index = function(files)

    for i = 1, math.floor(#files/2), 1 do
        files[i], files[#files-i+1] = files[#files-i+1], files[i]
    end

	local data = { "# Diary" }
	local date = {}
	local months = {
		"January",
		"February",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December"
	}
	for _, filename in ipairs(files) do

		if filename:sub(1,4) ~= date["year"] then
			date["year"] = filename:sub(1,4)
			table.insert(data, "")
			table.insert(data, "## "..date["year"])
		end

		if filename:sub(6,7) ~= date["month"] then
			date["month"] = filename:sub(6,7)
			table.insert(data, "")
			table.insert(data, "### "..months[tonumber(date["month"])])
		end

		table.insert(
		data,
		"[" .. filename:sub(1,10) .. "](." .. sep .. filename .. ")"
		)
	end
	return data
end

M.open_diary_index = function()
	local index_path = vim.fn.expand(M.config.path)..sep..M.config.index_name..'.'..M.config.file_extension
	vim.cmd.edit(index_path)
	local buffer_number = vim.fn.bufnr(index_path, true)

	local new_lines = {}
	if M.config.custom_generate_index ~= nil then
		new_lines = M.config.custom_generate_index(M.list_entries())
	else
		new_lines = M.generate_index(M.list_entries())
	end

	local old_lines = vim.api.nvim_buf_get_lines(0,0,-1,false)
	if table.concat(new_lines) ~= table.concat(old_lines) then
		vim.api.nvim_buf_set_lines(buffer_number, 0, -1, false, new_lines)
	end
end

M.open_diary_new = function()
	local date = os.date(M.config.date_format)
	local filepath = vim.fn.expand(M.config.path)..sep..date..'.'..M.config.file_extension
	local buffer_number = vim.fn.bufnr(filepath, true)
	vim.api.nvim_win_set_buf(0, buffer_number)
	if M.config.template_path ~= nil then
		local content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
		if #content == 1 and content[1] == "" then
			local file = assert(io.open(vim.fn.expand(M.config.template_path)))
			content = file:read('*all')
			file:close()
			local new_lines = {}
			for s in content:gmatch('[^\r\n]+') do
				table.insert(new_lines, s)
			end
			vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
		end
	end
end

return M
