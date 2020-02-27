require "cyanSoul"
spawntimer = 0
bullets = {}
pspeed = GetGlobal("pspeed")
begin()

function Update()
	calcspeed()
	pspeed = GetGlobal("pspeed")
	spawntimer = spawntimer + 1
	if spawntimer % 10 == 0 then
		local posx = math.random(-77,77)
		local posy = math.random(0,65)
		local bullet = CreateProjectile('fire', posx, posy)
		bullet.SetVar('velx', 0)
		bullet.SetVar('vely', -2)
		table.insert(bullets, bullet)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		local velx = bullet.GetVar('velx')*pspeed
		local vely = bullet.GetVar('vely')*pspeed
		bullet.Move(velx, vely)
	end
end

function EndingWave()
	finish()
end