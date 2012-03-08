local T, C, L = unpack(Tukui)

-- hide Panels we don't need.
local lines = {TukuiInfoLeftLineVertical, TukuiInfoRightLineVertical, TukuiLineToABLeft, TukuiLineToABLeftAlt, TukuiLineToABRight, TukuiLineToABRightAlt, TukuiChatBackgroundRight, TukuiTabsRightBackground, TukuiLineToPetActionBarBackground, TukuiCubeLeft, TukuiCubeRight}
for _, panel in pairs(lines) do
	panel:Hide()
end

if not C.actionbar.hideshapeshift == true then 
	-- shapeshift bar
	local ssborder = CreateFrame( "Frame", "ShapeShiftBorder", ShapeshiftButton1 )
	ssborder:Point("LEFT", -T.buttonspacing, 0)
	ssborder:SetTemplate("Default")
	ssborder:SetFrameLevel(1)
	ssborder:SetFrameStrata("BACKGROUND")

	TukuiShapeShift:HookScript( "OnEvent", function( self, event, ... )
		ShapeShiftBorder:Size((( ShapeshiftButton1:GetWidth() + T.buttonspacing) * GetNumShapeshiftForms()) + T.buttonspacing, ShapeshiftButton1:GetHeight() + 2 * T.buttonspacing)
	end)
end

-- Bottom background
local bottomBackground = CreateFrame("Frame", "TukuiBottomBar", UIParent)
    bottomBackground:CreatePanel("Default", 1, 22, "TOP", UIParent, "TOP", 0, 0)
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

-- switch layout
local UpdateLayoutTexture = function( self )
	if( IsAddOnLoaded( "Tukui_Raid" ) ) then
		newTex = C["media"].DPSTex
	elseif( IsAddOnLoaded( "Tukui_Raid_Healing" ) ) then
		newTex = C["media"].HealingTex
	end
	self.tex:SetTexture( newTex )
end

local SwitchLayoutButton = CreateFrame("Button", "TukuiSwitchLayoutButton", UIParent, "SecureActionButtonTemplate")
	SwitchLayoutButton:CreatePanel( nil, 23, 23, "LEFT", TukuiInfoLeft, "RIGHT", -3, 0 )
	SwitchLayoutButton:Point("LEFT", TukuiInfoLeft, "RIGHT", 3, 0)
	SwitchLayoutButton:SetFrameStrata("BACKGROUND")
	SwitchLayoutButton:SetFrameLevel(2)
	SwitchLayoutButton.tex = SwitchLayoutButton:CreateTexture( nil, "ARTWORK" )
	SwitchLayoutButton.tex:Point( "TOPLEFT", 2, -2 )
	SwitchLayoutButton.tex:Point( "BOTTOMRIGHT", -2, 2 )
	SwitchLayoutButton.tex:SetTexCoord( 0.08, 0.92, 0.08, 0.92 )
	
	SwitchLayoutButton:RegisterEvent( "PLAYER_ENTERING_WORLD" )
	SwitchLayoutButton:SetScript( "OnEvent", UpdateLayoutTexture )
	SwitchLayoutButton:RegisterForClicks( "AnyUp" )
	SwitchLayoutButton:SetScript("OnClick", function()
		if IsAddOnLoaded("Tukui_Raid") then
			DisableAddOn("Tukui_Raid")
			EnableAddOn("Tukui_Raid_Healing")
			ReloadUI()
		elseif IsAddOnLoaded("Tukui_Raid_Healing") then
			DisableAddOn("Tukui_Raid_Healing")
			EnableAddOn("Tukui_Raid")
			ReloadUI()
		elseif not IsAddOnLoaded("Tukui_Raid_Healing") and not IsAddOnLoaded("Tukui_Raid") then
			EnableAddOn("Tukui_Raid")
			ReloadUI()
		end
	end)




-- Hydra Spec Button!
if UnitLevel("player") <= 10 then return end

local SwitchTemplateButton = CreateFrame( "Button", "SwitchTemplateButton", UIParent, "SecureActionButtonTemplate" )
	SwitchTemplateButton:CreatePanel(nil, 23, 23, "RIGHT", TukuiInfoRight, "LEFT", -3, 0)
	SwitchTemplateButton:SetFrameLevel( 2 )
	SwitchTemplateButton:SetFrameStrata( "BACKGROUND" )

	SwitchTemplateButton.tex = SwitchTemplateButton:CreateTexture( nil, "ARTWORK" )
	SwitchTemplateButton.tex:Point( "TOPLEFT", 2, -2 )
	SwitchTemplateButton.tex:Point( "BOTTOMRIGHT", -2, 2 )
	SwitchTemplateButton.tex:SetTexCoord( 0.08, 0.92, 0.08, 0.92 )

	SwitchTemplateButton:SetScript( "OnClick", function( self )
		local i = GetActiveTalentGroup()
		if( IsModifierKeyDown() ) then
			ToggleTalentFrame()
		else
			if( i == 1 ) then 
				SetActiveTalentGroup( 2 )
			end
			if( i == 2 ) then
				SetActiveTalentGroup( 1 )
			end
		end
	end )

local UpdateTexture = function( self )
	if not GetPrimaryTalentTree() then return end

	local primary = GetPrimaryTalentTree()
	local tex = select( 4, GetTalentTabInfo( primary ) )

	self.tex:SetTexture( tex )
end

SwitchTemplateButton:RegisterEvent( "PLAYER_ENTERING_WORLD" )
SwitchTemplateButton:RegisterEvent( "ACTIVE_TALENT_GROUP_CHANGED" )
SwitchTemplateButton:RegisterEvent( "PLAYER_TALENT_UPDATE" )
SwitchTemplateButton:SetScript( "OnEvent", UpdateTexture )