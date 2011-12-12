local S, C, L = unpack( Tukui )

S.EnableTukuiPlayer = function()
	local self = _G["TukuiPlayer"]

	---------------------------------------------------------------------------------------------
	-- not needed
	---------------------------------------------------------------------------------------------
	do
		self.shadow:Kill()
		self.panel:Kill()
	end

	---------------------------------------------------------------------------------------------
	-- health
	---------------------------------------------------------------------------------------------
	do
		self.Health:SetHeight( 28 )
		self.Health:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Health:SetStatusBarColor( .150, .150, .150, 1 )
			self.Health.bg:SetVertexColor( 1, 0, 0, 1 )
			self.Health.bg:SetTexture( 238, .44, .44, 0.3 )
		end

		self.Health.value = S.SetFontString( self.Health, C["media"].uffont, 13, "THINOUTLINE" )
		self.Health.value:Point( "RIGHT", self.Health, "RIGHT", -5, 0 )
		self.Health.value:SetShadowOffset( 0, 0 )
	end

	---------------------------------------------------------------------------------------------
	-- power
	---------------------------------------------------------------------------------------------
	do
		self.Power:SetHeight( 5 )
		self.Power:CreateBorder( true )
		self.Power:Point( "TOPLEFT", self.Health, "BOTTOMLEFT", 9, 1 )
		self.Power:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", -105, -2 )
		self.Power:SetFrameLevel( self.Health:GetFrameLevel() + 1 )

		if( C["unitframes"].unicolor == true ) then
			self.Power.colorTapping = true
			self.Power.colorClass = true
			self.Power.bg.multiplier = 0.1
		end

		self.Power.value = S.SetFontString( self.Health, C["media"].uffont, 13, "THINOUTLINE" )
		self.Power.value:Point( "LEFT", self.Health, "LEFT", 5, 0 )
		self.Power.value:SetShadowOffset( 0, 0 )
	end

	---------------------------------------------------------------------------------------------
	-- portrait
	---------------------------------------------------------------------------------------------
	do
		if( C["unitframes"].charportrait == true ) then
			self.Portrait:ClearAllPoints()
			self.Portrait:SetAllPoints( TukuiPlayer.Health )
			self.Portrait:SetAlpha( 0.2 )
			self.Portrait.SetAlpha = S.dummy
			self.Health:SetPoint( "TOPLEFT", 0, 0 )
			self.Health:SetPoint( "TOPRIGHT" )
			self.Portrait:SetFrameLevel( self.Power:GetFrameLevel() - 1 )
		end
	end

	---------------------------------------------------------------------------------------------
	-- experience and reputation bar
	---------------------------------------------------------------------------------------------
	do
		if( S.level ~= MAX_PLAYER_LEVEL ) then
			self.Experience:Width( 5 )
			self.Experience:Height( TukuiMinimap:GetHeight() - 4 )
			self.Experience:ClearAllPoints()
			self.Experience:Point( "LEFT", TukuiMinimap, "RIGHT", 7, 0 )
			self.Experience:SetOrientation( "Vertical" )
			self.Experience.Rested:SetOrientation( "Vertical" )
			self.Experience:SetFrameLevel( 12 )
			self.Experience:SetAlpha( 1 )
			self.Experience:HookScript( "OnLeave", function( self ) self:SetAlpha( 1 ) end )
			self.Experience:CreateBorder( true )
			self.Resting:SetTexture( nil )
		end

		if( S.level == MAX_PLAYER_LEVEL ) then
			self.Reputation:Width( 5 )
			self.Reputation:Height( TukuiMinimap:GetHeight() - 4 )
			self.Reputation:ClearAllPoints()
			self.Reputation:Point( "LEFT", TukuiMinimap, "RIGHT", 7, 0 )
			self.Reputation:SetOrientation( "Vertical" )
			self.Reputation:SetFrameLevel( 10 )
			self.Reputation:SetAlpha( 1 )
			self.Reputation:HookScript( "OnLeave", function( self ) self:SetAlpha( 1 ) end )
			self.Reputation:CreateBorder( true )
		end
	end

	---------------------------------------------------------------------------------------------
	-- castbar
	---------------------------------------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true ) then
			self.Castbar:ClearAllPoints()
			self.Castbar:SetPoint( "BOTTOMRIGHT", TukuiBar1, "TOPRIGHT", -2, 49 )
			if C["unitframes"].cbicons == true then
				self.Castbar:Size( TukuiBar1:GetWidth() - 38, 26 )
			else
				self.Castbar:Size( TukuiBar1:GetWidth() - 4, 26 )
			end
			self.Castbar:CreateBorder( true )

			if C["unitframes"].cbicons == true then
				self.Castbar.button:ClearAllPoints()
				self.Castbar.button:SetPoint( "LEFT", self.Castbar, -36, 0 )
				self.Castbar.button:Size( 30, 30 )
			end

			self.Castbar.Text:SetFont( C["media"].uffont, 14, "THINOUTLINE" )
			self.Castbar.Text:SetParent( self.Castbar )
			self.Castbar.Text:ClearAllPoints()
			self.Castbar.Text:SetPoint( "LEFT", self.Castbar, "LEFT", 5, 0 )
			self.Castbar.Text.ClearAllPoints = S.dummy
			self.Castbar.Text.SetPoint = S.dummy

			self.Castbar.time:SetFont( C["media"].uffont, 14, "THINOUTLINE" )
			self.Castbar.time:SetParent( self.Castbar )
			self.Castbar.time:ClearAllPoints()
			self.Castbar.time:SetPoint( "RIGHT", self.Castbar, "RIGHT", -5, 0 )
			self.Castbar.time.ClearAllPoints = S.dummy
			self.Castbar.time.SetPoint = S.dummy
		end
	end

	---------------------------------------------------------------------------------------------
	-- classbar
	---------------------------------------------------------------------------------------------
	do
		if( C["unitframes"].classbar == true ) then
			if( S.myclass == "DRUID" ) then
				local classbar = CreateFrame( "Frame", "Classbar", UIParent )
				classbar:Width( TukuiPlayer:GetWidth() )
				classbar:Height( 9 )
				classbar:Point( "BOTTOM", TukuiPlayer, "TOP", 0, 5 )
				classbar:SetBackdropBorderColor( 0, 0, 0, 0 )
				classbar:SetTemplate( "Default" )
				classbar:CreateShadow( "Default" )

				self.DruidManaBackground:SetWidth( classbar:GetWidth() - 4 )
				self.DruidManaBackground:SetHeight( 5 )
				self.DruidManaBackground:ClearAllPoints()
				self.DruidManaBackground:SetPoint( "TOPLEFT", classbar, "TOPLEFT", 2, -2 )

				self.DruidMana:SetSize( self.DruidManaBackground:GetWidth(), self.DruidManaBackground:GetHeight() )

				self.EclipseBar:SetWidth( classbar:GetWidth() - 4 )
				self.EclipseBar:SetHeight( 5 )
				self.EclipseBar:ClearAllPoints()
				self.EclipseBar:SetPoint( "TOPLEFT", classbar, "TOPLEFT", 2, -2 )

				self.EclipseBar.LunarBar:SetStatusBarColor( .41, .8, .94 )
				self.EclipseBar.LunarBar:SetSize( self.EclipseBar:GetWidth(), self.EclipseBar:GetHeight() )

				self.EclipseBar.SolarBar:SetStatusBarColor( 1, .96, .41 )
				self.EclipseBar.SolarBar:SetSize( self.EclipseBar:GetWidth(), self.EclipseBar:GetHeight() )
			end

			if( S.myclass == "WARLOCK" or S.myclass == "PALADIN" ) then
				local classbar = CreateFrame( "Frame", "Classbar", UIParent )
				classbar:Width( TukuiPlayer:GetWidth() )
				classbar:Height( 9 )
				classbar:Point( "BOTTOM", TukuiPlayer, "TOP", 0, 5 )
				classbar:SetBackdropBorderColor( 0, 0, 0, 0 )
				classbar:SetTemplate( "Default" )
				classbar:CreateShadow( "Default" )

				if( S.myclass == "WARLOCK" ) then
					self.SoulShards:SetWidth( classbar:GetWidth() - 4 )
					self.SoulShards:SetHeight( 5 )
					self.SoulShards:ClearAllPoints()
					self.SoulShards:SetPoint( "TOPLEFT", classbar, "TOPLEFT", 2, -2 )

					TukuiPlayer_Shard1:SetStatusBarColor( .58, .5, .78 )
					TukuiPlayer_Shard2:SetStatusBarColor( .58, .5, .78 )
					TukuiPlayer_Shard3:SetStatusBarColor( .58, .5, .78 )
				elseif( S.myclass == "PALADIN" ) then
					self.HolyPower:SetWidth( classbar:GetWidth() - 4 )
					self.HolyPower:SetHeight( 5 )
					self.HolyPower:ClearAllPoints()
					self.HolyPower:SetPoint( "TOPLEFT", classbar, "TOPLEFT", 2, -2 )
				end

				TukuiPlayer_Shard1:SetHeight( 5 )
				TukuiPlayer_Shard1:SetWidth( ( classbar:GetWidth() - 6 ) / 3 )

				TukuiPlayer_Shard2:SetHeight( 5 )
				TukuiPlayer_Shard2:SetWidth( ( classbar:GetWidth() - 6 ) / 3 )

				TukuiPlayer_Shard3:SetHeight( 5 )
				TukuiPlayer_Shard3:SetWidth( ( classbar:GetWidth() - 6 ) / 3 )
			end

			if( S.myclass == "DEATHKNIGHT" ) then
				local classbar = CreateFrame( "Frame", "Classbar", UIParent )
				classbar:Width( TukuiPlayer:GetWidth() )
				classbar:Height( 9 )
				classbar:Point( "BOTTOM", TukuiPlayer, "TOP", 0, 5 )
				classbar:SetBackdropBorderColor( 0, 0, 0, 0 )
				classbar:SetTemplate( "Default" )
				classbar:CreateShadow( "Default" )

				self.Runes:SetWidth( classbar:GetWidth() - 4 )
				self.Runes:SetHeight( 5 )
				self.Runes:ClearAllPoints()
				self.Runes:SetPoint( "TOPLEFT", classbar, "TOPLEFT", 2, -2 )

				for i = 1, 6 do
					self.Runes[i]:SetHeight( 5 )
					self.Runes[i]:SetWidth( ( classbar:GetWidth() - 9 ) / 6 )

					if( i == 1 ) then
						self.Runes[i]:Point( "BOTTOMLEFT", classbar, "BOTTOMLEFT", 2, 2 )
					else
						self.Runes[i]:Point( "TOPLEFT", self.Runes[i - 1], "TOPRIGHT", 1, 0 )
					end
				end
			end

			if( S.myclass == "SHAMAN" ) then
				local classbar = CreateFrame( "Frame", "Classbar", UIParent )
				classbar:Width( TukuiPlayer:GetWidth() )
				classbar:Height( 9 )
				classbar:Point( "BOTTOM", TukuiPlayer, "TOP", 0, 5 )
				classbar:SetBackdropBorderColor( 0, 0, 0, 0 )
				classbar:SetTemplate( "Default" )
				classbar:CreateShadow( "Default" )

				for i = 1, 4 do
					self.TotemBar[i]:SetWidth( ( classbar:GetWidth() - 7 ) / 4 )
					self.TotemBar[i]:SetHeight( 5 )
					self.TotemBar[i]:ClearAllPoints()

					if( i == 1 ) then
						self.TotemBar[i]:Point( "TOPLEFT", classbar, "TOPLEFT", 2, -2 )
					else
						self.TotemBar[i]:Point( "TOPLEFT", self.TotemBar[i - 1], "TOPRIGHT", 1, 0 )
					end
				end
			end

			if( S.myclass == "MAGE" ) then
				local classbar = CreateFrame( "Frame", "Classbar", UIParent )
				classbar:Width( TukuiPlayer:GetWidth() )
				classbar:Height( 9 )
				classbar:Point( "BOTTOM", TukuiPlayer, "TOP", 0, 5 )
				classbar:SetBackdropBorderColor( 0, 0, 0, 0 )
				classbar:SetTemplate( "Default" )
				classbar:CreateShadow( "Default" )

				local ABStack = {}

				for i = 1, 4 do
					ABStack[i] = CreateFrame( "StatusBar", "Classbar_Power" .. i, classbar )
					ABStack[i]:SetWidth( ( classbar:GetWidth() - 7 ) / 4 )
					ABStack[i]:SetHeight( 5 )
					ABStack[i].tex = ABStack[i]:CreateTexture( nil, "OVERLAY" )
					ABStack[i].tex:SetTexture( C["media"].normTex )
					ABStack[i].tex:SetVertexColor( .58, .5, .78 )
					ABStack[i].tex:SetAllPoints( ABStack[i] )
					ABStack[i]:SetOrientation( "VERTICAL" )

					if( i == 1 ) then
						ABStack[i]:SetPoint( "LEFT", classbar, "LEFT", 2, 0 )
					else
						ABStack[i]:SetPoint( "LEFT", ABStack[i - 1], "RIGHT", 1, 0 )
					end
				end

				change = CreateFrame( "Frame" )
				change:RegisterEvent( "PLAYER_ENTERING_WORLD" )
				change:RegisterEvent( "UNIT_AURA" )
				change:RegisterEvent( "PLAYER_TARGET_CHANGED" )
				change:SetScript( "OnEvent", function()
					count = select( 4, UnitDebuff( "player", GetSpellInfo( 36032 ) ) )
					if( count and count > 0 ) then
						for i = 1, count do ABStack[i]:SetAlpha( 1 ) end
					else
						for i = 1, 4 do ABStack[i]:SetAlpha( 0.2 ) end
					end
				end )
			end

			if( S.myclass == "PRIEST" ) then
				local classbar = CreateFrame( "Frame", "Classbar", UIParent )
				classbar:Width( TukuiPlayer:GetWidth() )
				classbar:Height( 9 )
				classbar:Point( "BOTTOM", TukuiPlayer, "TOP", 0, 5 )
				classbar:SetBackdropBorderColor( 0, 0, 0, 0 )
				classbar:SetTemplate( "Default" )
				classbar:CreateShadow( "Default" )

				local Orbs = {}

				for i = 1, 3 do
					Orbs[i] = CreateFrame( "StatusBar", "Classbar_Power" .. i, classbar )
					Orbs[i]:SetWidth( ( classbar:GetWidth() - 6 ) / 3 )
					Orbs[i]:SetHeight( 5 )
					Orbs[i].tex = Orbs[i]:CreateTexture( nil, "OVERLAY" )
					Orbs[i].tex:SetTexture( C["media"].normTex )
					Orbs[i].tex:SetVertexColor( .5,0,.7 )
					Orbs[i].tex:SetAllPoints( Orbs[i] )
					Orbs[i]:SetOrientation( "VERTICAL" )

					if( i == 1 ) then
						Orbs[i]:SetPoint( "LEFT", classbar, "LEFT", 2, 0 )
					else
						Orbs[i]:SetPoint( "LEFT", Orbs[i - 1], "RIGHT", 1, 0 )
					end
				end

				local change = CreateFrame( "Frame" )
				change:RegisterEvent( "PLAYER_ENTERING_WORLD" )
				change:RegisterEvent( "UNIT_AURA" )
				change:RegisterEvent( "PLAYER_TARGET_CHANGED" )
				change:SetScript( "OnEvent", function()
					count = select( 4, UnitAura( "player", GetSpellInfo( 77487 ) ) )
					if( count and count > 0 ) then
						for i = 1, count do Orbs[i]:SetAlpha( 1 )end
					else
						for i = 1, 3 do Orbs[i]:SetAlpha( 0.2 ) end
					end
				end )
			end
		end
	end

	---------------------------------------------------------------------------------------------
	-- size, position
	---------------------------------------------------------------------------------------------
	do
		self:Size( 246, 28 )
		self:ClearAllPoints()
		self:SetPoint( "BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", 60, 80 )
	end
