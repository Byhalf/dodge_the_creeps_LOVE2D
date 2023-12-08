--[[
    Credit: Colton Ogden
    cogden@cs50.harvard.edu

    Most of the code in this file is copied from the lessons in the course.

]]

HighScoreState = Class{__includes = BaseState}

function HighScoreState:init()
end

function HighScoreState:enter(params)
    self.highScores = self:loadHighScore()
end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('home')
    end
end



function HighScoreState:loadHighScore()

    love.filesystem.setIdentity('dodge_the_creeps')

    -- if the file doesn't exist, initialize it with some default scores
    if not love.filesystem.getInfo('dodge_the_creeps.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'GRT\n'
            scores = scores .. tostring(i ) .. '\n'
        end

        love.filesystem.write('dodge_the_creeps.lst', scores)
    end

    -- flag for whether we're reading a name or not
    local name = true
    local currentName = nil
    local counter = 1

    -- initialize scores table with at least 10 blank entries
    local scores = {}

    for i = 1, 10 do
        -- blank table; each will hold a name and a score
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    -- iterate over each line in the file, filling in names and scores
    for line in love.filesystem.lines('dodge_the_creeps.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        -- flip the name flag
        name = not name
    end
    return scores
end


function HighScoreState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('High Scores', 0, 20, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['medium'])

    -- iterate over all high score indices in our high scores table
    for i = 1, 10 do
        local name = self.highScores[i].name or '---'
        local score = self.highScores[i].score or '---'

        -- score number (1-10)
        love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 
            60 + i * 13, 50, 'left')

        -- score name
        love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 
            60 + i * 13, 50, 'right')
        
        -- score itself
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2,
            60 + i * 13, 100, 'right')
    end

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("Press Escape to return to the main menu!",
        0, VIRTUAL_HEIGHT - 18, VIRTUAL_WIDTH, 'center')
end