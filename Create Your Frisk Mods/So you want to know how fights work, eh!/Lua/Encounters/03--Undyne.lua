music = "spearofjustice"
encountertext = "Go to the ACT menu, select\rUndyne and select Check."
wavetimer = 4.0
arenasize = {155, 130}
autolinebreak = true
blue = require "blueSoul"

enemies = {
"undyne"
}

enemypositions = {
{0, 0}
}

next_attacks = {"spears", "green", "spears", "ending"}

function OhHELLno()
	Audio.Stop()
end

function EncounterStarting()
	Player.name = "Chara"
	Inventory.AddCustomItems({"Sushi"}, {0})
	Inventory.SetInventory({"Sushi"})
end

function EnemyDialogueStarting()
	if futurewave == "green" then
		enemies[1].SetVar('currentdialogue', {'[effect:none][voice:undyne]Ready for my [color:00c000]GREEN[color:000000] attack?', "[effect:none][voice:undyne]You'll need to learn to [color:ff0000]face danger head on[color:000000] if you want to stand a chance against me!"})
	elseif futurewave == "ending" then
		enemies[1].SetVar('currentdialogue', {'[effect:none][voice:undyne]See ya, kid!', "[effect:none][voice:undyne]Watch out for [color:d535d9]spiders[color:000000]..."})
	end
	if mortification == true then
		enemies[1].SetVar('currentdialogue', {'[effect:twitch][voice:undyne][speed:5]Nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnope!'})
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
	if nextwaves[1] == "spears" then
		Player.sprite.color = {255/255, 0/255, 0/255}
	end
	if mortification == true then
		nextwaves = {"ending"}
	end
end

function DefenseEnding()
	encountertext = RandomEncounterText()
	if futurewave == nil then
		enemies[1].SetVar("canspare", true)
		encountertext = "Go to the MERCY menu and select Spare."
	end
	if mortification == true then
		gold = 0
		enemies[1].Call('Spare')
	end
end

function HandleSpare()
	State("ENEMYDIALOGUE")
end

function HandleItem(item)
	if item == "SUSHI" then
		BattleDialog({"You ate the Sushi.\n[func:OhHELLno]Undyne is mortified, disgusted, and most of all... [w:15][novoice][sound:crack]apalled."}) 
		Player.Heal(10)
		mortification = true
		enemies[1].Call("SetSprite", "ya_nasty")
	end
end