end

S.EnableTukuiTarget = function()
	local self = _G["TukuiTarget"]

	---------------------------------------------------------------------------------------------
	-- not needed
	---------------------------------------------------------------------------------------------
	do
		self.shadow:Kill()
		self.panel:Kill()
	end

	---------------------------------------------------------------------------------------------
	-- health
	---------------------------------------------------------------------------------------------
	do
		self.Health:SetHeight( 28 )
		self.Health:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Health:SetStatusBarColor( .150, .150, .150, 1 )
			self.Health.bg:SetVertexColor( 1, 0, 0, 1 )
			self.Health.bg:SetTexture( 238, .44, .44, 0.3 )
		end

		self.Health.value = S.SetFontString( self.Health, C["media"].uffont, 13, "THINOUTLINE" )
		self.Health.value:Point( "RIGHT", self.Health, "RIGHT", -5, 0 )
		self.Health.value:SetShadowOffset( 0, 0 )

		self.Name:SetFont( C["media"].uffont, 13, "THINOUTLINE" )
		self.Name:SetParent( self.Health )
		self.Name:ClearAllPoints()
		self.Name:SetPoint( "LEFT", self.Health, "LEFT", 5, 0 )
		self.Name:SetShadowOffset( 0, 0 )
		self.Name.ClearAllPoints = S.dummy
		self.Name.SetPoint = S.dummy

		self:Tag( self.Name, "[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]" )
	end

	---------------------------------------------------------------------------------------------
	-- power
	---------------------------------------------------------------------------------------------
	do
		self.Power:SetHeight( 5 )
		self.Power:Point( "TOPLEFT", self.Health, "BOTTOMLEFT", 105, 1 )
		self.Power:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", -9, -2 )
		self.Power:SetFrameLevel( self.Health:GetFrameLevel() + 1 )
		self.Power:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Power.colorTapping = true
			self.Power.colorClass = true
			self.Power.bg.multiplier = 0.1
		end
	end

	---------------------------------------------------------------------------------------------
	-- portrait
	---------------------------------------------------------------------------------------------
	do
		if( C["unitframes"].charportrait == true ) then
			self.Portrait:ClearAllPoints()
			self.Portrait:SetAllPoints( TukuiTarget.Health )
			self.Portrait:SetAlpha( 0.2 )
			self.Portrait.SetAlpha = S.dummy
			self.Health:SetPoint( "TOPLEFT", 0, 0 )
			self.Health:SetPoint( "TOPRIGHT" )
			self.Portrait:SetFrameLevel( self.Power:GetFrameLevel() - 1 )
		end
	end

	---------------------------------------------------------------------------------------------
	-- castbar
	---------------------------------------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true ) then
			self.Castbar:ClearAllPoints()
			self.Castbar:SetPoint( "TOPRIGHT", TukuiTarget, "BOTTOMRIGHT", 0, -14 )
			if C["unitframes"].cbicons == true then
				self.Castbar:Size( TukuiTarget:GetWidth() - 34, 22 )
			else
				self.Castbar:Size( TukuiTarget:GetWidth() - 4, 22 )
			end
			self.Castbar:CreateBorder( true )

			if C["unitframes"].cbicons == true then
				self.Castbar.button:ClearAllPoints()
				self.Castbar.button:SetPoint( "LEFT", self.Castbar, -32, 0 )
				self.Castbar.button:Size( 26, 26 )
			end

			self.Castbar.Text:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.Text:SetParent( self.Castbar )
			self.Castbar.Text:ClearAllPoints()
			self.Castbar.Text:SetPoint( "LEFT", self.Castbar, "LEFT", 5, 0 )
			self.Castbar.Text.ClearAllPoints = S.dummy
			self.Castbar.Text.SetPoint = S.dummy

			self.Castbar.time:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.time:SetParent( self.Castbar )
			self.Castbar.time:ClearAllPoints()
			self.Castbar.time:SetPoint( "RIGHT", self.Castbar, "RIGHT", -5, 0 )
			self.Castbar.time.ClearAllPoints = S.dummy
			self.Castbar.time.SetPoint = S.dummy
		end
	end

	---------------------------------------------------------------------------------------------
	-- combopoints
	---------------------------------------------------------------------------------------------
	do
		TukuiTarget:DisableElement( "CPoints" )
		for i = 1, 5 do TukuiTarget.CPoints[i]:Hide() end

		local colors = {
			{ .69, .31, .31, 1 },
			{ .65, .42, .31, 1 },
			{ .65, .63, .35, 1 },
			{ .46, .63, .35, 1 },
			{ .33, .63, .33, 1 },
		}

		local classbar = CreateFrame( "Frame", "Classbar", UIParent )
		classbar:Width( TukuiTarget:GetWidth() )
		classbar:Height( 8 )
		classbar:Point( "BOTTOM", TukuiTarget, "TOP", 0, 5 )
		classbar:SetBackdropBorderColor( 0, 0, 0, 0 )
		classbar:SetTemplate( "Default" )
		classbar:CreateShadow( "Default" )

		local points = {}

		for i = 1, 5 do
			points[i] = CreateFrame( "StatusBar", "Classbar_Power" .. i, classbar )
			points[i]:SetWidth( ( ( TukuiPlayer:GetWidth() + 4 ) - 8 ) / 5 )
			points[i]:SetHeight( 4 )
			points[i].tex = points[i]:CreateTexture( nil, "OVERLAY" )
			points[i].tex:SetTexture( C["media"].normTex )
			points[i].tex:SetVertexColor( unpack( colors[i] ) )
			points[i].tex:SetAllPoints( points[i] )

			if( points[i]:GetHeight() > points[i]:GetWidth() ) then
				points[i]:SetOrientation( "VERTICAL" )
			else
				points[i]:SetOrientation("HORIZONTAL")
			end

			if( i == 1 ) then
				points[i]:SetPoint( "LEFT", classbar, "LEFT", 2, 0 )
			else
				points[i]:SetPoint( "LEFT", points[i - 1], "RIGHT", 1, 0 )
			end

			points[i]:RegisterEvent( "PLAYER_ENTERING_WORLD" )
			points[i]:RegisterEvent( "UNIT_COMBO_POINTS" )
			points[i]:RegisterEvent( "PLAYER_TARGET_CHANGED" )
			points[i]:SetScript( "OnEvent", function( self, event )
				
				local numpoints, pt = 0, GetComboPoints( "player", "target" )
				if pt == numpoints then
					classbar:Hide()
					points[i]:Hide()
					
					if( C["unitframes"].targetauras == true ) then
						TukuiTarget.Buffs:ClearAllPoints()
						TukuiTarget.Buffs:SetPoint( "BOTTOMLEFT", TukuiTarget, "TOPLEFT", -2, 4 )
					end
				elseif pt > numpoints then
					classbar:Show()
					for i = numpoints + 1, pt do
						points[i]:Show()

						if( C["unitframes"].targetauras == true ) then
							TukuiTarget.Buffs:ClearAllPoints()
							TukuiTarget.Buffs:SetPoint( "BOTTOMLEFT", TukuiTarget, "TOPLEFT", -2, 16 )
						end
					end
				else
					for i = pt + 1, numpoints do
						points[i]:Hide()
					end
				end
				numpoints = pt
			end )
		end
	end

	---------------------------------------------------------------------------------------------
	-- buffs, debuffs
	---------------------------------------------------------------------------------------------
	do
		if( C["unitframes"].targetauras == true ) then
			self.Buffs.num = 9
			self.Debuffs.num = 18

			self.Buffs:ClearAllPoints()
			self.Buffs:SetPoint( "BOTTOMLEFT", self, "TOPLEFT", -2, 4 )
		end
	end

	---------------------------------------------------------------------------------------------
	-- size, position
	---------------------------------------------------------------------------------------------
	self:Size( 246, 28 )
	self:ClearAllPoints()
	self:SetPoint( "BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", -60, 80 )
