-- load all otui files, order doesn't matter
local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text

local configFiles = g_resources.listDirectoryFiles("/bot/" .. configName .. "/vBot", true, false)
for i, file in ipairs(configFiles) do
  local ext = file:split(".")
  if ext[#ext]:lower() == "ui" or ext[#ext]:lower() == "otui" then
    g_ui.importStyle(file)
  end
end

local function loadScript(name)
  return dofile("/vBot/" .. name .. ".lua")
end

-- here you can set manually order of scripts
-- libraries should be loaded first
local luaFiles = {
  "items",
  "vlib",
  "new_cavebot_lib",
  "configs", -- do not change this and above
  "extras",
  "playerlist",
  "BotServer",
  "alarms",
  "HEALING",
  "Conditions",
  "Equipper",
  "pushmax",
  "combo",
  "HealBot",
  "new Healer",
  "AttackBot", -- last of major modules
  "main",
  "autohaste",
  "manashield",
  "amuletRecharge",
  "deathRelog",
  "e ring",
  "mwalls",
  "mw",
  "ingame_editor",
  "Dropper",
  "Containers",
  "tools",
  "quiver_manager",
  "Mana Trainer",
  "antiRs",
  "cavebot",
  "depot_withdraw",
  "anty paral",
  "follow",
  "rainbow",
  "outfiter",
  "cast_food",
  "eat_food",
  "imbu_handler",
  "equip",
  "exeta",
  "analyzer",
  "jewellery_equipper",
  "spy_level",
  "supplies",
  "depositer_config",
  "Sio",
  "npc_talk",
  "xeno_menu",
  "cavebot_control_panel"
}

for i, file in ipairs(luaFiles) do
  loadScript(file)
end

setDefaultTab("Main")
UI.Separator()
