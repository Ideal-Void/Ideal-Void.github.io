music = "mus_battle1 old"
encountertext = "Use the arrow keys to move, ENTER to select, and SHIFT to go back. Use ESC to just exit." --Modify as necessary. It will only be read out in the action select screen.

wavetimer = 4
arenasize = {155, 130}
autolinebreak = true

enemies = {
"poseur",
"posette"
}
enemypositions = {
{-180, 0},
{120, 0}
}

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"bullettest_bouncy", "bullettest_chaserorb", "bullettest_touhou"}
remaining_atks = 3

function EncounterStarting()
	Player.name = "Chara"
end

function EnemyDialogueStarting()
	-- Good location for setting monster dialogue depending on how the battle is going.
	if remaining_atks > 0 then
		nextwaves = { possible_attacks[math.random(#possible_attacks)] }
		if #enemies == 2 then
			table.insert(nextwaves, possible_attacks[math.random(#possible_attacks)])
		end
		remaining_atks = remaining_atks - 1
	else
		nextwaves = {"ending"}
		for i=1,#enemies do
			enemies[i].SetVar("canspare", true)
		end
		enemies[1].SetVar("currentdialogue", "Let's not fight any longer.")
		enemies[2].SetVar("currentdialogue", "Good luck with Toriel.")
	end
end

function DefenseEnding() --This built-in function fires after the defense round ends.
	if remaining_atks > 0 then
		encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
	else
		encountertext = "Go to the MERCY menu and select Spare."
	end
end

function HandleSpare()
	State("ENEMYDIALOGUE")
end