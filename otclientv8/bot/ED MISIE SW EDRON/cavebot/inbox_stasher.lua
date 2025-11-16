--containers to stash to
local stashToContainers = {28750}

--containers to stash from
local stashFromContainers = {12902}

StashResolver = {}
CaveBot.Extensions.DepoStasher = {}

function StashResolver.GetStashContainer(stashContainers, actualContainer)

end

function StashResolver.Stash()
    local dest
    local from
    local locker = getContainerByName("Locker")

    if not locker then
        print("Locker not opened, unable to stash")
        return false
    end

    for i, item in pairs(locker:getItems()) do
        -- find final destination
        if table.find(stashToContainers, item:getId()) then
             dest = { container = item, slot = i }

        end
        -- find item to move
        if table.find(stashFromContainers, item:getId()) then
            from = { container = item, slot = i }
            print("FROM " .. from.container:getId())
        end

    end

    if dest and from then
        print("from container " .. from.container:getId())
        for i, elo in pairs(locker:getSlotPosition(dest.slot)) do
            print("pozycja w locker" .. i .. " a wartosc " .. elo)
         end
         print("a count to " .. from.container:getCount())
         CaveBot.delay(2000)
        return CaveBot.StashItem(from.container, dest.slot, locker) -- g_game.move(from.container, locker:getSlotPosition(dest.slot), from.container:getCount())
    end
    return false
end
CaveBot.Extensions.DepoStasher.setup = function()
  CaveBot.registerAction("DepoStasher", "#C300FF", function(value, retries)

    local val = string.split(value, ",")

    -- resume when too much retries
    if retries >= 50 then return false end

    -- reach depo
    if not CaveBot.ReachDepot() then return "retry" end
    -- open locker
    if not CaveBot.OpenLocker() then return "retry" end

    if not StashResolver.Stash() then return "retry" end

    return true
 end)

 CaveBot.Editor.registerAction("depostasher", "depo/inbox stasher", {
  value="inbox",
  title="Inbox/Depo Stasher",
  description="Stash your items from (depo|inbox) to stash",
  validation = "^(depo|inbox)$"
 })
end


onTextMessage(function(mode,text)

end)