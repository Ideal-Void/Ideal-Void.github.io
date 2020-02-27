-- Utilizes "Blue Soul Library" by u/bindingofshear on Reddit at r/Unitale, slightly tweaked by me, Tux Penguin. Find it at https://www.reddit.com/r/Unitale/comments/44dh9i/blue_soul_library/?st=isj4vh25&sh=c656aef7
spawntimer = 0
bones = {}
Encounter.SetVar("wavetimer", 10)

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 15 == 0 then
		local bone = CreateProjectile('bone2', -346, 0)
		bone.sprite.color = {66/255, 252/255, 255/255}
		table.insert(bones, bone)
	end
	
	for i=1,#bones do
		local bone = bones[i]
		bone.Move(2, 0)
	end
end


function OnHit(bone)
	if Player.isMoving then
		Player.Hurt(3)
	end
end

function EndingWave()
	Encounter.SetVar("wavetimer", 4)
	Player.sprite.color = {0/255, 60/255, 255/255}
end