local stopCaveBot = 75
local startCaveBot = 90

macro(500, "CaveBot start/stop", function()
  if manapercent(75) <= stopCaveBot and CaveBot.isOn() then
    CaveBot.setOff()
  elseif manapercent(90) >= startCaveBot and CaveBot.isOff() then
    CaveBot.setOn()
  end
end)

macro(1000, "CAVE OFF IF LOW CC", function()
    if itemAmount(3043) <= 20 then
        CaveBot:setOff()
        TargetBot:setOff()
    end
end)

macro(20000, "FWB", function()
  say('!fwb')
end)

macro(20000, "SOFTY", function()
  say('!softy')
end)

macro(60000, "task maxpoints", function()
  say('!task maxpoints')
end)

macro(20000, "task level", function()
  say('!task level')
end)

macro(500, "Lure+5monsters,Off,if0", function()
    if isInPz() then return end
    local monsters = 0
    for i, mob in ipairs(getSpectators(posz())) do
        if mob:isMonster() and getDistanceBetween(player:getPosition(), mob:getPosition()) >= 1 and getDistanceBetween(player:getPosition(), mob:getPosition()) <= 10 then
            monsters = monsters + 1
        end
    end

    if monsters >= 6  then
      if TargetBot:isOff() then TargetBot:setOn() end
    elseif monsters == 2  then
      if TargetBot:isOn() then TargetBot:setOff() end
    end
end)

macro(5000, "Firewalk Enchanter", function()
  if getFeet():getId() == 9020 then
    usewith(676, getFeet())
    end
end)