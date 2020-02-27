comments = {"Smells like Mettaton.", "Smells like metal.", "Mettaton.", "Smells like cold steel.", "The Mini-Mettatons are preparing...", "Papyrus is rattling his bones.", "Papyrus remembered a bad joke Sans told and is frowning.", "Papyrus is considering his options."}
commands = {"Act 1", "Act 2", "Act 3"}
randomdialogue = {"[effect:none]NYEH HEH HEH!"}

sprite = "mtt"
name = "Mettaton"
hp = 9999
atk = 8
def = 9999
check = 'Once a human-killing machine,\rnow a cooking show host.'
dialogbubble = "rightlarge" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
xp = 1000
gold = 250

-- Happens after the slash animation but before the animation.
function HandleAttack(attackstatus)
	if attackstatus < 1 then
		-- player pressed fight but didn't press Z afterwards
		currentdialogue = {"[effect:none]DID YOU JUST TRY TO ATTACK ME? OH DEAR..."}
	else
		-- player did actually attack
		if hp > 30 then
			currentdialogue = {"[effect:none]OUCH! YOU'RE STRONG!"}
		else
			currentdialogue = {"[effect:shake,0.5]NYEH...\nY-YOU'RE VERY STRONG..."}
		end
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "ACT 1" then
		currentdialogue = {"[effect:none]YOU SELECTED ACT ONE!"}
	elseif command == "ACT 2" then
		currentdialogue = {"[effect:none]YOU SELECTED ACT TWO!"}
	elseif command == "ACT 3" then
		currentdialogue = {"[effect:none]YOU SELECTED ACT THREE!"}
	end
	currentdialogue = {currentdialogue[1]}
	BattleDialog({"You selected " .. command .. "."})
end