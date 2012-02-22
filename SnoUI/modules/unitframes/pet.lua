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
	if not T.lowversion then
		unit.panel:Kill()
	end
end

---------------------------------------------------------------------------------------------
-- health
---------------------------------------------------------------------------------------------
do
	health:SetHeight( 16 )
	health:CreateBorder( true )

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
	power:SetHeight( 8 )
	power:Point( "TOPLEFT", health, "BOTTOMLEFT", 7, 2 )
	power:Point( "TOPRIGHT", health, "BOTTOMRIGHT", -7, 0 )
	power:SetFrameLevel( health:GetFrameLevel() + 1 )
	power:CreateBorder( false, true )
end
---------------------------------------------------------------------------------------------
-- size
---------------------------------------------------------------------------------------------

unit:Size( 130, 16 )
