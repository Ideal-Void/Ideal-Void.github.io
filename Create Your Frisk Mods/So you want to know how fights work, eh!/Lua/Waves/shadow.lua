turnPlayer = require("turning")
turnPlayer.Init()

spawntimer = 0
bullets = {}
dirs = {'u','d','l','r'}

function Update()
	turnPlayer.Update()
	spawntimer = spawntimer + 1
	if spawntimer % 20 == 0 then
		dir = dirs[math.random(#dirs)]
		local bullet = CreateProjectile('shadow', 0, 0)
		if dir == 'u' or dir == 'd' then
			posx = math.random(-77,77)
			bullet.SetVar('velx', 0)
			if dir == 'u' then
				posy = -100
				bullet.SetVar('vely', 2)
			else
				posy = 100
				bullet.SetVar('vely', -2)
			end
		elseif dir == 'l' or dir == 'r' then
			posy = math.random(-65,65)
			bullet.SetVar('vely', 0)
			if dir == 'l' then
				posx = -100
				bullet.SetVar('velx', 2)
			else
				posx = 100
				bullet.SetVar('velx', -2)
			end
		end
		bullet.MoveTo(posx, posy)
		table.insert(bullets, bullet)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		if bullet.isactive then
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			bullet.Move(velx, vely)
			bullet.sprite.alpha = bullet.sprite.alpha - 0.01
			if bullet.sprite.alpha == 0 then
				bullet.remove()
			end
		end
	end
end