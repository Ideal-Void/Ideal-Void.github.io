comments = {"Smells like penguin.", "You really shouldn't rm -rf /", "You really shouldn't sudo mv $HOME /dev/null", "You really shouldn't :(){:|:&};:", "Tux readies his rubber balls."}
commands = {"Be friends", "Be Enemies", "Weird fact", "Nerd out"}
randomdialogue = {"[effect:none][voice:tux]Dude...", "[effect:none][voice:tux]Cool!", "[effect:none][voice:tux]Huh."}

sprite = "tux/tux" --Always PNG. Extension is added automatically.
name = "Tux"
hp = 50
atk = 8
def = 12
check = "He likes to party. He likes to program."
dialogbubble = "rightlong" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
antagonizing = {"You tell Tux that Dave was weak anyways.", "You tell Tux that he was never good to Dave.", "You tell Tux that his life is worthless.", "You tell Tux that he will never amount to anything.", "You tell Tux that it will all be over soon."}
antagonized = {"[effect:shake,0.25][voice:tux]No he wasn't! Dave was strong!", "[effect:shake,0.5][voice:tux]Shut up! We were good to each other!", "[effect:shake,1.0][voice:tux]Sh-shut up...", "[effect:shake,2.0][voice:tux]Shut up!",{"[effect:shake,4.0][voice:angery][noskip]SHUT![w:15][next]", "[effect:shake,4.0][voice:angery][noskip]THE![w:15][next]", "[effect:shake,4.0][sound:squeak][instant]****![instant:stop][w:15][next]", "[effect:shake,4.0][voice:angery][noskip]UP!"}}
itsTheEnd = 0

-- Happens after the slash animation but before
function HandleAttack(damage)
	if damage < 1 then
		currentdialogue = {"[effect:none]Hah! You missed!"}
	else
		currentdialogue = randomdialogue[math.random(#randomdialogue)]
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "BE FRIENDS" then
		BattleDialog({"You tell Tux that you want to be friends."})
		currentdialogue = {"[effect:none][voice:tux]We're friends! Yay!"}
		canspare = true
	elseif command == "BE FRIENDS?" then
		BattleDialog({"You tell Tux that you want to be friends."})
		currentdialogue = {"[effect:shake,1.0][voice:tux]I can never forgive you for what you did to Dave."}
	elseif command == "BE ENEMIES" then
		BattleDialog({"You tell Tux that you hate him."})
		currentdialogue = {"[effect:none][voice:tux]Hey, screw you too!"}
		canspare = false
	elseif command == "ANTAGONIZE" then
		if next(antagonizing) == nil then
			Audio.Stop()
			BattleDialog("[next]")
			SetSprite("tux/sadboye")
			if itsTheEnd == 0 then
				currentdialogue = {"[voice:tux][effect:shake,0.5][noskip]Just...[w:30][next]", "[voice:tux][effect:shake,1.0][noskip]Just...[w:30][next]", "[voice:tux][effect:shake,2.0][noskip]Get it over with...[w:30][next]", "[voice:tux][effect:shake,4.0][noskip]JUST GET IT OVER WITH ALREADY!!"}
				commands = {}
				randomdialogue = {"[effect:shake,1.0][voice:tux]Why?", "[effect:shake,1.0][voice:tux]Just end it already.", "[effect:shake,1.0][voice:tux]Please..."}
				comments = {"Finish the job.", "Put him out of his misery.", "[voice:v_floweymad][color:ff0000]What are you waiting for?[w:15] Dust him! =)", "Make your move.", "End it.", "Take his life.", "Turn him to dust."}
			end
			itsTheEnd = 1
			def = 0
			canspare = true
			check = "His brother is dead. He wants to be with him again."
		else
			BattleDialog(antagonizing[1])
			currentdialogue = antagonized[1]
			table.remove(antagonizing, 1)
			table.remove(antagonized, 1)
		end
	elseif command == "WEIRD FACT" then
		BattleDialog({"You tell Tux a random, bizarre factoid."})
		currentdialogue = {"[effect:none][voice:tux]Wh- Huh? What in the-", "[effect:none][voice:tux]What am I supposed to do with this?"}
	elseif command == "NERD OUT" then
		BattleDialog({"You and Tux geek out about Linux and stuff."})
		currentdialogue = {"[effect:none][voice:tux]Dude! You like Linux, too?", "[effect:none][voice:tux]Open source is great...", "[effect:none][voice:tux]So are easy- to- modify files!", "[effect:none][voice:tux]You can make custom game themes!", "[effect:none][voice:tux]I have, and it was super fun!", "[effect:none][voice:tux]Ever played 20,000 Light- years Into Space?", "[effect:none][voice:tux]I made a Minecraft inspired theme for it! It was definitely a bit tough...", "[effect:none][voice:tux]Am I talking too much? Let's just get on with with the fight, shall we...?"}
	end
end

function OnSpare()
	if youmonsterpre == 1 then
		youMonster = 1
		itsTheEnd = 0
		State("ENEMYDIALOGUE")
	elseif itsTheEnd == 1 then
		youmonsterpre = 1
		SetSprite("tux/suicidea")
	else
		Spare()
	end
end