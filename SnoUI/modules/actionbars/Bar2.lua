local T, C, L, G= unpack(Tukui)

if not C.actionbar.enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarBottomLeft as bar #2
---------------------------------------------------------------------------

local bar = TukuiBar2
MultiBarBottomLeft:SetParent(bar)

-- setup the bar
for i=1, 12 do
	local b = _G["MultiBarBottomLeftButton"..i]
	local b2 = _G["MultiBarBottomLeftButton"..i-1]
	-- b:SetSize(T.buttonsize, T.buttonsize)
	b:ClearAllPoints()
	-- b:SetFrameStrata("BACKGROUND")
	-- b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("TOPLEFT", bar, T.buttonspacing, -T.buttonspacing)
	elseif (i == 6 or i == 11) and C.general.nostromo == true then
		b:SetPoint("LEFT", b2, "RIGHT", T.buttonspacing*3, 0)
	else
		b:SetPoint("LEFT", b2, "RIGHT", T.buttonspacing, 0)
	end
end

-- for i=7, 12 do
-- 	local b = _G["MultiBarBottomLeftButton"..i]
-- 	local b2 = _G["MultiBarBottomLeftButton1"]
-- 	b:SetFrameLevel(b2:GetFrameLevel() - 2)
-- end