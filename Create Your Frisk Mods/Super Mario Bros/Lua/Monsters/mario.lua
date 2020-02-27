comments = {"Smells like hats.", "Smells like mushroom.", "Mario readies his shells."}
commands = {"Give coins", "Taunt", "Fly"}
randomdialogue = {"[effect:none][novoice][sound:okey-dokey]Ok!", "[effect:none][novoice][sound:hoohoo]Neat!", "[effect:none][novoice][sound:hmm]Hmm..."}

sprite = "mario/mario" --Always PNG. Extension is added automatically.
name = "Mario"
hp = 100
atk = 10
def = 10
check = "He likes mushrooms."
dialogbubble = "rightwide" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true
flying = 0
NewAudio.CreateChannel("flyer")

function LaunchMusic()
	Audio.Play()
end

-- Happens after the slash animation but before
function HandleAttack(attackstatus)
	if attackstatus > 0 then
		SetSprite("mario/damage")
		if attackstatus > 19 then
			currentdialogue = {"[effect:none][novoice][sound:whoa]Whoa!"}
		elseif attackstatus > 9 then
			currentdialogue = {"[effect:none][novoice][sound:oof]Oof!"}
		else
			currentdialogue = {"[effect:none][novoice][sound:ungh]Ow!"}
		end
	else
		currentdialogue = {"[effect:none][novoice][sound:haha]Haha! You missed!"}
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "GIVE COINS" then
		BattleDialog({"You give Mario [color:ffff00][w:8][sound:mariosounds/coin][novoice]10[voice:default][w:8][color:ffffff] coins."})
		currentdialogue = {"[effect:none][novoice][sound:yahoo]Hey, thanks-a-for\nthe coins!"}
		canspare = true
	elseif command == "TAUNT" then
		BattleDialog({"You tell Mario that you think\nhis attacks are slow."})
		currentdialogue = {"[effect:none][novoice][sound:come_on]Come on!"}
		canspare = false
	elseif command == "FLY" then
		BattleDialog({"You ask Mario to fly for you."})
		currentdialogue = {"[effect:none][noskip][novoice][func:itsAFlyingPlumber]I'm-a-gonna fly\nfor you![w:15][next]"}
	end
end

function itsAFlyingPlumber()
	NewAudio.PlaySound("flyer", "flying")
	flying = 1
end