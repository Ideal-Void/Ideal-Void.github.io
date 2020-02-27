music = "_x^badc0de#_@"
encountertext = "[instant][effect:shake,0.5]...?"
wavetimer = 4.0
arenasize = {155, 130}
bg = "sprite.bg.null"
flee = false
autolinebreak = true
unescape = true
voicer = require "randomvoice"
voices = {"a", "aa", "eul", "hh", "oh", "ohh", "uo"}
voicer.setvoices(voices)
sprites = {"g0", "g1", "g2", "g3", "g4", "g5", "g6", "g7", "g8", "g9", "g10", "g11", "g12", "g13"}
nextdialogue = {"[effect:shake,0.5][font:wingdings]HOW DID YOU FIND ME", "[effect:shake,0.5][font:wingdings]I THOUGHT THIS VOID WAS IMPENETRABLE", "[effect:shake,0.5][font:wingdings]WELL THEN", "[effect:shake,0.5][font:wingdings]I GUESS NOT", "[effect:shake,0.5][font:wingdings]GOODBYE"}

CreateSprite("sprite.bg.null", "BelowUI")

enemies = {
"[UNKNOWN]"
}

enemypositions = {
{0, 0}
}

next_attacks = {"shadow", "shadow", "shadow", "shadow", "ending"}

function Update()
	enemies[1].Call("SetSprite", sprites[math.random(#sprites)])
end

function EncounterStarting()
	Player.name = "Chara"
	local dialogue = nextdialogue -- retrieve dialogue first, for readability
	nextdialogue = voicer.randomizetable(dialogue) -- Randomize voices with the library!
	Player.sprite.color = {1,1,1}
	Player.sprite.rotation = 180
	Player.sprite.Set("ghostSoul")
	Inventory.AddCustomItems({"item.null.name"}, {0})
	Inventory.SetInventory({"item.null.name"})
end

function EnemyDialogueStarting()
	if nextdialogue[1] == nil then
		nextdialogue = {"[effect:shake,0.5][font:wingdings]GOODBYE"}
	else
		enemies[1].SetVar('currentdialogue', {nextdialogue[1]})
		table.remove(nextdialogue, 1)
	end
	if futurewave == "ending" then
		enemies[1].SetVar('currentdialogue', {'[effect:shake,0.5][font:wingdings]GOODBYE\nHUMAN', '[effect:shake,0.5][font:wingdings]THANK YOU FOR GIVING ME HOPE IN THIS DARK AND DREARY VOID'})
	end
	local enemydialogue = enemies[1].GetVar("currentdialogue") -- retrieve dialogue first, for readability
	if enemydialogue ~= nil then -- Note that this can happen when a monster is having its random dialogue!
		enemies[1].SetVar('currentdialogue', voicer.randomizetable(enemydialogue)) -- Randomize voices with the library!
	end
end

function EnemyDialogueEnding()
	if next_attacks[1] != nil then
		nextwaves = {next_attacks[1]}
		futurewave = next_attacks[2]
		table.remove(next_attacks, 1)
	else
		nextwaves = {"ending"}
	end
end

function DefenseEnding()
	encountertext = RandomEncounterText()
	if futurewave == nil then
		enemies[1].SetVar("canspare", true)
		encountertext = "[instant][effect:shake,0.5]Is it over?"
	end
end

function HandleSpare()
	State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
	BattleDialog({"Selected item [speed:4][voice:aa][REDACTED] [REDACTED] [REDACTED]\r[REDACTED] [REDACTED] [REDACTED] [REDACTED]\r[REDACTED] [REDACTED] [REDACTED] [REDACTED]\r[REDACTED] [REDACTED] [REDACTED] [REDACTED]\r[REDACTED] [REDACTED] [REDACTED] [REDACTED]\r[REDACTED] [REDACTED] [REDACTED] [REDACTED]\r[REDACTED] [REDACTED] [REDACTED] [REDACTED]\r[REDACTED] [REDACTED] [REDACTED] [REDACTED]\r[REDACTED] [REDACTED] [REDACTED] [REDACTED]"})
	Inventory.NoDelete = true
end