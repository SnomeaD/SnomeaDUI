-- raid editing guide by hydra/tukz
-- Copied from PatUI - Thanks !
local T, C, L = unpack(Tukui)

--------------------------------------------------------------
-- Edit Unit Raid Frames here!
--------------------------------------------------------------
-- 1 second delay before edited skin apply (can probably be a lower because 1 second is really too long, 0.1 or 0.2 should be the best, setting it to 1 was just for testing, CANNOT BE 0)
local delay = 0.2

local function EditUnitFrame(frame, header)
	local name = frame.Name
	local health = frame.Health
	local power = frame.Power
	local panel = frame.panel
	local name = frame.Name
	local healthBG = frame.Health.bg
	

	-- place your stuff here for editing ALL raid frame unit in all layout with the same value

	TukuiRaidUtility:ClearAllPoints()
	TukuiRaidUtility:SetPoint( "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, 20 )

	-- for layout-specifics, here we edit only 1 layout at time
	if header == TukuiRaid25 then
		health:CreateBorder(false, true)
		health:Height(24)
		health:SetFrameLevel(2)
		healthBG:SetTexture(.25, .1, .1)
		healthBG:SetVertexColor(.25, .1, .1)
		
		power:ClearAllPoints()
	    power:Height(1)
		power:CreateBorder(false, true)
	    power:Point("BOTTOMLEFT", health, "BOTTOMLEFT", 4, 2)
	    power:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", -4, 2)
	    power:SetStatusBarTexture(C["media"].blank)
		power:SetFrameLevel(3)
		
		name:SetParent(health)
		name:ClearAllPoints()
		name:SetPoint("TOP", health, "TOP", 0, -5)
		name:SetFont(C.media.pixelfont, 12, "MONOCHROMEOUTLINE")
	elseif header == TukuiRaid40 then
		health:CreateBorder(false, true)
		health:Height(24)
		health:SetFrameLevel(2)
		healthBG:SetTexture(.25, .1, .1)
		healthBG:SetVertexColor(.25, .1, .1)
		
		power:ClearAllPoints()
	    power:Height(1)
		power:CreateBorder(false, true)
	    power:Point("BOTTOMLEFT", health, "BOTTOMLEFT", 4, 2)
	    power:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", -4, 2)
	    power:SetStatusBarTexture(C["media"].blank)
		power:SetFrameLevel(3)
		
		name:SetParent(health)
		name:ClearAllPoints()
		name:SetPoint("TOP", health, "TOP", 0, -5)
		name:SetFont(C.media.pixelfont, 12, "MONOCHROMEOUTLINE")
	elseif header == TukuiRaidHealerGrid then
		health:CreateBorder(false, true)
		health:Height(31)
		health:SetFrameLevel(2)
		healthBG:SetTexture(.25, .1, .1)
		healthBG:SetVertexColor(.25, .1, .1)
		
		power:ClearAllPoints()
	    power:Height(1)
		power:CreateBorder(false, true)
	    power:Point("BOTTOMLEFT", health, "BOTTOMLEFT", 4, 2)
	    power:Point("BOTTOMRIGHT", health, "BOTTOMRIGHT", -4, 2)
	    power:SetStatusBarTexture(C["media"].blank)
		power:SetFrameLevel(3)
		
		panel:Kill()
		
		name:SetParent(health)
		name:ClearAllPoints()
		name:SetPoint("TOP", 0, 0)
		-- name:SetFont(C.media.uffont, 12, "THINOUTLINE")
		name:SetFont(C.media.pixelfont, 12, "MONOCHROMEOUTLINE")
	end
end

local function EditUnitAttributes(layout)
	local header = _G[layout]
	local dpsmax25 = layout:match("Raid25")
	local dpsmax40 = layout:match("Raid40")
	local healmax15 = layout:match("Healer15")
	local grid = layout:match("HealerGrid")
	
	-- set your new attributes here, in this example we only resize units, X/Y offset and column spacing to Grid.
	if dpsmax25 then
		header:SetAttribute("yOffset", -10)
	elseif dpsmax40 then
		header:SetAttribute("yOffset", -10)
	elseif healmax15 then
		-- do your attributes
	elseif grid then
		header:SetAttribute("initial-width", 65)
		header:SetAttribute("initial-height", 30)
		header:SetAttribute("xoffset", 4)
		header:SetAttribute("yOffset", 0)
		header:SetAttribute("columnSpacing", T.Scale(4))
	end
end

--------------------------------------------------------------
-- Stop Editing!
--------------------------------------------------------------

-- import the framework
local oUF = oUFTukui or oUF

local function InitScript()
	local children
	local heal = IsAddOnLoaded("Tukui_Raid_Healing")
	local dps = IsAddOnLoaded("Tukui_Raid")
	
	-- don't need to load, because we will reload anyway after user select their layout
	if heal and dps then return end
	
	local function UpdateRaidUnitSize(frame, header)
		frame:SetSize(header:GetAttribute("initial-width"), header:GetAttribute("initial-height"))
	end

	local GetActiveHeader = function()
		local players = (GetNumPartyMembers() + 1)
		
		if UnitInRaid("player") then
			players = GetNumRaidMembers()
		end

		if heal then
			if C["unitframes"].gridonly then
				return TukuiRaidHealerGrid
			else
				if players <= 15 then
					return TukuiRaidHealer15
				else
					return TukuiRaidHealerGrid
				end
			end
		elseif dps then
			if players <= 25 then
				return TukuiRaid25
			elseif players > 25 then
				return TukuiRaid40
			end
		end
	end
	
	local function Update(frame, header, event)
		if (frame and frame.unit) then
			local isEdited = frame.isEdited
			
			-- we need to update size of every raid frames if already in raid when we enter world (or /rl)
			if event == "PLAYER_ENTERING_WORLD" then
				UpdateRaidUnitSize(frame, header)
			end
			
			-- we check for "isEdited" here because we don't want to edit every frame
			-- every time a member join the raid else it will cause high cpu usage
			-- and could cause screen freezing
			if not frame.isEdited then
				EditUnitFrame(frame, header)
				frame.isEdited = true
			end
		end	
	end

	local function Skin(header, event)
		children = {header:GetChildren()}
		
		for _, frame in pairs(children) do
			Update(frame, header, event)
		end	
	end
	
	local StyleRaidFrames = function(self, event)
		local header = GetActiveHeader()
		-- make sure we... catch them all! (I feel pikachu inside me)
		-- we add a delay to make sure latest created unit is catched.
		T.Delay(delay, function() Skin(header, event) end)
	end

	-- init, here we modify the initial Config.
	local function SpawnHeader(name, layout, visibility, ...)
		EditUnitAttributes(layout)
	end
	
	-- this is the function oUF framework use to create and set attributes to headers
	hooksecurefunc(oUF, "SpawnHeader", SpawnHeader)

	local style = CreateFrame("Frame")
	style:RegisterEvent("PLAYER_ENTERING_WORLD")
	style:RegisterEvent("PARTY_MEMBERS_CHANGED")
	style:RegisterEvent("RAID_ROSTER_UPDATE")
	style:SetScript("OnEvent", StyleRaidFrames)
end

local script = CreateFrame("Frame")
script:RegisterEvent("ADDON_LOADED")
script:SetScript("OnEvent", function(self, event, addon)
	if addon == "Tukui_Raid" or addon == "Tukui_Raid_Healing" then
		InitScript()
	end
end)