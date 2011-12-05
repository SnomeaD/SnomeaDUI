local T, C, L = unpack( Tukui )

if C.unitframes.enable ~= true then return end

local Experience = TukuiPlayer.Experience
local Resting = TukuiPlayer.Resting
local Reputation = TukuiPlayer.Reputation
local Castbar = TukuiPlayer.Castbar

---------------------------------------------------------------------------------------------
-- experience and reputation bar
---------------------------------------------------------------------------------------------
if( T.level ~= MAX_PLAYER_LEVEL ) then
	Experience:Width( TukuiMinimap:GetWidth() -2)
	Experience:Height( 7 )
	Experience:ClearAllPoints()
	Experience:Point( "TOP", TukuiMinimap, "BOTTOM", 0, -4 )
	Experience:SetFrameLevel( 12 )
	Experience:SetAlpha( 1 )
	Experience:HookScript( "OnLeave", function( self ) self:SetAlpha( 1 ) end )
	Experience:CreateBorder()
	Resting:SetTexture( nil )
end

if( T.level == MAX_PLAYER_LEVEL ) then
	Reputation:Width( TukuiMinimap:GetWidth() -2)
	Reputation:Height( 7 )
	Reputation:ClearAllPoints()
	Reputation:Point( "TOP", TukuiMinimap, "BOTTOM", 0, -4 )
	Reputation:SetFrameLevel( 10 )
	Reputation:SetAlpha( 1 )
	Reputation:HookScript( "OnLeave", function( self ) self:SetAlpha( 1 ) end )
	Reputation:CreateBorder()
end


---------------------------------------------------------------------------------------------
-- castbar
---------------------------------------------------------------------------------------------

if( C["unitframes"].unitcastbar == true ) then
	-- setup castbar
	Castbar:ClearAllPoints()
	Castbar:SetPoint( "BOTTOM", InvTukuiActionBarBackground, "TOP", 15, 5 )
	
	if C["unitframes"].cbicons == true then
		Castbar:Size( InvTukuiActionBarBackground:GetWidth() - 186, 22 )
	else
		Castbar:Size( InvTukuiActionBarBackground:GetWidth() - 160, 22 )
	end
	Castbar:CreateBorder()
	Castbar:SetFrameLevel(4)


	-- Castbar.Time = T.SetFontString(castbar, font1, 12, "MONOCHROMEOUTLINE")
	Castbar.Time:Point("RIGHT", Castbar, "RIGHT", -4, 0)
	Castbar.Text:Point("LEFT", Castbar, "LEFT", 4, 0)


	if C["unitframes"].cbicons == true then
		Castbar.button:ClearAllPoints()
		Castbar.button:SetPoint( "RIGHT", Castbar, "LEFT", -6, 0 )
		Castbar.button:Size( 24, 24 )
	end

	Castbar.bg = CreateFrame("Frame", nil, Castbar)
	Castbar.bg:SetTemplate("Transparent")
	Castbar.bg:SetBorder()
	Castbar.bg:SetPoint("TOPLEFT", -2, 2)
	Castbar.bg:SetPoint("BOTTOMRIGHT", 2, -2)
	Castbar.bg:SetFrameLevel(3)

end