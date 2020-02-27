music = "bonetrousle"
encountertext = "Go to the ACT menu, select Papyrus and select Check."
wavetimer = 4.0
arenasize = {155, 130}
autolinebreak = true
blue = require "blueSoul"
deathtext = {"[voice:v_papyrus]AH! OH NO!", "[voice:v_papyrus]A-ARE YOU ALRIGHT, HUMAN?!"}

enemies = {
"papyrus"
}

enemypositions = {
{0, 0}
}

next_attacks = {"bones", "fabled_blue_attack", "blue_bones", "bones", "ending"}

function EncounterStarting()
	Player.name = "Chara"
	Inventory.AddCustomItems({"Spaghetti"}, {0})
end

function EnemyDialogueStarting()
	if futurewave == "fabled_blue_attack" then
		enemies[1].SetVar('currentdialogue', {'[effect:none][font:papyrus][voice:v_papyrus]ARE YOU PREPARED FOR MY FABLED BLUE ATTACK, HUMAN?', '[effect:none][font:papyrus][voice:v_papyrus]BY THE WAY, ABOUT BLUE ATTACKS...', '[effect:none][font:papyrus][voice:v_papyrus]YOU DO KNOW HOW STOP\nSIGNS ARE [color:ff0000]RED[color:000000], CORRECT?', '[effect:none][font:papyrus][voice:v_papyrus]WELL, WHEN\nYOU SEE A BLUE ATTACK, JUST IMAGINE A [color:003cff]BLUE[color:000000] STOP SIGN!', '[effect:none][font:papyrus][voice:v_papyrus]HOLD STILL,\nAND YOU WILL TAKE NO DAMAGE! THE ATTACK WILL PASS RIGHT THROUGH YOU.'})
	elseif futurewave == "blue_bones" then
		enemies[1].SetVar('currentdialogue', {"[effect:none][font:papyrus][voice:v_papyrus]YOU'RE BLUE NOW!", "[effect:none][font:papyrus][voice:v_papyrus]THAT'S MY ATTACK!", '[effect:none][font:papyrus][voice:v_papyrus]NYEH HEH HEH!'})
	elseif futurewave == "ending" then
		enemies[1].SetVar('currentdialogue', {'[effect:none][font:papyrus][voice:v_papyrus]GOODBYE, HUMAN!', '[effect:none][font:papyrus][voice:v_papyrus]GOOD LUCK ON YOUR LESSONS WITH UNDYNE!'})
	end
end

function EnemyDialogueEnding()
	if futurewave == "fabled_blue_attack" then
		State("ACTIONSELECT")
	end
	if next_attacks[1] != nil then
		nextwaves = {next_attacks[1]}
		futurewave = next_attacks[2]
		table.remove(next_attacks, 1)
	else
		next_attacks = {"ending"}
	end
	if nextwaves[1] == "bones" then
		Player.sprite.color = {255/255, 0/255, 0/255}
	end
end

function DefenseEnding()
	encountertext = RandomEncounterText()
	if futurewave == "blue_bones" then
		encountertext = "You're blue now."
		State("ENEMYDIALOGUE")
	elseif futurewave == nil then
		enemies[1].SetVar("canspare", true)
		encountertext = "Go to the MERCY menu and select Spare."
	end
end

function HandleSpare()
	State("ENEMYDIALOGUE")
end

function HandleItem(item)
	BattleDialog({"You ate the Spaghetti.\nThe taste is indescribable."}) 
	Player.Heal(math.random(10,100))
end