-- Based on bullettest_touhou
spawntimer = 0
bullets = {}
yOffset = 225
mult = 0.5
numbullets = math.random(5,15)
delay = math.random(10,60)
function Update()
	spawntimer = spawntimer + 1
	if(spawntimer % delay == 0) then
		for i=1,numbullets+1 do
			local bullet = CreateProjectile('shuriken', 0, yOffset)
			bullet.SetVar('timer', 0)
			bullet.SetVar('offset', math.pi * 2 * i / numbullets)
			bullet.SetVar('negmult', mult)
			bullet.SetVar('lerp', 0)
			table.insert(bullets, bullet)
		end
		mult = mult + 0.05
		Audio.PlaySound('blast')
	end

	for i=1,#bullets do
		local bullet = bullets[i]
		local timer = bullet.GetVar('timer')
		local offset = bullet.GetVar('offset')
		local lerp = bullet.GetVar('lerp')
		local posx = (70*lerp)*math.sin(timer*bullet.GetVar('negmult') + offset)
		local posy = (70*lerp)*math.cos(timer + offset) + yOffset - lerp*50
		bullet.sprite.rotation = bullet.sprite.rotation - 10
		bullet.MoveTo(posx - 130, posy)
		bullet.SetVar('timer', timer + 1/40)
		lerp = lerp + 1 / 90
		if lerp > 4.0 then
			lerp = 4.0
		end
		bullet.SetVar('lerp', lerp)
	end
end