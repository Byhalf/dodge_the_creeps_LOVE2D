Enemy = Class{}

ENEMY_SPRITES = {
    {'art/enemyFlyingAlt_1.png', 'art/enemyFlyingAlt_2.png'} ,
    {"art/enemySwimming_1.png", "art/enemySwimming_2.png"},
    {"art/enemyWalking_1.png","art/enemyWalking_2.png"}

}

function Enemy:init(x,y, x_speed, y_speed)

    --local enemySprite = ENEMY_SPRITES[math.random(#ENEMY_SPRITES)]
    local enemySprite = ENEMY_SPRITES[1]

    self.scale = 0.25
    self.images = {love.graphics.newImage(enemySprite[1]),love.graphics.newImage(enemySprite[2])}
    self.image = self.images[1]
    self.width = self.image:getWidth()*0.25
    self.height = self.image:getHeight()*0.25
    self.x,self.y, self.x_speed , self.y_speed =x, y , x_speed, y_speed
    self.offsetX , self.offsetY = self.width*0.5, self.height*0.5
    self.offset = 50
    self.angle =  math.atan2( self.y_speed ,self.x_speed)
    self.collision = HC.circle(self.x+self.offsetX , self.y+self.offsetY, 10)
    self.collision:rotate(self.angle,self.x,self.y)
end



function Enemy:update(dt)
    self.x = self.x + dt * self.x_speed
    self.y = self.y + dt * self.y_speed
    self.collision:move(dt * self.x_speed, dt * self.y_speed)      
    -- every 0.04 second change sprite
    self.image = self.images[ math.floor(love.timer.getTime()*4) % 2 +1] 

end

function Enemy:isInBounds()
    if self.x < -self.width*2 or self.x > VIRTUAL_WIDTH+ self.width*2 
    or self.y < -self.height*2 or self.y > VIRTUAL_HEIGHT + self.height*2
    then
        return false
    end
    return true
end


function Enemy:render()
    love.graphics.draw(self.image, self.x, self.y, self.angle,0.25,0.25, self.offsetX, self.offsetY)
    -- love.graphics.setColor(100,0,0,0.6)
    --self.collision:draw('fill')
    --love.graphics.setColor(255,255,255)

end