end

S.EnableTukuiTargetTarget = function()
	local self = _G["TukuiTargetTarget"]

	---------------------------------------------------------------------------------------------
	-- not needed
	---------------------------------------------------------------------------------------------
	do
		self.shadow:Kill()
		self.panel:Kill()
	end

	---------------------------------------------------------------------------------------------
	-- health
	---------------------------------------------------------------------------------------------
	do
		self.Health:SetHeight( 24 )
		self.Health:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Health:SetStatusBarColor( .150, .150, .150, 1 )
			self.Health.bg:SetVertexColor( 1, 0, 0, 1 )
			self.Health.bg:SetTexture( 238, .44, .44, 0.3 )
		end

		self.Name:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
		self.Name:SetParent( self.Health )
		self.Name:ClearAllPoints()
		self.Name:SetPoint( "CENTER", self.Health, "CENTER", 0, 0 )
		self.Name:SetShadowOffset( 0, 0 )
		self.Name.ClearAllPoints = S.dummy
		self.Name.SetPoint = S.dummy

		self:Tag( Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]" )
	end

	---------------------------------------------------------------------------------------------
	-- size, position
	---------------------------------------------------------------------------------------------
	do
		self:Size( 130, 24 )
		self:ClearAllPoints()
		self:Point( "BOTTOM", InvTukuiActionBarBackground, "TOP", 0, 84 )
	end
