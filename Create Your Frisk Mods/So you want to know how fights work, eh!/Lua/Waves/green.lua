--Green soul by Moofins21
--Expanded on/made more authentic by Crystalwarrior160
--To create new patterns, simply modify bullet_table and nothing else!
--Doesn't support any fancy-fartsy projectiles yet, just the basic spear with speed variable.
bullets = {}
spawntimer = 0
hittimer = 0
shielddir = "left"
Player.sprite.color = {0/255, 192/255, 0/255}
mask = CreateProjectile('soulmask', Player.x, Player.y)
circle = CreateProjectile("circle", 0, 0)
shield = CreateProjectile("shieldup", 0, 20)
soul = CreateProjectile("greenSoul", 0, 0)
Encounter.SetVar("wavetimer", 12)
savedpx = Player.x
savedpy = Player.y
--This is where we grab the bullet pattern table
bullet_table = {
[10]	= {dir = 'left',	speed = 0.25},
[20]	= {dir = 'left',	speed = 4},
[40]	= {dir = 'up',		speed = 4},
[60]	= {dir = 'right',	speed = 4},
[80]	= {dir = 'down',	speed = 4},
[100]	= {dir = 'right',	speed = 2},
[110]	= {dir = 'right',	speed = 2},
[200]	= {dir = 'left',	speed = 2},
[205]	= {dir = 'left',	speed = 3},
[210]	= {dir = 'left',	speed = 4},
[215]	= {dir = 'left',	speed = 5},
[216]	= {dir = 'left',	speed = 10},
[217]	= {dir = 'left',	speed = 10},
[218]	= {dir = 'left',	speed = 10},
[219]	= {dir = 'left',	speed = 10},
[220]	= {dir = 'left',	speed = 10},
[221]	= {dir = 'left',	speed = 10},
[222]	= {dir = 'left',	speed = 10},
[223]	= {dir = 'left',	speed = 10},
[224]	= {dir = 'left',	speed = 10},
[225]	= {dir = 'left',	speed = 10},
[226]	= {dir = 'left',	speed = 10},
[227]	= {dir = 'left',	speed = 10},
[228]	= {dir = 'left',	speed = 10},
[229]	= {dir = 'left',	speed = 10},
[230]	= {dir = 'left',	speed = 10},
[250]	= {dir = 'up',		speed = math.random(2,5)},
[300]	= {dir = 'down',	speed = math.random(2,5)},
[350]	= {dir = 'up',		speed = math.random(2,5)},
[400]	= {dir = 'down',	speed = math.random(2,5)},
[450]	= {dir = 'up',		speed = math.random(2,5)},
[500]	= {dir = 'down',	speed = math.random(2,5)},
}
function Update()
	spawntimer = spawntimer + 1
	local proj = bullet_table[spawntimer]
	if type(proj) == "table" then
		local dir = proj.dir
		if type(dir) == "table" then
			dir = dir[math.random(#dir)]
		end
		if dir == 'down' then
			local bullet = CreateProjectile('spear', 0, -200)
			bullet.SetVar('velx', 0)
			bullet.SetVar('vely', proj.speed)
			bullet.sprite.rotation = 0
			table.insert(bullets, bullet)
		end
		if dir == 'up' then
			local bullet = CreateProjectile('spear', 0, 200)
			bullet.SetVar('velx', 0)
			bullet.SetVar('vely', -proj.speed)
			bullet.sprite.rotation = 180
			table.insert(bullets, bullet)
		end
		if dir == 'left' then
			local bullet = CreateProjectile('spear', -200, 0)
			bullet.SetVar('velx', proj.speed)
			bullet.SetVar('vely', 0)
			bullet.sprite.rotation = 270
			table.insert(bullets, bullet)
		end
		if dir == 'right' then
			local bullet = CreateProjectile('spear', 200, 0)
			bullet.SetVar('velx', -proj.speed)
			bullet.SetVar('vely', 0)
			bullet.sprite.rotation = 90
			table.insert(bullets, bullet)
		end
	end
	if proj == 'repeat' then
		spawntimer = 0
	end
	mask.MoveTo(Player.x, Player.y)

	hittimer = math.max(0, hittimer - 1)
	if savedpx < Player.x then
		shielddir = "right"
	elseif savedpx > Player.x then
		shielddir = "left"
	elseif savedpy < Player.y then
		shielddir = "up"
	elseif savedpy > Player.y then
		shielddir = "down"
	end
	shield.Remove()
	if shielddir == "right" then
		if hittimer > 0 then
			shield = CreateProjectile('shieldright_hit', 20, 0)
		else
			shield = CreateProjectile('shieldright', 20, 0)
		end
	elseif shielddir == "left" then
		if hittimer > 0 then
			shield = CreateProjectile('shieldleft_hit', -20, 0)
		else
			shield = CreateProjectile('shieldleft', -20, 0)
		end
	elseif shielddir == "up" then
		if hittimer > 0 then
			shield = CreateProjectile('shieldup_hit', 0, 20)
		else
			shield = CreateProjectile('shieldup', 0, 20)
		end
	elseif shielddir == "down" then
		if hittimer > 0 then
			shield = CreateProjectile('shielddown_hit', 0, -20)
		else
			shield = CreateProjectile('shielddown', 0, -20)
		end
	end
	savedpx = Player.x
	savedpy = Player.y
	for i=1,#bullets do
		local bullet = bullets[i]
		if bullet.isactive then
			local velx = bullet.GetVar('velx')
			local vely = bullet.GetVar('vely')
			local newposx = bullet.x + velx
			local newposy = bullet.y + vely
			bullet.MoveTo(newposx, newposy)
			if bullet.x > -60 and bullet.x < 0 and bullet.GetVar('velx') > 0 and shielddir == "left" then
				hittimer = 10
				bullet.Remove()
				Audio.PlaySound('hit')
			elseif bullet.x < 60 and bullet.x > 0 and bullet.GetVar('velx') < 0 and shielddir == "right" then
				hittimer = 10
				bullet.Remove()
				Audio.PlaySound('hit')
			elseif bullet.y < 60 and bullet.y > 0 and bullet.GetVar('vely') < 0 and shielddir == "up" then
				hittimer = 10
				bullet.Remove()
				Audio.PlaySound('hit')
			elseif bullet.y > -60 and bullet.y < 0 and bullet.GetVar('vely') > 0 and shielddir == "down" then
				hittimer = 10
				bullet.Remove()
				Audio.PlaySound('hit')
			end
			if bullet.x < 16 and bullet.x > -16 and bullet.GetVar('vely') == 0 then
				bullet.Remove()
				Player.Hurt(3,0)
			elseif bullet.y < 16 and bullet.y > -16 and bullet.GetVar('velx') == 0 then
				bullet.Remove()
				Player.Hurt(3,0)
			end
		end
	end
end

function OnHit(bullet)
	--Did you ever hear the Tragedy of Darth Plagueis the wise?
	--I thought not.
	--It's not a story the Jedi would tell you.
	--It's a Sith legend.
	--Darth Plagueis was a Dark Lord of the Sith, so powerful and so wise he could use the Force to influence the midichlorians to create life...
	--He had such a knowledge of the dark side that he could even keep the ones he cared about from dying.
	--The dark side of the Force is a pathway to many abilities some consider to be unnatural.
	--He became so powerful... the only thing he was afraid of was losing his power, which eventually, of course, he did.
	--Unfortunately, he taught his apprentice everything he knew, then his apprentice killed him in his sleep.
	--It's ironic he could save others from death, but not himself.
end

function EndingWave()
	Encounter.SetVar("wavetimer", 4)
end