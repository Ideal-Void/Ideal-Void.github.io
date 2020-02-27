-- Utilizes "Blue Soul Library" by u/bindingofshear on Reddit at r/Unitale, slightly tweaked by me, Tux Penguin. Find it at https://www.reddit.com/r/Unitale/comments/44dh9i/blue_soul_library/?st=isj4vh25&sh=c656aef7
spawntimer = 0
bones = {}
Encounter.SetVar('wavetimer', 10)
blue = require "blueSoul"
blue.WaveStart()
blue.TurnBlue(true)
blue.inAir = true

function Update()
	blue.HandleMovement()
	spawntimer = spawntimer + 1
	if spawntimer % 30 == 0 then
		if spawntimer % 60 == 0 then
			local bone = CreateProjectile('bone3', -346, -41)
			bone.SetVar('velx', 1)
			table.insert(bones, bone)
		else
			local bone = CreateProjectile('bone3', 346, 41)
			bone.SetVar('velx', -1)
			table.insert(bones, bone)
		end
	end
	
	for i=1,#bones do
		local bone = bones[i]
		bone.Move(bone.GetVar('velx'), 0)
	end
end

function EndingWave()
	Encounter.SetVar('wavetimer', 4)
end