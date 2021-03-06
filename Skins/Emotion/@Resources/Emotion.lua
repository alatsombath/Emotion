-- Emotion v1.2
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

-- This Lua script is encoded in UTF-16
-- http://docs.rainmeter.net/tips/unicode-in-rainmeter

local Measure,MeasureBuffer,Meter,MeterName,Hidden={},{},{},{},{}

function Initialize()

	-- Retrieve the symbol in an external file, encoded in UTF-8
	local SymbolFile=io.open(SKIN:ReplaceVariables("#@#Symbol.inc"),"r") Symbol=SymbolFile:read("*all") SymbolFile:close()
	
	-- Number of vertical String meters
	Levels=SKIN:ParseFormula(SKIN:ReplaceVariables("#Levels#"))
	
	-- Measure increment to unhide a single meter
	Threshold=1/Levels
	
	-- Iteration control variables
	Sub,Sub2,Index,Limit=SELF:GetOption("Sub"),SELF:GetOption("Sub2"),SKIN:ParseFormula(SELF:GetNumberOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit"))
	local MeasureName,MeterNameString,gsub=SELF:GetOption("MeasureName"),SELF:GetOption("MeterName"),string.gsub
	
	-- For each String meter, left-to-right
	for i=Index,Limit do
		
		-- Retrieve measures and meter names, store in tables
		Meter[i],MeterName[i],Hidden[i],Measure[i]={},{},{},SKIN:GetMeasure((gsub(MeasureName,Sub,i)))
		
		-- For each String meter, top-to-bottom
		for j=1,Levels do
			
			Hidden[i][j],MeterName[i][j]=1,(gsub((gsub(MeterNameString,Sub,i)),Sub2,j))
			
			-- Retrieve String meters and set the symbol as the text
			Meter[i][j]=SKIN:GetMeter(MeterName[i][j])
			SKIN:Bang("!SetOption",MeterName[i][j],"Text",Symbol)
			
		end
		
	end
	
end

function Update()

	-- For each String meter, left-to-right
	for i=Index,Limit do
	
		local Hidden,Meter,MeterName,Value=Hidden[Limit+1-i],Meter[Limit+1-i],MeterName[Limit+1-i],Measure[i]:GetValue()
		
		-- For each String meter, top-to-bottom
		for j=Levels,1,-1 do
		
			-- If the measure value is past the multiplied threshold for that level (bottom-to-top)
			if Value>Threshold*(Levels-j-1) then
			
				-- Unhide the String meter
				if Hidden[j]==1 then Meter[j]:Show() SKIN:Bang("!UpdateMeter",MeterName[j]) Hidden[j]=0 end
				
			-- Otherwise hide the string meter
			elseif Hidden[j]==0 then Meter[j]:Hide() SKIN:Bang("!UpdateMeter",MeterName[j]) Hidden[j]=1 end
			
		end
		
	end
	
end