comments = {"Smells like sushi.", "Undyne flips her spear impatiently.", "Undyne bounces impatiently.", "Undyne suplexes a large boulder, just because she can.", "Something seems fishy...", "Undyne is throwing spears around.", "Spears are everywhere."}
commands = {"Taunt"}
randomdialogue = {"[effect:none][voice:undyne]Fuhuhuhuhu!"}

sprite = "undyne"
name = "Undyne"
hp = 60
atk = 4
def = 1
check = "Captain of the Royal Guard, she's here to teach you to fight."
dialogbubble = "rightlarge" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
xp = 100
gold = 50

-- Happens after the slash animation but before the animation.
function HandleAttack(attackstatus)
	if attackstatus < 1 then
		-- player pressed fight but didn't press Z afterwards
		currentdialogue = {"[effect:none][voice:undyne]Seriously?"}
	else
		-- player did actually attack
		if hp > 30 then
			currentdialogue = {"[effect:none][voice:undyne]Fuhuhuhu! You're strong!"}
		else
			currentdialogue = {"[effect:shake,0.5][voice:undyne]Nngh... N-nice shot."}
		end
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "TAUNT" then
		BattleDialog({"You tell Undyne her attacks are too slow. You can tell she wants to go faster."})
		currentdialogue = {"[effect:none][voice:undyne]Listen, kid. I don't want to go TOO hard on ya, you're just learning!"}
	end
end