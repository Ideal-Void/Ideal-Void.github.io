bullets = {}
spawntimer = 0

mag1 = CreateProjectile('magic/r', -30, Arena.height - 10)
mag1.sprite.SetAnimation({"r","g","b","y"}, 1/4, "magic/")
mag2 = CreateProjectile('magic/r', 30, Arena.height - 10)
mag2.sprite.SetAnimation({"r","g","b","y"}, 1/4, "magic/")

spots = {mag1.x, mag2.x}

Audio.PlaySound('mariosounds/powerup_appears')

function Update()
	mag1.sprite.rotation = mag1.sprite.rotation + 10
	mag2.sprite.rotation = mag2.sprite.rotation - 10
	spawntimer = spawntimer + 1
	if spawntimer % 10 == 0 then
		local bullet = CreateProjectile('magic/spark/1', spots[math.random(#spots)], Arena.height - 10)
		bullet.sprite.SetAnimation({"0","1","2","1","2","3","2","3"}, 1/8, "magic/spark")
		bullet.sprite.loopmode = "ONESHOT"
		bullet.SetVar("dir", math.random(-2,2))
		table.insert(bullets, bullet)
	end
	
	for i=1,#bullets do
		local bullet = bullets[i]
		bullet.Move(bullet.GetVar("dir"), -4)
		if bullet.x > Arena.width/2 or bullet.x < -Arena.width/2 or bullet.y < -Arena.height/2then
			bullet.sprite.dust(false)
		end
	end
end

function OnHit(bullet)
	Player.hurt(2,1)
end

function EndingWave()
	mag1.sprite.dust(false)
	mag2.sprite.dust(false)
end