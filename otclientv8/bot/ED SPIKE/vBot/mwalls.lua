setDefaultTab("Main")

local toggle = macro(20, "mwall step", "PageUp",function() end)

onPlayerPositionChange(function(newPos, oldPos)
    if oldPos.z ~= posz() then return end
    if oldPos then
        local tile = g_map.getTile(oldPos)
        if toggle.isOn() and tile:isWalkable() then
            useWith(3180, tile:getTopUseThing())
            toggle.setOff()
        end
    end
end)

local toggle2 = macro(20, "mwall on target", "PageDown",function() end)

onCreaturePositionChange(function(creature, newPos, oldPos)
    if creature == target() or creature == g_game.getFollowingCreature() then
        if oldPos and oldPos.z == posz() then
            local tile2 = g_map.getTile(oldPos)
            if toggle2.isOn() and tile2:isWalkable() then
                useWith(3180, tile2:getTopUseThing())
                toggle2.setOff()
            end 
        end
    end
end)

hotkey("4", "Drop Flower To Mouse", function()
    local tile = getTileUnderCursor()
    if tile then
        local pos = tile:getPosition()
        local itemToMouse = 2988
        for _, container in pairs(g_game.getContainers()) do
            for __, item in ipairs(container:getItems()) do
                if item:getId() == itemToMouse then
                    return g_game.move(item, pos, 1)
                end
            end
        end
    end
end)


local c = {
    pickUp = {28714,34096,34093,3246,30006,290,39188,39163,27565,30401,30403}, -- lista de items
    CheckPOS = 1 -- SQM a distancia para recoger
}
addIcon("ZBIERACZKA", {item={id=3253}, text="ZBIERACZKA"}, macro(20, function()
    for x = -c.CheckPOS, c.CheckPOS do
        for y = -c.CheckPOS, c.CheckPOS do
            local tile = g_map.getTile({x = posx() + x, y = posy() + y, z = posz()})
            if tile then
                local things = tile:getThings()
                for _, item in pairs(things) do
                    if table.find(c.pickUp, item:getId()) then
                        local containers = getContainers()
                        for _, container in pairs(containers) do
                            g_game.move(item, container:getSlotPosition(container:getItemsCount()), item:getCount())
                        end
                    end
                end
            end
        end
    end
end))