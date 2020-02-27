comments = {"Smells like hats.", "Dave readies his spears."}
commands = {"Be friends", "Be Enemies", "Weird fact"}
randomdialogue = {"[effect:none][voice:dave]Ok...", "[effect:none][voice:dave]Neat!", "[effect:none][voice:dave]Huh."}

sprite = "dave/dave" --Always PNG. Extension is added automatically.
name = "Dave"
hp = 25
atk = 12
def = 16
check = "His spear is sharp, and his tongue is poisoned. [voice:dave][w:15]Hey,[w:8]wait a..."
dialogbubble = "right" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true

-- Happens after the slash animation but before
function HandleAttack(attackstatus)
	if attackstatus < 1 then
		currentdialogue = {"[effect:none][voice:dave]Was that supposed to hit me?"}
	else
		currentdialogue = {"[effect:none][voice:dave]Ow!"}
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "BE FRIENDS" then
		BattleDialog({"You tell Dave that you want to be friends."})
		currentdialogue = {"[effect:none][voice:dave]We're friends! Yay!"}
		canspare = true
	elseif command == "BE ENEMIES" then
		BattleDialog({"You tell Dave that you hate him."})
		currentdialogue = {"[effect:none][voice:dave]Hah, the feeling's mutual now."}
		canspare = false
	elseif command == "WEIRD FACT" then
		BattleDialog({"You tell Dave a random, bizarre factoid."})
		currentdialogue = {"[effect:none][voice:dave]Eh?", "[effect:none][voice:dave]And I need to know this why?"}
	end
end