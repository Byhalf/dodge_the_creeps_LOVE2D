EnemiesSpawner = Class{}

function EnemiesSpawner:init()
    self.enemies = {}

end

function EnemiesSpawner:getEnemies()
    return self.enemies
end

function EnemiesSpawner:update(dt)
    for k,enemy in ipairs(self.enemies) do
        enemy:update(dt)
        if not enemy:isInBounds() then
            self.enemies[k] = Enemy(self:getCoordinatesAndSpeed())
        end
    end
end

function EnemiesSpawner:render()
    for _, enemy in ipairs(self.enemies) do
        enemy:render()
    end
end

function EnemiesSpawner:spawnEnemies()
    for _=1,20 do
        table.insert(self.enemies, Enemy(self:getCoordinatesAndSpeed()))
    end
end



function EnemiesSpawner:getCoordinatesAndSpeed()
    local offset = 50
    local min_speed = 50
    local max_speed = 100
     -- table of functions, each creates coordinates from a side of the screen and speed
    local coordinatesAndSpeedGenerators = {
        function() --top
            return math.random(VIRTUAL_WIDTH), -offset ,
            math.random(max_speed*2)-max_speed ,  math.random(min_speed, max_speed)
        end, 
        function() --bottom
            return math.random(VIRTUAL_WIDTH), VIRTUAL_HEIGHT +offset, 
            math.random(max_speed*2)-max_speed , -math.random(min_speed, max_speed) 
        end,
        function() -- right
            return VIRTUAL_WIDTH + offset, math.random(VIRTUAL_HEIGHT),
            -math.random(min_speed,max_speed) , math.random(max_speed*2)-max_speed  
        end,
        function() --left
            return -offset, math.random(VIRTUAL_HEIGHT) , 
            math.random(min_speed,max_speed) , math.random(max_speed*2)-max_speed 
         end
    }
    return coordinatesAndSpeedGenerators[math.random(#coordinatesAndSpeedGenerators)]()
    -- maybe not the most elegant solution but I think it's fun and comming from java I wanted to try 
    -- some first class order shenanigans
end

