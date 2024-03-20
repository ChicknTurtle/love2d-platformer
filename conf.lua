
Game = {
    NAME = "Platformer",
    width = 960,
    height = 540,
}

-- Initial window config
function love.conf(game)
    Game.identity = Game.NAME
    game.window.title = Game.NAME.." - Loading..."
    game.window.icon = 'assets/icon.png'

    game.window.width = Game.width
    game.window.height = Game.height
    game.window.fullscreen = false
    game.window.resizable = true

    game.window.vsync = 0
    game.window.highdpi = true
    game.window.msaa = 1
end
