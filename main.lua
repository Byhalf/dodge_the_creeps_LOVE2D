require 'src/Dependencies'
require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/HomeState'
require 'src/states/HighScoreState'
require 'src/states/GameOverState'
require 'src/states/EnterHighScoreState'
require 'src/Squid'
require 'src/Enemy'
require 'src/EnemiesSpawner'



function love.load()
    -- set love's default filter to "nearest" so no bluriness
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- set the application title bar
    love.window.setTitle('Dodge the creeps')

    -- initialize our fonts
    gFonts = {
        ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('fonts/font.ttf', 32)
    }
    love.graphics.setFont(gFonts['small'])


    
    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- set up our sound effects; later, we can just index this table and
    -- call each entry's `play` method
    gSounds = {
        ['gameover'] = love.audio.newSource('art/gameover.wav', 'static'),
        ['music'] = love.audio.newSource('art/House In a Forest Loop.ogg','stream')
    }

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    -- initialize state machine with all state-returning functions
    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
        ['home'] = function () return HomeState() end,
        ['highScore'] = function () return HighScoreState() end,
        ['gameover'] = function () return GameOverState()   end,
        ['enterHighScore'] = function () return EnterHighScoreState() end
    }
    gStateMachine:change('home')


    -- a table we'll use to keep track of which keys have been pressed this
    -- frame, to get around the fact that LÖVE's default callback won't let us
    -- test for input from within other functions
    love.keyboard.keysPressed = {}
end

--[[
    Called whenever we change the dimensions of our window, as by dragging
    out its bottom corner, for example. In this case, we only need to worry
    about calling out to `push` to handle the resizing. Takes in a `w` and
    `h` variable representing width and height, respectively.
]]
function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Called every frame, passing in `dt` since the last frame. `dt`
    is short for `deltaTime` and is measured in seconds. Multiplying
    this by any changes we wish to make in our game will allow our
    game to perform consistently across all hardware; otherwise, any
    changes we make will be applied as fast as possible and will vary
    across system hardware.
]]
function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

--[[
    A callback that processes key strokes as they happen, just the once.
    Does not account for keys that are held down, which is handled by a
    separate function (`love.keyboard.isDown`). Useful for when we want
    things to happen right away, just once, like when we want to quit.
]]
function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

--[[
    A custom function that will let us test for individual keystrokes outside
    of the default `love.keypressed` callback, since we can't call that logic
    elsewhere by default.
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--[[
    Called each frame after update; is responsible simply for
    drawing all of our game objects and more to the screen.
]]
function love.draw()
    -- begin drawing with push, in our virtual resolution
    push:start()


    love.graphics.clear(0, 102/255, 153/255, 255/255)
    gStateMachine:render()

    -- display FPS for debugging; simply comment out to remove
    --displayFPS()

    push:finish()
end






--[[
    Renders the current FPS.
]]
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
end

