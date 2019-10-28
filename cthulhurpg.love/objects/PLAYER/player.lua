player = Object:extend()

function player:new(data)
	self.currentAnim = 1
	self.currentDir = 1
	self.currentFrame = 1
	self.elapsedTime = 0
	
	self.images = {}
	self.images[1] = love.graphics.newImage('resources/images/PLAYER/ply_breathing.png')
	self.images[2] = love.graphics.newImage('resources/images/PLAYER/ply_walking_down.png')
	self.images[3] = love.graphics.newImage('resources/images/PLAYER/ply_walking_up.png')
	self.images[4] = love.graphics.newImage('resources/images/PLAYER/ply_walking_left.png')
	self.images[5] = love.graphics.newImage('resources/images/PLAYER/ply_walking_right.png')
	
	self.frames = {}
	
	self.frames[1] = {}
	self.frames[1][1] = {}
	self.frames[1][2] = {}
	self.frames[1][3] = {}
	self.frames[1][4] = {}
	
	self.frames[1][1][1] = love.graphics.newQuad(0, 0, 64, 64, self.images[1]:getDimensions())
	self.frames[1][1][2] = love.graphics.newQuad(64, 0, 64, 64, self.images[1]:getDimensions())
	self.frames[1][2][1] = love.graphics.newQuad(128, 0, 64, 64, self.images[1]:getDimensions())
	self.frames[1][2][2] = love.graphics.newQuad(192, 0, 64, 64, self.images[1]:getDimensions())
	self.frames[1][3][1] = love.graphics.newQuad(0, 64, 64, 64, self.images[1]:getDimensions())
	self.frames[1][3][2] = love.graphics.newQuad(64, 64, 64, 64, self.images[1]:getDimensions())
	self.frames[1][4][1] = love.graphics.newQuad(128, 64, 64, 64, self.images[1]:getDimensions())
	self.frames[1][4][2] = love.graphics.newQuad(192, 64, 64, 64, self.images[1]:getDimensions())
	
	self.frames[2] = {}
	self.frames[2][1] = {}
	
	self.frames[2][1][1] = love.graphics.newQuad(0, 0, 64, 64, self.images[2]:getDimensions())
	self.frames[2][1][2] = love.graphics.newQuad(64, 0, 64, 64, self.images[2]:getDimensions())
	self.frames[2][1][3] = love.graphics.newQuad(0, 64, 64, 64, self.images[2]:getDimensions())
	self.frames[2][1][4] = love.graphics.newQuad(64, 64, 64, 64, self.images[2]:getDimensions())
	
	self.frames[3] = {}
	self.frames[3][2] = {}
	
	self.frames[3][2][1] = love.graphics.newQuad(0, 0, 64, 64, self.images[3]:getDimensions())
	self.frames[3][2][2] = love.graphics.newQuad(64, 0, 64, 64, self.images[3]:getDimensions())
	self.frames[3][2][3] = love.graphics.newQuad(0, 64, 64, 64, self.images[3]:getDimensions())
	self.frames[3][2][4] = love.graphics.newQuad(64, 64, 64, 64, self.images[3]:getDimensions())
	
	self.frames[4] = {}
	self.frames[4][3] = {}
	
	self.frames[4][3][1] = love.graphics.newQuad(0, 0, 64, 64, self.images[4]:getDimensions())
	self.frames[4][3][2] = love.graphics.newQuad(64, 0, 64, 64, self.images[4]:getDimensions())
	self.frames[4][3][3] = love.graphics.newQuad(0, 64, 64, 64, self.images[4]:getDimensions())
	self.frames[4][3][4] = love.graphics.newQuad(64, 64, 64, 64, self.images[4]:getDimensions())
	
	self.frames[5] = {}
	self.frames[5][4] = {}
	
	self.frames[5][4][1] = love.graphics.newQuad(0, 0, 64, 64, self.images[5]:getDimensions())
	self.frames[5][4][2] = love.graphics.newQuad(64, 0, 64, 64, self.images[5]:getDimensions())
	self.frames[5][4][3] = love.graphics.newQuad(0, 64, 64, 64, self.images[5]:getDimensions())
	self.frames[5][4][4] = love.graphics.newQuad(64, 64, 64, 64, self.images[5]:getDimensions())
	
	self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
	
	self.scale = 2
    self.w = 64
    self.h = 64
    self.x = 0
    self.y = 0
    self.realX = 0
    self.realY = 0
	
	self.savedData = data
	self.savedData = {}
	self.savedData.Inventory = {}
	self.savedData.InventorySlots = 16
	
	self.savedData.Inventory.menu = {}
	self.savedData.Inventory.menu[0] = ui('Frame')
	self.savedData.Inventory.menu[0]:SetPos(0, 0)
	self.savedData.Inventory.menu[0]:SetSize(window.w, window.h)
	self.savedData.Inventory.menu[0]:SetColor(0, 0, 0, 0.65)
	self.savedData.Inventory.menu[0]:SetVisible(true)
	self.savedData.Inventory.menu[1] = ui('Button', self.savedData.Inventory.menu[0])
	self.savedData.Inventory.menu[1]:SetPos(10, 10)
	self.savedData.Inventory.menu[1]:SetSize(window.w / 7, window.h / 18)
	self.savedData.Inventory.menu[1]:SetColor(0, 0, 0)
	self.savedData.Inventory.menu[1]:SetFont(norseRegular)
	self.savedData.Inventory.menu[1]:SetText('Equipment')
	self.savedData.Inventory.menu[1]:SetTextColor(1, 1, 1, 1)
	self.savedData.Inventory.menu[1]:OnClick(function()
		if self.savedData.Inventory.menu[2]:IsVisible() then
			self.savedData.Inventory.menu[2]:SetVisible(false)
		else
			self.savedData.Inventory.menu[2]:SetVisible(true)
		end
	end)
	self.savedData.Inventory.menu[2] = ui('Frame', self.savedData.Inventory.menu[0])
	self.savedData.Inventory.menu[2]:SetPos(10, 20 + self.savedData.Inventory.menu[1]:GetHeight())
	self.savedData.Inventory.menu[2]:SetSize(window.w - 20, window.h - 30 - self.savedData.Inventory.menu[1]:GetHeight())
	self.savedData.Inventory.menu[2]:SetColor(0, 0, 0, 0.2)
	self.savedData.Inventory.menu[2]:SetVisible(false)
	

	self.savedData.Level = 1
	self.savedData.Exp = {}
	self.savedData.Exp.Current = 0
	self.savedData.Exp.Max = 200
	self.savedData.Exp.Modifier = 0
	self.cam = Camera(self.x, self.y)
