macro(100, 'AoL', function()
  if not getNeck() then
      say('!aol')
  end
end)

if player:getBlessings() == 0 then
    say("!pvpbless")
    schedule(4000, function()
        if player:getBlessings() == 0 then
            error("!! Blessings not bought !!")
        end
    end)
end

macro(500, "SUMMON BAXPIA", function()
saySpell("!summon", 200)
delay(7500)
end)

macro(100, "HOLY FALCON", function()
    if manapercent() < 10 then
    use(8175)
    delay(800)
    end
end)