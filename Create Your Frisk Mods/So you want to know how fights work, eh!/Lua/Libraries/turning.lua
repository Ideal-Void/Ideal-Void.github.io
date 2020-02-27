local self = {}

--Modifiable variables--
self.speed = 2
self.turnSpeed = 4
self.reverseMult = 0.5
self.collideArena = true
---------------------

--Interal variables--
hurttimer = 0
---------------------

--[[ FUNCTIONS ]]--
function self.Init()
	--Initialize player control and sprites
	Player.SetControlOverride(true)
end
function self.Update()
	local px = Player.x
	local py = Player.y
	if(Input.Right > 0) then
		Player.sprite.rotation = Player.sprite.rotation - (self.turnSpeed * Time.mult)
	end
	if(Input.Left > 0) then
		Player.sprite.rotation = Player.sprite.rotation + (self.turnSpeed * Time.mult)
	end
	if(Input.Up > 0) then
		px = px + math.cos(math.rad(Player.sprite.rotation - 90)) * self.speed * Time.mult
		py = py + math.sin(math.rad(Player.sprite.rotation - 90)) * self.speed * Time.mult
	end
	if(Input.Down > 0) then
		px = px - math.cos(math.rad(Player.sprite.rotation - 90)) * (self.speed * self.reverseMult) * Time.mult
		py = py - math.sin(math.rad(Player.sprite.rotation - 90)) * (self.speed * self.reverseMult) * Time.mult
	end
	if(Player.isHurting and hurttimer==0) then
		hurttimer = Time.time
	elseif(not Player.isHurting) then
		hurttimer = 0
	end
	if(Time.time - hurttimer >= 0.3) then
		hurttimer = Time.time
	end
	Player.MoveTo(px, py, not self.collideArena)
end

return self