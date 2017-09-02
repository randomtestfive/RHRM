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
    dancers[i].anim:addAnimation("turn",0,fh,fw,fh,3,225)
    dancers[i].anim:addFrame("turn",fw*3,fh,fw,fh,10000000)
    dancers[i].anim:addAnimation("right1",0,fh*2,fw,fh,2, 500)
    dancers[i].anim:addAnimation("right2",fw,fh*2,fw,fh,5, 75)
    dancers[i].anim:addAnimation("lets",0,fh*3,fw,fh,2,50)
    dancers[i].anim:addFrame("lets",fw*2,fh*3,fw,fh,100000)
    dancers[i].anim:addAnimation("sit",fw*3,fh*3,fw,fh,1,100)
    dancers[i].anim:addFrame("sit",fw*4,fh*3,fw,fh,100000)
    dancers[i].anim:addAnimation("down",0,fh*4,fw,fh,2,400)
    dancers[i].anim:addFrame("down",fw*2,fh*4,fw,fh,50)
    dancers[i].anim:addFrame("down",fw*3,fh*4,fw,fh,50)
    dancers[i].anim:addFrame("down",fw*4,fh*4,fw,fh,50)
    dancers[i].anim:addFrame("down",fw*5,fh*4,fw,fh,50)
    dancers[i].anim:addFrame("down",fw*6,fh*4,fw,fh,50)
    dancers[i].anim:addAnimation("pa1",0,fh*5,fw,fh,2,200)
    dancers[i].anim:addFrame("pa1",fw*2,fh*5,fw,fh,1000000)
    dancers[i].anim:addAnimation("pa2",0,fh*6,fw,fh,2,200)
    dancers[i].anim:addFrame("pa2",fw*2,fh*6,fw,fh,1000000)
    dancers[i].anim:addAnimation("punch1",0,fh*7,fw,fh,2,200)
    dancers[i].anim:addAnimation("punch2",fw*2,fh*7,fw,fh,5,100)
    dancers[i].anim:addAnimation("hurt",0,fh*8,fw,fh,3,100)
    dancers[i].anim:addFrame("hurt",fw*3,fh*8,fw,fh,1000)
    dancers[i].anim:addFrame("hurt",fw*2,0,fw,fh,50)
    
    dancers[i].anim:setAnimation("idle")
    dancers[i].player = false
  end
  
  dancers[3].player = true
  pa = 0
end

function uminigame(dt)
--player code
  local hit = false
  local barely = false
  local cue = ""
  for _,s in pairs(currentHits) do
    if s.name == "right" or s.name == "punch" or s.name == "down" then
      hit = true
      barely = s.bearly
      cue = s.name
    end
  end
  
  if hit then
    if input["pressA"] then
      dancers[3].anim:setAnimation("punch1")
    elseif input["pressRIGHT"] then
      dancers[3].anim:setAnimation("right1")
    elseif input["pressDOWN"] then
      dancers[3].anim:setAnimation("down")
    end
  end
  
  --other dancers (and player)
  local animStart = false;
  for i = 0, 3 do
    if dancers[i].anim:getCurrentAnimation() == "right1" and dancers[i].anim:getCurrentFrame() == 1 then
      dancers[i].anim:setAnimation("right2")
      animStart = true
    end
    
    if dancers[i].anim:getCurrentAnimation() == "punch1" and dancers[i].anim:getCurrentFrame() == 1 then
      dancers[i].anim:setAnimation("punch2")
      animStart = true
    end
    
    for _,s in pairs(currentSounds) do
      if s.name == "turn" then
        dancers[i].anim:setAnimation("turn")
      elseif s.name == "right" and not dancers[i].player then
        dancers[i].anim:setAnimation("right1")
      elseif s.name == "right" and not hit and dancers[3].anim:getCurrentAnimation() == "turn" then
        dancers[i].anim:setAnimation("hurt")
      elseif s.name == "lets" then
        dancers[i].anim:setAnimation("lets")
      elseif s.name == "sit" then
        dancers[i].anim:setAnimation("sit")
      elseif s.name == "down" and not dancers[i].player then
        dancers[i].anim:setAnimation("down")
        animStart = true
      elseif s.name == "down" and not hit and dancers[3].anim:getCurrentAnimation() == "sit" then
        dancers[i].anim:setAnimation("hurt")
      elseif s.name == "pa1" then
        dancers[i].anim:setAnimation("pa1")
      elseif s.name == "pa2" then
        dancers[i].anim:setAnimation("pa2")
      elseif s.name == "punch" and not dancers[i].player then
        dancers[i].anim:setAnimation("punch1")
        animStart = true
      elseif s.name == "punch" and not hit and dancers[3].anim:getCurrentAnimation() == "pa1" then
        dancers[i].anim:setAnimation("hurt")
      end
      
    end
    
    if not animStart and (dancers[i].anim:getCurrentAnimation() == "right2" or dancers[i].anim:getCurrentAnimation() == "down" or dancers[i].anim:getCurrentAnimation() == "punch2" or dancers[i].anim:getCurrentAnimation() == "hurt") and dancers[i].anim:getLength(dancers[i].anim:getCurrentAnimation())-1 == dancers[i].anim:getCurrentFrame() then
      dancers[i].anim:setAnimation("idle")
    end
    
    if dancers[i].anim:getCurrentAnimation() == "idle" and beat == 10 then
      dancers[i].anim:setFrame(0)  
    end
    
  end
  
  for i = 0, 3 do
    dancers[i].anim:update(dt)
  end
end

function dminigame()
  setColorHex("0000d6")
  love.graphics.rectangle("fill",0,0,view.width,view.height)
  setColorHex("ffffff")
  for i = 3, 0, -1 do
    dancers[i].anim:draw(math.floor(view.width/2+120*i)-260,math.floor(view.height/2-3*99/2),0,3,3) --TODO: do some actual math
  end
end

return {lminigame,uminigame,dminigame}