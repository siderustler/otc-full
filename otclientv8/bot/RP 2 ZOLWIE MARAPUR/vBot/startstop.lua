setDefaultTab("Tools")


UI.Button("Bot OnOff", function()
   if TargetBot.isOn() and CaveBot.isOn() or TargetBot.isOn() and CaveBot.isOff() or TargetBot.isOff() and CaveBot.isOn() then
        TargetBot.setOff()
        CaveBot.setOff()
        warn("BotSet: Off")
    elseif TargetBot.isOff() and CaveBot.isOff() or TargetBot.isOn() and CaveBot.isOff() or TargetBot.isOff() and CaveBot.isOn() then
        TargetBot.setOn()
        CaveBot.setOn()
        warn("BotSet: On")
        return        
    end
  end)