end

S.EnableTukuiPet = function()
	local self = _G["TukuiPet"]

	---------------------------------------------------------------------------------------------
	-- not needed
	---------------------------------------------------------------------------------------------
	do
		self.shadow:Kill()
		self.panel:Kill()
	end

	---------------------------------------------------------------------------------------------
	-- health
	---------------------------------------------------------------------------------------------
	do
		self.Health:SetHeight( 16 )
		self.Health:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Health:SetStatusBarColor( .150, .150, .150, 1 )
			self.Health.bg:SetVertexColor( 1, 0, 0, 1 )
			self.Health.bg:SetTexture( 238, .44, .44, 0.3 )
		end

		self.Name:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
		self.Name:SetParent( self.Health )
		self.Name:ClearAllPoints()
		self.Name:SetPoint( "CENTER", self.Health, "CENTER", 0, 0 )
		self.Name:SetShadowOffset( 0, 0 )
		self.Name.ClearAllPoints = S.dummy
		self.Name.SetPoint = S.dummy

		self:Tag( Name, "[Tukui:getnamecolor][Tukui:namemedium] [Tukui:diffcolor][level]" )
	end

	---------------------------------------------------------------------------------------------
	-- power
	---------------------------------------------------------------------------------------------
	do
		self.Power:SetHeight( 5 )
		self.Power:Point( "TOPLEFT", self.Health, "BOTTOMLEFT", 7, 0 )
		self.Power:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", -7, 0 )
		self.Power:SetFrameLevel( self.Health:GetFrameLevel() + 1 )
		self.Power:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Power.colorTapping = true
			self.Power.colorClass = true
			self.Power.bg.multiplier = 0.1
		end
	end

	---------------------------------------------------------------------------------------------
	-- size, position
	---------------------------------------------------------------------------------------------
	do
		self:Size( 130, 16 )
		self:ClearAllPoints()
		self:Point( "BOTTOM", InvTukuiActionBarBackground, "TOP", 0, 125 )
	end
