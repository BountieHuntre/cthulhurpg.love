ui = Object:extend()

uiTypes = {
    'Frame',
    'Button',
    'Label'
}

function ui:new(str, parent)
    if str then
        for k, v in ipairs(uiTypes) do
            if str == v then
                self.type = str
            end
        end
    else
        love.errhand('No type.')
    end
    self.parent = parent or nil

    if self.parent then
        self.x = self.parent.x
        self.y = self.parent.y

        self.visible = self.parent.visible

        table.insert(self.parent.Children, self)
    else
        self.x = 0
        self.y = 0

        self.visible = false
    end
    self.w = 1
    self.h = 1



    self.text = nil

    self.font = defaultFont

    self.isHovered = false

    self.color = {255, 255, 255}
    self.textColor = {0, 0, 0}

    self.scrollable = false

    self.Children = {}
end

function ui:SetPos(x, y)
    if x and y and type(x) == 'number' and type(y) == 'number' then
        if self.parent then
            self.x = self.parent.x + x
            self.y = self.parent.y + y
        else
            self.x = x
            self.y = y
        end
    end
end

function ui:SetSize(w, h)
    if w and h and type(w) == 'number' and type(h) == 'number' then
        self.w = w
        self.h = h
    end
end

function ui:SetColor(r, g, b, a)
    if r and g and b and type(r) == 'number' and type(g) == 'number' and type(b) == 'number' then
        self.color = {r, g, b, 1}
        if a and type(a) == 'number' then
            self.color = {r, g, b, a}
        end
    end
end

function ui:SetFont(font)
    self.font = font or defaultFont
end

function ui:SetText(text)
    if text and type(text) == 'string' then
        self.text = text
        self.text_w = self.font:getWidth(self.text)
        self.text_h = self.font:getHeight(self.text)

        if self.w < self.text_w then
            self.w = self.text_w
        end
        if self.h < self.text_h then
            self.h = self.text_h
        end

        if self.type == 'Button' then
            self.text_x = self.x - (self.text_w / 2) + (self.w / 2)
            self.text_y = self.y - (self.text_h / 2.5) + (self.h / 2)
        else
            self.text_x = self.x
            self.text_y = self.y
        end
    end
end

function ui:SetTextColor(r, g, b, a)
    if r and g and b and type(r) == 'number' and type(g) == 'number' and type(b) == 'number' then
        self.textColor = {r, g, b, 255}
        if a and type(a) == 'number' then
            self.textColor = {r, g, b, a}
        end
    end
end

function ui:SetScrollable(bool)
    self.scrollable = bool or false
end

function ui:SetVisible(bool)
    self.visible = bool
    if #self.Children > 0 then
        for k, v in pairs(self.Children) do
            v:SetVisible(bool)
        end
    end
end

function ui:OnClick(func)
    if func and type(func) == 'function' then
        self.func = func
    end
end

function ui:GetHeight()
	if self.h then
		return self.h
	end
end

function ui:GetWidth()
	if self.w then
		return self.w
	end
end

function ui:IsVisible()
	if self.visible == true then
		return true
	else
		return false
	end
end

function ui:GetText()
    if self.text then
        return self.text
    end
end

function ui:GetColor()
    if self.color then
        return unpack(self.color)
    end
end

function ui:update(dt)
    if self.type == 'Button' then
        local x, y = love.mouse.getPosition()

        if x > self.x and x < self.x + self.w and y > self.y and y < self.y + self.h then
            self.isHovered = true
            if input:pressed('left_click') then
                if self.func then
                    self.func()
                end
            end
        else
            self.isHovered = false
        end
    end
    if #self.Children > 0 then
        for k, v in ipairs(self.Children) do
            if v.visible == true then
                v:update(dt)
            end
        end
    end
end

function ui:draw()
    if self.parent then
        love.graphics.setScissor(self.parent.x, self.parent.y, self.parent.w, self.parent.h)
    end
    love.graphics.setColor(self.color)
    if self.type ~= 'Label' then
        love.graphics.rectangle('fill', self.x, self.y, self.w, self.h)
    end
    if self.isHovered then
		if self.type == 'Button' then
			self:SetFont(norseBold)
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.rectangle('line', self.x, self.y, self.w, self.h)
		end
	else
		self:SetFont(norseRegular)
    end
    love.graphics.setColor(self.textColor)
    love.graphics.setFont(self.font)
    if self.text then
        love.graphics.print(self.text, self.text_x, self.text_y)
    end
    love.graphics.setColor(255, 255, 255)
    love.graphics.setFont(defaultFont)
    if #self.Children > 0 then
        for k, v in ipairs(self.Children) do
            if v.visible == true then
                v:draw()
            end
        end
    end
    love.graphics.setScissor()
end
