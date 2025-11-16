local setup = {discharged = 22060, useItem = 22083}
addIcon("AMULET RECHARGE",{item={id=22060}, text="AMULET RECHARGE"}, macro(2000, "Recharge Werewolf Amulet", function()
  if getNeck() and (getNeck():getId() == setup.discharged) then
    moveToSlot(getNeck(), getBack())
  elseif findItem(setup.discharged) then
      useWith(findItem(setup.useItem), findItem(setup.discharged)) 
  end
end))