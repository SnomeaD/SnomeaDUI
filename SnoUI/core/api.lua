local T, C, L = unpack(Tukui)

---Stolen from Pat
-- API stuff
local function CreateBorder(f, i, o)
	if i then
		if f.iborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName() .. "InnerBorder" or nil, f)
		border:Point("TOPLEFT", T.mult, -T.mult)
		border:Point("BOTTOMRIGHT", -T.mult, T.mult)
		border:SetBackdrop({
			edgeFile = C["media"].blank, 
			edgeSize = T.mult, 
			insets = { left = T.mult, right = T.mult, top = T.mult, bottom = T.mult }
		})
		border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
		f.iborder = border
	end
	
	if o then
		if f.oborder then return end
		local border = CreateFrame("Frame", f:GetName() and f:GetName() .. "OuterBorder" or nil, f)
		border:Point("TOPLEFT", -T.mult, T.mult)
		border:Point("BOTTOMRIGHT", T.mult, -T.mult)
		border:SetFrameLevel(f:GetFrameLevel() + 1)
		border:SetBackdrop({
			edgeFile = C["media"].blank, 
			edgeSize = T.mult, 
			insets = { left = T.mult, right = T.mult, top = T.mult, bottom = T.mult }
		})
		border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
		f.oborder = border
	end
end

local function SetBorder(f)
	if f:GetFrameStrata() == "BACKGROUND" then f:SetFrameStrata("LOW") end
	f:SetBackdropColor(.075, .075, .075, 0.7)
	f:SetBackdropBorderColor(unpack(C["media"].bordercolor))
	local border = CreateFrame("Frame", nil, f)
	border:SetPoint("TOPLEFT", f, "TOPLEFT", T.Scale(-1), T.Scale(1))
	border:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", T.Scale(1), T.Scale(-1))
	border:SetFrameStrata("BACKGROUND")
	border:SetFrameLevel(1)
	border:SetBackdrop { edgeFile = C["media"].blank, edgeSize = T.Scale(3), insets = {left = 0, right = 0, top = 0, bottom = 0} }
	border:SetBackdropColor(unpack(C["media"].backdropcolor))
	border:SetBackdropBorderColor(unpack(C["media"].backdropcolor))
end

local function AllPoints(obj, frame, inset)
	if not inset then inset = 0 end
	obj:SetPoint("TOPLEFT", frame, "TOPLEFT", inset, -inset)
	obj:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -inset, inset)
end

local function CreateOverlay(f)
	if f.overlay then return end
	
	local overlay = f:CreateTexture(f:GetName() and f:GetName().."Overlay" or nil, "BORDER", f)
	overlay:ClearAllPoints()
	overlay:Point("TOPLEFT", 2, -2)
	overlay:Point("BOTTOMRIGHT", -2, 2)
	overlay:SetTexture(C.media.blank)
	overlay:SetVertexColor(.05, .05, .05)
	f.overlay = overlay
end

local function FadeIn(f)
	UIFrameFadeIn(f, .4, f:GetAlpha(), 1)
end
	
local function FadeOut(f)
	UIFrameFadeOut(f, .8, f:GetAlpha(), 0)
end

local function OnMouseOver(bar, button, num, baralpha, fadealpha)
	if bar and bar:IsShown() then
		if not bar:EnableMouse() == true then
			bar:EnableMouse(true)
		end
	bar:SetAlpha(baralpha)
	bar:SetScript("OnEnter", function(self) self:SetAlpha(fadealpha) end)
	bar:SetScript("OnLeave", function(self) self:SetAlpha(baralpha) end)

		for i = 1, num do
			local btn = _G[button..i]
			btn:SetScript("OnEnter", function() bar:SetAlpha(fadealpha) end)
			btn:SetScript("OnLeave", function() bar:SetAlpha(baralpha) end)
		end
	end
end


local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.SetBorder then mt.SetBorder = SetBorder end
	if not object.AllPoints then mt.AllPoints = AllPoints end
	if not object.CreateOverlay then mt.CreateOverlay = CreateOverlay end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
	if not object.OnMouseOver then mt.OnMouseOver = OnMouseOver end
end

local handled = {["Frame"] = true}
local object = CreateFrame("Frame")
addapi(object)
addapi(object:CreateTexture())
addapi(object:CreateFontString())

object = EnumerateFrames()
while object do
	if not handled[object:GetObjectType()] then
		addapi(object)
		handled[object:GetObjectType()] = true
	end

	object = EnumerateFrames(object)
end