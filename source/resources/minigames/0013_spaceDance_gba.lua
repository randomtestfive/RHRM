function lminigame()
  img = {
    sheet = newImageAssetFlipped("/space dance/sheet.png")
  }
  
  dancers = {}
  
  --frame height and frame width
  fw = 69
  fh = 99
  
  for i = 0, 3 do
    dancers[i] = {}
    dancers[i].anim = newAnimationGroup(img.sheet)
    dancers[i].anim:addAnimation("idle",0,0,fw,fh,2,50)
    dancers[i].anim:addFrame("idle",fw*2,0,fw,fh,10000000)
    dancers[i].anim:addAnimation("turn",0,fh,fw,fh,3,150)
    dancers[i].anim:addFrame("turn",fw*3,fh,fw,fh,10000000)
    dancers[i].anim:addAnimation("right1",0,fh*2,fw,fh,2, 500)
    dancers[i].anim:addAnimation("right2",fw,fh*2,fw,fh,5, 75)
    
    dancers[i].anim:setAnimation("idle")
    dancers[i].player = false
  end
  
  dancers[3].player = true
end

function uminigame(dt)
  for i = 0, 3 do
    if dancers[i].anim:getCurrentAnimation() == "right1" and dancers[i].anim:getCurrentFrame() == 1 then
      dancers[i].anim:setAnimation("right2")
    end
    if dancers[i].anim:getCurrentAnimation() == "right2" and dancers[i].anim:getLength("right2")-1 == dancers[i].anim:getCurrentFrame() then
      dancers[i].anim:setAnimation("idle")
    end
    for _,s in pairs(currentSounds) do
      print(s.name)
      if s.name == "turn" then
        dancers[i].anim:setAnimation("turn")
      elseif s.name == "right" and dancers[i].anim:getCurrentAnimation() == "right1" and dancers[i].anim:getCurrentFrame() == 1 then
        dancers[i].anim:setAnimation("right2")
      elseif s.name == "right" then
        dancers[i].anim:setAnimation("right1")
      end
    end
    if dancers[i].anim:getCurrentAnimation() == "idle" and beat == 10 then
      dancers[i].anim:setFrame(0)  
    end
    dancers[i].anim:update(dt)
   end
end

function dminigame()
  setColorHex("0000d6")
  love.graphics.rectangle("fill",0,0,view.width,view.height)
  setColorHex("ffffff")
  dancers[0].anim:draw(40,0,0,2,2)
end

return {lminigame,uminigame,dminigame}