require "Libraries/gaster_blasters"
spawntimer = 0

function Update()
	spawntimer = spawntimer + 1
	if spawntimer%60 == 0 then
		blaster.New(-310, 65, -155, 65, 90)
		GasterBlaster.Scale(0.5,1)
	end
end