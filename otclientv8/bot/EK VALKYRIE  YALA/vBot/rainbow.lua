UI.Separator()

local rainbowOutfitTime = 1

rainbowOutfit = macro(rainbowOutfitTime, "Rainbow Outfit", function ()
  rainbowOutfit()
end)

function rainbowOutfit()
    local randomColor = math.random(1,132)
    local pOutfit = player:getOutfit()
    local rainbowOutfit = { type = pOutfit.type, head = randomColor, body = randomColor, legs = randomColor, feet = randomColor, addons = pOutfit.addons}
    setOutfit(rainbowOutfit)
  return true
end
