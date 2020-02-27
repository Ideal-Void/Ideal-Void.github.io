-- Based on bullettest_bouncy
spawntimer = 0
blocks = {}
rubbles = {}
rots = {"22.5","-22.5"}

function RubbleSplit()
	for i=1,4 do
		rubble = CreateProjectile('brick/rubble', block.x, block.y)
		rubble.SetVar('velx', math.random(-4,4))
		rubble.SetVar('vely', math.random(8))
		rubble.SetVar('dir', rots[math.random(#rots)])
		table.insert(rubbles, rubble)
	end
	Audio.PlaySound("mariosounds/break")
	block.Remove()
end

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % math.random(60) == 0 then
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
			vely = vely - 0.5
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
			vely = vely - 0.125
			rubble.Move(velx, vely)
			rubble.SetVar('vely', vely)
			rubble.sprite.rotation = rubble.sprite.rotation + rubble.GetVar('dir')
			if rubble.y < -1.5*Arena.height then
				rubble.Remove()
			end
		end
	end
end

function OnHit(bullet)
	if bullet.sprite.spritename == 'brick/block' then
		RubbleSplit()
		Player.Hurt(5,0)
	else
		Player.Hurt(1,0)
		bullet.Remove()
	end
end