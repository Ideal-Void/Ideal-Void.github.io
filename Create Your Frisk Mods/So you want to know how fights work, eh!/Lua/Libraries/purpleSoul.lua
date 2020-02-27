--A purple soul library that allows you to create as many web lines as you want either horizontally or vertically and in any size arena.

webs = {} --array that stores the webs
gaps = {} --array that stores the coordinates of the webs
orient = 0
libactive = false
movingup = false
movingdown = false
movingleft = false
movingright = false
previnput = false
playerpos = 0
xspeed = 0
yspeed = 0
inputdelay = 0

--align: either 0 or 1. 0 = horizontal, 1 = vertical.
--num: number of lines.
function CreateWebs(align,num)
	libactive = true
	numlines = num
	Player.SetControlOverride(true)
	Player.sprite.color = {213/255,53/255,217/255}
	webs = {}
	gaps = {}
	local xsc = 0
	local ysc = 0
	local xoff = 0
	local yoff = 0
	if align == 0 then
		xsc = Arena.width
		ysc = 1
		xoff = 0
		yoff = Arena.height/(num+1)
		orient = 0
	else
		xsc = 1
		ysc = Arena.height
		xoff = Arena.width/(num+1)
		yoff = 0
		orient = 1
	end
	playerpos = math.ceil(num/2)
	for i=1,num do
		web = CreateProjectile("webstrand",Arena.width/2+i*xoff,Arena.height/2+i*yoff)
		web.sprite.SetAnchor(0,0)
		web.sprite.SetPivot(0,0)
		web.sprite.xscale = xsc
		web.sprite.yscale = ysc
		web.MoveTo(math.ceil(-Arena.width/2-1+i*xoff),math.ceil(-Arena.height/2-1+i*yoff))
		table.insert(webs,web)
		if orient == 0 then
			table.insert(gaps,web.y)
		else
			table.insert(gaps,web.x)
		end
	end
	if align == 0 then
		Player.Move(0,gaps[playerpos],false)
	else
		Player.Move(gaps[playerpos],0,false)
	end
end

function HandlePurple()--put this in your wave's update function.

	if Input.Up > 0 then
		if movingup == false then
			if orient == 0 then
				if previnput == false then
					movingup = true
					if playerpos < #webs then
						playerpos = playerpos + 1
						--DEBUG("playerpos: ".. playerpos .. "!")
					end
				end
			else
				yspeed = 2
			end
		end
		previnput = true
	end
	
	if Input.Down > 0 then
		if movingdown == false then
			if orient == 0 then
				if previnput == false then
				movingdown = true
					if playerpos > 1 then
						playerpos = playerpos - 1
						--DEBUG("playerpos: ".. playerpos .. "!")
					end
				end
			else
				yspeed = -2
			end
		end
		previnput = true
	end	
	
	if Input.Left > 0 then
		if movingleft == false then
			if orient == 1 then
				if previnput == false then
				movingleft = true
					if playerpos > 1 then
						playerpos = playerpos - 1
						--DEBUG("playerpos: ".. playerpos .. "!")
					end
				end
			else
				xspeed = -2
			end
		end
		previnput = true
	end
	
	if Input.Right > 0 then
		if movingright == false then
			if orient == 1 then
				if previnput == false then
				movingright = true
					if playerpos < #webs then
						playerpos = playerpos + 1
						--DEBUG("playerpos: ".. playerpos .. "!")
					end
				end
			else
				xspeed = 2
			end
		end
		previnput = true
	end
	if Input.Up == 0 and Input.Down == 0 and Input.Left == 0 and Input.Right == 0 then
		xspeed = 0
		yspeed = 0
		previnput = false
	end
	
	if movingup == true then
		if Player.y < gaps[playerpos] then
			yspeed = math.floor(Arena.height/#webs/4)
		else
			yspeed = 0
			Player.MoveTo(Player.x,gaps[playerpos],false)
			movingup = false
		end
	end
	if movingdown == true then
		if Player.y > gaps[playerpos] then
			yspeed = math.ceil(-Arena.height/#webs/4)
		else
			yspeed = 0
			Player.MoveTo(Player.x,gaps[playerpos],false)
			movingdown = false
		end
	end
	if movingleft == true then
		if Player.x > gaps[playerpos] then
			xspeed = math.ceil(-Arena.height/#webs/4)
		else
			xspeed = 0
			Player.MoveTo(gaps[playerpos],Player.y,false)
			movingleft = false
		end
	end
	if movingright == true then
		if Player.x < gaps[playerpos] then
			xspeed = math.ceil(Arena.height/#webs/4)
		else
			xspeed = 0
			Player.MoveTo(gaps[playerpos],Player.y,false)
			movingright = false
		end
	end
	Player.MoveTo(Player.x+xspeed,Player.y+yspeed,false)
end

function PurpleActive() --returns either "true" or "false" depending on whether or not the purple soul is active.
	if libactive == true then
		return true
	else
		return false
	end
end

function EndWebs() --call this when you want to turn the player's soul red again.
	Player.sprite.color = {1,0,0}
	libactive = false
end

--The function below returns the coordinate value of the <arraypos>th web. Webs are saved in order of lowest to highest or furthest left to
--furthest right depending on whether your webs are horizontal or vertical.
function WebPos(arraypos)
	return gaps[arraypos]
end

function PlayerWeb() --returns the position in the web array of the web currently occupied by the player.
	return playerpos
end

--The function below returns the coordinate value (x or y depending on the alignment of your webs) of the web currently occupied by
--the player.
function PlayerCoord()
	return gaps[playerpos]
end