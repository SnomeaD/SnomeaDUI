local T, C, L = unpack( Tukui )

-- Allways show Zone text above minimap
local minimap = Minimap
local minimapZoneText = TukuiMinimapZoneText
local minimapZone = TukuiMinimapZone
local minimapCoordText = TukuiMinimapCoordText
local minimapCoord = TukuiMinimapCoord

minimapZone:ClearAllPoints()
minimapZone:SetAlpha(1)
minimapZone:Point("BOTTOM", minimap, "TOP", 0, 2)
minimapZone:SetWidth(TukuiMinimap:GetWidth())
minimapZoneText:ClearAllPoints()
minimapZoneText:SetAlpha(1)
minimapZoneText:Point("BOTTOM", minimap, "TOP", 0, 2)

minimap:HookScript("OnLeave",function(self)
	minimapZone:SetAlpha(1)
	minimapZoneText:SetAlpha(1)
end)
