[ScriptRepeatReadMetersAgain]
Measure=Script
ScriptFile=#@#RepeatSection.lua
ReadFile=#@#ReadMeters.inc
WriteFile=#@#ReadMetersAgain.inc
Sub=Repeat
Index=Again
Limit=Again

[ScriptRepeatWriteMetersAgain]
Measure=Script
ScriptFile=#@#RepeatSection.lua
ReadFile=#@#ReadMetersAgain.inc
WriteFile=#@#WriteMetersAgain.inc
Sub=#
Index=1
Limit=#Levels#
@Include=#@#WriteMetersAgain.inc

[MeterDummyAgain]
Meter=Bar
MeasureName=MeasureAudio
X=0R
UpdateDivider=-1