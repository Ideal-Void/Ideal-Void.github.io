spawntimer = 0
bullets = {}
function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 10 == 0 then
		local posx = math.random(-77,77)
		local posy = 128
		local bullet = CreateProjectile('fire', posx, posy)
		bullet.SetVar('velx', 0)
		bullet.SetVar('vely', -2)
		table.insert(bullets, bullet)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		local velx = bullet.GetVar('velx')
		local vely = bullet.GetVar('vely')
		bullet.Move(velx, vely)
	end
end