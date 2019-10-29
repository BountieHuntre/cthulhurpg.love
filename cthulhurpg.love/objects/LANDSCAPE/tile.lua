tile = Object:extend()

function tile:new(dir, conn, str, x, y)
	if dir and love.filesystem.getInfo(dir, 'file') then
		self.img = love.graphics.newImage(dir)
		
		self.w = self.img:getWidth()
		self.h = self.img:getHeight()
		self.x = ply.x
		self.y = ply.y
		
		if conn and str and type(conn) == 'table' and type(str) == 'string' then
			if str == 'up' then
				if x and y then
					self.x = conn.x + x
					self.y = conn.y - self.h + y
				else
					self.x = conn.x + (conn.w / 2) - (self.w / 2)
					self.y = conn.y - self.h
				end
			elseif str == 'right' then
				if x and y then
					self.x = conn.x + conn.w + x
					self.y = conn.y + y
				else
					self.x = conn.x + conn.w
					self.y = conn.y + (conn.h / 2) - (self.h / 2)
				end
			elseif str == 'left' then
				if x and y then
					self.x = conn.x - self.w + x
					self.y = conn.y + y
				else
					self.x = conn.x - self.w
					self.y = conn.y + (conn.h / 2) - (self.h / 2)
				end
			elseif str == 'down' then
				if x and y then
					self.x = conn.x + x
					self.y = conn.y + conn.h + y
				else
					self.x = conn.x + (conn.w / 2) - (self.w / 2)
					self.y = conn.y + conn.h
				end
			end
		end
		
		if conn and str and type(conn) == 'number' and type(str) == 'number' then
			self.x = x
			self.y = y
		end
		print(dir..' | x: '..self.x..' | y: '..self.y..' | w: '..self.w..' | h: '..self.h)
	end
end

function tile:update(dt)
	self.x = self.x
	self.y = self.y

end

function tile:draw()
	love.graphics.draw(self.img, self.x - ply.x, self.y - ply.y)
end