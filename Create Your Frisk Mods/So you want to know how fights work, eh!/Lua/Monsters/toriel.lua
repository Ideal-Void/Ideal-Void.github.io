comments = {"Toriel gives an encouraging smile.", "Toriel looks intimidating with fire in her hands."}
commands = {"Hug", "Ask for pie"}
randomdialogue = {"[effect:none][voice:toriel]Are you ready?"}

sprite = "toriel"
name = "Toriel"
hp = 60
atk = 4
def = 1
check = 'Motherly caretaker of the RUINS.'
dialogbubble = "rightlarge" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
xp = 0
gold = 0

-- Happens after the slash animation but before the animation.
function HandleAttack(attackstatus)
	if attackstatus < 1 then
		currentdialogue = {"[effect:none][voice:toriel]Did you just try to... attack me?"}
	else
		-- player didn't miss
		if hp > 30 then
			currentdialogue = {"[effect:none][voice:toriel]Oh! You're strong!"}
		else
			currentdialogue = {"[effect:shake,0.5][voice:toriel]Ngh... Please, don't..."}
		end
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "HUG" then
		BattleDialog({"You hug Toriel. She hugs you back."})
	elseif command == "ASK FOR PIE" then
		BattleDialog({"You ask Toriel for a slice of butterscotch pie, and she gives you one.", "Check the ITEM menu!"})
		Inventory.SetInventory({"Butterscotch Pie"})
	end
end