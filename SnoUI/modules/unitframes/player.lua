local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
if C.unitframes.enable ~= true then return end

-- Base layout/code by Sinaris
-- http://www.tukui.org/forums/forum.php?id=113

------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------
local unit = TukuiPlayer
local Castbar = TukuiPlayer.Castbar
local health = TukuiPlayer.Health
local power = TukuiPlayer.Power
local healthBG = TukuiPlayer.Health.bg
local portrait = TukuiPlayer.Portrait
local Experience = TukuiPlayer.Experience
local Resting = TukuiPlayer.Resting
local Reputation = TukuiPlayer.Reputation

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
	health:SetHeight( 28 )
	health:CreateBorder( true )
	health.value = T.SetFontString( health, C["media"].uffont, 13, "THINOUTLINE" )
	health.value:Point( "RIGHT", health, "RIGHT", -25, 2 )
	health.value:SetShadowOffset( 0, 0 )
end

---------------------------------------------------------------------------------------------
-- power
---------------------------------------------------------------------------------------------
do
	power:CreateBorder( false, true )
	power:Point( "TOPLEFT", health, "BOTTOMLEFT", 9, 4 )
	power:Point( "TOPRIGHT", health, "BOTTOMRIGHT", -9, -6 )
	power:SetFrameLevel( health:GetFrameLevel() + 1 )
	power.value = T.SetFontString( health, C["media"].uffont, 13, "THINOUTLINE" )
	power.value:Point( "LEFT", health, "LEFT", 25, 2 )
end

---------------------------------------------------------------------------------------------
-- portrait
---------------------------------------------------------------------------------------------
do
	if( C["unitframes"].charportrait == true ) then
		portrait:ClearAllPoints()
		portrait:SetAllPoints( health )
		-- portrait:SetAllPoints( TukuiPlayer.Health )
		portrait:SetAlpha( 0.2 )
		portrait.SetAlpha = T.dummy
		health:SetPoint( "TOPLEFT", 0, 0 )
		health:SetPoint( "TOPRIGHT" )
		portrait:SetFrameLevel( power:GetFrameLevel() - 1 )
	end
end

---------------------------------------------------------------------------------------------
-- experience and reputation bar
---------------------------------------------------------------------------------------------
if( T.level ~= MAX_PLAYER_LEVEL ) then
	Experience:Width( TukuiMinimap:GetWidth() -4)
	Experience:Height( 7 )
	Experience:ClearAllPoints()
	Experience:Point( "TOP", TukuiMinimap, "BOTTOM", 0, -6 )
	Experience:SetFrameLevel( 2 )
	Experience:SetAlpha( 1 )
	Experience:HookScript( "OnLeave", function( self ) self:SetAlpha( 1 ) end )
	Experience.bg = CreateFrame("Frame", nil, Experience)
	Experience.bg:SetTemplate("Transparent")
	Experience.bg:CreateBorder(false, true)
	Experience.bg:SetPoint("TOPLEFT", -2, 2)
	Experience.bg:SetPoint("BOTTOMRIGHT", 2, -2)
	Experience.bg:SetFrameLevel(1)
	Resting:SetTexture( nil )
end

if( T.level == MAX_PLAYER_LEVEL ) then
	Reputation:Width( TukuiMinimap:GetWidth() -4)
	Reputation:Height( 7 )
	Reputation:ClearAllPoints()
	Reputation:Point( "TOP", TukuiMinimap, "BOTTOM", 0, -6 )
	Reputation:SetFrameLevel( 2 )
	Reputation:SetAlpha( 1 )
	Reputation:HookScript( "OnLeave", function( self ) self:SetAlpha( 1 ) end )
	Reputation.bg = CreateFrame("Frame", nil, Reputation)
	Reputation.bg:SetTemplate("Transparent")
	Reputation.bg:CreateBorder(false, true)
	Reputation.bg:SetPoint("TOPLEFT", -2, 2)
	Reputation.bg:SetPoint("BOTTOMRIGHT", 2, -2)
	Reputation.bg:SetFrameLevel(1)
end


---------------------------------------------------------------------------------------------
-- castbar
---------------------------------------------------------------------------------------------

if( C["unitframes"].unitcastbar == true ) then
	Castbar:ClearAllPoints()
	Castbar:SetPoint( "BOTTOM", InvTukuiActionBarBackground, "TOP", 15, 5 )
	
	if C["unitframes"].cbicons == true then
		Castbar:Size( InvTukuiActionBarBackground:GetWidth() - 190, 18 )
	else
		Castbar:Size( InvTukuiActionBarBackground:GetWidth() - 164, 18 )
	end
	Castbar:CreateBorder()
	Castbar:SetFrameLevel(4)


	-- Castbar.Time = T.SetFontString(castbar, font1, 12, "MONOCHROMEOUTLINE")
	Castbar.Time:Point("RIGHT", Castbar, "RIGHT", -4, 0)
	Castbar.Text:Point("LEFT", Castbar, "LEFT", 4, 0)


	if C["unitframes"].cbicons == true then
		Castbar.button:ClearAllPoints()
		Castbar.button:SetPoint( "RIGHT", Castbar, "LEFT", -6, 0 )
		Castbar.button:Size( 20, 20 )
	end

	Castbar.bg = CreateFrame("Frame", nil, Castbar)
	Castbar.bg:SetTemplate("Transparent")
	Castbar.bg:CreateBorder(false, true)
	Castbar.bg:SetPoint("TOPLEFT", -2, 2)
	Castbar.bg:SetPoint("BOTTOMRIGHT", 2, -2)
	Castbar.bg:SetFrameLevel(3)
end

---------------------------------------------------------------------------------------------
-- size
---------------------------------------------------------------------------------------------

-- unit:Size( 246, 28 )
unit:SetHeight( 28 )

