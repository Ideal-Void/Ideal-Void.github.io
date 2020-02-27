-- I know I used another bullettest attack's code for this, but I can't remember which one...
spawntimer = 0
bullets = {}
delay = math.random(10,20)
function Update()
	spawntimer = spawntimer + 1
	if spawntimer % delay == 0 then
		local posx = math.random(-77,77)
		local posy = -128
		local bullet = CreateProjectile('spear', posx, posy)
		Audio.PlaySound('spear')
		bullet.SetVar('velx', 0)
		bullet.SetVar('vely', 0)
		table.insert(bullets, bullet)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		local velx = bullet.GetVar('velx')
		local vely = bullet.GetVar('vely')
		local newposx = bullet.x + velx
		local newposy = bullet.y + vely
		vely = vely + 0.1
		bullet.MoveTo(newposx, newposy)
		bullet.SetVar('vely', vely)
	end
end