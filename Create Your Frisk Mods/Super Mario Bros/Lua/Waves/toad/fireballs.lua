-- Based on bullettest_bouncy
spawntimer = 0
bullets = {}
hands = {-30, 30}
dirs = {-2, 2}

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 5 == 0 then
		local posx = hands[math.random(#hands)]
		local posy = Arena.height - 10
		local bullet = CreateProjectile('fire/ball', posx, posy)
		bullet.SetVar('velx', dirs[math.random(#dirs)])
		bullet.SetVar('vely', 0)
		table.insert(bullets, bullet)
		Audio.PlaySound("mariosounds/fireball")
		bullet.SetVar("bounces", 0)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		if bullet.isactive then
			bounces = bullet.GetVar("bounces")
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			local newposx = bullet.x + velx
			local newposy = bullet.y + vely
			if(bullet.x < -Arena.width/2)and(bullet.y > -Arena.height/2)and(bullet.y < Arena.height/2) then
				newposx = -Arena.width/2
				velx = math.abs(velx)
				vely = math.abs(vely)/2
			elseif(bullet.x > Arena.width/2)and(bullet.y > -Arena.height/2)and(bullet.y < Arena.height/2) then
				newposx = Arena.width/2
				velx = -velx
				vely = math.abs(vely)/2
			elseif(bullet.y < -Arena.height/2 + 8) then
				if bounces < 3 then
					newposy = -Arena.height/2 + 8
					vely = math.abs(vely) - 0.8
					bounces = bounces + 1
					bullet.SetVar("bounces", bounces)
				end
			end
			vely = vely - 0.5
			bullet.sprite.rotation = bullet.sprite.rotation - 45
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
	Player.Hurt(1,0)
	bullet.sprite.dust(false)
end

function EndingWave()
	for i=1,#bullets do
		local bullet = bullets[i]
		bullet.sprite.dust(false)
	end
end