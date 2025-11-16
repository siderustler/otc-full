setDefaultTab("Main")
addLabel("", "Auto Follow")
addSeparator()

local objectsTable = {7727, 8265, 1629, 1632, 8266, 7728, 1211, 1220, 1224, 1228, 1233, 1238, 1242, 1246, 1251, 1256, 1260, 1540, 3546, 3548, 3550, 3552, 4915, 5083, 5109, 5111, 5113, 5115, 5127, 5129, 5131,
    5133, 5142, 5145, 5283, 5285, 5289, 5293, 5516, 5737, 5749, 6194, 6199, 6203, 6207, 6251, 6256, 6260, 6264, 6798, 6802, 6902, 6904, 6906, 6908, 7044,
    7046, 7048, 7050, 7055, 8543, 8548, 8552, 8556, 9167, 9172, 9269, 9274, 9274, 9269, 9278, 9282, 10270, 10275, 10279, 10283, 10479, 10481, 10485, 10483,
    10786, 12101, 12199, 19851, 19853, 19991, 19993, 20284, 20286, 17238, 13021, 10790, 12103, 12205, 19855, 19995, 20288, 10792, 12105, 12203, 19857, 19997,
    20290, 22825, 22827, 22829, 22831, 1214, 1222, 1226, 1230, 1236, 1240, 1244, 1248, 1254, 1258, 1262, 1542, 3537, 3539, 3541, 3543, 4918, 5085, 5100, 5102, 5104, 5106, 5118,
    5120, 5122, 5124, 5136, 5139, 5280, 5287, 5291, 5295, 5518, 5734, 5746, 6197, 6201, 6205, 6209, 6254, 6258, 6262, 6266, 6796, 6800, 6893,
    6895, 6897, 6899, 7035, 7037, 7039, 7041, 7057, 8546, 8550, 8554, 8558, 9170, 9174, 9272, 9276, 9280, 9284, 10273, 10277, 10281, 10285,
    10470, 10472, 10476, 10474, 10777, 12094, 12190, 19842, 19844, 19982, 19984, 20275, 20277, 17236, 18209, 13023, 10781, 12096, 12196,
    19846, 19986, 20279, 10783, 12098, 12194, 19848, 19988, 20281, 22816, 22818, 22820, 22822, 1224, 1226, 1228, 1230, 1242, 1244, 1246, 1248, 1256, 1258, 1260, 1262, 3541, 3543, 3550, 3552, 5104, 5106, 5113, 5115, 5122, 5124, 5131, 5133,
    5289, 5291, 5293, 5295, 6203, 6205, 6207, 6209, 6260, 6262, 6264, 6266, 6897, 6899, 6906, 6908, 7039, 7041, 7048, 7050, 8552, 8554, 8556, 8558,
    9176, 9178, 9180, 9182, 9278, 9280, 9282, 9284, 10279, 10281, 10283, 10285, 10474, 10476, 10483, 10485, 10781, 12096, 12196, 19846, 19986, 20279,
    10783, 12098, 12194, 19848, 19988, 20281, 10790, 12103, 12205, 19855, 19995, 20288, 10792, 12105, 12203, 19857, 19997, 20290, 1223, 1225, 1241, 1243, 1255, 1257, 3542, 3551, 5105, 5114, 5123, 5132, 5288, 5290, 5745, 5748, 6202, 6204, 6259, 6261, 6898, 6907, 7040, 7049,
    8551, 8553, 9175,9177, 9277, 9279, 10278, 10280, 10475, 10484, 10782, 12097, 19847, 19987, 20280, 10791, 12104, 12204, 12195, 19856, 19996, 20289,
    22821, 22830, 1227, 1229, 1245, 1247, 1259, 1261, 3540, 3549, 5103, 5112, 5121, 5130, 5292, 5294, 6206, 6208, 6263, 6265, 6896, 6905, 7038, 7047, 8555, 8557,9179, 9181,
    9281, 9283, 10282, 10284, 10473, 10482, 10780, 10789, 10780, 12095, 12195, 19845, 19985, 20278, 10789, 12102, 12193, 12202, 19854, 19994, 20287, 5129, 1644, 1666, 8261, 1646,
    -- objects
    435, 1948, 7771, 1723, 5542, 386

  }

