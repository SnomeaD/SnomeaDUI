local T, C, L = unpack( Tukui )

local function SnoUICVars()
	SetCVar( "autoDismountFlying", 1 )
	SetCVar( "showLootSpam", 0 )
	SetCVar( "guildMemberNotify", 1 )
	SetCVar( "chatBubblesParty", 0 )
	SetCVar( "chatBubbles", 0 )
	SetCVar( "cameraDistanceMax", 50 )
	SetCVar( "cameraDistanceMaxFactor", 3.4 )
	SetCVar( "UnitNameFriendlyPetName", 0 )
	SetCVar( "nameplateShowFriends", 0 )
	-- SetCVar( "UnitNameCompanionName", 0 ) -- Doesn't work with 4.3 ?
	-- InterfaceOptionsNamesPanelNonCombatCreature:SetChecked(false)
end

local OnLogon = CreateFrame( "Frame" )
OnLogon:RegisterEvent( "PLAYER_ENTERING_WORLD" )
OnLogon:SetScript( "OnEvent", function( self, event )
	self:UnregisterEvent( "PLAYER_ENTERING_WORLD" )
	print( "|cffFFFFFFSnoUI|r loaded." )
	print( "For information visit |cff8467D7http://www.tukui.org" )
	SnoUICVars()
end )