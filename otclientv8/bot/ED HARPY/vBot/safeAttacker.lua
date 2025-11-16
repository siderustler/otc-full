-- vbot/AttackBot.lua
-- change line 1073 to condition below
-- if spec ~= player and (spec:isPlayer() and not (spec:isPartyMember() or isFriend(spec:getName()))) then

local m = macro(50, "Safe Attacker", function() end)

-- ADD TO FRIEND LIST
onTextMessage(function(mode,text)
    if not m.isOn() then return end
    local re = "You lose (%d+) hitpoints due to an attack by (.+)%."
    local _, playerName = text:match(re)

  
    if playerName and playerName ~= "" then

      local spectators = getSpectators()
      for i,spec in ipairs(spectators) do
        if spec:getName() == playerName then
            if spec:isPlayer() and not isFriend(spec:getName()) and spec:getSkull() ~= 0 and spec:getSkull() ~= 6 then
                table.insert(storage.playerList.friendList, playerName)
                delay(2000)
                break
            end
        end
      end
    end
end)
  
  -- CLEAR FRIEND LIST
macro(45000, function()
    -- clean friend list to avoid attacking player which lost skull (change macro time if pz lasts less than 45 secs)
    if not m.isOn() then return end
    storage.playerList.friendList = {}
    CachedFriends = {}
end)


addIcon("Safe Attack",{item={id=3288}, text="Safe Attack"}, m)

