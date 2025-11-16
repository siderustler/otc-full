setDefaultTab("Cave")

UI.Label("Imbuement Items")
if type(storage.imbueItems) ~= "table" then
    storage.imbueItems = {3359, 3327}
  end
local imbueContainer = UI.Container(function(widget, items)
    storage.imbueItems = items
end, true)
imbueContainer:setHeight(35)
imbueContainer:setItems(storage.imbueItems)

macro(100, "Imbuement Items", function() end)

UI.Separator()