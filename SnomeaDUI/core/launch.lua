local T, C, L = unpack( Tukui )

local function SnoUICVars()
	SetCVar( "autoDismountFlying", 1 )
	SetCVar( "guildMemberNotify", 1 )
	SetCVar( "chatBubblesParty", 0 )
	SetCVar( "chatBubbles", 0 )
	SetCVar( "cameraDistanceMax", 50 )
	SetCVar( "cameraDistanceMaxFactor", 3.4 )
	SetCVar( "UnitNameFriendlyPetName", 0 )
	SetCVar( "nameplateShowFriends", 0 )
	SetCVar( "taintlog", 1 )
end

local OnLogon = CreateFrame( "Frame" )
OnLogon:RegisterEvent( "PLAYER_ENTERING_WORLD" )
OnLogon:SetScript( "OnEvent", function( self, event )
	self:UnregisterEvent( "PLAYER_ENTERING_WORLD" )
	local db = TukuiDataPerChar
	SnoUICVars()
	print( "|cff8467D7SnoUI|r |cff009900loaded!" )
end )