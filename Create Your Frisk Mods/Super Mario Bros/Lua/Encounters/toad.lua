music = "smwcastle"
encountertext = "Here we go..."
wavetimer = 5.0
arenasize = {155, 130}
possible_attacks = {"toad/bricks", "toad/fireballs", "toad/lava", "toad/plants", "toad/shells", "toad/big_plant", "toad/magic"}
revive = true

deathtext = {"\n     [voice:coin][speed:0.1][color:00ff00]1-up![func:extralife][w:4][sound:1-up]", "You have [color:00ff00][voice:coin][w:15]2[w:15][voice:default][color:ffffff] lives remaining."}

enemies = {
"toad"
}

enemypositions = {
{0, -1}
}

function extralife()
	if Player.lv > 11 then
		deathtext = {"\n     [voice:coin][speed:0.1][color:00ff00]1-up![func:extralife][w:4][sound:1-up]", "You have [color:00ff00][voice:coin][w:15]1[w:15][voice:default][color:ffffff] life remaining."}
		Player.lv = Player.lv - 1
		Player.atk = 75
	end
	if Player.lv == 11 then
		deathtext = "[w:45][novoice]   [sound:game_over]Continue?"
		revive = false
	end
end

function EncounterStarting()
	Player.lv = 13
	Player.hp = 68
	Player.atk = 75
	Player.name = "Weegee"
	Audio.Stop()
	enemies[1]["currentdialogue"] = {"[novoice][effect:none][sound:little_toadies/y]Yahoo!", "[novoice][effect:shake,0.25][color:d82800][sound:little_toadies/dh][func:OhNo]Here we go!", "[noskip][func:LaunchMusic][func:State, ACTIONSELECT][next]"}
	State("ENEMYDIALOGUE")
	enemies[1].Call("SetSprite", "toad/idle")
end

function EnemyDialogueStarting()
	if enemies[1].GetVar("hp") > 0 then
		enemies[1].Call("SetSprite", "toad/didle")
	end
	nextwaves = { possible_attacks[math.random(#possible_attacks)] }
	if nextwaves[1] == "toad/big_plant" or nextwaves[1] == "toad/bricks" then
		arenasize = {256, 400}
	elseif nextwaves[1] == "toad/shells" or nextwaves[1] == "toad/lava" then
		arenasize = {768, 130}
	end
end

function EnemyDialogueEnding()
	if enemies[1].GetVar("hp") < 1 then
		nextwaves = {"empty"}
	elseif nextwaves[1] == "toad/big_plant" or nextwaves[1] == "toad/fireballs" or nextwaves[1] == "toad/lava" then
		enemies[1].Call("SetSprite", "toad/dpower")
		Audio.PlaySound("little_toadies/da")
	end
end

function DefenseEnding()
	if enemies[1].GetVar("hp") > 0 then
		enemies[1].Call("SetSprite", "toad/didle")
	end
	encountertext = RandomEncounterText()
	arenasize = {155, 130}
	if enemies[1].GetVar("hp") < 1 then
		enemies[1].Call("Kill")
	end
end

function HandleSpare()
	State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
	BattleDialog({"Selected item " .. ItemID .. "."})
end