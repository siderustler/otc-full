local lastCast = 0
macro(250, "Auto Manashield", function()
  if not hasManaShield() or (now - lastCast) > 90000 then
    say("Utamo Vita")
    lastCast = now
  end
end)