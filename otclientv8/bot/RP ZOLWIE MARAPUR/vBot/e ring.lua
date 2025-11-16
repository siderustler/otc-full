local amuletID = 3081
SSA = macro(100, function()
if getNeck() == nil or getNeck():getId() ~= amuletID then
moveToSlot(amuletID, SlotNeck)
   end
end)
addIcon("SSA", {item=3081}, function(icon, isOn)
  SSA.setOn(isOn) 
end)


local ringID = 3048
MR = macro(100, function()
if getFinger() == nil or getFinger():getId() ~= ringID then
moveToSlot(ringID, SlotFinger)
   end
end)
addIcon("MR", {item=3048}, function(icon, isOn)
  MR.setOn(isOn) 
end)
