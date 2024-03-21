
-- Define editor
Editor = {
    cameraX = 0,
    cameraY = 0,
    zoom = 1,
    world = {
        {x=0,y=-1,t='s'},
        {x=0,y=0,t='g'},
        {x=1,y=0,t='g'},
        {x=1,y=1,t='g'},
    }
}

local buttons = {
    home = {
        extra = 3,
        x = 7.5,
        y = 7.5,
        width = 35,
        height = 35,
        hovering = false,
    }
}

-- Define functions

-- Draw grid
local function drawGrid(size, thickness)
    for x = -size, gfx.getWidth()+size, size do
        gfx.rectangle('fill', x-Editor.cameraX%size, 0, thickness, Game.height)
    end
    for y = -size, gfx.getHeight()+size, size do
        gfx.rectangle('fill', 0, y-Editor.cameraY%size, Game.width, thickness)
    end
end

-- Check surrounding tiles
function checkSurroundingTiles(x, y)
    -- Define the directions to check
    local dirs = {
        {dx=-1,dy=-1,id=0},
        {dx=0,dy=-1,id=1},
        {dx=1,dy=-1,id=2},
        {dx=-1,dy=0,id=3},
        {dx=1,dy=0,id=4},
        {dx=-1,dy=1,id=5},
        {dx=0,dy=1,id=6},
        {dx=1,dy=1,id=7},
    }

    local tiles = {}
    for _, dir in ipairs(dirs) do
        for _, tile in ipairs(Editor.world) do
            if x+dir.dx==tile.x and y+dir.dy==tile.y then
                tiles.append(dir.id)
            end
        end
    end
end

-- On load
function Editor.load()
    -- Reset cursor
    mouse.setCursor()
end

-- On quit
function Editor.quit()

end

-- Tick every frame
function Editor.tick(dt)
    -- Reset cursor
    mouse.setCursor()

    local mx, my = mouse.getPosition()

    -- Home button
    local button = buttons.home
    if t.clamp(mx, button.x-button.extra, button.x+button.width+button.extra) == mx and t.clamp(my, button.y-button.extra, button.y+button.height+button.extra) == my then
        button.hovering = true
        -- Set cursor if hovering
        mouse.setCursor(Game.cursors.hand)
    else
        button.hovering = false
    end

end

-- Draw editor
function Editor.draw()

    -- Set background color
    gfx.setBackgroundColor(0.15,0.15,0.175)

    -- Draw the grid
    gfx.setColor(0.135,0.135,0.1575)
    drawGrid(35, 3)

    -- Draw gui backgrounds
    -- Tile palette
    gfx.setColor(0,0,0,0.3)
    gfx.rectangle('fill', Game.width-175, 0, 175, Game.height)
    -- Menu bar
    gfx.setColor(0.35,0.35,0.35)
    gfx.rectangle('fill', 0, 0, Game.width, 50)
    gfx.setColor(0.2,0.2,0.2)
    gfx.rectangle('fill', 0, 50, Game.width, 5)

    -- Home button
    local button = buttons.home
    if buttons.home.hovering then
        gfx.setColor(0.3,0.3,0.3)
        gfx.rectangle('fill', button.x, button.y, button.width, button.height, 10)
    end

    -- Print debug
    gfx.setColor(1,1,1)
    gfx.print(love.timer.getFPS()..' FPS', 4, 55+2)

end

-- On key press
function Editor.keypressed(key)
    if key == "escape" then
        Editor.quit()
        Game.scene = 'main'
        mainmenu.load()
    end
end

return Editor
