local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
if C.unitframes.enable ~= true then return end

-- Base layout/code by Sinaris
-- http://www.tukui.org/forums/forum.php?id=113

------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------
local unit = TukuiPet
local health = TukuiPet.Health
local power = TukuiPet.Power
local healthBG = TukuiPet.Health.bg
local name = TukuiPet.Name


---------------------------------------------------------------------------------------------
-- not needed
---------------------------------------------------------------------------------------------
do
	unit.shadow:Kill()
	unit.panel:Kill()
end

---------------------------------------------------------------------------------------------
-- health
---------------------------------------------------------------------------------------------
do
	health:SetHeight( 16 )
	health:CreateBorder( true )

	if( C["unitframes"].unicolor == true ) then
		health:SetStatusBarColor( .150, .150, .150, 1 )
		healthBG:SetVertexColor( 1, 0, 0, 1 )
		healthBG:SetTexture( 238, .44, .44, 0.3 )
	end

	name:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
	name:SetParent( health )
	name:ClearAllPoints()
	name:SetPoint( "CENTER", health, "CENTER", 0, 0 )
	name:SetShadowOffset( 0, 0 )
	name.ClearAllPoints = T.dummy
	name.SetPoint = T.dummy

	unit:Tag( Name, "[Tukui:getnamecolor][Tukui:namemedium]" )
end

---------------------------------------------------------------------------------------------
-- power
---------------------------------------------------------------------------------------------
do
	power:SetHeight( 5 )
	power:Point( "TOPLEFT", health, "BOTTOMLEFT", 7, 0 )
	power:Point( "TOPRIGHT", health, "BOTTOMRIGHT", -7, 0 )
	power:SetFrameLevel( health:GetFrameLevel() + 1 )
	power:CreateBorder( true )

	if( C["unitframes"].unicolor == true ) then
		power.colorTapping = true
		power.colorClass = true
		power.bg.multiplier = 0.1
	end
end
