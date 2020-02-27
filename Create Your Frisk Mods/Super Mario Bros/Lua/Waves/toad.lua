function Update()
end
sounds = {"little_toadies/h","little_toadies/i","little_toadies/y"}
Encounter.SetVar("wavetimer", 60)
toad = CreateProjectile('toad/1', 0, -41)
toad.sprite.SetAnimation({'1','2','1','3'}, 1/4, 'toad/')
Audio.PlaySound(sounds[math.random(#sounds)])
function OnHit(toad)
	Encounter.SetVar("wavetimer", 5)
	EndWave()
end