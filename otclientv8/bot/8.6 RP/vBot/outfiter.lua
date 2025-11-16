local looktypes = {
    {outfitID = 143, addons = 0}, 
    {outfitID = 152, addons = 0},
    {outfitID = 128, addons = 0},
    {outfitID = 134, addons = 0},
    {outfitID = 151, addons = 0},
    {outfitID = 153, addons = 0},
    {outfitID = 154, addons = 0},
    {outfitID = 145, addons = 0},
    {outfitID = 144, addons = 0}
}

local outfit = {
  head = 0,
  body = 1,
  legs = 2,
  feet = 3
}

macro(300, "Outfiter",  function()
  outfit.head = (outfit.head + 1) % 133
  outfit.body = (outfit.body + 1) % 133
  outfit.legs = (outfit.legs + 1) % 133
  outfit.feet = (outfit.feet + 1) % 133

  -- get looktype & addons
  local lt = looktypes[math.random(#looktypes)]
  outfit.type = lt.outfitID
  outfit.addons = lt.addons

  setOutfit(outfit)
end)

macro(250, "Dance", function()
    turn(math.random(0,3))
 end)

UI.Separator()

function MathRandomExclude(lowerbound,upperbound,exclude)
  local x = math.random(lowerbound,upperbound)
  if type(exclude) == "table" then
    for _,v in pairs(exclude) do
      if v == x then
        return MathRandomExclude(lowerbound,upperbound,exclude)
      end
    end
  else
    if x == exclude then
      return MathRandomExclude(lowerbound,upperbound,exclude)
    end
  end
  return x
end

local rainbow={[0]=94,[1]=77,[2]=79,[3]=82,[4]=88,[5]=90,[6]=91}
local excludeid ={86,87,88,89}
local oldoutfit={}
local outfit={}
id = 0

macro(100, "FairyColors",  function()
outfit = player:getOutfit()
  outfit.head = ((MathRandomExclude(85,93,excludeid)%93)-math.random(0,1)*4*19)
  outfit.body = ((MathRandomExclude(85,93,excludeid)%93)-math.random(0,1)*4*19)
  outfit.legs = ((MathRandomExclude(85,93,excludeid)%93)-math.random(0,1)*4*19)
  outfit.feet = ((MathRandomExclude(85,93,excludeid)%93)-math.random(0,1)*4*19)
  setOutfit(outfit);
end)


macro(100, "RandomOutfit",  function()
outfit = player:getOutfit()
  outfit.head = (math.random(76,134))%133
  outfit.body = (math.random(76,134))%133
  outfit.legs = (math.random(76,134))%133
  outfit.feet = (math.random(76,134))%133
  setOutfit(outfit);
end)


macro(100, "RainbowOutfit",  function()
outfit = player:getOutfit()
  if outfit ~= oldoutfit then
      oldoutfit = outfit
      outfit.head = (rainbow[id%7])
      outfit.body = (rainbow[(id+1)%7])
      outfit.legs = (rainbow[(id+2)%7])
      outfit.feet = (rainbow[(id+3)%7])
      setOutfit(outfit);
      id = id+1
  end
end)