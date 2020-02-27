local superhot = {}

SetGlobal("pspeed",0) --initialize global variable for the player's speed.

local prevx = Player.x
local prevy = Player.y
local timeleft = 240

function begin()--call this whenever you want to activate the soul mode.
	Player.sprite.color = {66/255,252/255,1} -- if you dislike the default sprite, delete the "--" at the begining of this line and replace the color with something you prefer.
end

function finish()--call this whenever you want to deactivate the soul mode.
	Player.sprite.color = {1,0,0}
end

function calcspeed ()--call this function during your wave's "update" function.
	SetGlobal("pspeed",math.floor((math.abs(prevx-Player.x+0.1)+math.abs(prevy-Player.y+0.1)))/2)
	if GetGlobal("pspeed") == 0 then
		SetGlobal("pspeed",1/60)
	end
	prevx = Player.x
	prevy = Player.y
	timeleft = timeleft-GetGlobal("pspeed")
	--DEBUG("time left:" .. timeleft .. "frames")
	if timeleft <= 0 then
		EndWave()
	end
end