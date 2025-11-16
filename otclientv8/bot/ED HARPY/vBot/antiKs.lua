if not storage.caveManager then storage.caveManager = { isLeavingExp = false, isRunning = false, isTraining = false } end

local function spellAttack()
    local spellsToCast = {"exori gran frigo", "exori max frigo", "exori vis"}
    for _, spell in ipairs(spellsToCast) do
        if g_game.isAttacking() then
        say(spell)
        end
        delay(300)
    end
end

addIcon("Anti KS",{item={id=3397}, text="Anti KS"}, macro(1000, "Anti KS", function()
    local config = storage.caveManager
    if not CaveBot.isOn() then return end
    local maxMonsterAmount = getMonsters(8) > 8
    local maxStandTime = 5000
    local isDangerous = (not isSafe(8, true) and maxMonsterAmount)

    if standTime() > maxStandTime and not isInPz() then
        TargetBot.setOn()
        AttackBot.setOn()
        spellAttack()
    end

    if TargetBot.isOn() then
        if isDangerous or config.isRunning or config.isLeavingExp then
            TargetBot.setOff()
        end
    end
    if TargetBot.isOff() then
        if not config.isRunning and not config.isLeavingExp and not isDangerous then
            TargetBot.setOn()
            AttackBot.setOn()
        end
    end
end))
