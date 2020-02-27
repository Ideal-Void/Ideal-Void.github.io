-- Based on bullettest_bouncy
spawntimer = 0
blocks = {}
rubbles = {}
rvel = {-2,-1,0,1,2}
rots = {"22.5","-22.5"}

function RubbleSplit()
	for i=1,#rvel do
		rubble = CreateProjectile('brick/rubble', block.x, block.y)
		rubble.SetVar('velx', rvel[i])
		rubble.SetVar('vely', 6)
		rubble.SetVar('dir', rots[math.random(#rots)])
		table.insert(rubbles, rubble)
	end
	Audio.PlaySound("mariosounds/break")
	block.Remove()
end

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 60 == 0 then
		local posx = math.random(-75,75)
		local posy = Arena.height/2
		local block = CreateProjectile('brick/block', posx, posy)
		Audio.PlaySound("falling")
		block.SetVar('velx', 0)
		block.SetVar('vely', 0)
		table.insert(blocks, block)
	end
	
	for i=1,#blocks do
		block = blocks[i]
		if block.isactive then
			local velx = block.GetVar('velx')
			local vely = block.GetVar('vely')
			vely = vely - 0.25
			block.Move(velx, vely)
			block.SetVar('vely', vely)
			if(block.y < -Arena.height/2) then
				RubbleSplit()
			end
		end
	end
	
	for i=1,#rubbles do
		rubble = rubbles[i]
		if rubble.isactive then
			local velx = rubble.GetVar('velx')
			local vely = rubble.GetVar('vely')
			vely = vely - 0.25
			rubble.Move(velx, vely)
			rubble.SetVar('vely', vely)
			rubble.sprite.rotation = rubble.sprite.rotation + rubble.GetVar('dir')
			if rubble.y < -Arena.height then
				rubble.Remove()
			end
		end
	end
end

function OnHit(bullet)
	if bullet.sprite.spritename == 'brick/block' then
		RubbleSplit()
		Player.Hurt(5)
	else
		Player.Hurt(1)
		bullet.Remove()
	end
end