function lminigame()
  
end

function uminigame(dt)

end

function dminigame()
  setColorHex("f3f3f3")
  love.graphics.rectangle("fill",0,0,view.width,view.height)
end

return {lminigame,uminigame,dminigame}