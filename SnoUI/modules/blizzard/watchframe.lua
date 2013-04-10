local T, C, L = unpack( Tukui )


TukuiWatchFrameAnchor:ClearAllPoints()
if not T.lowversion then
	TukuiWatchFrameAnchor:SetPoint("TOPRIGHT", UIParent, -90, -220)
else
	TukuiWatchFrameAnchor:SetPoint("TOPRIGHT", UIParent, -104, -220)
end
