--[[ 
    -- [ IMBUEMENTS CODES ] --
    [BOT] Basic Scorch | id: 1
    [BOT] Intricate Scorch | id: 2
    [BOT] Powerful Scorch | id: 3
    [BOT] Basic Venom | id: 4
    [BOT] Intricate Venom | id: 5
    [BOT] Powerful Venom | id: 6
    [BOT] Basic Frost | id: 7
    [BOT] Intricate Frost | id: 8
    [BOT] Powerful Frost | id: 9
    [BOT] Basic Electrify | id: 10
    [BOT] Intricate Electrify | id: 11
    [BOT] Powerful Electrify | id: 12
    [BOT] Basic Reap | id: 13
    [BOT] Intricate Reap | id: 14
    [BOT] Powerful Reap | id: 15
    [BOT] Basic Vampirism is id: 16
    [BOT] Intricate Vampirism is id: 17
    [BOT] Powerful Vampirism is id: 18
    [BOT] Basic Void | id: 19
    [BOT] Intricate Void | id: 20
    [BOT] Powerful Void | id: 21
    [BOT] Basic Strike | id: 22
    [BOT] Intricate Strike | id: 23
    [BOT] Powerful Strike | id: 24
    [BOT] Basic Chop | id: 25
    [BOT] Intricate Chop | id: 26
    [BOT] Powerful Chop | id: 27
    [BOT] Basic Swiftness | id: 28
    [BOT] Intricate Swiftness | id: 29
    [BOT] Powerful Swiftness | id: 30
    [BOT] Basic Slash | id: 31
    [BOT] Intricate Slash | id: 32
    [BOT] Powerful Slash | id: 33
    [BOT] Basic Precision | id: 34
    [BOT] Intricate Precision | id: 35
    [BOT] Powerful Precision | id: 36
    [BOT] Basic Blockade | id: 37
    [BOT] Intricate Blockade | id: 38
    [BOT] Powerful Blockade | id: 39
    [BOT] Basic Epiphany | id: 40
    [BOT] Intricate Epiphany | id: 41
    [BOT] Powerful Epiphany | id: 42
    [BOT] Basic Lich Shroud | id: 43
    [BOT] Intricate Lich Shroud | id: 44
    [BOT] Powerful Lich Shroud | id: 45
    [BOT] Basic Snake Skin | id: 46
    [BOT] Intricate Snake Skin | id: 47
    [BOT] Powerful Snake Skin | id: 48
    [BOT] Basic Dragon Hide | id: 49
    [BOT] Intricate Dragon Hide | id: 50
    [BOT] Powerful Dragon Hide | id: 51
    [BOT] Basic Quara Scale | id: 52
    [BOT] Intricate Quara Scale | id: 53
    [BOT] Powerful Quara Scale | id: 54
    [BOT] Basic Cloud Fabric | id: 55
    [BOT] Intricate Cloud Fabric | id: 56
    [BOT] Powerful Cloud Fabric | id: 57
    [BOT] Basic Cloud Fabric | id: 58
    [BOT] Intricate Demon Presence | id: 59
    [BOT] Powerful Demon Presence | id: 60
    [BOT] Basic Bash | id: 61
    [BOT] Intricate Bash | id: 62
    [BOT] Powerful Bash | id: 63
    [BOT] Basic Featherweight | id: 64
    [BOT] Intricate  Featherweight | id: 65
    [BOT] Powerful  Featherweight | id: 66
--]]
    



-- [[ settings ]] -- 
local imbueTable = {
    ["Pomagier"] = {
         [3326] = {21,24},            -- epee
         [7992] = {21},            -- magician hat
    },
    ["Funbwoy"] = {
        [3326] = {21,24},            -- epee
        [7992] = {21},            -- magician hat
   },
   ["Morena Cordoba"] = {
    [34254] = {21,18},            -- lion hammer
    [10385] = {21},            -- zaoan helmet
    [13993] = {18}             -- ornate chestplate
   },
   ["Scripts By Dey"] = {
    [22866] = {21,18,24},            -- bow
    [10385] = {21},            -- zaoan helmet
    [16110] = {18}             -- arm
   },
   ["Cweluch"] = {
    [22866] = {21,18,24},            -- bow
    [10385] = {21},            -- zaoan helmet
    [13994] = {18}             -- arm
   },
   ["Kamilka"] = {
    [22866] = {21,18,24},            -- bow
    [10385] = {21},            -- zaoan helmet
    [13994] = {18}             -- arm
   },
}

local safeTime = 1 * 60 * 60 -- when duration of buff is above this time (default 1h) it wont perform any action
local time = 100 -- some delay is required between action to prevent kicks
local lastCalled = now

onImbuementWindow(function(itemId, slots, activeSlots, imbuements, needItems)
    -- ignore if called recently to avoid bugs
    if now - lastCalled < 2000 then return end
    -- no imbue slots, do nothing
    if slots == 0 then return end

    local name = player:getName()
    local imbuData = imbueTable[name][itemId]

    -- no imbue data, do nothing
    if not imbuData then return end

    -- all good, proceed
    for i=0,slots-1 do
        -- gotta slow down the function otherwise will kick
        schedule(i*time, function()
            local isActive = activeSlots[i]
            if isActive then
                isActive = isActive[2]
            end
            -- can use this slot as imbue
            if not isActive or isActive < safeTime then
                --clear existing imbue
                if isActive and isActive < safeTime then
                    g_game.clearImbuement(i)
                end
                local imbuementId = imbuData[i+1]
                if imbuementId then
                    g_game.applyImbuement(i, imbuementId, true)
                end
            end
        end)
    end
    -- when finish close window
    modules.game_imbuing.hide()
end)