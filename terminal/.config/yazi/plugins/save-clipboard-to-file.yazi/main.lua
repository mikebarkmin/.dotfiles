--- @since 25.5.31

local M = {}
local PackageName = "save-clipboard-to-file"

---@enum STATE
local STATE = {
	INPUT_POSITION = "input_position",
	OVERWRITE_CONFIRM_POSITION = "overwrite_confirm_position",
	HIDE_NOTIFY = "hide_notify",
}

local set_state = ya.sync(function(state, key, value)
	if state then
		state[key] = value
	else
		state = {}
		state[key] = value
	end
end)

local get_state = ya.sync(function(state, key)
	if state then
		return state[key]
	else
		return nil
	end
end)
local function warn(s, ...)
	if get_state(STATE.HIDE_NOTIFY) then
		return
	end
	ya.notify({ title = PackageName, content = string.format(s, ...), timeout = 3, level = "warn" })
end

local get_cwd = ya.sync(function()
	local is_virtual = Url(cx.active.current.cwd).scheme and Url(cx.active.current.cwd).scheme.is_virtual
	return is_virtual and cx.active.current.cwd or cx.active.current.cwd.path
end)

local get_current_tab_id = ya.sync(function()
	return tostring(cx.active.id.value)
end)

local function input_file_name()
	local pos = get_state(STATE.INPUT_POSITION)
	pos = pos or { "center", w = 70 }

	local input_value, input_event = ya.input({
		title = "Enter file name:",
		pos = pos,
		-- TODO: remove this after next yazi released
		position = pos,
	})
	if input_event == 1 then
		if not input_value or input_value == "" then
			warn("File name can't be empty!")
			return
		elseif input_value:match("/$") then
			warn("File name can't ends with '/'")
			return
		end
		return input_value
	end
end

function M:setup(opts)
	if opts and opts.hide_notify and type(opts.hide_notify) == "boolean" then
		set_state(STATE.HIDE_NOTIFY, opts.hide_notify)
	else
		set_state(STATE.HIDE_NOTIFY, false)
	end
	if opts and opts.input_position and type(opts.input_position) == "table" then
		set_state(STATE.INPUT_POSITION, opts.input_position)
	else
		set_state(STATE.INPUT_POSITION, { "center", w = 70 })
	end
	if opts and opts.overwrite_confirm_position and type(opts.overwrite_confirm_position) == "table" then
		set_state(STATE.OVERWRITE_CONFIRM_POSITION, opts.overwrite_confirm_position)
	else
		set_state(STATE.OVERWRITE_CONFIRM_POSITION, { "center", w = 70, h = 10 })
	end
end

function M:entry(job)
	local no_hover = job.args.no_hover == nil and false or job.args.no_hover
	-- Get contents from the clipboard
	local clipboard_content = ya.clipboard()
	if not clipboard_content then
		warn("Clipboard is empty!")
		return
	end
	local file_name = input_file_name()
	if not file_name or file_name == "" then
		return
	end
	local path_separator = package.config:sub(1, 1)
	local cwd = get_cwd()

	local file_path = Url(tostring(cwd) .. path_separator .. file_name)
	local cha, _ = fs.cha(file_path)
	if cha then
		local pos = get_state(STATE.OVERWRITE_CONFIRM_POSITION)
		pos = pos or { "center", w = 70, h = 10 }

		local overwrite_confirmed = ya.confirm({
			title = ui.Line("Save clipboard to file"):style(th.confirm.title),
			body = ui.Text({
				ui.Line(""),
				ui.Line("The following file is existed, overwrite?"):style(ui.Style():fg("yellow")),
				ui.Line(""),
				ui.Line({
					ui.Span(" "),
					ui.Span(tostring(file_path)):style(th.confirm.list or ui.Style():fg("blue")),
				}):align(ui.Align.LEFT),
			})
				:align(ui.Align.LEFT)
				:wrap(ui.Wrap.YES),
			-- TODO: remove this after next yazi released
			content = ui.Text({
				ui.Line(""),
				ui.Line("The following file is existed, overwrite?"):style(ui.Style():fg("yellow")),
				ui.Line(""),
				ui.Line({
					ui.Span(" "),
					ui.Span(tostring(file_path)):style(th.confirm.list or ui.Style():fg("blue")),
				}):align(ui.Align.LEFT),
			})
				:align(ui.Align.LEFT)
				:wrap(ui.Wrap.YES),
			pos = pos,
		})
		if overwrite_confirmed then
			local deleted_collided_item, _ = fs.remove("file", file_path)
			if not deleted_collided_item then
				warn("Failed to delete collided file: %s", tostring(file_path))
				return
			end
			if file_path.parent then
				fs.create("dir_all", file_path.parent)
			end
			fs.write(file_path, clipboard_content)
			if not no_hover then
				ya.emit("reveal", { tostring(file_path), tab = get_current_tab_id(), no_dummy = true, raw = true })
			end
		end
	else
		if file_path.parent then
			fs.create("dir_all", file_path.parent)
		end
		fs.write(file_path, clipboard_content)
		if not no_hover then
			ya.emit("reveal", { tostring(file_path), tab = get_current_tab_id(), no_dummy = true, raw = true })
		end
	end
end
return M
