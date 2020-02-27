music = "Zakarra-MainstreamMemory" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "Tux and Dave appear!" --Modify as necessary. It will only be read out in the action select screen.
wavetimer = 5.0
autolinebreak = true
deathtext = "not big surprise"

enemies = {
"tux",
"dave"
}

enemypositions = {
{-128, 0},
{128, 0}
}

daveDead = 0
transitiontext = 0

function EncounterStarting()
	-- If you want to change the game state immediately, this is the place.
	Player.name = "Alpac"
	Player.lv = 4
	Player.hp = 32
end

function EnemyDialogueStarting()
	-- Good location for setting monster dialogue depending on how the battle is going.
	if enemies[2].GetVar("hp") < 1 and daveDead == 0 then
		Audio.Stop()
		enemies[1].Call("SetSprite", "tux/shocked")
		enemies[1].SetVar("currentdialogue", {"[voice:tux][noskip][effect:none]Wha-[w:30][next]", "[voice:tux][noskip][effect:none]You-[w:30][next]", "[voice:tux][noskip][effect:none]How-[w:30][next]", "[voice:angery][noskip][speed:0.25][effect:shake,0.5]You...[w:30][next]", "[noskip][effect:shake,1.0][voice:angery][speed:0.5]YOU[w:15]\nKILLED[w:15]\nMY[w:15]\nBROTHER![w:15][next]", "[noskip][effect:shake,2.0][color:ff0000][voice:angery][speed:0.5]YOU SON OF A [novoice][sound:squeak][instant]*****!"})
		enemies[1].SetVar("commands", {"Be friends?", "Antagonize"})
	end
	if enemies[1].GetVar("hp") < 1 then
		Audio.Stop()
		enemies[2].Call("SetSprite", "dave/shocked")
		enemies[2].SetVar("currentdialogue", {"[novoice][sound:nope]Fuck this shit I'm out!"})
	end
	if enemies[1].GetVar("youMonster") == 1 then
		Audio.PlaySound("heartbeatbreaker")
		enemies[1].Call("SetSprite", "tux/suicideb")
		enemies[1].Call("Kill")
	end
	if enemies[1].GetVar("youmonsterpre") == 1 then
		enemies[1].SetVar("currentdialogue", {"[effect:shake][voice:dave]It's alright...", "[effect:shake][voice:dave]I'm coming, Dave..."})
	end
end

function EnemyDialogueEnding()
	-- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
	-- Custom lists with attacks to choose from. Also handles how Tux behaves depensing on if Dave is alive or not.
	if enemies[2].GetVar("hp") > 0 then
		if Player.hp < 11 then
			nextwaves = {"bouncy_heal"}
		else
			tux_attacks = {"bouncy", "rings_tux"}
			dave_attacks = {"rings_dave", "spears"}
			nextwaves = {tux_attacks[math.random(#tux_attacks)], dave_attacks[math.random(#dave_attacks)]}
		end
	else
		if daveDead == 0 then
			enemies[1].Call("SetSprite", "tux/angeryboi")
			enemies[1].SetVar("check", "Oh boy, he MAD")
			Audio.PlaySound("eye")
			daveDead = 1
		end
		tux_attacks = {"bouncy_angery", "flurry", "rings_angery"}
		enemies[1].SetVar("randomdialogue", {"[effect:shake,0.5][voice:tux]How could you...?", "[effect:shake,0.5][voice:tux]Die!", "[effect:shake,0.5][voice:tux]Why?"})
		nextwaves = {tux_attacks[math.random(#tux_attacks)]}
		if enemies[1].GetVar("itsTheEnd") == 1 then
			nextwaves = {"bouncy_pointless"}
		end
	end
	if enemies[1].GetVar("hp") < 1 then
		nextwaves = {"empty"}
	end
end

function DefenseEnding() --This built-in function fires after the defense round ends.
	encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
	if daveDead == 1 and transitiontext == 0 then
		transitiontext = 1
		Player.hp = 32
		Audio.LoadFile("Impulslogik-Zen")
		encountertext = "Uh-oh. Now you've pissed him off.[w:8]\nAren't you proud of yourself?[w:8]\nCongratu-frickin'-lations to you."
	end
	if enemies[1].GetVar("itsTheEnd") == 1 then
		encountertext = "Tux is sparing you."
	end
	if enemies[1].GetVar("hp") < 1 then
		enemies[2].Call('Spare')
	end
end

function HandleSpare()
	if daveDead == 1 then
		enemies[1].SetVar("currentdialogue", "[effect:shake][voice:tux]No.[w:15] There's no mercy for you now. [w:15]I will make you pay for what you have done.")
	end
	State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
	encountertext({"Selected item " .. ItemID .. "."})
end