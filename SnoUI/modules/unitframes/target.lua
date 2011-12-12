local T, C, L = unpack(Tukui) -- Import: T - functions, constants, variables; C - config; L - locales
if C.unitframes.enable ~= true then return end

-- Base layout/code by Sinaris
-- http://www.tukui.org/forums/forum.php?id=113

------------------------------------------------------------------------
--	local variables
------------------------------------------------------------------------
local unit = TukuiTarget
local castbar = TukuiTarget.Castbar
local health = TukuiTarget.Health
local power = TukuiTarget.Power
local healthBG = TukuiTarget.Health.bg
local portrait = TukuiTarget.Portrait
local name = TukuiTarget.Name

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
	health.value:Point( "RIGHT", health, "RIGHT", -5, 0 )
	health.value:SetShadowOffset( 0, 0 )

	name:SetFont( C["media"].uffont, 13, "THINOUTLINE" )
	name:SetParent( health )
	name:ClearAllPoints()
	name:SetPoint( "LEFT", health, "LEFT", 5, 2 )
	name:SetShadowOffset( 0, 0 )
	name.ClearAllPoints = T.dummy
	name.SetPoint = T.dummy

	unit:Tag( name, "[Tukui:getnamecolor][Tukui:namelong] [Tukui:diffcolor][level] [shortclassification]" )
end

---------------------------------------------------------------------------------------------
-- power
---------------------------------------------------------------------------------------------
do
	-- power:SetHeight( 5 )
	power:Point( "TOPLEFT", health, "BOTTOMLEFT", 9, 4 )
	power:Point( "TOPRIGHT", health, "BOTTOMRIGHT", -9, -6 )
	power:SetFrameLevel( health:GetFrameLevel() + 1 )
	power:CreateBorder( true )
	-- power:CreateBorder( true )
end

---------------------------------------------------------------------------------------------
-- portrait
---------------------------------------------------------------------------------------------
do
	if( C["unitframes"].charportrait == true ) then
		portrait:ClearAllPoints()
		portrait:SetAllPoints( TukuiTarget.Health )
		portrait:SetAlpha( 0.2 )
		portrait.SetAlpha = T.dummy
		health:SetPoint( "TOPLEFT", 0, 0 )
		health:SetPoint( "TOPRIGHT" )
		portrait:SetFrameLevel( power:GetFrameLevel() - 1 )
	end
end

---------------------------------------------------------------------------------------------
-- castbar
---------------------------------------------------------------------------------------------
do
	if( C["unitframes"].unitcastbar == true ) then
		castbar:ClearAllPoints()
		castbar:SetPoint( "BOTTOMLEFT", TukuiTarget, "TOPLEFT", 0, 64 )
		if C["unitframes"].cbicons == true then
			castbar:Size( TukuiTarget:GetWidth() - 24, 16 )
		else
			castbar:Size( TukuiTarget:GetWidth() - 4, 16 )
		end
		castbar:CreateBorder()

		if C["unitframes"].cbicons == true then
			castbar.button:ClearAllPoints()
			castbar.button:SetPoint( "LEFT", castbar, "RIGHT", 6, 0 )
			castbar.button:Size( 18, 18 )
		end
		castbar.Time = T.SetFontString(castbar, C["media"].uffont, 12, "THINOUTLINE")
		castbar.Text = T.SetFontString(castbar, C["media"].uffont, 12, "THINOUTLINE")
		
		castbar.Time:Point("RIGHT", castbar, "RIGHT", -4, 0)
		castbar.Text:Point("LEFT", castbar, "LEFT", 4, 0)

		castbar.bg = CreateFrame("Frame", nil, castbar)
		castbar.bg:SetTemplate("Transparent")
		castbar.bg:SetBorder()
		castbar.bg:SetPoint("TOPLEFT", -2, 2)
		castbar.bg:SetPoint("BOTTOMRIGHT", 2, -2)
		castbar.bg:SetFrameLevel(3)
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
		unit.Buffs.num = 9
		unit.Debuffs.num = 18

		unit.Buffs:ClearAllPoints()
		unit.Buffs:SetPoint( "BOTTOMLEFT", unit, "TOPLEFT", -2, 4 )
	end
end
---------------------------------------------------------------------------------------------
-- size
---------------------------------------------------------------------------------------------

-- unit:Size( 246, 28 )
unit:SetHeight( 28 )