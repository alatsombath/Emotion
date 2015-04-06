-- Emotion v1.1
-- LICENSE: Creative Commons Attribution-Non-Commercial-Share Alike 3.0

local Measure,MeasureBuffer,Meter,MeterName,Hidden={},{},{},{},{}
function Initialize()
	local SymbolFile=io.open(SKIN:ReplaceVariables("#@#Symbol.inc"),"r") Symbol=SymbolFile:read("*all") SymbolFile:close()
	Levels=SKIN:ParseFormula(SKIN:ReplaceVariables("#Levels#"))
	Threshold=1/Levels
	
	Sub,Sub2,Index,Limit=SELF:GetOption("Sub"),SELF:GetOption("Sub2"),SKIN:ParseFormula(SELF:GetOption("Index")),SKIN:ParseFormula(SELF:GetOption("Limit"))
	local MeasureName,MeterNameString,gsub=SKIN:ReplaceVariables("#MeasureName#"),SKIN:ReplaceVariables("#MeterName#"),string.gsub
			
	for i=Index,Limit do
		Meter[i],MeterName[i],Hidden[i],Measure[i]={},{},{},SKIN:GetMeasure((gsub(MeasureName,Sub,i)))
		for j=1,Levels do Hidden[i][j],MeterName[i][j]=1,(gsub((gsub(MeterNameString,Sub,i)),Sub2,j))
			Meter[i][j]=SKIN:GetMeter(MeterName[i][j]) SKIN:Bang("!SetOption",MeterName[i][j],"Text",Symbol) end end end

function Update()
	for i=Index,Limit do
		local Hidden,Meter,MeterName,Value=Hidden[Limit+1-i],Meter[Limit+1-i],MeterName[Limit+1-i],Measure[i]:GetValue()
		for j=Levels,1,-1 do
			if Value>Threshold*(Levels-j-1) then
				if Hidden[j]==1 then Meter[j]:Show() SKIN:Bang("!UpdateMeter",MeterName[j]) Hidden[j]=0 end
			elseif Hidden[j]==0 then Meter[j]:Hide() SKIN:Bang("!UpdateMeter",MeterName[j]) Hidden[j]=1 end
		end
	end
end