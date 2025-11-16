local utamoHp = 60
local exanaHp = 90
local safeMana = 5
addIcon("UTAMO", {item={id=3051}, text="UTAMO"}, macro(100, function()
    if hppercent() <= utamoHp and not hasManaShield() and manapercent() > safeMana then
        say("utamo vita")
    elseif hasManaShield() and (hppercent() >= exanaHp or manapercent() < safeMana) then
        say("exana vita")
end
end))