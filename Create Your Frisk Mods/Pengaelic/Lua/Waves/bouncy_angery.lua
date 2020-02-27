-- Based on bullettest_bouncy
spawntimer = 0
bullets = {}

function Update()
	spawntimer = spawntimer + 1
	if spawntimer%20 == 0 then
		local posx = math.random(-75,75)
		local posy = Arena.height/2
		local bullet = CreateProjectile('ball', posx, posy)
		bullet.SetVar('velx', 1 - 2*math.random())
		bullet.SetVar('vely', 0)
		table.insert(bullets, bullet)
		Audio.PlaySound("ball")
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		if bullet.isactive then
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			local newposx = bullet.x + velx
			local newposy = bullet.y + vely
			if(bullet.x > -Arena.width/2 and bullet.x < Arena.width/2) then
				if(bullet.y < -Arena.height/2 + 8) then 
					newposy = -Arena.height/2 + 8
					Audio.PlaySound("bounce")
					vely = math.abs(vely) - 0.8
				end
			end
			vely = vely - 0.1
			bullet.MoveTo(newposx, newposy)
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
	Audio.PlaySound("bounce")
	bullet.MoveTo(newposx, newposy)
	bullet.SetVar('vely', vely)
	Player.Hurt(1,0.1)
end