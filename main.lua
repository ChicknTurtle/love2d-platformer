
t = require 'lib.turtleutils'
inspect = require 'lib.inspect'
binser = require 'lib.binser'

gfx = love.graphics
mouse = love.mouse
window = love.window
keyboard = love.keyboard
timer = love.timer

keyDown = keyboard.isDown

Game = {
    NAME = Game.NAME,
    width = Game.width,
    height = Game.height,
    scene = "main",
    fonts = {
        main = gfx.newFont('assets/fonts/OdibeeSans-Regular.ttf', 20)
    },
    cursors = {
        hand = love.mouse.getSystemCursor("hand")
    },
}

-- Import scenes
require 'editor'
local mainmenu = require 'mainmenu'

-- love.load
-- Called when game starts
function love.load()
    gfx.setDefaultFilter("linear")
    love.window.requestAttention()
end

-- love.update
-- Called every frame
function love.update(dt)
    dt = timer.getAverageDelta()

    -- Limit fps to 30
    -- Game will slow down if < 30 fps
    if dt > 1/30 then
        dt = 1/30
    end

    if Game.scene == 'main' then
        -- Update window title
        window.setTitle(Game.NAME.." - Main Menu")
        -- Tick main menu
        mainmenu.tick(dt)

    elseif Game.scene == 'editor' then
        -- Update window title
        window.setTitle(Game.NAME.." - Level Editor")
        -- Tick editor
        Editor.tick(dt)

    else
        window.setTitle(Game.NAME)
    end

    -- Update window width and height
    Game.width = gfx.getWidth()
    Game.height = gfx.getHeight()
end

-- love.draw
-- Called every frame for drawing visuals
function love.draw()
    gfx.push()
    if Game.scene == 'main' then
        -- Draw main menu
        mainmenu.draw()
    elseif Game.scene == 'editor' then
        -- Draw editor
        Editor.draw()
    end
    gfx.pop()
end

-- love.mousepressed
-- Called on mouse click
function love.mousepressed(x, y, click, istouch)
    if Game.scene == 'main' then
        mainmenu.click(x, y, click, istouch)
    end
end

-- love.keypressed
-- Called on key press
function love.keypressed(key)
    if Game.scene == 'editor' then
        Editor.keypressed(key)
    end
end
