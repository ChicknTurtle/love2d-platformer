
-- Editor

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

    -- Initialize an array to store the presence of ground tiles in each direction
    local tiles = {}

    for _, dir in ipairs(dirs) do
        for _, tile in ipairs(Editor.world) do
            if x+dir.dx==tile.x and y+dir.dy==tile.y then
                tiles.append(dir.id)
            end
        end
    end
end

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

    -- Back button
    if keyDown('escape') then
        Editor.quit()
        Game.scene = 'main'
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

    -- Back button
    gfx.setColor(0.3,0.3,0.3)
    gfx.rectangle('fill', 5, 5, 40, 40, 5)

    -- Print debug
    gfx.setColor(1,1,1)
    gfx.print(love.timer.getFPS()..' FPS', 4, 55+2)

end

-- On key press
function Editor.keypressed(key)
    if key == "escape" then
        Editor.quit()
        Game.scene = 'main'
    end
end

return Editor
