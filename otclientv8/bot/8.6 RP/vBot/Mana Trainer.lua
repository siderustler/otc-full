local stopCaveBot = 70
local startCaveBot = 80

addIcon("START/STOP", {item={id=3157}, text="START STOP"}, macro(500, function()
  if manapercent(70) <= stopCaveBot and CaveBot.isOn() then
    CaveBot.setOff()
  elseif manapercent(80) >= startCaveBot and CaveBot.isOff() then
    CaveBot.setOn()
  end
end))

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

local function checkPos(x, y)
 xyz = g_game.getLocalPlayer():getPosition()
 xyz.x = xyz.x + x
 xyz.y = xyz.y + y
 tile = g_map.getTile(xyz)
 if tile then
  return g_game.use(tile:getTopUseThing(), 1, { ignoreNonPathable = true, precision = 1 })
 else
  return false
 end
end

Bugmap = {}
Bugmap = macro(1, function()
 if modules.corelib.g_keyboard.isKeyPressed('NumPad8') then
  checkPos(0, -5)
 elseif modules.corelib.g_keyboard.isKeyPressed('NumPad9') then
  checkPos(5, -5)
 elseif modules.corelib.g_keyboard.isKeyPressed('NumPad6') then
  checkPos(5, 0)
 elseif modules.corelib.g_keyboard.isKeyPressed('NumPad3') then
  checkPos(5, 5)
 elseif modules.corelib.g_keyboard.isKeyPressed('NumPad2') then
  checkPos(0, 5)
 elseif modules.corelib.g_keyboard.isKeyPressed('NumPad1') then
  checkPos(-5, 5)
 elseif modules.corelib.g_keyboard.isKeyPressed('NumPad4') then
  checkPos(-5, 0)
 elseif modules.corelib.g_keyboard.isKeyPressed('NumPad7') then
  checkPos(-5, -5)
 end
end)


addIcon("Bug Map", {item=10607, text="Bug Map", hotkey="NumPad0"}, function(icon, isOn)
  Bugmap.setOn(isOn) 
end)