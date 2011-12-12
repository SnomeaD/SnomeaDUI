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

	if( C["unitframes"].unicolor == true ) then
		health:SetStatusBarColor( .150, .150, .150, 1 )
		healthBG:SetVertexColor( 1, 0, 0, 1 )
		healthBG:SetTexture( 238, .44, .44, 0.3 )
	end

	health.value = T.SetFontString( health, C["media"].uffont, 13, "THINOUTLINE" )
	health.value:Point( "RIGHT", health, "RIGHT", -5, 0 )
	health.value:SetShadowOffset( 0, 0 )
end

---------------------------------------------------------------------------------------------
-- power
---------------------------------------------------------------------------------------------
do
	-- power:SetHeight( 8 )
	power:CreateBorder( true )
	power:Point( "TOPLEFT", health, "BOTTOMLEFT", 9, 4 )
	power:Point( "TOPRIGHT", health, "BOTTOMRIGHT", -9, -6 )
	power:SetFrameLevel( health:GetFrameLevel() + 1 )

	if( C["unitframes"].unicolor == true ) then
		power.colorTapping = true
		power.colorClass = true
		power.bg.multiplier = 0.1
	end

	power.value = T.SetFontString( health, C["media"].uffont, 13, "THINOUTLINE" )
	power.value:Point( "LEFT", health, "LEFT", 5, 0 )
	power.value:SetShadowOffset( 0, 0 )
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
	Experience:SetFrameLevel( 12 )
	Experience:SetAlpha( 1 )
	Experience:HookScript( "OnLeave", function( self ) self:SetAlpha( 1 ) end )
	Experience.bg = CreateFrame("Frame", nil, Experience)
	Experience.bg:SetTemplate("Transparent")
	Experience.bg:SetBorder()
	Experience.bg:SetPoint("TOPLEFT", -2, 2)
	Experience.bg:SetPoint("BOTTOMRIGHT", 2, -2)
	Experience.bg:SetFrameLevel(3)
	Resting:SetTexture( nil )
end

if( T.level == MAX_PLAYER_LEVEL ) then
	Reputation:Width( TukuiMinimap:GetWidth() -4)
	Reputation:Height( 7 )
	Reputation:ClearAllPoints()
	Reputation:Point( "TOP", TukuiMinimap, "BOTTOM", 0, -6 )
	Reputation:SetFrameLevel( 10 )
	Reputation:SetAlpha( 1 )
	Reputation:HookScript( "OnLeave", function( self ) self:SetAlpha( 1 ) end )
	Reputation.bg = CreateFrame("Frame", nil, Reputation)
	Reputation.bg:SetTemplate("Transparent")
	Reputation.bg:SetBorder()
	Reputation.bg:SetPoint("TOPLEFT", -2, 2)
	Reputation.bg:SetPoint("BOTTOMRIGHT", 2, -2)
	Reputation.bg:SetFrameLevel(3)
	
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
	Castbar.bg:SetBorder()
	Castbar.bg:SetPoint("TOPLEFT", -2, 2)
	Castbar.bg:SetPoint("BOTTOMRIGHT", 2, -2)
	Castbar.bg:SetFrameLevel(3)
end

---------------------------------------------------------------------------------------------
-- size
---------------------------------------------------------------------------------------------

-- unit:Size( 246, 28 )
unit:SetHeight( 28 )

