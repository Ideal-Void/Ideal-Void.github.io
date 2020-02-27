spawned = false
stopped = false
Encounter.SetVar("wavetimer", 8)
function Update()
	if spawned == false then
		plant = CreateProjectile('piranha_plants/big_boye', 0, -180)
		vely = 2
		spawned = true
	end
	plant.ppcollision = true
	plant.Move(0, vely)
	vely = vely - 0.01
	if vely < 0 and stopped == false then
		stopped = true
		plant.sprite.Set('piranha_plants/big_boye_closed')
		Audio.PlaySound("chomp")
	end
end

function OnHit(plant)
	if plant.sprite.spritename == 'piranha_plants/big_boye_closed' then
		Player.Hurt(10)
	else
	
	end
end

function EndingWave()
	Encounter.SetVar("wavetimer", 5)
end