tile = Object:extend()

function tile:new(dir, conn, str, x, y)
	if dir and love.filesystem.getInfo(dir, 'file') then
		self.img = love.graphics.newImage(dir)
		
		self.w = self.img:getWidth()
		self.h = self.img:getHeight()
		
		if x and y and type(x) == 'number' and type(y) == 'number' then
			self.x = x
			self.y = y
		else
			self.x = self.w
			self.y = 0
		end
		
		if conn and str then
			if str == 'up' then
				self.x = conn.x + (conn.w / 2) - (self.w / 2)
				self.y = conn.y - self.h
			elseif str == 'right' then
				self.x = conn.x + conn.w
				self.y = conn.y + (conn.h / 2) - (self.h / 2)
			elseif str == 'left' then
				self.x = conn.x - self.w
				self.y = conn.y + (conn.h / 2) - (self.h / 2)
			elseif str == 'down' then
				self.x = conn.x + (conn.w / 2) - (self.w / 2)
				self.y = conn.y + conn.h
			end
		end
		print(dir..' | x: '..self.x..' | y: '..self.y..' | w: '..self.w..' | h: '..self.h)
	end
end

function tile:update(dt)
	self.x = self.x
	self.y = self.y

end

function tile:draw()
	love.graphics.draw(self.img, self.x - ply.cam.x, self.y - ply.cam.y)
end