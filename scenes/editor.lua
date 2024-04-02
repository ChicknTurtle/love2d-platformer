
-- Define editor
editor = {
    cameraX = 0,
    cameraY = 0,
    brushsize = 1,
    world = {
        {x=0,y=-1,t='s'},
        {x=0,y=0,t='g'},
        {x=1,y=0,t='g'},
        {x=1,y=1,t='g'},
    },
    SCROLLSPEED = 10,
}

local buttons = {
    home = {
        extra = 3,
        x = 5,
        y = 5,
        width = 40,
        height = 40,
        hovering = false,
    }
}

-- Define functions

-- Draw grid
local function drawGrid(size, thickness)
    for x = -size, gfx.getWidth()+size, size do
        gfx.rectangle('fill', x-editor.cameraX%size, 0, thickness, Game.height)
    end
    for y = -size, gfx.getHeight()+size, size do
        gfx.rectangle('fill', 0, y-editor.cameraY%size, Game.width, thickness)
    end
end

-- Define all 256 possible tiles
local tilepos = {
    ''={x=7,y=0},
    '1'={x=7,y=0}, -- up left
    '2'={x=6,y=2}, -- up
    '3'={x=7,y=0}, -- up right
    '4'={x=6,y=3}, -- left
    '5'={x=4,y=3}, -- right
    '6'={x=7,y=0}, -- down left
    '7'={x=6,y=0}, -- down
    '8'={x=7,y=0}, -- down right
    '12'={x=6,y=2}, -- 1, 2 long
    '13'={x=7,y=0},
    '14'={x=6,y=3},
    '15'={x=4,y=3},
    '16'={x=7,y=0},
    '17'={x=6,y=0},
    '18'={x=7,y=0},
    '23'={x=6,y=2}, -- 2, 2 long
    '24'={x=5,y=2},
    '25'={x=3,y=2},
    '26'={x=6,y=2},
    '27'={x=6,y=1},
    '28'={x=6,y=2},
    '34'={x=6,y=3}, -- 3, 2 long
    '35'={x=4,y=3},
    '36'={x=7,y=0},
    '37'={x=6,y=0},
    '38'={x=6,y=0},
    '45'={x=5,y=3}, -- 4, 2 long
    '46'={x=6,y=3},
    '47'={x=5,y=0},
    '48'={x=6,y=3},
    '56'={x=4,y=3}, -- 5, 2 long
    '57'={x=3,y=0},
    '58'={x=4,y=3},
    '67'={x=6,y=0}, -- 6, 2 long
    '68'={x=7,y=0},
    '78'={x=6,y=0}, -- 7, 2 long
    '123'={x=6,y=2}, -- 1, 3 long
    '124'={x=2,y=2},
    '125'={x=3,y=2},
    '126'={x=6,y=2},
    '127'={x=6,y=1},
    '128'={x=6,y=2},
    '134'={x=6,y=3},
    '135'={x=4,y=3},
    '136'={x=7,y=0},
    '137'={x=6,y=0},
    '138'={x=7,y=0},
    '145'={x=5,y=3},
    '146'={x=6,y=3},
    '147'={x=5,y=0},
    '148'={x=6,y=3},
    '156'={x=4,y=3},
    '157'={x=3,y=0},
    '158'={x=4,y=3},
    '167'={x=6,y=0},
    '168'={x=7,y=0},
    '178'={x=6,y=0},
    '234'={x=5,y=2}, -- 2, 3 long
}

-- 1 2 3 - o x x 
-- 4 # 5 - x # o 
-- 6 7 8 - o o o 

-- Check surrounding tiles
local function checkSurroundingTiles(x, y, type)
    -- Define the directions to check
    local dirs = {          -- 0 self
        {dx=-1,dy=-1,id=1}, -- 1 up left
        {dx=0,dy=-1,id=2},  -- 2 up
        {dx=1,dy=-1,id=3},  -- 3 up right
        {dx=-1,dy=0,id=4},  -- 4 left
        {dx=1,dy=0,id=5},   -- 5 right
        {dx=-1,dy=1,id=6},  -- 6 down left
        {dx=0,dy=1,id=7},   -- 7 down
        {dx=1,dy=1,id=8},   -- 8 down right
    }

    local tiles = {0}
    for _, dir in ipairs(dirs) do
        for _, tile in ipairs(editor.world) do
            if x+dir.dx==tile.x and y+dir.dy==tile.y and tile.t==type then
                tiles.append(dir.id)
            end
        end
    end
    table.sort(tiles)
    tiles = table.concat(tiles)
    return tiles
end

-- Draw all tiles
local function drawTiles(tileset)
    for i, tile in ipairs(editor.world) do
        local surrounding = checkSurroundingTiles(tile.x, tile.y, tile.t)

    end
end

-- On load
function editor.load()
    Game.scene = 'editor'
    -- Reset cursor
    mouse.setCursor()
end

-- On quit
function editor.quit()

end

-- Tick every frame
function editor.tick(dt)
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

    -- Scroll
    if keyboard.isDown('left') then
        editor.cameraX = editor.cameraX + editor.SCROLLSPEED
    end
    if keyboard.isDown('right') then
        editor.cameraX = editor.cameraX - editor.SCROLLSPEED
    end
    if keyboard.isDown('up') then
        editor.cameraY = editor.cameraY + editor.SCROLLSPEED
    end
    if keyboard.isDown('down') then
        editor.cameraY = editor.cameraY - editor.SCROLLSPEED
    end

end

-- Draw editor
function editor.draw()

    -- Set background color
    gfx.setBackgroundColor(0.15,0.15,0.175)

    -- Draw in certain order for layering

    -- Draw the grid
    gfx.setColor(0.12,0.12,0.13)
    drawGrid(35, 3)

    -- Draw tiles

    -- Draw gui

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

    -- Print fps
    gfx.setColor(1,1,1)
    gfx.print(love.timer.getFPS()..' FPS', 4, 55+2)

end

-- On key press
function editor.keypressed(key)
    if key == "escape" then
        editor.quit()
        mainmenu.load()
    end
end

-- On click
function editor.click(x, y, click, istouch)
    if click == 1 then
        if buttons.home.hovering then
            mainmenu.load()
        end
    end
end