local panelName = "ultimateFollow"
if not storage[panelName] then
  storage[panelName] = 'name'
end
local toFollowPos = {}

UI.TextEdit(storage[panelName] or "name", function(widget, newText)
  storage[panelName] = newText
end)





local ultimateFollow = macro(10000, "Ultimate Follow", function() end)

local function getNearTiles(pPosition, range)
  pPosition = pPosition or pos()
  range = range or 1
  if type(pPosition) ~= "table" then
    pPosition = pPosition:getPosition()
  end
  local tiles = {}
  if pPosition and pPosition.x and pPosition.y then 
    for x = -range, range do
      for y = -range, range do
        local tile = g_map.getTile({x = pPosition.x + x, y = pPosition.y + y, z = pPosition.z})
        if tile and math.max(math.abs(x), math.abs(y)) <= range then
          table.insert(tiles, tile)
        end
      end
    end
  end
  return tiles
end



local function useClosestItem(targetPos, dist)
  dist = dist or 3
  targetPos = targetPos or toFollowPos[posz()]

  local closestDistance = math.huge
  local closestItem = nil

  for _, tile in ipairs(getNearTiles(targetPos, dist)) do
    for _, item in ipairs(tile:getItems()) do
      if table.find(objectsTable, item:getId()) then
        if item:getId() == 386 then
          return say("exani tera")
        end
        local distance = getDistanceBetween(tile:getPosition(), targetPos)
        if distance < closestDistance then
          closestDistance = distance
          closestItem = item
        end
      end
    end
  end

  if closestItem then
    g_game.use(closestItem)
  end
end

local function isReachable(position, precis)
  precis = precis or 0
  local path = findPath(pos(), position, 10, { ignoreFields = true, ignoreNonPathable = true, ignoreCreatures = true, precision = precis})
  return path ~= nil
end

local expectedDirs = {}
local isWalking = false
local walkPath = {}
local walkPathIter = 0

resetWalking = function()
  expectedDirs = {}
  walkPath = {}
  isWalking = false
end

local function doWalking()
  if #expectedDirs == 0 then
    return false
  end
  if #expectedDirs >= 3 then
    resetWalking()
  end
  local dir = walkPath[walkPathIter]
  if dir then
    g_game.walk(dir, false)
    table.insert(expectedDirs, dir)
    walkPathIter = walkPathIter + 1
    uFollowMacro.timeout = player:getStepDuration(false, dir) + 20
    return true
  end
  return false
end

onPlayerPositionChange(function(newPos, oldPos)
  if not oldPos or not newPos then return end

  local dirs = {{NorthWest, North, NorthEast}, {West, 8, East}, {SouthWest, South, SouthEast}}
  local dir = dirs[newPos.y - oldPos.y + 2]
  if dir then
    dir = dir[newPos.x - oldPos.x + 2]
  end
  if not dir then
    dir = 8
  end

  if not isWalking or not expectedDirs[1] then
    walkPath = {}
    uFollowMacro.timeout = player:getStepDuration(false, dir) + 150
    return
  end

  if expectedDirs[1] ~= dir then
    uFollowMacro.timeout = player:getStepDuration(false, dir) + 20
    return
  end

  table.remove(expectedDirs, 1)
end)

local function shortWalker(inputPos, inputDelay)
  inputDelay = inputDelay or 0
  if not inputPos then return end
  doWalking()
  local path = findPath(pos(), inputPos, 40, {precision = 1})
  if path and #path ~= 0 then
    g_game.walk(path[1], false)
    isWalking = true
    walkPath = path
    walkPathIter = 2
    expectedDirs = {path[1]}
    uFollowMacro.timeout = player:getStepDuration(false, path[1]) + (g_game.getPing() > 90 and g_game.getPing() or 90) + inputDelay
  end
  return true
end


