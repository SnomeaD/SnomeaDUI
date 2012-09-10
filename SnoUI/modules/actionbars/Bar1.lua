local T, C, L, G = unpack(Tukui)

if not C.actionbar.enable == true then return end

local bar = TukuiBar1

for i = 1, 12 do
	-- local button = G.ActionBars.Bar1["Button"..i]
	-- local previous = G.ActionBars.Bar1["Button"..i-1]
	local button = _G["ActionButton"..i]
	local previous = _G["ActionButton"..i-1]
	button:ClearAllPoints()
	if i == 1 then
		button:SetPoint("BOTTOMLEFT",bar, "BOTTOMLEFT", T.buttonspacing, T.buttonspacing)
	elseif (i == 6 or i == 11) and C.general.nostromo == true then
		button:SetPoint("LEFT", previous, "RIGHT", T.buttonspacing*3, 0)
	else
		button:SetPoint("LEFT", previous, "RIGHT", T.buttonspacing*3, 0)
	end
end