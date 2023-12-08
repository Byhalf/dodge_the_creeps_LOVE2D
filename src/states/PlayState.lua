PlayState = Class{__includes = BaseState}


function PlayState:init()
    self.enemiesSpawner = EnemiesSpawner()
    -- spawn enemies
    self.enemiesSpawner:spawnEnemies()
    self.squid = Squid(self.enemiesSpawner:getEnemies())

    -- play music
end

function PlayState:update(dt)
    self.squid:update(dt)
    self.enemiesSpawner:update(dt)
end

function PlayState:render()
    self.squid:render()
    self.enemiesSpawner:render()
end

--[[
    Called when this state is transitioned to from another state.
]]
function PlayState:enter()
    self.squid:render()
end

--[[
    Called when this state changes to another state.
]]
function PlayState:exit()
end