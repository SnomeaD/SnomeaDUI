local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
if C.unitframes.enable ~= true then return end

-- Base layout/code by Sinaris
-- http://www.tukui.org/forums/forum.php?id=113

------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------
local unit = TukuiTargetTarget
local health = TukuiTargetTarget.Health
local power = TukuiPlayer.Power
local healthBG = TukuiPlayer.Health.bg
local name = TukuiTargetTarget.Name

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
	health:SetHeight( 24 )
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

	unit:Tag( Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]" )
end
---------------------------------------------------------------------------------------------
-- size
---------------------------------------------------------------------------------------------

unit:Size( 130, 24 )
