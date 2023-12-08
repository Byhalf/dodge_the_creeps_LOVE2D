HomeState = Class{__includes = BaseState}

function HomeState:init()
end

function HomeState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('h') then
        gStateMachine:change('highScore')
    end
end

function HomeState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Dodge the creeps!', 0, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press Enter to Play', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press H to see High Scores', 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Esc to Quit', 0, VIRTUAL_HEIGHT / 2 + 60, VIRTUAL_WIDTH, 'center')
end

function HomeState:enter()
    self:render()
end

function HomeState:exit()
end