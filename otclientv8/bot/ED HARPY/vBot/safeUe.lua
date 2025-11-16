addIcon("Safe UE", {item={id=3191}, text="Safe UE"}, macro(300, "Safe UE", function()
    local minMonsters = getMonsters(5) > 4
    if isSafe(8, true) and minMonsters then
      delay(100)
      say('exevo gran mas frigo')
    end
end))