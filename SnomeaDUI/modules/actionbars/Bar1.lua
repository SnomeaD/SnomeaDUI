local T, C, L, G = unpack(Tukui)

if not C.actionbar.enable == true then return end

local bar = TukuiBar1


bar:HookScript( "OnEvent", function( self, event, unit )
	if( event == "PLAYER_ENTERING_WORLD" ) then
		local button

		for i = 1, 12 do
			button = _G["ActionButton"..i]
			local previous = _G["ActionButton"..i-1]
			button:ClearAllPoints()
			if i == 1 then
				button:SetPoint("BOTTOMLEFT",bar, "BOTTOMLEFT", T.buttonspacing, T.buttonspacing)
			elseif (i == 6 or i == 11) and C.general.nostromo == true then
				local previous = _G["ActionButton" .. i - 1]
				button:SetPoint("LEFT", previous, "RIGHT", T.buttonspacing*3, 0)
			else
				local previous = _G["ActionButton" .. i - 1]
				button:SetPoint("LEFT", previous, "RIGHT", T.buttonspacing, 0)
			end
		end
	end
end)