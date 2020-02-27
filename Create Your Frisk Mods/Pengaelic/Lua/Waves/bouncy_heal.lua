bullets = {}
-- Based on bullettest_bouncy
stopper = 0
sprites = {'ball', 'ut-heart'}
function Update()
	if stopper == 0 then
		stopper = 1
		local bullet = CreateProjectile(sprites[math.random(#sprites)], 0, Arena.height/2)
		bullet.SetVar('velx', math.random(-1,1))
		if bullet.GetVar('velx') == -1 then
			bullet.MoveTo(64, Arena.height/2)
		elseif bullet.GetVar('velx') == 1 then
			bullet.MoveTo(-64, Arena.height/2)
		end
		bullet.SetVar('vely', 0)
		table.insert(bullets, bullet)
		Audio.PlaySound("ball")
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		bullet.sprite.color = {0/255, 255/255, 0/255}
		if bullet.isactive then
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			local newposx = bullet.x + velx
			local newposy = bullet.y + vely
			if(bullet.x < -Arena.width/2) then 
				newposx = -Arena.width/2
				Audio.PlaySound("bounce")
				velx = math.abs(velx)
				vely = math.abs(vely)/2
			elseif(bullet.x > Arena.width/2) then 
				newposx = Arena.width/2
				Audio.PlaySound("bounce")
				velx = -velx
				vely = math.abs(vely)/2
			end
			vely = vely - 0.05
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
	Player.Heal(5)
end