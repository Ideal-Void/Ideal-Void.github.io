-- A basic encounter script skeleton you can copy and modify for your own creations.

music = "fallendown" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "Go to the ACT menu, select Toriel and select Check." --Modify as necessary. It will only be read out in the action select screen.
wavetimer = 4.0
arenasize = {155, 130}
autolinebreak = true
first_atk = 0

enemies = {
"toriel"
}

enemypositions = {
{0, 0}
}

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
next_attacks = {"fire", "cyan", "fire", "ending"}

function EncounterStarting()
	-- If you want to change the game state immediately, this is the place.
	Player.name = "Chara"
end

function EnemyDialogueStarting()
	-- Good location for setting monster dialogue depending on how the battle is going.
	if first_atk == 0 then
		enemies[1].SetVar('currentdialogue', {'[effect:none][voice:toriel]Are you ready?', '[effect:none][voice:toriel]This attack is random every time.'})
		first_atk = 1
	elseif futurewave == "cyan" then
		enemies[1].SetVar('currentdialogue', {'[effect:none][voice:toriel]Are you ready for my special [color:42fcff]CYAN[color:000000] attack?', "[effect:none][voice:toriel]If you don't move, the fire doesn't move either."})
	elseif futurewave == "fire" then
		enemies[1].SetVar('currentdialogue', {'[effect:none][voice:toriel]Are you ready?', '[effect:none][voice:toriel]One more attack!'})
	elseif futurewave == "ending" then
		enemies[1].SetVar('currentdialogue', {'[effect:none][voice:toriel]Goodbye!', '[effect:none][voice:toriel]I wish you luck with Papyrus.'})
	end
end

function EnemyDialogueEnding()
	if next_attacks[1] != nil then
		nextwaves = {next_attacks[1]}
		futurewave = next_attacks[2]
		table.remove(next_attacks, 1)
	else
		next_attacks = {"ending"}
	end
end

function DefenseEnding() --This built-in function fires after the defense round ends.
	encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
	if futurewave == nil then
		enemies[1].SetVar("canspare", true)
		encountertext = "Go to the MERCY menu and select Spare."
	end
end

function HandleSpare()
	State("ENEMYDIALOGUE")
end

function HandleItem(item)
	BattleDialog({"You ate the Butterscotch Pie.\nHP maxed out!"}) 
	Player.Heal(99)
end