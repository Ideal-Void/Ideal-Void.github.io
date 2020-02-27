music = "zarpman_super_mario_medley"
encountertext = "It's-a-him."
wavetimer = 5.0
arenasize = {155, 130}
revive = true
lastwaves = {}
noPipes = 0

deathtext = {"\n     [voice:coin][speed:0.1][color:00ff00]1-up![func:extralife][w:4][sound:1-up]", "You have [color:00ff00][voice:coin][w:15]2[w:15][voice:default][color:ffffff] lives remaining."}

enemies = {
"mario"
}

enemypositions = {
{0, 0}
}

function extralife()
	if Player.lv > 1 then
		deathtext = {"\n     [voice:coin][speed:0.1][color:00ff00]1-up![func:extralife][w:4][sound:1-up]", "You have [color:00ff00][voice:coin][w:15]1[w:15][voice:default][color:ffffff] life remaining."}
		Player.hp = 20
		Player.lv = Player.lv - 1
		Player.atk = 20
	end
	if Player.lv == 1 then
		deathtext = "[w:45][novoice]   [sound:game_over]Continue?"
		revive = false
	end
end

function EncounterStarting()
	Player.lv = 3
	Player.name = "Weegee"
	Player.atk = 20
	Audio.Stop()
	enemies[1]["currentdialogue"] = {"[novoice][effect:none][sound:hello]Hello!", "[novoice][effect:none][sound:its-a-me!]It's-a-me, [w:4]Mario!", "[noskip][func:LaunchMusic][func:State, ACTIONSELECT][next]"}
	State("ENEMYDIALOGUE")
end

function EnemyDialogueStarting()
	enemies[1].Call("SetSprite", "mario/mario")
	if lastwaves[1] == "pipe" then
		noPipes = 1
		enemies[1].Call("SetSprite", "mario/confused")
		enemies[1]["currentdialogue"] = {"[effect:none]Where did that pipe\ncome from?"}
	end
	if Player.hp == 1 then
		nextwaves = {"shells_heal"}
	else
		possible_attacks = {"bricks", "fireballs", "lava", "plants", "shells", "toad"}
		if noPipes == 0 then
			table.insert(possible_attacks, "pipe")
		end
		nextwaves = { possible_attacks[math.random(#possible_attacks)] }
	end
	
end

function EnemyDialogueEnding()
	if enemies[1].GetVar("flying") == 1 then
		nextwaves = {"fly"}
	elseif nextwaves[1] == "fireballs" or nextwaves[1] == "plants" or nextwaves[1] == "lava" then
		Audio.PlaySound("mariosounds/powerup")
		enemies[1].Call("SetSprite", "mario/fire")
	elseif nextwaves[1] == "pipe" or nextwaves[1] == "toad" then
		enemies[1].Call("SetSprite", "mario/confused")
	elseif Player.hp == 1 then
		enemies[1].Call("SetSprite", "mario/luigi")
	end
end

function DefenseEnding()
	encountertext = RandomEncounterText()
	lastwaves = nextwaves
	enemies[1].SetVar("flying", 0)
end

function HandleSpare()
	State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
	BattleDialog({"Selected item " .. ItemID .. "."})
end