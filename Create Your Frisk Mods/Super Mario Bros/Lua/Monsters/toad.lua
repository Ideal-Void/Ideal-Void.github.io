comments = {"Smells like toads.", "Smells like mushroom.", "Toad."}
commands = {"Give coins", "Taunt", "Plead"}
randomdialogue = {"[effect:shake,0.25][novoice][sound:little_toadies/di][color:d82800]I'm the best!", "[effect:shake,0.25][novoice][sound:little_toadies/dh][color:d82800]Here we go!", "[effect:shake,0.25][novoice][sound:little_toadies/dy][color:d82800]Yahoo!"}

sprite = "toad/idle" --Always PNG. Extension is added automatically.
name = "Toad"
hp = 500
atk = 50
def = 50
check = "What have you done?"
dialogbubble = "rightwide" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true

function StopSound()
	Audio.Stop()
end

function OhNo()
	SetSprite("toad/didle")
end

function OhYes()
	SetSprite("toad/idle")
end

function OhWhy()
	SetSprite("toad/damage")
end

function OnSpare()
	currentdiamogue = {"[effect:shake,0.25][color:d82800]Hah, as if."}
end

function LaunchMusic()
	Audio.Play()
end

-- Happens after the slash animation but before
function HandleAttack(attackstatus)
	if attackstatus > 0 then
		SetSprite("toad/damage")
	end
	if hp < 1 then
		currentdialogue = {"[effect:shake,0.25][func:StopSound][instant]Ngh...", "[noskip][effect:shake,0.25][speed:0.25]N-nice...\n[w:15]shot...[w:15][next]", "[noskip][effect:shake,0.25][func:OhYes][speed:0.5]Let's fight again,\n[w:15]sometime...[w:20][next]", "[noskip][effect:shake,0.5][speed:0.25]It's [w:15]been [w:15]fun.[w:25][next]", "[noskip][effect:shake][func:OhWhy][speed:0.125]So long...[w:30][next]"}
		State("ENEMYDIALOGUE")
	end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
	if command == "GIVE COINS" then
		BattleDialog({"You try to give Toad [color:ffff00][w:8][sound:mariosounds/coin][novoice]50[voice:default][w:8][color:ffffff] coins."})
		currentdialogue = {"[effect:shake,0.25][color:d82800]I have no need for\nthese things."}
	elseif command == "TAUNT" then
		BattleDialog({"You tell Toad that you think\rhis attacks are weak."})
		currentdialogue = {"[effect:shake,0.25][color:d82800]Pfeh."}
	elseif command == "PLEAD" then
		BattleDialog({"You beg Toad not to kill you."})
		currentdialogue = {"[effect:shake,0.25][color:d82800]Heh heh heh... You're\nfunny."}
	end
end