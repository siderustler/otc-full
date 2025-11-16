hotkey("HOME", "MWall", function()
    local tile = getTileUnderCursor()
    if not tile then return end
    g_game.useInventoryItemWith(3180, tile:getTopUseThing())
end)

macro(1500, "EXIVA",  function()
  say('exiva "' .. storage.ExivaPlayer)
end)

addTextEdit("ExivaPlayer", storage.ExivaPlayer or "Player Name", function(widget, text) 
storage.ExivaPlayer = text
end)