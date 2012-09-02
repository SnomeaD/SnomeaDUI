---------------------------------------------------------------------------------------------
--Taken from AsphyxiaUI, Thanks!
---------------------------------------------------------------------------------------------

local T, C, L, G = unpack( Tukui )

T.RaidFrameAttributes = function()
	return
		"TukuiRaid",
		nil,
		"solo,raid,party",
		"oUF-initialConfigFunction", [[
			local header = self:GetParent()
			self:SetWidth( header:GetAttribute( "initial-width" ) )
			self:SetHeight( header:GetAttribute( "initial-height" ) )
		]],
		"initial-width", T.Scale( 66 ),
		"initial-height", T.Scale( 40 ),
		"showParty", true,
		"showRaid", true,
		"showPlayer", true,
		"showSolo", false,
		"xoffset", 4,
		"yOffset", 1,
		"point", "LEFT",
		"groupFilter", "1,2,3,4,5,6,7,8",
		"groupingOrder", "1,2,3,4,5,6,7,8",
		"groupBy", "GROUP",
		"maxColumns", 5,
		"unitsPerColumn", 5,
		"columnSpacing", T.Scale( 7 ),
		"columnAnchorPoint", "TOP"
end


T.PostUpdateRaidUnit = function( self )

	------------------------------
	-- Panel
	------------------------------
	self:SetBackdropColor( 0.0, 0.0, 0.0, 0.8 )

	self.panel:SetPoint("TOPLEFT")
	self.panel:SetPoint("TOPRIGHT")

	------------------------------
	-- health
	------------------------------
	self.Health:ClearAllPoints()
	self.Health:Point("TOPLEFT", self.panel, "TOPLEFT", 0, -15)
	self.Health:Point("TOPRIGHT", self.panel, "TOPRIGHT", 0, -15)
	self.Health:SetStatusBarTexture( C["media"]["normTex"] )
	self.Health:CreateBorder( false )

	self.Health.colorDisconnected = false
	self.Health.colorClass = true
	self.Health:SetStatusBarColor( 0.2, 0.2, 0.2, 1 )
	self.Health.bg:SetTexture( 0.6, 0.6, 0.6 )
	self.Health.bg:SetVertexColor( 0, 0, 0 )

	self.Health.value:SetFont(C.media.uffont, 14, "THINOUTLINE")
	self.Health:SetHeight(20)


	if( C["unitframes"]["gradienthealth"] == true and C["unitframes"]["unicolor"] == true ) then
		self:HookScript( "OnEnter", function( self )
			if( not UnitIsConnected( self.unit ) or UnitIsDead( self.unit ) or UnitIsGhost( self.unit ) ) then return end
			local hover = RAID_CLASS_COLORS[select( 2, UnitClass( self.unit ) )]
			if( not hover ) then return end
			self.Health:SetStatusBarColor( hover.r, hover.g, hover.b )
		end )

		self:HookScript( "OnLeave", function( self )
			if( not UnitIsConnected( self.unit ) or UnitIsDead( self.unit ) or UnitIsGhost( self.unit ) ) then return end
			local r, g, b = oUFTukui.ColorGradient( UnitHealth( self.unit ), UnitHealthMax( self.unit ), unpack( C["unitframes"]["gradient"] ) )
			self.Health:SetStatusBarColor( r, g, b )
		end )
	end

	local color = RAID_CLASS_COLORS[T.myclass]
	self:HighlightUnit( color.r, color.g, color.b, 0.3 )
	
	------------------------------
	-- Power
	------------------------------
	self.Power:SetStatusBarTexture( C["media"]["normTex"] )
	self.Power:CreateBorder( false)


	self.Power.colorPower = true
	self.Power:SetStatusBarColor( 0.2, 0.2, 0.2, 1 )
	self.Power.bg:SetTexture( 0.6, 0.6, 0.6 )
	self.Power.bg:SetVertexColor( 0, 0, 0 )

	self.Power:SetPoint( "BOTTOM", self.Health, 1, -5 )
	self.Power:SetHeight(10)

	------------------------------
	-- name
	------------------------------
	self.Name:ClearAllPoints()
	self.Name:SetPoint( "TOP", 0, -2 )
	self.Name:SetFont(C.media.uffont, 14, "THINOUTLINE")

	
	------------------------------
	-- debuffs
	------------------------------
	if( C["unitframes"]["raidunitdebuffwatch"] == true ) then
		self.RaidDebuffs:Height( 21 * C["unitframes"]["gridscale"] )
		self.RaidDebuffs:Width( 21 * C["unitframes"]["gridscale"] )
		self.RaidDebuffs:Point( "CENTER", self.Health, 2, 1 )

		self.RaidDebuffs.count:ClearAllPoints()
		self.RaidDebuffs.count:SetPoint( "CENTER", self.Raiddebuff, -6, 6 )
		self.RaidDebuffs.count:SetFont(C.media.uffont, 14, "THINOUTLINE")

		self.RaidDebuffs.time:ClearAllPoints()
		self.RaidDebuffs.time:SetPoint( "CENTER", self.Raiddebuff, 2, 0 )
		self.RaidDebuffs.time:SetFont(C.media.uffont, 14, "THINOUTLINE")
	end

	------------------------------
	-- icons
	------------------------------
	local leader = self.panel:CreateTexture( nil, "OVERLAY" )
	leader:Height( 12 * T.raidscale )
	leader:Width( 12 * T.raidscale )
	leader:SetPoint( "TOPLEFT", 0, 6 )
	self.Leader = leader

	local LFDRole = self.panel:CreateTexture( nil, "OVERLAY" )
	LFDRole:Height( 6 * T.raidscale )
	LFDRole:Width( 6 * T.raidscale )
	LFDRole:Point( "TOPRIGHT", -2, -5 )
	LFDRole:SetTexture( "Interface\\AddOns\\Tukui\\medias\\textures\\lfdicons.blp" )
	self.LFDRole = LFDRole

	local MasterLooter = self.panel:CreateTexture( nil, "OVERLAY" )
	MasterLooter:Height( 12 * T.raidscale )
	MasterLooter:Width( 12 * T.raidscale )
	self.MasterLooter = MasterLooter
	self:RegisterEvent( "PARTY_LEADER_CHANGED", T.MLAnchorUpdate )
	self:RegisterEvent( "PARTY_MEMBERS_CHANGED", T.MLAnchorUpdate )

	local Resurrect = CreateFrame( "Frame", nil, self.Health )
	Resurrect:SetFrameLevel( self.Health:GetFrameLevel() + 1 )
	Resurrect:Size( 20 )
	Resurrect:SetPoint( "CENTER" )

	local ResurrectIcon = Resurrect:CreateTexture( nil, "OVERLAY" )
	ResurrectIcon:SetAllPoints()
	ResurrectIcon:SetDrawLayer( "OVERLAY", 7 )
	self.ResurrectIcon = ResurrectIcon
end

local SnoUiRaidPosition = CreateFrame( "Frame" )
SnoUiRaidPosition:RegisterEvent( "PLAYER_LOGIN" )
SnoUiRaidPosition:SetScript( "OnEvent", function( self, event )
	local raid = G.UnitFrames.RaidUnits
	local pets = G.UnitFrames.RaidPets
	raid:ClearAllPoints()
	if T.lowversion then
		raid:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 4, 210)
	else
		raid:SetPoint( "BOTTOM", InvTukuiActionBarBackground, "TOP", 0, 34 )
	end
end )