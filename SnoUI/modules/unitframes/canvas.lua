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
