-- Based on bullettest_bouncy
spawntimer = 0
bullets = {}
CreateProjectileLayer('lava', '')
lava = CreateProjectile('biglava', 0, -50, 'lava')

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 8 == 0 then
		local posx = math.random(-Arena.width/2,Arena.width/2)
		local posy = -Arena.height/2
		local bullet = CreateProjectile('fire/bubble', posx, posy)
		Audio.PlaySound('lava')
		bullet.SetVar('velx', 0)
		bullet.SetVar('vely', 8)
		table.insert(bullets, bullet)
	end
	
	for i=1,#bullets do
		bullet = bullets[i]
		if bullet.isactive then
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			vely = vely - 0.25
			bullet.Move(velx, vely)
			bullet.SetVar('vely', vely)
			if bullet.GetVar('vely') < 0 then
				bullet.sprite.set('fire/bubble2')
				if(bullet.y < -Arena.height/2) then
					bullet.Remove()
				end
			end
		end
	end
end

function OnHit(bullet)
	if bullet.sprite.spritename == 'biglava' then
		Player.Hurt(1,0.125)
	else
		Player.Hurt(5,0.5)
	end
end

function EndingWave()
	lava.sprite.dust(false)
end