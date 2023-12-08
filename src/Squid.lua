 -- squid is the main character

Squid = Class{}

SQUID_IMAGES = {
    up = {love.graphics.newImage('art/playerGrey_up1.png'),love.graphics.newImage('art/playerGrey_up2.png')},    
    right = {love.graphics.newImage('art/playerGrey_walk1.png'), love.graphics.newImage('art/playerGrey_walk2.png')},
}
function Squid:init(enemies)
    self.enemies = enemies
    self.image = love.graphics.newImage('art/playerGrey_walk1.png')
    self.x = VIRTUAL_WIDTH / 4 
    self.y = VIRTUAL_HEIGHT / 4 
    self.speed = 300
    self.width = self.image:getWidth()*0.25
    self.height = self.image:getHeight()*0.25
    self.scaleX = 0.25
    self.scaleY = 0.25
    self.collision = HC.circle(self.x, self.y, 13)
    self.colisionColor = {0,0,100,0.3}

end

function Squid:update(dt)
    if love.keyboard.isDown('z') then
        self.dy = -self.speed
        self.image = SQUID_IMAGES.up[math.floor(love.timer.getTime()*4) % 2 +1]
        self.scaleY = math.abs(self.scaleY )
    elseif love.keyboard.isDown('s') then
        self.dy = self.speed
        self.image = SQUID_IMAGES.up[math.floor(love.timer.getTime()*4) % 2 +1]
        self.scaleY = -math.abs(self.scaleY )
    else
        self.dy = 0
    end

    if love.keyboard.isDown('q') then
        self.dx = -self.speed
        self.image = SQUID_IMAGES.right[math.floor(love.timer.getTime()*4) % 2 +1]
        self.scaleX = - math.abs(self.scaleX)
    elseif love.keyboard.isDown('d') then
        self.dx = self.speed
        self.image = SQUID_IMAGES.right[math.floor(love.timer.getTime()*4) % 2 +1]
        self.scaleX =  math.abs(self.scaleX)
    else
        self.dx = 0
    end

    -- boundary checking
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.height, self.x + self.dx * dt)
    end

    self.collision:moveTo(self.x, self.y)
    if self:checkCollisions(self.enemies, self) then
        --gStateMachine:change('gameover')
        self.colisionColor = {0,0,100,0.3}
    else
        self.colisionColor = {0,100,0,0.3}
    end

end

function Squid:checkCollisions(enemies, squid)
    for _, enemy in ipairs(enemies) do
        if enemy.collision:collidesWith(squid.collision) then
            return true
        end
    end
    return false
end

function Squid:render()
    --love.graphics.draw(drawable, x, y, rotation, scaleX, scaleY, originOffsetX, originOffsetY)
    love.graphics.draw(self.image, self.x, self.y,0,self.scaleX,self.scaleY, self.width+27, self.height+20)
    love.graphics.setColor(self.colisionColor)
    self.collision:draw('fill')
    love.graphics.setColor(255,255,255)

end