local T, C, L, G = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales

local SnoUiExtraButtonPosition = CreateFrame( "Frame" )
SnoUiExtraButtonPosition:RegisterEvent( "PLAYER_LOGIN" )
SnoUiExtraButtonPosition:SetScript( "OnEvent", function( self, event )
	local raid = G.UnitFrames.RaidUnits
	local extra = G.ActionBars.BarExtra
	if not T.lowversion then
		extra:ClearAllPoints()
		extra:Point("BOTTOM", raid , "TOP", 0, 20)
	end
end )