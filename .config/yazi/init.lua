function Manager:render(area)
	self.area = area

	local chunks = ui.Layout()
		:direction(ui.Layout.HORIZONTAL)
		:constraints({
			ui.Constraint.Ratio(MANAGER.ratio.parent, MANAGER.ratio.all),
			ui.Constraint.Ratio(MANAGER.ratio.current, MANAGER.ratio.all),
			ui.Constraint.Ratio(MANAGER.ratio.preview, MANAGER.ratio.all),
		})
		:split(area)

	local bar = function(c, x, y)
		return ui.Bar(
			ui.Rect({ x = math.max(0, x), y = math.max(0, y), w = math.min(1, area.w), h = math.min(1, area.h) }),
			ui.Bar.TOP
		):symbol(c)
	end

	return ya.flat({
		-- Borders
		ui.Border(area, ui.Border.ALL):type(ui.Border.ROUNDED),
		ui.Bar(chunks[1], ui.Bar.RIGHT),
		ui.Bar(chunks[3], ui.Bar.LEFT),

		bar("┬", chunks[1].right - 1, chunks[1].y),
		bar("┴", chunks[1].right - 1, chunks[1].bottom - 1),
		bar("┬", chunks[2].right, chunks[2].y),
		bar("┴", chunks[2].right, chunks[1].bottom - 1),

		-- Parent
		Parent:render(chunks[1]:padding(ui.Padding.xy(1))),
		-- Current
		Current:render(chunks[2]:padding(ui.Padding.y(1))),
		-- Preview
		Preview:render(chunks[3]:padding(ui.Padding.xy(1))),
	})
end

function Header:host()
	if ya.target_family() ~= "unix" then
		return ui.Line({}) -- No host information for non-Unix systems
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end

function Header:render(area)
	local chunks = self:layout(area)

	local left = ui.Line({ self:host(), self:cwd() }) -- Include host information
	local right = ui.Line({ self:tabs() })
	return {
		ui.Paragraph(chunks[1], { left }),
		ui.Paragraph(chunks[2], { right }):align(ui.Paragraph.RIGHT),
	}
end

function Status:owner()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		ui.Span(":"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		ui.Span(" "),
	})
end

function Status:render(area)
	self.area = area

	local left = ui.Line({ self:mode(), self:size(), self:name() })
	local right = ui.Line({ self:owner(), self:permissions(), self:percentage(), self:position() })
	return {
		ui.Paragraph(area, { left }),
		ui.Paragraph(area, { right }):align(ui.Paragraph.RIGHT),
		table.unpack(Progress:render(area, right:width())),
	}
end

function Status:name()
	local h = cx.active.current.hovered
	if h == nil then
		return ui.Span("")
	end

	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end
	return ui.Span(" " .. h.name .. linked)
end
