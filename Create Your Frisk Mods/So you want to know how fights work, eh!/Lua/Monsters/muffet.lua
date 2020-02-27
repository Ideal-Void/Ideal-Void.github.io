comments = {"Smells like spider.", "All the spiders clap along to the music.", "Muffet does a synchronized dance with the other spiders.", "Muffet pours you a cup of spiders."}
commands = {"Pay"}
randomdialogue = {"[sound:muffetlaugh]Ahuhuhuhu!~"}

sprite = "muffet"
name = "Muffet"
hp = 60
atk = 4
def = 1
check = "If you're invited to her parlor, get ready to be stuck there."
dialogbubble = "rightlarge" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
xp = 20
gold = 100

-- Happens after the slash animation but before the animation.
function HandleAttack(attackstatus)
	if attackstatus < 1 then
		-- player pressed fight but didn't press Z afterwards
		currentdialogue = {"Oh dear, let's not fight."}
	else
		-- player did actually attack
		if hp > 30 then
			currentdialogue = {"Ah! You're a strong one."}
		else
			currentdialogue = {"[effect:shake,0.5]Ah...\nT-too... Strong..."}
		end
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "PAY" then
		if canspare == true then
			BattleDialog({"You try to give Muffet 10 gold, but she refuses."})
			currentdialogue = {"Oh no, dear. It's quite alright."}
		else
			BattleDialog({"You pay Muffet 10 gold."})
			currentdialogue = {"[sound:muffetlaugh]Ahuhuhu!~\nThank you, dearie."}
		end
	end
end