Arena.ResizeImmediate(math.random(120,200),math.random(120,200))

require "libraries/purpleSoul"

numwebs = math.random(3,5)
side = math.random(0,1)

spawntimer = 0
bulletpos = 1

bullets = {}

CreateWebs(side,numwebs)

function Update()
	HandlePurple()
	if spawntimer%30 == 0 then
		if side == 0 then
			bullet = CreateProjectile("spider",-Arena.width/2,WebPos(bulletpos))
		else
			bullet = CreateProjectile("spider",WebPos(bulletpos),Arena.height/2)
			bullet.sprite.rotation = 90
		end
		table.insert(bullets,bullet)
		if bulletpos < numwebs then
			bulletpos = bulletpos + 1
		else
			bulletpos = 1
		end
	end
	for i=1,#bullets do
		if bullets[i].isactive then
			if side == 0 then
				bullets[i].Move(5,0)
			else
				bullets[i].Move(0,-5)
			end
			if bullets[i].x >= Arena.width/2 or bullets[i].y <= -Arena.height/2 then
				bullets[i].remove()
			end
		end
	end
	spawntimer = spawntimer + 1
end

function OnHit(bullet)
	if bullet.sprite.spritename != "webstrand" then
		Player.Hurt(3)
	end
end