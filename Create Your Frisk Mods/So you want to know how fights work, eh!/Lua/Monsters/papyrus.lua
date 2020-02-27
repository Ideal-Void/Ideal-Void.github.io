comments = {"Smells like bones.", "Papyrus is trying hard to play it cool.", 'Papyrus whispers "[voice:v_papyrus]Nyeh heh heh![voice:default]"', "Papyrus is preparing a bone attack.", "Papyrus is cackling.", "Papyrus prepares a non-bone attack, then spends a minute fixing his mistake.", "Papyrus is rattling his bones.", "Papyrus remembered a bad joke Sans told and is frowning.", "Papyrus is considering his options."}
commands = {"Joke", "Flirt", "Insult", "Ask for spaghetti"}
randomdialogue = {"[effect:none][font:papyrus][voice:v_papyrus]NYEH HEH HEH!"}

sprite = "papyrus"
name = "Papyrus"
hp = 60
atk = 4
def = 1
check = 'Likes to say "Nyeh heh heh!"'
dialogbubble = "rightlarge" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
xp = 10
gold = 20

-- Happens after the slash animation but before the animation.
function HandleAttack(attackstatus)
	if attackstatus < 1 then
		-- player pressed fight but didn't press Z afterwards
		currentdialogue = {"[effect:none][font:papyrus][voice:v_papyrus]DID YOU JUST TRY TO ATTACK ME? OH DEAR..."}
	else
		-- player did actually attack
		if hp > 30 then
			currentdialogue = {"[effect:none][font:papyrus][voice:v_papyrus]OUCH! YOU'RE STRONG!"}
		else
			currentdialogue = {"[effect:shake,0.5][font:papyrus][voice:v_papyrus]NYEH...\nY-YOU'RE VERY STRONG..."}
		end
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "JOKE" then
		currentdialogue = {"[effect:none][font:papyrus][voice:v_papyrus]NYEEEEEHHHHH! YOU'RE ALMOST AS BAD AS SANS!"}
		BattleDialog({"You tell Papyrus a joke.\n[w:30][speed:4]He hates it."})
	elseif command == "FLIRT" then
		currentdialogue = {"[effect:none][font:papyrus][voice:v_papyrus]WH-WHAT? FLIRTING?", "[effect:none][font:papyrus][voice:v_papyrus]NO, WE MUST NOT GET DISTRACTED!"}
		BattleDialog({"You give Papyrus a seductive smirk."})
	elseif command == "INSULT" then
		BattleDialog({"You try to insult Papyrus, but he is too absorbed in his own greatness."})
	elseif command == "ASK FOR SPAGHETTI" then
		Inventory.SetInventory({"Spaghetti", "Spaghetti", "Spaghetti", "Spaghetti", "Spaghetti", "Spaghetti", "Spaghetti", "Spaghetti"})
		currentdialogue = {"[effect:none][font:papyrus][voice:v_papyrus]AH! YOU LIKE SPAGHETTI, TOO?", "[effect:none][font:papyrus][voice:v_papyrus]HOORAY! NYEH HEH HEH!"}
		BattleDialog({"You ask Papyrus for some spaghetti. He happily fills your inventory!"})
	end
end