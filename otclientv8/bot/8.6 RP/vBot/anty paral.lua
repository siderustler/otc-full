addSeparator("separator")

macro(250, "Anty Paral", nil, function()
  if isParalyzed() or not hasHaste() then
    say(storage.antiparaspell)
  end
end)

addLabel("", "Anti Para Spell:")
addTextEdit("", storage.antiparaspell or "utani hur", function(widget, text)    
  storage.antiparaspell = text
end)