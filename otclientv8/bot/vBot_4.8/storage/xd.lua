local choicesToIgnore = {"Resting Area Bonuses (0)"}

onModalDialog(function(id, title, message, buttons, enterButton, escapeButton, choices, priority)
    local dialogOption = 0
        print("xd")
    if choices[2][2] ~= "Daily Reward [picked]" then modules.game_modaldialog:destroyDialog()
    else
        for i = 1, choices do
            local choiceId = choices[i][1]
            local choiceName = choices[i][2]

            if choiceName == "Daily Reward [picked]" then return true end

            if not table.find(choicesToIgnore, choiceName)  then
                dialogOption = choiceId
            end
        end
    end
    if dialogOption > 0 then
        g_game.answerModalDialog(id, enterButton, dialogOption)
    end
end)
return true
--local modalpanel = modules.game_modaldialog.modalDialog

--for i=1, 10, 1 do
--    if modalpanel then
--        print("siema")
--        local choiceList = modalpanel:getChildById('choiceList')
--        if choiceList then
--            for i, widget in pairs(choiceList:getChildren()) do
--                if not table.find(choicesToIgnore, widget:getText()) then
--                    choiceList:focusChild(widget)
--                    modalpanel:onEnter()
--                end
--            end
--        end
--    end
--end
--if modules.game_modaldialog.modalDialog then modules.game_modaldialog:destroyDialog() -- end

--return true