local lastFollow = nil
uFollowMacro = macro(50, function()
  if ultimateFollow.isOff() then return end
  local target = getPlayerByName(storage[panelName])
  local zPos = posz()
  if target then
    local tpos = target:getPosition()
    if isReachable(tpos, 1) then
      toFollowPos[tpos.z] = tpos
      lastFollow = storage[panelName]
    end
  end
  local prevFollow = getPlayerByName(lastFollow)
  if not toFollowPos or table.size(toFollowPos) == 0 or toFollowPos[zPos] == nil then return end
  
  if not player:isWalking() then
    local distanceToTarget = prevFollow and math.max(math.abs(posx() - prevFollow:getPosition().x), math.abs(posy() - prevFollow:getPosition().y)) or 0
    if prevFollow and (distanceToTarget > 1 and not isReachable(prevFollow:getPosition(), 1)) then
      useClosestItem(toFollowPos[zPos], 3)
    elseif not prevFollow and not target then
      useClosestItem(toFollowPos[zPos], 2)
    elseif not prevFollow or not isReachable(toFollowPos[zPos], 1) then
      useClosestItem(toFollowPos[zPos], 1)
    end
  end
  shortWalker(toFollowPos[zPos])
  local cTile = g_map.getTile(toFollowPos[zPos])
  if cTile and cTile:getTopUseThing() then
    g_game.useInventoryItemWith(3308, cTile:getTopUseThing())
  end
end)



onCreaturePositionChange(function(creature, newPos, oldPos)
  if ultimateFollow.isOff() then return end
  if creature:getName():lower() ~= storage[panelName]:lower() then return end

  if newPos and oldPos and posz() == newPos.z then
    if isReachable(newPos, 1) then
      toFollowPos[newPos.z] = newPos
    end
  end

  if oldPos and newPos then
    if oldPos.z ~= newPos.z then
      toFollowPos[oldPos.z] = oldPos
    end
  end
  if oldPos and oldPos.z ~= posz() then return end

  if oldPos and ((g_game.getPing() > 100 and isRewardChest()) or  g_game.getPing() < 60) then
    shortWalker(oldPos, g_game.getPing())
  end
end)

local rewardChests = {
    [1723] = { lastInteract = 0 },
    [2031] = { lastInteract = 0 },
    [2472] = { lastInteract = 0 },
    [4073] = { lastInteract = 0 },
    [4077] = { lastInteract = 0 },
    [23740] = { lastInteract = 0 },
    [23741] = { lastInteract = 0 },
    [24040] = { lastInteract = 0 }
}
LastChestClick = now

macro(200, "Auto Reward", function()
    for _, tile in ipairs(g_map.getTiles(posz())) do
        local tPos = tile:getPosition()
        for _, item in ipairs(tile:getItems()) do
            local intObject = rewardChests[item:getId()]
            if intObject then
                if not intObject.lastInteract or (now - intObject.lastInteract) >= 20000 then
                    if math.max(math.abs(tPos.x - posx()), math.abs(tPos.y - posy())) == 1 then
                        g_game.use(item)
                        intObject.lastInteract = now
                        LastChestClick = intObject.lastInteract
                        return
                    end
                end
            end
        end
    end
end)

local exitMacro
exitMacro = macro(1000, "Find TP", function()
    for _, tile in ipairs(g_map.getTiles(posz())) do
        for _, item in ipairs(tile:getItems()) do
            if item:getId() == 1949 then
                autoWalk(tile:getPosition(), 100, { ignoreNonPathable = true })
                exitMacro.setOff()
            end
        end
    end
end)

local allowed = { "Friz" }
onTalk(function(name, level, mode, text, channelId, pos)
    local t = text:lower()
    if table.find(allowed, name) then
        if t == "follow" then
            ultimateFollow.setOn()
        elseif t == "stop" then
             ultimateFollow.setOff()
        elseif t == "lp" then
            g_game.partyLeave()
        elseif t == "say invite" then
            say('invite')
        elseif t == "exit" then
            exitMacro.setOn()
        end
    end
end)

UI.Separator()