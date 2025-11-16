setDefaultTab("Main")


local dropItems = { 3031 }
local dropDelay = 100

gpAntiPushDrop = macro(dropDelay , "Anti Push", function ()
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
local playerName = "GIOVANNI PAOLO SECONDO" -- NAME OF PLAYER
local pot = 238
 macro (100, "POTOWANIE KOGOS", function()
  local player = getCreatureByName(playerName)
  if manapercent() >= belowMp then
    usewith(pot, player)
    delay(ex)
  end
end)
local utamoHp = 60
local exanaHp = 90
local safeMana = 5
macro(100, "Utamo", function()
    if hppercent() <= utamoHp and not hasManaShield() and manapercent() > safeMana then
        say("utamo vita")
    elseif hasManaShield() and (hppercent() >= exanaHp or manapercent() < safeMana) then
        say("exana vita")
    end
end)




local minDist = 4
local maxDist = 6
local mList = {"Naga Archer", "Dark Torturer", "Orc", "Monk"}
local lastCast = now
macro(1000, "SMART AMP RES", function()
    if isInPz() then return end
    local monsters = 0
    for _, mob in ipairs(getSpectators(posz())) do
        if mob:isMonster() then
            local actualDist = getDistanceBetween(player:getPosition(), mob:getPosition())
            if actualDist >= minDist and actualDist <= maxDist then
                if table.contains(mList, mob:getName(), true) then
                    monsters = monsters + 1
                end
            end
        end
    end
    if monsters >= 1 then
        if manapercent() > 30 then
            if not modules.game_cooldown.isCooldownIconActive(101) and not modules.game_cooldown.isCooldownIconActive(133) then
                if canCast("exeta amp res") and now - lastCast > 8000 then
                    say("exeta amp res")
                    lastCast = now
                end
            end
        end
    end
end)