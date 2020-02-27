spawntimer = 0
bullets = {}
dirs = {'l','r'}
function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 20 == 0 then
		dir = dirs[math.random(#dirs)]
		local bullet = CreateProjectile('donut', 0, 0)
		if dir == 'l' then
			posx = -77
			bullet.SetVar('velx', 2)
		else
			posx = 77
			bullet.SetVar('velx', -2)
		end
		bullet.MoveTo(posx, math.random(-65,65))
		table.insert(bullets, bullet)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		local velx = bullet.GetVar('velx')
		if velx < 0 then
			bullet.sprite.rotation = bullet.sprite.rotation + 10
		elseif velx > 0 then
			bullet.sprite.rotation = bullet.sprite.rotation - 10
		end
		bullet.Move(velx, 0)
	end
end