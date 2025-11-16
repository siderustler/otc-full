

addIcon("Wall lure", {item=17210}, macro(100, function (macro)
    local creatures = 0
    if CaveBot.isOff() or TargetBot.isOff() then
        macro.setOff()
    end
    if CaveBot.isOn() and TargetBot.isOn() then
        macro.setOn()
    end
    local ppos = player:getPosition()
    local tiles = getNearTiles(ppos)
    for i, mob in ipairs(getSpectators(posz())) do
        if mob:isMonster() and getDistanceBetween(ppos, mob:getPosition()) >= 1 and getDistanceBetween(ppos, mob:getPosition()) <= 10 then
            creatures = creatures + 1
        end
    end
    if creatures > 4  then
        for i, tile in ipairs(tiles) do
            local tilePos = tile:getPosition()
            local minimapColor = g_map.getMinimapColor(tilePos)
            local stairs = minimapColor >= 210 and minimapColor <= 213
            
            if not stairs and not tile:isWalkable() then
                -- set position to move
                local movePos = {x = ppos.x - tile.x, y = ppos.y - tile.y, z = ppos.z}
                if movePos.x > 0 then
                    movePos.x = tile.x + 1
                end
                if movePos.x < 0 then
                    movePos.x = tile.x - 1
                end
                if movePos.y > 0 then
                    movePos.y = tile.y + 1
                end
                if movePos.y < 0 then
                    movePos.y = tile.y - 1
                end
                local moveTile = g_map.getTile(movePos)
                -- move to pos
                if moveTile:isWalkable() then
                    CaveBot.GoTo(movePos,1)
                end
            end
        end
    end
end))
