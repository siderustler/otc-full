CaveBot.Extensions.RewardShrine = {}

local rewardShrines = {25802, 25803, 25720, 25721}
local shrine = nil

CaveBot.Extensions.RewardShrine.setup = function ()
    CaveBot.registerAction("rewardshrine", "#db5a5a", function ()
        -- localize shrine
        for _, tile in ipairs(g_map.getTiles(posz())) do
            for _, item in ipairs(tile:getItems()) do
                local id = item:getId()
                if table.find(rewardShrines, id) then
                  shrine = item
                  break
                end
            end
        end
        if not shrine then
            warn("CaveBot[RewardShrine] shrine not found!")
            shrine = nil
            return false
        end
        destination = shrine:getPosition()

        -- reach shrine
        if not CaveBot.MatchPosition(destination, 1) then
            CaveBot.GoTo(destination, 1)
            delay(1000)
            return "retry"
        end
        use(shrine)
        delay(2000)
        modalpanel = modules.game_modaldialog.modalDialog
        if modalpanel then
            return "retry"
        end
        return true
    end)

CaveBot.Editor.registerAction("rewardshrine", "reward shrine", {
    value="dey_scripts",
    title="Reward Shrine",
    description="Reward Shrine",
    validation="dey_scripts",
    multiline = false,
}) end

onModalDialog(function(id, title, message, buttons, enterButton, escapeButton, choices, priority)
    -- handle dialog
    modalpanel = modules.game_modaldialog.modalDialog
    if modalpanel then
        choiceList = modalpanel:getChildById('choiceList')
        if choiceList then
            for i, widget in pairs(choiceList:getChildren()) do
                if (widget:getText() == "Daily Reward [pick reward!]") then
                    choiceList:focusChild(widget)
                    modalpanel:onEnter()
                    return "retry"
                end
            end
        end
        -- if dialog still opened choose choice
        modalpanel = modules.game_modaldialog.modalDialog
        if modalpanel then
            modalpanel:onEnter()
            return "retry"
        end
        -- if dialog still opened, destroy dialog
        modalpanel = modules.game_modaldialog.modalDialog
        if modalpanel then
            modules.game_modaldialog:destroyDialog()
            return "retry"
        end
    end
end)


