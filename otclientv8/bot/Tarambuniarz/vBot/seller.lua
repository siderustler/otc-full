UI.Separator()
local ui = setupUI([[
Panel
  height: 71
  padding: 2

  BotItem
    id: key
    anchors.top: parent.top
    anchors.left: parent.left
    margin-left: 1

  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: prev.right
    anchors.right: parent.right
    text-align: center
    width: 138
    !text: tr('Sell Items')
    margin-top: 9
    margin-left: 5

  BotContainer
    id: CapItems
    anchors.top: key.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    margin-top: 5
    height: 34 
]])

if not storage.dropper then
    storage.dropper = {
enabled = false,
capItems = {},
key = nil
    }
end

local config = storage.dropper

ui.title:setOn(config.enabled)
ui.title.onClick = function(widget)
config.enabled = not config.enabled
ui.title:setOn(config.enabled)
end

UI.Container(function()
    config.capItems = ui.CapItems:getItems()
end, true, nil, ui.CapItems)
ui.CapItems:setItems(config.capItems)

ui.key.onItemChange = function(widget)
config.key = widget:getItemId()
end
ui.key:setItemId(config.key)

local function properTable(t)
    local r = {}
    for _, entry in pairs(t) do
      table.insert(r, entry.id)
    end
    return r
end

macro(300, function()
    if not config.enabled then return end
    local containers = getContainers()
    for i, container in pairs(containers) do
        for j, item in ipairs(container:getItems()) do
            if table.find(properTable(config.capItems), item:getId()) then
                useWith(config.key, item)
            end
        end
    end
end)