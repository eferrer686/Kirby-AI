function getPositions()
	
		kirbyX = mainmemory.read_s16_le(0x04F4)
		kirbyY = mainmemory.read_s16_le(0x04F6)
				
		local layer1x = mainmemory.read_s16_le(0x0B7A)
		local layer1y = mainmemory.read_s16_le(0x0FAA)
		
		screenX = kirbyX+layer1x
		screenY = kirbyY+layer1y

end
function getSprites()

	local sprites = {}
	for slot=0,15 do
		local status = mainmemory.readbyte(0x0501+(slot*12))
		local id = mainmemory.readbyte(0x0505+(slot*12))
		if status == 0 and id ~= 0 then
			spritex = mainmemory.readbyte(0x500+(slot*12))
			spritey = mainmemory.readbyte(0x502+(slot*12))
			if spritex < 240 and spritex>0 and spritey>0 and spritey<160 then
				spriteId = mainmemory.readbyte(0x505+(slot*12))
				sprites[#sprites+1] = {["x"]=spritex, ["y"]=spritey,["id"]=spriteId}
			end
		end
	end		

	return sprites
	
end

function sigmoid(x)
	return 2/(1+math.exp(-4.9*x))-1
end



function clearJoypad()
        controller = {}
        for b = 1,#ButtonNames do
                controller[ButtonNames[b]] = false
        end
        joypad.set(controller)
end
function selectInput()
	ButtonNames = {
			"A",
			"B",
			"Down",
			"L",
			"Left",
			"Light Sensor",
			"Power",
			"R",
			"Right",
			"Select",
			"Start",
			"Tilt X",
			"Tilt Y",
			"Tilt Z",
			"Up"
		}

	 createRandom()

	 outputs ={}
	 Outputs = #ButtonNames
	 for o=1,Outputs do
		local button = ButtonNames[o]
		outputs[button] = false
	 end

	if outputs[ButtonNames[but]]== false then
	 outputs[ButtonNames[but]]= true
	else		
	  repeatInput()
			
		
	end
	
	
	 setController()
	 

	 
	 timeout=3
		 
end

function setController()
	joypad.set(outputs)
end

function repeatInput()
	joypad.set(outputs)
end

function createRandom()
	num = math.random(60)
	if num <=5  and num >= 0 then
		but = 1
	elseif num <= 13 and num >= 10 then
		but = 2
	elseif num <= 18 and num>= 14  then
		but = 3
	elseif num <= 32 and num>= 19  then
		but = 5
	elseif num <= 53 and num>=33 then
		but = 9
	elseif num <= 60 and num>=54 then
		but = 15
	end
end

timeout = 3

function drawGUI()
	
		getPositions()
		sprites = getSprites()
		BoxRadius = 16;
		gui.drawBox(-120,-80,120,80,0xFF000000, 0x80808080)
		r=2
		kirbycol=0xFFED4EC5
		gui.drawBox((kirbyX-10)/r,(kirbyY-8)/r,(kirbyX+8)/r,(kirbyY+10)/r,kirbycol,kirbycol)
		enemcol=0xFFFFFF00
		for i=1,#sprites do
			if #sprites>0 then
			color = 0x0
			gui.drawBox((sprites[i].x-10)/r,(sprites[i].y-8)/r,(sprites[i].x+8)/r,(sprites[i].y+10)/r,enemcol,enemcol)
		end
		end
	
end

while true do

		drawGUI()
		
		if timeout <= 0 then		 
				selectInput()
			else 
				emu.frameadvance()
				timeout = timeout - 1
				joypad.set(outputs)
				
		end
		
		
	end