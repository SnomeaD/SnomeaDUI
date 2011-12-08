local T, C, L = unpack( Tukui )

local AddonLayout = CreateFrame("Frame")
AddonLayout:RegisterEvent("ADDON_LOADED")
AddonLayout:SetScript("OnEvent", function(self, event, addon)
	if TukuiRaidUtility then
		TukuiRaidUtility:ClearAllPoints()
		TukuiRaidUtility:SetPoint( "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, 20 )
	end
end)


