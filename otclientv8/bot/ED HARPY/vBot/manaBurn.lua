addIcon("Mana burn",{item={id=3051}, text="Mana burn"}, macro(500, function()
  if manapercent() > 80 then
    say('utana vid')
    delay(1000)
  end
end))
