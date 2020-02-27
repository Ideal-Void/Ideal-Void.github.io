-- I know I used another bullettest attack's code for this, but I can't remember which one...
spawntimer = 0
plants = {}
bullets = {}

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 10 == 0 then
		local posx = math.random(-60,60)
		local posy = -180
		local plant = CreateProjectile('piranha_plants/open', posx, posy)
		plant.SetVar('velx', 0)
		plant.SetVar('vely', 5.75)
		table.insert(plants, plant)
	end
	
	for i=1,#plants do
		plant = plants[i]
		if plant.isactive then
			local velx = plant.GetVar('velx')
			local vely = plant.GetVar('vely')
			local newposx = plant.x + velx
			local newposy = plant.y + vely
			vely = vely - 0.125
			plant.MoveTo(newposx, newposy)
			plant.SetVar('vely', vely)
		end
		
		if plant.GetVar('vely') < 0 and plant.isactive and plant.y == -45 then
			plant.sprite.Set('piranha_plants/closed')
			local posx = plant.x
			local posy = -50
			local bullet = CreateProjectile('fire/ball', posx, posy)
			Audio.PlaySound('mariosounds/fireball')
			bullet.SetVar('velx', 0)
			bullet.SetVar('vely', 4)
			table.insert(bullets, bullet)
			if plant.y < -90 then
				plant.Remove()
			end
		end
	end
	
	for i=1,#bullets do
		bullet = bullets[i]
		if bullet.isactive then
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			local newposx = bullet.x + velx
			local newposy = bullet.y + vely
			bullet.MoveTo(newposx, newposy)
			bullet.sprite.rotation = bullet.sprite.rotation - 45
			if bullet.y > Arena.height/2 then
				bullet.Remove()
			end
		end
	end
end

function OnHit(bullet)
	if bullet.sprite.spritename == 'fire/ball' then
		Player.Hurt(1,0)
		bullet.Remove()
	elseif bullet.sprite.spritename == 'piranha_plants/closed' then
		Player.Hurt(5,1)
	else
		
	end
end