end

S.EnableTukuiFocus = function()
	local self = _G["TukuiFocus"]

	---------------------------------------------------------------------------------------------
	-- not needed
	---------------------------------------------------------------------------------------------
	do
		self.shadow:Kill()
	end

	---------------------------------------------------------------------------------------------
	-- health
	---------------------------------------------------------------------------------------------
	do
		self.Health:Height( 22 )
		self.Health:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Health:SetStatusBarColor( .150, .150, .150, 1 )
			self.Health.bg:SetVertexColor( 1, 0, 0, 1 )
			self.Health.bg:SetTexture( 238, .44, .44, 0.3 )
		end

		self.Health.value = S.SetFontString( self.Health, C["media"].uffont, 12, "THINOUTLINE" )
		self.Health.value:Point( "LEFT", 5, 0 )
		self.Health.value:SetShadowOffset( 0, 0 )
	end

	---------------------------------------------------------------------------------------------
	-- power
	---------------------------------------------------------------------------------------------
	do
		self.Power:Height( 5 )
		self.Power:Point( "TOPLEFT", self.Health, "BOTTOMLEFT", 9, 1 )
		self.Power:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", -85, -2 )
		self.Power:SetFrameLevel( self.Health:GetFrameLevel() + 1 )
		self.Power:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Power.colorTapping = true
			self.Power.colorClass = true
			self.Power.bg.multiplier = 0.1
		end

		self.Power.value = S.SetFontString( self.Health, C["media"].uffont, 12, "THINOUTLINE" )
		self.Power.value:Point( "RIGHT", -5, 0 )
		self.Power.value:SetShadowOffset( 0, 0 )
	end

	---------------------------------------------------------------------------------------------
	-- castbar
	---------------------------------------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true ) then
			self.Castbar:ClearAllPoints()
			self.Castbar:SetPoint( "TOPLEFT", TukuiFocus, "BOTTOMLEFT", 0, -12 )
			if C["unitframes"].cbicons == true then
				self.Castbar:Size( TukuiFocus:GetWidth() - 24, 16 )
			else
				self.Castbar:Size( TukuiFocus:GetWidth(), 16 )
			end
			self.Castbar:CreateBorder( true )

			if C["unitframes"].cbicons == true then
				self.Castbar.button:ClearAllPoints()
				self.Castbar.button:SetPoint( "RIGHT", self.Castbar, 26, 0 )
				self.Castbar.button:Size( 20, 20 )
				self.Castbar.button:CreateShadow( "Default" )
			else
				self.Castbar.button:Kill()
			end

			self.Castbar.Text:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.Text:SetParent( self.Castbar )
			self.Castbar.Text:ClearAllPoints()
			self.Castbar.Text:SetPoint( "LEFT", self.Castbar, "LEFT", 5, 0 )
			self.Castbar.Text.ClearAllPoints = S.dummy
			self.Castbar.Text.SetPoint = S.dummy

			self.Castbar.time:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.time:SetParent( self.Castbar )
			self.Castbar.time:ClearAllPoints()
			self.Castbar.time:SetPoint( "RIGHT", self.Castbar, "RIGHT", -5, 0 )
			self.Castbar.time.ClearAllPoints = S.dummy
			self.Castbar.time.SetPoint = S.dummy
		end
	end

	---------------------------------------------------------------------------------------------
	-- size, position
	---------------------------------------------------------------------------------------------
	do
		self:Size( 200, 22 )
		self:ClearAllPoints()
		self:Point( "BOTTOMLEFT", InvTukuiActionBarBackground, "TOPLEFT", -50, 300 )
	end
