spawntimer = 111
bullets = {}
starts = {-350,350}

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 120 == 0 then
		local posx = starts[math.random(#starts)]
		local posy = math.random(-65,65)
		local bullet = CreateProjectile('mario/teenyr', posx, posy)
		if posx > 0 then
			bullet.SetVar('velx', -5)
			bullet.sprite.Set('mario/teenyl')
		elseif posx < 0 then
			bullet.SetVar('velx', 5)
		end
		bullet.SetVar('vely', 0)
		table.insert(bullets, bullet)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		local velx = bullet.GetVar('velx')
		local vely = bullet.GetVar('vely')
		local newposx = bullet.x + velx
		local newposy = bullet.y + vely
		bullet.MoveTo(newposx, newposy)
		bullet.SetVar('velx', velx)
	end
end

function OnHit(bullet)
	Player.hurt(5)
end