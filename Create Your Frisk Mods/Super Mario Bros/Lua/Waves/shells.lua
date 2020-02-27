spawntimer = 0
shells = {}

function Update()
	spawntimer = spawntimer + 1
	if spawntimer % 30 == 0 then
		local posx = -350
		local posy = math.random(-65,65)
		local shell = CreateProjectile('shells/red', posx, posy)
		Audio.PlaySound('mariosounds/kick')
		shell.SetVar('velx', 4)
		shell.SetVar('vely', 0)
		table.insert(shells, shell)
	end
	
	for i=1,#shells do
		local shell = shells[i]
		local velx = shell.GetVar('velx')
		local vely = shell.GetVar('vely')
		local newposx = shell.x + velx
		local newposy = shell.y + vely
		shell.MoveTo(newposx, newposy)
		shell.SetVar('velx', velx)
	end
end

function OnHit(shell)
	velx = shell.GetVar('velx')
	velx = -velx
	shell.SetVar('velx', velx)
	Player.hurt(5,0)
end