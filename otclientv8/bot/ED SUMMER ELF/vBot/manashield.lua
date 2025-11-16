local utamoHp = 60
local exanaHp = 90
local safeMana = 25
addIcon("UTAMO", {item={id=3051}, text="UTAMO"}, macro(100, function()
    if hppercent() <= utamoHp and not hasManaShield() and manapercent() > safeMana then
        say("utamo vita")
    elseif hasManaShield() and (hppercent() >= exanaHp or manapercent() < safeMana) then
        say("exana vita")
end
end))

addIcon("UTAMO_EXP", {item={id=3051}, text="UTAMO_EXP"}, macro(100, function()
    if hppercent() <= utamoHp and not hasManaShield() and manapercent() > safeMana then
        say("utamo vita")
    elseif hasManaShield() and (hppercent() >= exanaHp or manapercent() < safeMana) and not storage.isLeavingExp then
        say("exana vita")
end
end))