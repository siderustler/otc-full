setDefaultTab("Cave")

local cashManager = "cashManager"
if not storage[cashManager] then storage[cashManager] = { balance = 0, minCashToBot = 0 } end

local function formatNumber(num)
    local formattedNum = ""
    local parsedNum = tonumber(num)
    if parsedNum >= 1e9 then
        formattedNum = string.format("%.0fkkk", parsedNum / 1e9)
    elseif parsedNum >= 1e6 then
        formattedNum = string.format("%.0fkk", parsedNum / 1e6)
    elseif parsedNum >= 1e3 then
        formattedNum = string.format("%.0fk", parsedNum / 1e3)
    else
        formattedNum = string.format("%.0f", parsedNum)
    end
    return formattedNum
end

local function formatAbbreviatedNumber(str)
    local suffixes = {
        ["k"] = 1e3,
        ["kk"] = 1e6,
        ["kkk"] = 1e9
    }

    local num, suffix = str:match("(%d+)([kK]+)")

    if num and suffix and suffixes[suffix:lower()] then
        local formattedNum = tonumber(num) * suffixes[suffix:lower()]
        return string.format("%.0f", formattedNum)
    else
        return "invalid"
    end
end

UI.Separator()
UI.Label("Character Balance")
local labelPrefix = "Balance is: "
local labelRef = UI.Label(labelPrefix .. formatNumber(storage[cashManager].balance or 0))

UI.Separator()

local m = macro(1000, "Stop CaveBot on low cash", function ()
    local currBalance = tonumber(storage.cashManager.balance or 0)
    local minCash = tonumber(storage.cashManager.minCashToBot)
    if currBalance <= minCash and CaveBot.isOn() then
        warn("CaveBot turning off.. Cash limit reached .. Current cash is " .. currBalance)
        CaveBot.setOff()
    end
end)

UI.TextEdit(formatNumber(tonumber(storage[cashManager].minCashToBot)), function(widget, newText)
    local formattedNum = formatAbbreviatedNumber(newText)
    if formattedNum == "invalid" then
        widget:setText("0")
        storage[cashManager].minCashToBot = 0
    else
        storage[cashManager].minCashToBot = formattedNum
    end

end)
UI.Separator()

macro(5000, function ()
    local preyWindowRef = modules.game_prey.preyWindow
    if preyWindowRef then
        local retrievedBalance = preyWindowRef.gold:getText()
        storage[cashManager].balance = retrievedBalance:gsub("%D", "")
        labelRef:setText(labelPrefix .. formatNumber(storage[cashManager].balance or 0))
    end
end)





