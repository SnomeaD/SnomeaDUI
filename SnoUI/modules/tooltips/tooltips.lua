local T, C, L = unpack( Tukui )

if( C["tooltip"].enable ~= true ) then return end

TukuiTooltipAnchor:ClearAllPoints()
TukuiTooltipAnchor:SetPoint( "BOTTOMRIGHT", UIParent, -6, 160 )