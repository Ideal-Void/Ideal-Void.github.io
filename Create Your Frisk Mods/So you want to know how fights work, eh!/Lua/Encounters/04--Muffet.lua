music = "spiderdance"
encountertext = "Go to the ACT menu, select Muffet and select Check."
wavetimer = 4.0
arenasize = {155, 130}
autolinebreak = true

enemies = {
"muffet"
}

enemypositions = {
{-10, 0}
}

next_attacks = {"donuts", "purple", "donuts", "ending"}

function EncounterStarting()
	Player.name = "Chara"
end

function EnemyDialogueStarting()
	if futurewave == "purple" then
		enemies[1].SetVar('currentdialogue', {'Why so blue?', 'I think purple is a much better look on you!', '[sound:muffetlaugh]Ahuhuhuhuhuhu~'})
	elseif futurewave == "ending" then
		enemies[1].SetVar('currentdialogue', {'So long, dearie!'})
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
	if nextwaves[1] == "donuts" then
		Player.sprite.color = {255/255, 0/255, 0/255}
	end
end

function DefenseEnding()
	encountertext = RandomEncounterText()
	if futurewave == nil then
		enemies[1].SetVar("canspare", true)
		encountertext = "Go to the MERCY menu and select Spare."
	end
end

function HandleSpare()
	State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
	BattleDialog({"Selected item " .. ItemID .. "."})
end