    delay(1000)

    reachGroundItem(25803)

    delay(5000)

    useGroundItem(25803)

    delay(2000)

    onModalDialog(function(id, title, message, buttons, enterButton, escapeButton, choices, priority)

        local choicesToIgnore = {"Resting Area Bonuses (0)", "Daily Reward [picked]"}

        if (string.find(message, "Next reward after")) then

            if modules.game_modaldialog.modalDialog then modules.game_modaldialog.modalDialog.onEscape() end

        else

          for j = 1, #choices do

            local choiceId = choices[j][1]

            local choiceName = choices[j][2]

            if not table.find(choicesToIgnore, choiceName) then

              g_game.answerModalDialog(id, enterButton, choiceId)

              delay(2000)
            for k = 1, 5 do
                if modules.game_modaldialog.modalDialog then modules.game_modaldialog.modalDialog.onEnter() end
            end
            end

          end

        end

      end)

    if modules.game_modaldialog.modalDialog then modules.game_modaldialog.modalDialog.onEscape() end

return true