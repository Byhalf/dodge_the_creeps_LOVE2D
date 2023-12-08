GameOverState = Class{__includes = BaseState}

function GameOverState:init()
end

function GameOverState:enter(params)
    self.params = params
    self:render()
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('home')
    end
    if love.keyboard.wasPressed('s') then
        gStateMachine:change('enterHighScore',{score = self.params.score})
    end
    if love.keyboard.wasPressed('h') then
        gStateMachine:change('high-scores')
    end
    if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('r') then
        gStateMachine:change('play')
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Game Over!', 0, 30, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press S to save your score!', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press H to see High Scores', 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press P to Play Again', 0, VIRTUAL_HEIGHT / 2 + 60, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Press Esc to Quit', 0, VIRTUAL_HEIGHT / 2 + 90, VIRTUAL_WIDTH, 'center')
end