setDefaultTab("HP")

addSeparator("separator")

local manapot = macro(300, "Mana Pot",  function()
  if (manapercent() <= tonumber(storage.belowmana)) then
    usewith(tonumber(storage.manapot), player) 
  end
end)
addLabel("", "Manapot ID:")
addTextEdit("", storage.manapot or "268", function(widget, text)    
  storage.manapot = text
end)
addLabel("", "Use Below % Mana:")
addTextEdit("", storage.belowmana or "99", function(widget, text)    
  storage.belowmana = text
end)

addSeparator("separator")
macro(50, "Healing Spell",  function()
  if (hppercent() <= tonumber(storage.belowhp)) then
    say(storage.healspell) 
  end
end)

addLabel("", "Healing Spell:")

addTextEdit("", storage.healspell or "Healing Spell", function(widget, text)    
  storage.healspell = text
end)

addLabel("", "Heal Below % Hp:")

addTextEdit("", storage.belowhp or "99", function(widget, text)    
  storage.belowhp = text
end)
