npc = Object:extend()

function npc:new()
	self.name = nil
	self.x = nil
	self.y = nil
	
	self.quests = nil
	self.faction = nil
	self.model = nil
	
	self.converse = false
	self.ui = {}
	self.ui.frame = ui('Frame')
	self.ui.frame:SetPos(10, (3 / 4) * window.h - 10)
	self.ui.frame:SetSize(window.w - 20, window.h / 4 - 20)
	self.ui.frame:SetColor(0.5, 0.5, 0.5, 0.5)
	self.ui.frame:SetVisible(false)
	
	self.ui.exit = ui('Button', self.ui.frame)
	self.ui.exit:SetPos(self.ui.frame:GetWidth() - (self.ui.frame:GetWidth() / 5), self.ui.frame:GetHeight() - (self.ui.frame:GetHeight() / 3))
	self.ui.exit:SetSize(self.ui.frame:GetWidth() / 5, self.ui.frame:GetHeight() / 3)
	self.ui.exit:SetColor(0.5, 0.5, 0.5, 0.5)
	self.ui.exit:SetFont(adventurerRegular)
	self.ui.exit:SetText('End')
	self.ui.exit:SetTextColor(1, 1, 1)
	self.ui.exit:OnClick(function()
		self.converse = false
		self.ui.frame:SetVisible(false)
	end)
end

function npc:SetName(name)
	self.name = name
end

function npc:GetName()
	return self.name
end

function npc:SetPos(x, y)
	self.x, self.y = x, y
end

function npc:GetPos()
	return self.x, self.y
end

function npc:SetScale(s)
	self.scale = s
end

function npc:GetScale()
	return self.scale
end

function npc:SetDialogue(dialogue)
	self.dialogue = dialogue
end

function npc:GetDialogue()
	return self.dialogue
end

function npc:SetQuests(quests)
	self.quests = quests
end

function npc:GetQuests()
	return self.quests
end

function npc:SetFaction(faction)
	self.faction = faction
end

function npc:GetFaction()
	return self.faction
end

function npc:SetModel(model)
	self.model = love.graphics.newImage(model)
	self.w = self.model:getWidth() * self.scale
	self.h = self.model:getHeight() * self.scale
end

function npc:GetModel()
	return self.model
end

function npc:Talk()
	self.converse = true
	self.ui.frame:SetVisible(true)
end

function npc:update(dt)
	local x, y = love.mouse.getPosition()
	
	if x > self.x - ply.x - 200 and x < self.x - ply.x - 200 + self.w and y > self.y - ply.cam.y and y < self.y - ply.cam.y + self.h then
		self.isHovered = true
		if input:pressed('left_click') then
			self:Talk()
		end
	else
		self.isHovered = false
	end
	
	if self.converse then
		self.ui.frame:update(dt)
	end
end

function npc:draw()
	if self.x and self.y then
		if self.model then
			love.graphics.draw(self.model, self.x - ply.x - 200, self.y - ply.cam.y, 0, self.scale)
			if self.isHovered then
				love.graphics.setColor(0, 0, 0)
				love.graphics.rectangle('line',  self.x - ply.x - 200 - 4, self.y - ply.cam.y - 4, self.w + 8, self.h + 8)
				love.graphics.setColor(1, 1, 0)
			end
			
			if self.converse then
				self.ui.frame:draw()
			end
		end
	end
end