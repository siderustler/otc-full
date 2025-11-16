setDefaultTab("Main")


local dropItems = {3031}
local dropDelay = 10

gpAntiPushDrop = macro(dropDelay , "Antipush", "*", function ()
  antiPush()
end)

onPlayerPositionChange(function()
    antiPush()
end)

function antiPush()
  if gpAntiPushDrop:isOff() then
    return
  end

  local tile = g_map.getTile(pos())
  if tile then
    local thing = tile:getTopThing()
    if thing then
      for _, item in pairs(dropItems) do
        if item ~= thing:getId() then
            local dropItem = findItem(item)
            if dropItem then
              g_game.move(dropItem, pos(), 1)
            end
        end
      end
    end
  end
end

local targetID = nil

-- escape when attacking will reset hold target
onKeyPress(function(keys)
    if keys == "Escape" and targetID then
        targetID = nil
    end
end)

macro(100, "Hold Target", function()
    -- if attacking then save it as target, but check pos z in case of marking by mistake on other floor
    if target() and target():getPosition().z == posz() and not target():isNpc() then
        targetID = target():getId()
    elseif not target() then
        -- there is no saved data, do nothing
        if not targetID then return end

        -- look for target
        for i, spec in ipairs(getSpectators()) do
            local sameFloor = spec:getPosition().z == posz()
            local oldTarget = spec:getId() == targetID
            
            if sameFloor and oldTarget then
                attack(spec)
            end
        end
    end
end) 

addSeparator("separator")

local distance = 4
local amountOfMonsters = 1
local pvespeller = macro(250, "PvE Speller" ,  function()
    local specAmount = 0
    if not g_game.isAttacking() then
        return
    end
    for i,mob in ipairs(getSpectators()) do
        if (getDistanceBetween(player:getPosition(), mob:getPosition())  <= distance and mob:isMonster())  then
            specAmount = specAmount + 1
        end
    end
    if (specAmount >= amountOfMonsters) then
        say(storage.uespell)
    end
end)
addLabel("", "UE Spell:")
addTextEdit("", storage.uespell or "ue", function(widget, text)    
  storage.uespell = text
end)

local target
macro(1, "Fast attack", function()
  if g_game.isAttacking() then
    target = g_game.getAttackingCreature()
  end
  if target then
    g_game.attack(target)
  end
end)
onCreatureDisappear(function(creature)
  if not target then return end
  if target:getId() == creature:getId() then
    target = nil
  end
end)

local belowMp = 80
local ex = 800
local playerName = "JOHN PAUL SECOND" -- NAME OF PLAYER
local pot = 238
 macro (100, "MANA FRIEND", function()
  local player = getCreatureByName(playerName)
  if manapercent() >= belowMp then
    usewith(pot, player)
    delay(ex)
  end
end)

function getPlayers(range, multifloor)
  if not range then range = 10 end
    local specs = 0;
    for _, spec in pairs(getSpectators(multifloor)) do
      if not spec:isLocalPlayer() and spec:isPlayer() and distanceFromPlayer(spec:getPosition()) <= range and 
      not ((spec:getShield() ~= 1 and spec:isPartyMember()) or spec:getEmblem() == 1) then
      specs = specs + 1
    end
  end
  return specs;
end

macro(100, "XLOG 8PPLS", function()
  if getPlayers(8, false) == 8 then
    modules.game_interface.forceExit()
  end
end)

addIcon("ON/OFF", {item={id=9018}, text="ON/OFF"}, macro(100, function(macro)
  if TargetBot.isOff() or CaveBot.isOff() then
    CaveBot.setOn()
    TargetBot.setOn()
    macro.setOff()
  else
    CaveBot.setOff()
    TargetBot.setOff()
    macro.setOff()
end
end))

local manaCost = 1400
local ex = 1000
addIcon("PARALBLACH", {item={id=3165}, text="PARAL BLACH"}, macro(100, function()
    for _, spec in ipairs(getSpectators()) do
      if not spec:isPlayer() then return end
            if spec:getEmblem() == 2 and mana() >= manaCost then
	useWith(3165, spec)
        delay(ex)
        end
    end
end))
