spawntimer = 0
bones = {}
Encounter.SetVar('wavetimer', 10)

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 30 == 0 then
		if spawntimer % 60 == 0 then
			local bone = CreateProjectile('bone', -346, -33)
			bone.SetVar('velx', 1)
			table.insert(bones, bone)
		else
			local bone = CreateProjectile('bone', 346, 33)
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