end

function player:update(dt)
	if GAMESTATE == 'PLAY' then
		self.elapsedTime = self.elapsedTime + dt
		
		if not input:down('up') and not input:down('down') and not input:down('right') and not input:down('left') or input:down('left') and input:down('right') or input:down('up') and input:down('down') then
			self.currentAnim = 1
			if self.currentFrame > 2 then
				self.currentFrame = 1
			end
			self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
			if self.elapsedTime > 1 then
				if self.currentFrame < 2 then
					self.currentFrame = self.currentFrame + 1
				else
					self.currentFrame = 1
				end
				self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
				self.elapsedTime = 0
			end
		else
			if input:down('down') and not input:down('right') and not input:down('left') then
				self.y = self.y + 2
				if self.currentAnim ~= 2 then
					self.currentFrame = 1
					self.currentAnim = 2
					self.currentDir = 1
					self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
					self.elapsedTime = 0
				end
				if self.elapsedTime > 0.2 then
					if self.currentFrame < 4 then
						self.currentFrame = self.currentFrame + 1
					else
						self.currentFrame = 1
					end
					self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
					self.elapsedTime = 0
				end
			end
			if input:down('up') and not input:down('right') and not input:down('left') then
				self.y = self.y - 2
				if self.currentAnim ~= 3 then
					self.currentFrame = 1
					self.currentAnim = 3
					self.currentDir = 2
					self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
					self.elapsedTime = 0
				end
				if self.elapsedTime > 0.2 then
					if self.currentFrame < 4 then
						self.currentFrame = self.currentFrame + 1
					else
						self.currentFrame = 1
					end
					self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
					self.elapsedTime = 0
				end
			end
			if input:down('left') or input:down('left') and input:down('up') or input:down('left') and input:down('down') then
				self.x = self.x - 2
				if input:down('down') then
					self.y = self.y + 2
				elseif input:down('up') then
					self.y = self.y - 2
				end
				if self.currentAnim ~= 4 then
					self.currentFrame = 1
					self.currentAnim = 4
					self.currentDir = 3
					self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
					self.elapsedTime = 0
				end
				if self.elapsedTime > 0.2 then
					if self.currentFrame < 4 then
						self.currentFrame = self.currentFrame + 1
					else
						self.currentFrame = 1
					end
					self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
					self.elapsedTime = 0
				end
			end
			if input:down('right') or input:down('right') and input:down('up') or input:down('right') and input:down('down') then
				self.x = self.x + 2
				if input:down('down') then
					self.y = self.y + 2
				elseif input:down('up') then
					self.y = self.y - 2
				end
				if self.currentAnim ~= 5 then
					self.currentFrame = 1
					self.currentAnim = 5
					self.currentDir = 4
					self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
					self.elapsedTime = 0
				end
				if self.elapsedTime > 0.2 then
					if self.currentFrame < 4 then
						self.currentFrame = self.currentFrame + 1
					else
						self.currentFrame = 1
					end
					self.activeFrame = self.frames[self.currentAnim][self.currentDir][self.currentFrame]
					self.elapsedTime = 0
				end
			end
		end
		
		self.savedData.Exp.Modifier = math.ceil((self.savedData.Level)^1.86 * (100 + self.savedData.Level))

		if self.savedData.Exp.Max ~= self.savedData.Exp.Modifier then
			self.savedData.Exp.Max = self.savedData.Exp.Modifier
		end

		if self.savedData.Exp.Current >= self.savedData.Exp.Max then
			self.savedData.Level = self.savedData.Level + 1
			self.savedData.Exp.Current = 0
			self.savedData.Exp.Max = self.savedData.Exp.Modifier
		end
		
		local dx, dy = self.x - self.cam.x + 64, self.y - self.cam.y + 64
		self.cam:move(dx, dy)
		
		if input:pressed('save') then
			saveGame()
		end
		if input:pressed('giveXP') then
			self.savedData.Exp.Current = self.savedData.Exp.Current + 50
		end
		if input:pressed('inv') then
			GAMESTATE = 'INV'
		end
	elseif GAMESTATE == 'INV' then
		if input:pressed('inv') then
			GAMESTATE = 'PLAY'
		end
		self.savedData.Inventory.menu[0]:update(dt)
	end
end

function player:draw()
	love.graphics.setColor(1, 1, 1)
	self.cam:attach()
		love.graphics.draw(self.images[self.currentAnim], self.activeFrame, self.x, self.y, 0, self.scale)
	self.cam:detach()
	love.graphics.setColor(0, 0, 0)
	love.graphics.print(self.savedData.Exp.Current..' / '..self.savedData.Exp.Max, 2, 2)
	if GAMESTATE == 'INV' then
		self.savedData.Inventory.menu[0]:draw()
	end
end
