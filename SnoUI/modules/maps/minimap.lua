local T, C, L = unpack( Tukui )

-- Allways show Zone text above minimap
local minimap = Minimap
local minimapZoneText = TukuiMinimapZoneText
local minimapZone = TukuiMinimapZone
local minimapCoordText = TukuiMinimapCoordText
local minimapCoord = TukuiMinimapCoord

TukuiMinimap:ClearAllPoints()
TukuiMinimap:Point("TOPRIGHT", UIParent, "TOPRIGHT", -6, -30)
TukuiAurasPlayerBuffs:ClearAllPoints()
TukuiAurasPlayerBuffs:Point("TOPRIGHT", TukuiMinimap, "TOPLEFT", -22, 0)

minimapZone:ClearAllPoints()
minimapZone:SetAlpha(1)
minimapZone:Point("BOTTOM", TukuiMinimap, "TOP", 0, 6)
minimapZone:SetWidth(TukuiMinimap:GetWidth())
minimapZoneText:ClearAllPoints()
minimapZoneText:SetAlpha(1)
minimapZoneText:Point("BOTTOM", TukuiMinimap, "TOP", 0, 9)

minimap:HookScript("OnLeave",function(self)
	minimapZone:SetAlpha(1)
	minimapZoneText:SetAlpha(1)
end)
