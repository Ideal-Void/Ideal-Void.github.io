-- Based on bullettest_touhou
spawntimer = 0
bullets = {}
yOffset = -20
mult = 0.5
Audio.PlaySound("elytra")
function Update()
	spawntimer = spawntimer + 1
	if(spawntimer % 10 == 0) then
		local numbullets = 16
		for i=1,numbullets+1 do
			local bullet = CreateProjectile('shuriken', 0, yOffset)
			bullet.SetVar('timer', 0)
			bullet.SetVar('offset', math.pi * i / numbullets)
			bullet.SetVar('negmult', mult)
			bullet.SetVar('lerp', 0)
			bullet.sprite.rotation = math.random(0,360)
			table.insert(bullets, bullet)
		end
		mult = mult * math.random(2,10)
	end

	for i=1,#bullets do
		local bullet = bullets[i]
		local timer = bullet.GetVar('timer')
		local offset = bullet.GetVar('offset')
		local lerp = bullet.GetVar('lerp')
		local neg = 1
		local posx = (70*lerp)*math.tan(timer*bullet.GetVar('negmult') + offset)
		local posy = (70*lerp)*math.cos(timer + offset) + yOffset - lerp*50
		bullet.MoveTo(posx, posy)
		bullet.SetVar('timer', timer + 1/40)
		lerp = lerp + 1 / 90
		if lerp > 4.0 then
			lerp = 4.0
		end
		bullet.SetVar('lerp', lerp)
	end
end

function OnHit(bullet)
	Player.Hurt(1,0.25)
end