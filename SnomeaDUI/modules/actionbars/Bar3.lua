local T, C, L = unpack(Tukui)

if not C.actionbar.enable == true then return end

---------------------------------------------------------------------------
-- setup MultiBarRight as bar #3 
---------------------------------------------------------------------------

local bar = TukuiBar3
MultiBarBottomRight:SetParent(bar)

for i= 1, 12 do
	local b = _G["MultiBarBottomRightButton"..i]
	local b2 = _G["MultiBarBottomRightButton"..i-1]
	-- b:SetSize(T.buttonsize, T.buttonsize)
	b:ClearAllPoints()
	-- b:SetFrameStrata("BACKGROUND")
	-- b:SetFrameLevel(15)
	
	if i == 1 then
		b:SetPoint("BOTTOMLEFT", bar, T.buttonspacing, T.buttonspacing)
	elseif i == 7 then
		b:SetPoint("TOPLEFT", bar, T.buttonspacing, -T.buttonspacing)
	else
		b:SetPoint("LEFT", b2, "RIGHT", T.buttonspacing, 0)
	end
end

-- for i=7, 12 do
-- 	local b = _G["MultiBarBottomRightButton"..i]
-- 	local b2 = _G["MultiBarBottomRightButton1"]
-- 	b:SetFrameLevel(b2:GetFrameLevel() - 2)
-- end