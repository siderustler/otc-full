addIcon("DEATH RELOG", {item={id=3392}, text="DEATH RELOG"}, macro(1000, "relog after death", function()
    if hppercent() <= 0 or not g_game.isOnline() then
      modules.client_entergame.CharacterList.doLogin()
    end
  end))