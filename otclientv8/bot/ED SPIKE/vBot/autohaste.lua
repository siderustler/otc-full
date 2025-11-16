setDefaultTab("Main")

macro(250, "Auto Haste", nil, function()
  if not hasHaste() then
    say(storage.autohastespell)
  end
end)

addLabel("", "Auto Haste Spell:")
addTextEdit("", storage.autohastespell or "utani hur", function(widget, text)    
  storage.autohastespell = text
end)