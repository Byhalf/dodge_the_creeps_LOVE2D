PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.enemiesSpawner = EnemiesSpawner()
    -- spawn enemies
    self.enemiesSpawner:spawnEnemies()
    self.squid = Squid(self.enemiesSpawner:getEnemies())
    self.time = love.timer.getTime()
    -- play music
end

function PlayState:update(dt)
    self.squid:update(dt)
    self.enemiesSpawner:update(dt)
end

function PlayState:render()
    self.squid:render()
    self.enemiesSpawner:render()
    self:displayTimer()
end

--[[
    Called when this state is transitioned to from another state.
]]
function PlayState:enter()
    -- if I ever implement a pause screen I'll have to change this
    self.time = love.timer.getTime()
    self.squid:render()
end

function PlayState:displayTimer()
    love.graphics.setFont(gFonts['large'])
    love.graphics.setColor(0,0,0,1)
    love.graphics.print(math.ceil(love.timer.getTime()- self.time), 8, 8)
    love.graphics.setColor(1,1,1,1)
end

function PlayState:getScore()
    return math.ceil(love.timer.getTime()- self.time)
end

--[[
    Called when this state changes to another state.
]]
function PlayState:exit()
end