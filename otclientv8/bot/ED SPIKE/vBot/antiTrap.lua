addIcon("Anti Trap",{item={id=3197}, text="Anti Trap"}, macro(2000, "Anti Trap", function ()
    local lastMoved = 0
    local maxStandTime = 3000
    if CaveBot.isOff() then return end
    if storage.caveManager.isTraining then return end
    
    local tiles = getNearTiles(pos())
    for i, tile in ipairs(tiles) do
      local topThing = tile:getTopThing()
      local isMoveable = not topThing:isNotMoveable()
      local isWg = topThing and topThing:getId() == 2130
      if not tile:hasCreature() and not tile:isWalkable() and maxStandTime then
        if isMoveable then
          if not isInPz()  then
            return useWith(3197, tile:getTopThing()) -- disintegrate
          else
            if now < lastMoved + 200 then return end -- delay to prevent clogging
            local nearTiles = getNearTiles(tile:getPosition())
            for i, tile in ipairs(nearTiles) do
              local tpos = tile:getPosition()
              if pos() ~= tpos then
                if tile:isWalkable() then
                  lastMoved = now
                  return g_game.move(topThing, tpos) -- move item
                end
              end
            end
          end
        end
      end
      if isWg then
        useWith(9596, tile:getTopThing())
      end
    end
end))
