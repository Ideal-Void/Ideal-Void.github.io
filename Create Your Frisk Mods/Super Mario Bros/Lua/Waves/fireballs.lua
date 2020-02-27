-- Based on bullettest_bouncy
spawntimer = 0
bullets = {}
hands = {-40, 40}

function Update()
	spawntimer = spawntimer + 1
	if spawntimer%20 == 0 then
		local posx = hands[math.random(#hands)]
		local posy = Arena.height - 20
		local bullet = CreateProjectile('fire/ball', posx, posy)
		bullet.SetVar('velx', math.random(-2,2))
		bullet.SetVar('vely', 0)
		while bullet.GetVar('velx') == 0 do
			bullet.SetVar('velx', math.random(-2,2))
		end
		table.insert(bullets, bullet)
		Audio.PlaySound("mariosounds/fireball")
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		if bullet.isactive then
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			local newposx = bullet.x + velx
			local newposy = bullet.y + vely
			if(bullet.x < -Arena.width/2) then
				newposx = -Arena.width/2
				velx = math.abs(velx)
				vely = math.abs(vely)/2
			elseif(bullet.x > Arena.width/2) then
				newposx = Arena.width/2
				velx = -velx
				vely = math.abs(vely)/2
			elseif(bullet.y < -Arena.height/2 + 8) then
				newposy = -Arena.height/2 + 8
				vely = math.abs(vely) - 0.8
			end
			vely = vely - 0.1
			bullet.sprite.rotation = bullet.sprite.rotation - 22.5
			bullet.MoveTo(newposx, newposy)
			bullet.SetVar('velx', velx)
			bullet.SetVar('vely', vely)
		end
	end
end

function OnHit(bullet)
	local velx = bullet.GetVar('velx')
	local vely = bullet.GetVar('vely')
	velx = math.abs(velx) * math.abs(velx)
	vely = math.abs(vely)
	local newposx = bullet.x + velx
	local newposy = bullet.y + vely
	bullet.MoveTo(newposx, newposy)
	bullet.SetVar('vely', vely)
	Player.Hurt(1,1)
	bullet.Remove()
end