Object = require 'libraries.classic.classic'
Input = require 'libraries.boipushy.Input'
Timer = require 'libraries.chrono.Timer'
Camera = require 'libraries.hump.camera'
Vector = require 'libraries.hump.vector'
Binser = require 'libraries.binser.binser'

window = {}
window.w, window.h = love.graphics.getDimensions()

function love.load()
	GAMESTATE = 'MENU'
	
	love.graphics.setDefaultFilter('nearest')

	defaultFont = love.graphics.getFont()
	norseRegular = love.graphics.newFont('resources/fonts/Norse.otf', 24)
	norseBold = love.graphics.newFont('resources/fonts/Norse-Bold.otf', 24)

	local objects = {}
    addFiles('objects', objects)
    requireFiles(objects)
	print('Objects: COMPLETE')

    input = Input()
    input:bind('mouse1', 'left_click')
    input:bind('return', 'select')
    input:bind('escape', 'escape')
    input:bind('w', 'up')
    input:bind('a', 'left')
    input:bind('s', 'down')
    input:bind('d', 'right')
    input:bind('i', 'inv')
    input:bind('c', 'char')
	input:bind('k', 'save')
	input:bind('f', 'giveXP')
	print('Inputs: COMPLETE')

    UI = {}

    UI.MainMenu = {}
    UI.MainMenu[0] = ui('Frame')
    UI.MainMenu[0]:SetPos(0, 0)
    UI.MainMenu[0]:SetSize(window.w, window.h)
    UI.MainMenu[0]:SetColor(0, 0, 0)
    UI.MainMenu[0]:SetVisible(true)
    UI.MainMenu[1] = ui('Button', UI.MainMenu[0])
    UI.MainMenu[1]:SetPos(window.w / 2 - ((window.w / 8) / 2), window.h / 2 - ((window.h / 12) / 2))
    UI.MainMenu[1]:SetSize(window.w / 7, window.h / 18)
    UI.MainMenu[1]:SetColor(0, 0, 0)
    UI.MainMenu[1]:SetFont(norseRegular)
    UI.MainMenu[1]:SetText('Start')
    UI.MainMenu[1]:SetTextColor(1, 1, 1)
    UI.MainMenu[1]:OnClick(function()
		UI.MainMenu[0]:SetColor(0, 0, 0, 0.5)
        GAMESTATE = 'PLAY'
		ply = player()
    end)
    UI.MainMenu[2] = ui('Button', UI.MainMenu[0])
    UI.MainMenu[2]:SetPos(UI.MainMenu[1].x, UI.MainMenu[1].y + UI.MainMenu[1].h + 14)
    UI.MainMenu[2]:SetSize(window.w / 7, window.h / 18)
    UI.MainMenu[2]:SetColor(UI.MainMenu[1]:GetColor())
    UI.MainMenu[2]:SetFont(norseRegular)
    UI.MainMenu[2]:SetText('Exit')
    UI.MainMenu[2]:SetTextColor(1, 1, 1)
    UI.MainMenu[2]:OnClick(function()
        love.event.quit()
    end)
	print('Main Menu: COMPLETE')
	
	images = {}
	images.base = love.graphics.newImage('resources/images/start_area.png')
end

function addFiles(folder, file_list)
    local items = love.filesystem.getDirectoryItems(folder)
    for _, file in ipairs(items) do
        local dir = folder..'/'..file
        if love.filesystem.getInfo(dir, 'file') then
			print('[\''..dir..'\']: FILE')
            table.insert(file_list, dir)
        elseif love.filesystem.getInfo(dir, 'directory') then
			print('[\''..dir..'\']: DIR')
            addFiles(dir, file_list)
        end
    end
end

function requireFiles(files)
    for _, file in ipairs(files) do
        local file = file:sub(1, -5)
        require(file)
    end
end

function love.update(dt)
	if GAMESTATE == 'MENU' then
		UI.MainMenu[0]:update(dt)
	else
		ply:update(dt)
		if input:pressed('escape') then
			saveGame()
			GAMESTATE = 'MENU'
		end
	end
end

function love.draw()
	if GAMESTATE == 'MENU' then
		UI.MainMenu[0]:draw()
	else
		love.graphics.setColor(1, 1, 1)
		love.graphics.draw(images.base, (window.w / 2) + (images.base:getWidth() / 2) - ply.cam.x, (window.h / 2) + 64 - ply.cam.y)
		ply:draw()
	end
end