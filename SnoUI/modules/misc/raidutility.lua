local T, C, L = unpack( Tukui )

local AddonLayout = CreateFrame("Frame")
AddonLayout:RegisterEvent("ADDON_LOADED")
AddonLayout:SetScript("OnEvent", function(self, event, addon)
	if TukuiRaidUtility then
		TukuiRaidUtilityShowButton:ClearAllPoints()
		TukuiRaidUtilityShowButton:SetPoint( "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, 30 )
		TukuiRaidUtility:ClearAllPoints()
		TukuiRaidUtility:SetPoint( "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, 30 )
	end
end)


