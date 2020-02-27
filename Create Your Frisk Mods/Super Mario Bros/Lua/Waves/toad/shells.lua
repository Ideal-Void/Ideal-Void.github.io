spawntimer = 0
shells = {}

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 10 == 0 then
		local posx = -350
		local posy = math.random(-60,60)
		local shell = CreateProjectile('shells/red', posx, posy)
		Audio.PlaySound('mariosounds/kick')
		shell.SetVar('velx', 6)
		shell.ppcollision = true
		table.insert(shells, shell)
	end
	
	for i=1,#shells do
		local shell = shells[i]
		shell.Move(shell.GetVar('velx'), 0)
	end
end

function OnHit(shell)
	shell.SetVar('velx', -6)
	Player.hurt(5,0)
end