end

S.EnableTukuiFocusTarget = function()
	local self = _G["TukuiFocusTarget"]

	---------------------------------------------------------------------------------------------
	-- not needed
	---------------------------------------------------------------------------------------------
	do
		self.shadow:Kill()
	end

	---------------------------------------------------------------------------------------------
	-- health
	---------------------------------------------------------------------------------------------
	do
		self.Health:Height( 22 )
		self.Health:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Health:SetStatusBarColor( .150, .150, .150, 1 )
			self.Health.bg:SetVertexColor( 1, 0, 0, 1 )
			self.Health.bg:SetTexture( 238, .44, .44, 0.3 )
		end

		self.Health.value = S.SetFontString( self.Health, C["media"].uffont, 12, "THINOUTLINE" )
		self.Health.value:Point( "LEFT", 5, 0 )
		self.Health.value:SetShadowOffset( 0, 0 )
	end

	---------------------------------------------------------------------------------------------
	-- power
	---------------------------------------------------------------------------------------------
	do
		self.Power:Height( 5 )
		self.Power:Point( "TOPLEFT", self.Health, "BOTTOMLEFT", 9, 1 )
		self.Power:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", -85, -2 )
		self.Power:SetFrameLevel( self.Health:GetFrameLevel() + 1 )
		self.Power:CreateBorder( true )

		if( C["unitframes"].unicolor == true ) then
			self.Power.colorTapping = true
			self.Power.colorClass = true
			self.Power.bg.multiplier = 0.1
		end

		self.Power.value = S.SetFontString( self.Health, C["media"].uffont, 12, "THINOUTLINE" )
		self.Power.value:Point( "RIGHT", -5, 0 )
		self.Power.value:SetShadowOffset( 0, 0 )
	end

	---------------------------------------------------------------------------------------------
	-- castbar
	---------------------------------------------------------------------------------------------
	do
		if( C["unitframes"].unitcastbar == true ) then
			self.Castbar:ClearAllPoints()
			self.Castbar:SetPoint( "TOPLEFT", TukuiFocus, "BOTTOMLEFT", 0, -12 )
			if C["unitframes"].cbicons == true then
				self.Castbar:Size( TukuiFocus:GetWidth() - 24, 16 )
			else
				self.Castbar:Size( TukuiFocus:GetWidth(), 16 )
			end
			self.Castbar:CreateBorder( true )

			if C["unitframes"].cbicons == true then
				self.Castbar.button:ClearAllPoints()
				self.Castbar.button:SetPoint( "RIGHT", self.Castbar, 26, 0 )
				self.Castbar.button:Size( 20, 20 )
				self.Castbar.button:CreateShadow( "Default" )
			else
				self.Castbar.button:Kill()
			end

			self.Castbar.Text:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.Text:SetParent( self.Castbar )
			self.Castbar.Text:ClearAllPoints()
			self.Castbar.Text:SetPoint( "LEFT", self.Castbar, "LEFT", 5, 0 )
			self.Castbar.Text.ClearAllPoints = S.dummy
			self.Castbar.Text.SetPoint = S.dummy

			self.Castbar.time:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.time:SetParent( self.Castbar )
			self.Castbar.time:ClearAllPoints()
			self.Castbar.time:SetPoint( "RIGHT", self.Castbar, "RIGHT", -5, 0 )
			self.Castbar.time.ClearAllPoints = S.dummy
			self.Castbar.time.SetPoint = S.dummy
		end
	end

	---------------------------------------------------------------------------------------------
	-- size, position
	---------------------------------------------------------------------------------------------
	do
		self:Size( 200, 22 )
		self:ClearAllPoints()
		self:Point( "BOTTOM", TukuiFocus, "TOP", 0, 36 )
	end
