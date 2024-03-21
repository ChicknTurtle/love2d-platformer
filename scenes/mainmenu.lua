
mainmenu = {}

local buttons = {
    WIDTH = 225,
    HOVER_WIDTH = 250,
    HEIGHT = 30,
    EXTRA = 5,
    play = {
        label = "Play",
        Y = -100,
        hovering = false,
        width = 225,
    },
    multiplayer = {
        label = "Multiplayer",
        Y = -50,
        hovering = false,
        width = 225,
    },
    editor = {
        label = "Level Editor",
        Y = 0,
        hovering = false,
        width = 225,
    },
    settings = {
        label = "Settings",
        Y = 50,
        hovering = false,
        width = 225,
    },
    quit = {
        label = "Quit",
        Y = 100,
        hovering = false,
        width = 225,
    }
}

local function tickButton(button, dt)
    local mx, my = mouse.getPosition()
    local y = Game.height/2 + button.Y
    if t.clamp(mx, nil, button.width+buttons.EXTRA) == mx and t.clamp(my, y-buttons.EXTRA, y+buttons.HEIGHT+buttons.EXTRA) == my then
        button.hovering = true
        button.width = button.width + ((t.interpolate(button.width, buttons.HOVER_WIDTH, 0.5) - button.width) * dt * 10)
        -- Set cursor if hovering
        mouse.setCursor(Game.cursors.hand)
    else
        button.hovering = false
        button.width = button.width + ((t.interpolate(button.width, buttons.WIDTH, 0.5) - button.width) * dt * 10)
    end
end

local function drawButton(button)
    local y = Game.height/2+button.Y
    local width = button.width
    gfx.setColor(0,0,0,0.33)
    gfx.rectangle('fill', -10, y, width+10, buttons.HEIGHT, 5)
    gfx.setColor(1,1,1)
    local textx = button.width-buttons.WIDTH*0.7
    local texty = y+buttons.HEIGHT/2-(Game.fonts.main:getHeight()/2)
    gfx.setFont(Game.fonts.main)
    gfx.print(button.label, textx, texty)
end

-- On load
function mainmenu.load()
    -- Reset width of all buttons
    for name, button in pairs(buttons) do
        if type(button) == 'table' then
            button.width = buttons.WIDTH
        end
    end
end

-- Tick every frame
function mainmenu.tick(dt)
    -- Reset cursor
    mouse.setCursor()
    -- Tick buttons
    for name, button in pairs(buttons) do
        if type(button) == 'table' then
            -- Don't tick quit button on web
            if os ~= "Web" or name ~= "quit" then
                tickButton(button, dt)
            end
        end
    end
end

-- Draw menu
function mainmenu.draw()
    -- Set background color
    gfx.setBackgroundColor(0.15,0.15,0.175)
    -- Draw buttons
    for name, button in pairs(buttons) do
        if type(button) == 'table' then
            -- Don't draw quit button on web
            if os ~= "Web" or name ~= "quit" then
                drawButton(button)
            end
        end
    end
end

-- On click
function mainmenu.click(x, y, click, istouch)
    if click == 1 then
        for name, button in pairs(buttons) do
            if type(button) == 'table' then
                if button.hovering then
                    -- Editor
                    if name == 'editor' then
                        -- Switch to editor
                        Game.scene = 'editor'
                        -- Setup editor
                        Editor.load()
                    end
                    -- Quit
                    if name == 'quit' then
                        -- Exit game
                        love.event.quit()
                    end
                end
            end
        end
    end
end
