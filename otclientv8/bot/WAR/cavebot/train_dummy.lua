CaveBot.Extensions.TrainingDummy = {}

local mlvlDummies = {28564}
local exerciseWeapons = {28556, 35283,35289}
local trainingDummy = nil
local currentWeapon = nil
local weaponCharges = 0

CaveBot.Extensions.TrainingDummy.setup = function (value)
    CaveBot.registerAction("trainingdummy", "#db5a5a", function (value)
        -- set trainingDummy to nil to proke search for training dummy on every func run
        trainingDummy = nil
        -- leave dummy when stamina refilled
        if value == 'no' and stamina() > 1300 then
            warn("Stamina refilled to ".. stamina() .. " leaving training...")
            return true
        end
        -- localize dummy
        for _, tile in ipairs(g_map.getTiles(posz())) do
            for _, item in ipairs(tile:getItems()) do
                local id = item:getId()
                if table.find(mlvlDummies, id) then
                    trainingDummy = tile:getTopUseThing()
                  break
                end
            end
        end
        -- retry when dummy not found
        if not trainingDummy then
            warn("CaveBot[Trainingdummy] Training dummy not found! Retrying in 20 secs...")
            delay(20000)
            return "retry"
        end

        -- get rod to use and proke onTextMessage callback
        for i, container in pairs(g_game.getContainers()) do
            for j, item in ipairs(container:getItems()) do
                local id = item:getId()
                if table.find(exerciseWeapons, id) then
                    currentWeapon = id
                    g_game.look(item)
                    delay(20000)
                    return "retry"
                end
            end
        end
        -- warn when exercise weapon not found
        if type(currentWeapon) ~= "number" then
            warn("CaveBot[Trainingdummy] Exercise weapon not found!")
        end

        delay(20000)
        return "retry"
    end)

CaveBot.Editor.registerAction("trainingdummy", "dummy", {
    value="no",
    title="Training dummy",
    description="Infinite training?",
    validation="no|yes",
    multiline = false,
}) end

onTextMessage(function(mode, text)
    local pattern = "exercise rod that has" --fixme
    local dissapeared = "your training weapon has disappeared."

     if CaveBot.isOff() then return end
     if string.find(text:lower():trim(), dissapeared) then
        warn("exercise weapon dissapeared, continuing...")
        currentWeapon = nil
        weaponCharges = 0
        return
     end


     if not string.find(text, pattern) then return end
  
     local digits = ""
     for digit in text:lower():trim():gmatch("%d+") do
        digits = digits .. digit
     end

     local currentCharges = tonumber(digits)
     if currentCharges < weaponCharges then
        weaponCharges = currentCharges
        return
     end
     if trainingDummy ~= nil and currentCharges >= weaponCharges then
        useWith(currentWeapon, trainingDummy)
        warn("Using next exercise weapon...")
        weaponCharges = currentCharges
     end
 end)