end

S.EnableTukuiArena = function()
	for i = 1, 5 do
		local self = _G["TukuiArena" .. i]

		---------------------------------------------------------------------------------------------
		-- not needed
		---------------------------------------------------------------------------------------------
		self.shadow:Kill()

		---------------------------------------------------------------------------------------------
		-- health
		---------------------------------------------------------------------------------------------
		do
			self.Health:Height( 22 )
			self.Health:CreateBorder( true )

			if( C["unitframes"].unicolor == true ) then
				self.Health:SetStatusBarColor( .150, .150, .150, 1 )
				self.Health.bg:SetVertexColor( 1, 0, 0, 1 )
				self.Health.bg:SetTexture( 238, .44, .44, 0.3 )
			end

			self.Health.value = S.SetFontString( self.Health, C["media"].uffont, 12, "THINOUTLINE" )
			self.Health.value:Point( "LEFT", 5, 0 )
			self.Name:SetShadowOffset( 0, 0 )
		end

		---------------------------------------------------------------------------------------------
		-- power
		---------------------------------------------------------------------------------------------
		do
			self.Power:Height( 5 )
			self.Power:Point( "TOPLEFT", self.Health, "BOTTOMLEFT", 85, 2 )
			self.Power:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", -9, -1 )
			self.Power:SetFrameLevel( self.Health:GetFrameLevel() + 1 )
			self.Power:CreateBorder( true )

			if( C["unitframes"].unicolor == true ) then
				self.Power.colorTapping = true
				self.Power.colorClass = true
				self.Power.bg.multiplier = 0.1
			end

			self.Power.value = S.SetFontString( self.Health, C["media"].uffont, 12, "THINOUTLINE" )
			self.Power.value:Point( "RIGHT", -5, 0 )
			self.Power.value:SetShadowOffset( 0, 0 )
		end

		---------------------------------------------------------------------------------------------
		-- castbar
		---------------------------------------------------------------------------------------------
		do
			self.Castbar:ClearAllPoints()
			self.Castbar:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -12 )
			if( C["unitframes"].cbicons == true ) then
				self.Castbar:Size( self:GetWidth() - 24, 16 )
			else
				self.Castbar:Size( self:GetWidth(), 16 )
			end
			self.Castbar:CreateBorder( true )

			if( C["unitframes"].cbicons == true ) then
				self.Castbar.button:ClearAllPoints()
				self.Castbar.button:SetPoint( "LEFT", self.Castbar, -26, 0 )
				self.Castbar.button:Size( 20, 20 )
				self.Castbar.button:CreateShadow( "Default" )
			else
				self.Castbar.button:Kill()
			end

			self.Castbar.Text:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.Text:SetParent( self.Castbar )
			self.Castbar.Text:ClearAllPoints()
			self.Castbar.Text:SetPoint( "LEFT", self.Castbar, "LEFT", 5, 0 )
			self.Castbar.Text.ClearAllPoints = S.dummy
			self.Castbar.Text.SetPoint = S.dummy

			self.Castbar.time:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.time:SetParent( self.Castbar )
			self.Castbar.time:ClearAllPoints()
			self.Castbar.time:SetPoint( "RIGHT", self.Castbar, "RIGHT", -5, 0 )
			self.Castbar.time.ClearAllPoints = S.dummy
			self.Castbar.time.SetPoint = S.dummy
		end

		---------------------------------------------------------------------------------------------
		-- size, position
		---------------------------------------------------------------------------------------------
		do
			self:Size( 200, 22 )
			self:ClearAllPoints()
			if( i == 1 ) then
				self:SetPoint( "BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 50, 300 )
			else
				self:SetPoint( "BOTTOM", _G["TukuiArena" .. i - 1]  , "TOP", 0, 36 )
			end
		end
	end
end

S.EnableTukuiBoss = function()
	for i = 1, MAX_BOSS_FRAMES do
		local self = _G["TukuiBoss" .. i]

		---------------------------------------------------------------------------------------------
		-- not needed
		---------------------------------------------------------------------------------------------
		do
			self.shadow:Kill()
		end

		---------------------------------------------------------------------------------------------
		-- health
		---------------------------------------------------------------------------------------------
		do
			self.Health:Height( 22 )
			self.Health:CreateBorder( true )

			if( C["unitframes"].unicolor == true ) then
				self.Health:SetStatusBarColor( .150, .150, .150, 1 )
				self.Health.bg:SetVertexColor( 1, 0, 0, 1 )
				self.Health.bg:SetTexture( 238, .44, .44, 0.3 )
			end

			self.Health.value = S.SetFontString( self.Health, C["media"].uffont, 12, "THINOUTLINE" )
			self.Health.value:Point( "LEFT", 5, 0 )
			self.Health.value:SetShadowOffset( 0, 0 )
		end

		---------------------------------------------------------------------------------------------
		-- power
		---------------------------------------------------------------------------------------------
		do
			self.Power:Height( 5 )
			self.Power:Point( "TOPLEFT", self.Health, "BOTTOMLEFT", 85, 2 )
			self.Power:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", -9, -1 )
			self.Power:SetFrameLevel( self.Health:GetFrameLevel() + 1 )
			self.Power:CreateBorder( true )

			if( C["unitframes"].unicolor == true ) then
				self.Power.colorTapping = true
				self.Power.colorClass = true
				self.Power.bg.multiplier = 0.1
			end

			self.Power.value = S.SetFontString( self.Health, C["media"].uffont, 12, "THINOUTLINE" )
			self.Power.value:Point( "RIGHT", -5, 0 )
			self.Power.value:SetShadowOffset( 0, 0 )
		end

		---------------------------------------------------------------------------------------------
		-- castbar
		---------------------------------------------------------------------------------------------
		do
			self.Castbar:ClearAllPoints()
			self.Castbar:Point( "TOPRIGHT", self.Health, "BOTTOMRIGHT", 0, -12 )
			if C["unitframes"].cbicons == true then
				self.Castbar:Size( self:GetWidth() - 24, 16 )
			else
				self.Castbar:Size( self:GetWidth(), 16 )
			end
			self.Castbar:CreateBorder( true )

			if C["unitframes"].cbicons == true then
				self.Castbar.button:ClearAllPoints()
				self.Castbar.button:SetPoint( "LEFT", self.Castbar, -26, 0 )
				self.Castbar.button:Size( 20, 20 )
				self.Castbar.button:CreateShadow( "Default" )
			else
				self.Castbar.button:Kill()
			end

			self.Castbar.Text:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.Text:SetParent( self.Castbar )
			self.Castbar.Text:ClearAllPoints()
			self.Castbar.Text:SetPoint( "LEFT", self.Castbar, "LEFT", 5, 0 )
			self.Castbar.Text.ClearAllPoints = S.dummy
			self.Castbar.Text.SetPoint = S.dummy

			self.Castbar.time:SetFont( C["media"].uffont, 12, "THINOUTLINE" )
			self.Castbar.time:SetParent( self.Castbar )
			self.Castbar.time:ClearAllPoints()
			self.Castbar.time:SetPoint( "RIGHT", self.Castbar, "RIGHT", -5, 0 )
			self.Castbar.time.ClearAllPoints = S.dummy
			self.Castbar.time.SetPoint = S.dummy
		end


		---------------------------------------------------------------------------------------------
		-- size, position
		---------------------------------------------------------------------------------------------
		do
			self:Size( 200, 22 )
			self:ClearAllPoints()
			if( i == 1 ) then
				self:SetPoint( "BOTTOMRIGHT", InvTukuiActionBarBackground, "TOPRIGHT", 50, 300 )
			else
				self:SetPoint( "BOTTOM", _G["TukuiBoss" .. i - 1]  , "TOP", 0, 36 )
			end
		end
	end
end