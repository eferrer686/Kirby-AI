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
	 if but~=7 and but~=10 and  but~=11 and but~=12 and but~=13 and but~=14 and but~=4 and but~=8 then 
		outputs[ButtonNames[but]]= true
		else		
		 repeatInput()
			
		end
	end
	
	 if but > 85 then
		 setController()
	 end

	 emu.frameadvance()
	 timeout=10
		 
end

function setController()
	joypad.set(outputs)
end

function repeatInput()
	joypad.set(outputs)
end

function createRandom()
	n = math.random(100)
	if n <= 8 then	
		but = math.random(#ButtonNames)
	elseif n <=20  and n >= 9 then
		but = 15
	elseif n == 21 or n == 30 then
		but = 2
	
	elseif n >= 31 and n<= 40  then 
		but = 5
	elseif n >= 41 and n<= 50  then 
		but = 3
	elseif n > 51 and n<81 then
		but = 9
	elseif n > 80 and n<85 then
		but = 1
	end
end

timeout = 10

while true do
	
	if timeout <= 0 then		 
		selectInput()
	else 
		emu.frameadvance()
		timeout = timeout - 1
		joypad.set(outputs)
		
	end
end