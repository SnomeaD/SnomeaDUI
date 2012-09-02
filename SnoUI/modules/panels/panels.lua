local T, C, L, G = unpack(Tukui)

-- hide Panels we don't need.
local lines = {TukuiInfoLeftLineVertical, TukuiInfoRightLineVertical, TukuiLineToABLeft, TukuiLineToABLeftAlt, TukuiLineToABRight, TukuiLineToABRightAlt, TukuiChatBackgroundRight, TukuiTabsRightBackground, TukuiLineToPetActionBarBackground, TukuiCubeLeft, TukuiCubeRight}
for _, panel in pairs(lines) do
	panel:Hide()
end

-- Bottom background
local bottomBackground = CreateFrame("Frame", "TukuiBottomBar", UIParent)
	bottomBackground:Size(1,22)
	bottomBackground:SetTemplate("Default")
	bottomBackground:Point("TOP", UIParent, "TOP", 0, 0)

	bottomBackground:ClearAllPoints()
	bottomBackground:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", T.Scale(-6), T.Scale(-6))
	bottomBackground:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", T.Scale(6), T.Scale(-6))
	bottomBackground:SetFrameStrata("BACKGROUND")
	bottomBackground:SetFrameLevel(0)
	bottomBackground:SetAlpha(.9)
	bottomBackground:CreateShadow("Default")

-- Move TukInfoPanel
TukuiInfoRight:ClearAllPoints()
TukuiInfoLeft:ClearAllPoints()
TukuiInfoRight:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -8, 8)
TukuiInfoLeft:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 8, 8)

-- Move the minimap stats
local minileft = TukuiMinimapStatsLeft
local miniright = TukuiMinimapStatsRight

minileft:SetParent(UIParent)
minileft:ClearAllPoints()
minileft:Point("BOTTOMLEFT", TukuiBar2, "TOPLEFT", 0, 2)
minileft:Width(72)

miniright:SetParent(UIParent)
miniright:ClearAllPoints()
if T.lowversion then
	miniright:Point("BOTTOMRIGHT", TukuiBar2, "TOPRIGHT", 0, 2)
else
	miniright:Point("BOTTOMRIGHT", TukuiBar3, "TOPRIGHT", 0, 2)
end
miniright:Width(72)


-- Hydra/Sno Spec Button!
if UnitLevel("player") <= 10 then return end

local SwitchTemplateButton = CreateFrame( "Button", "SwitchTemplateButton", UIParent, "SecureActionButtonTemplate" )
	SwitchTemplateButton:Size(23,22)
	SwitchTemplateButton:SetTemplate("Default")
	SwitchTemplateButton:Point("RIGHT", TukuiInfoRight, "LEFT", -3, 0)

	SwitchTemplateButton:SetFrameLevel( 2 )
	SwitchTemplateButton:SetFrameStrata( "BACKGROUND" )

	SwitchTemplateButton.tex = SwitchTemplateButton:CreateTexture( nil, "ARTWORK" )
	SwitchTemplateButton.tex:Point( "TOPLEFT", 2, -2 )
	SwitchTemplateButton.tex:Point( "BOTTOMRIGHT", -2, 2 )
	SwitchTemplateButton.tex:SetTexCoord( 0.08, 0.92, 0.08, 0.92 )

	SwitchTemplateButton:SetScript( "OnClick", function( self )
		local spec = GetActiveSpecGroup()
		if( IsModifierKeyDown() ) then
			ToggleTalentFrame()
		else
			if( spec == 1 ) then 
				SetActiveSpecGroup( 2 )
			end
			if( spec == 2 ) then
				SetActiveSpecGroup( 1 )
			end
		end
	end )

local UpdateTexture = function( self )
	if not GetSpecialization() then
		self.tex:SetTexture(select(4, GetSpecializationInfo(0)))
	else
		local tree = GetSpecialization()
		local currentSpecIcon = tree and select(4, GetSpecializationInfo(tree)) or "None"
		self.tex:SetTexture(currentSpecIcon)
	end
end

SwitchTemplateButton:RegisterEvent( "PLAYER_ENTERING_WORLD" )
SwitchTemplateButton:RegisterEvent( "ACTIVE_TALENT_GROUP_CHANGED" )
SwitchTemplateButton:RegisterEvent( "PLAYER_TALENT_UPDATE" )
SwitchTemplateButton:SetScript( "OnEvent", UpdateTexture )