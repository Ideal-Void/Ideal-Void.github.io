blue = {}

blue.isBlue = false
blue.inAir = false
blue.velY = 0
blue.newX = Player.x
blue.newY = Player.y
blue.canDraw = true
blue.inSelection = false
blue.inAct = false
blue.mask = nil
blue.dir = "down"
blue.olddir = "down"

function blue.TurnBlue(boolean)
	if boolean == false then
		blue.isBlue = false
		Player.SetControlOverride(false)
	else
		blue.isBlue = true
		Player.sprite.color = {0/255, 60/255, 255/255}
		Player.SetControlOverride(true)
	end
end

function blue.WaveStart()
	if blue.isBlue then
		Player.SetControlOverride(true)
		blue.inAir = true
		blue.velY = 0
		blue.newX = Player.x
		blue.newY = Player.y
	end
end

function blue.HandleMovement()
	if blue.isBlue then
		if blue.olddir != blue.dir then
			blue.inAir = true
			blue.olddir = blue.dir
		end
		if blue.dir == "down" then
			if Input.Up > 0 and blue.velY == 0 and blue.inAir == false then
				blue.velY = 3/Time.mult
				blue.inAir = true
			end
			
			if blue.velY/Time.mult > 1/Time.mult and Input.Up < 0 then
					blue.velY = 1/Time.mult
			end
			
			if blue.inAir then
				if blue.newY < -Arena.height/2 + 8 then
					blue.velY = 0
					blue.newY = -Arena.height/2 + 8
					blue.inAir = false
				elseif blue.velY/Time.mult >= 2/Time.mult then
					blue.velY = blue.velY - 0.05/Time.mult^2
					blue.newY = Player.y + blue.velY
				elseif 2/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult >= 0.5/Time.mult then
					blue.velY = blue.velY - 0.125/Time.mult^2
					blue.newY = Player.y + blue.velY
				elseif 0.5/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult >= -0.25/Time.mult then
					blue.velY = blue.velY - 0.05/Time.mult^2
					blue.newY = Player.y + blue.velY
				elseif -0.25/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult > -4.25/Time.mult then
					blue.velY = blue.velY - 0.15/Time.mult^2
					blue.newY = Player.y + blue.velY
				elseif -4/Time.mult >= blue.velY/Time.mult then
					blue.velY = 0
					blue.newY = -Arena.height/2 + 8
					blue.inAir = false
				end
			end
			
			if Input.Left > 0 then
				if Input.Cancel > 0 then
					blue.newX = Player.x - 1
				else
					blue.newX = Player.x - 2
				end
			end
			
			if Input.Right > 0 then
				if Input.Cancel > 0 then
					blue.newX = Player.x + 1
				else
					blue.newX = Player.x + 2
				end
			end
		
		elseif blue.dir == "up" then
			if Input.Down > 0 and blue.velY == 0 and blue.inAir == false then
				blue.velY = 3/Time.mult
				blue.inAir = true
			end
			
			if blue.velY/Time.mult > 1/Time.mult and Input.Down < 0 then
					blue.velY = 1/Time.mult
			end
			
			if blue.inAir then
				if blue.newY > Arena.height/2 - 8 then
					blue.velY = 0
					blue.newY = Arena.height/2 - 8
					blue.inAir = false
				elseif blue.velY/Time.mult >= 2/Time.mult then
					blue.velY = blue.velY - 0.05/Time.mult^2
					blue.newY = Player.y - blue.velY
				elseif 2/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult >= 0.5/Time.mult then
					blue.velY = blue.velY - 0.125/Time.mult^2
					blue.newY = Player.y - blue.velY
				elseif 0.5/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult >= -0.25/Time.mult then
					blue.velY = blue.velY - 0.05/Time.mult^2
					blue.newY = Player.y - blue.velY
				elseif -0.25/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult > -4.25/Time.mult then
					blue.velY = blue.velY - 0.15/Time.mult^2
					blue.newY = Player.y - blue.velY
				elseif -4/Time.mult >= blue.velY/Time.mult then
					blue.velY = 0
					blue.newY = Arena.height/2 + 8
					blue.inAir = false
				end
			end
			
			if Input.Left > 0 then
				if Input.Cancel > 0 then
					blue.newX = Player.x - 1
				else
					blue.newX = Player.x - 2
				end
			end
			
			if Input.Right > 0 then
				if Input.Cancel > 0 then
					blue.newX = Player.x + 1
				else
					blue.newX = Player.x + 2
				end
			end
		
		elseif blue.dir == "left" then
			if Input.Right > 0 and blue.velY == 0 and blue.inAir == false then
				blue.velY = 3/Time.mult
				blue.inAir = true
			end
			
			if blue.velY/Time.mult > 1/Time.mult and Input.Right < 0 then
					blue.velY = 1/Time.mult
			end
			
			if blue.inAir then
				if blue.newX < -Arena.width/2 + 8 then
					blue.velY = 0
					blue.newX = -Arena.width/2 + 8
					blue.inAir = false
				elseif blue.velY/Time.mult >= 2/Time.mult then
					blue.velY = blue.velY - 0.05/Time.mult^2
					blue.newX = Player.x + blue.velY
				elseif 2/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult >= 0.5/Time.mult then
					blue.velY = blue.velY - 0.125/Time.mult^2
					blue.newX = Player.x + blue.velY
				elseif 0.5/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult >= -0.25/Time.mult then
					blue.velY = blue.velY - 0.05/Time.mult^2
					blue.newX = Player.x + blue.velY
				elseif -0.25/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult > -4.25/Time.mult then
					blue.velY = blue.velY - 0.15/Time.mult^2
					blue.newX = Player.x + blue.velY
				elseif -4/Time.mult >= blue.velY/Time.mult then
					blue.velY = 0
					blue.newX = -Arena.width/2 + 8
					blue.inAir = false
				end
			end
			
			if Input.Down > 0 then
				if Input.Cancel > 0 then
					blue.newY = Player.y - 1
				else
					blue.newY = Player.y - 2
				end
			end
			
			if Input.Up > 0 then
				if Input.Cancel > 0 then
					blue.newY = Player.y + 1
				else
					blue.newY = Player.y + 2
				end
			end
		
		elseif blue.dir == "right" then
			if Input.Left > 0 and blue.velY == 0 and blue.inAir == false then
				blue.velY = 3/Time.mult
				blue.inAir = true
			end
			
			if blue.velY/Time.mult > 1/Time.mult and Input.Left < 0 then
					blue.velY = 1/Time.mult
			end
			
			if blue.inAir then
				if blue.newX > Arena.width/2 - 8 then
					blue.velY = 0
					blue.newX = Arena.width/2 - 8
					blue.inAir = false
				elseif blue.velY/Time.mult >= 2/Time.mult then
					blue.velY = blue.velY - 0.05/Time.mult^2
					blue.newX = Player.x - blue.velY
				elseif 2/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult >= 0.5/Time.mult then
					blue.velY = blue.velY - 0.125/Time.mult^2
					blue.newX = Player.x - blue.velY
				elseif 0.5/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult >= -0.25/Time.mult then
					blue.velY = blue.velY - 0.05/Time.mult^2
					blue.newX = Player.x - blue.velY
				elseif -0.25/Time.mult > blue.velY/Time.mult and blue.velY/Time.mult > -4.25/Time.mult then
					blue.velY = blue.velY - 0.15/Time.mult^2
					blue.newX = Player.x - blue.velY
				elseif -4/Time.mult >= blue.velY/Time.mult then
					blue.velY = 0
					blue.newX = Arena.width/2 - 8
					blue.inAir = false
				end
			end
			
			if Input.Down > 0 then
				if Input.Cancel > 0 then
					blue.newY = Player.y - 1
				else
					blue.newY = Player.y - 2
				end
			end
			
			if Input.Up > 0 then
				if Input.Cancel > 0 then
					blue.newY = Player.y + 1
				else
					blue.newY = Player.y + 2
				end
			end
		end
	end
	Player.MoveTo(blue.newX, blue.newY, false)
end

return blue