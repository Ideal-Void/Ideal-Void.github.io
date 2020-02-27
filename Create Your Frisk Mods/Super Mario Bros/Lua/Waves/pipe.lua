spawn = 0

function Update()
	if spawn == 0 then
		spawn = 1
		posx = math.random(-60,60)
		posy = -100
		pipe = CreateProjectile('pipe', posx, posy)
		Audio.PlaySound('mariosounds/powerup_appears')
		pipe.SetVar('velx', 0)
		pipe.SetVar('vely', 1)
	end
	
	for i=1,10 do
		velx = pipe.GetVar('velx')
		vely = pipe.GetVar('vely')
		newposx = pipe.x + velx
		newposy = pipe.y + vely
		vely = vely - 0.01
		pipe.MoveTo(newposx, newposy)
		pipe.SetVar('vely', vely)
		if pipe.GetVar('vely') < 0 then
			pipe.SetVar('vely', 0)
		end
	end
end

function OnHit()
	Audio.PlaySound('mariosounds/pipe')
	error('player tried to enter Warp Zone')
end

function EndingWave()
	Audio.PlaySound('mariosounds/pipe')
end