local T, C, L = unpack(Tukui)

---Stolen from Pat
-- API stuff

local function CreateBorders(self)
	if(self:GetFrameStrata() == "BACKGROUND") then self:SetFrameStrata("LOW") end

	local border = CreateFrame("Frame", nil, self)
	border:SetPoint("TOPLEFT", self, "TOPLEFT", T.Scale(-2), T.Scale(2))
	border:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", T.Scale(2), T.Scale(-2))
	border:SetTemplate("Default")
	border:SetFrameLevel(self:GetFrameLevel())
	border:ThickBorder()
end

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

local function CreateOverlay(f)
	if f.overlay then return end

	local overlay = f:CreateTexture(f:GetName() and f:GetName().."Overlay" or nil, "BORDER", f)
	overlay:ClearAllPoints()
	overlay:Point("TOPLEFT", 2, -2)
	overlay:Point("BOTTOMRIGHT", -2, 2)
	overlay:SetTexture(C["media"].normTex)
	overlay:SetVertexColor(unpack(C["media"].bordercolor))
	f.overlay = overlay
end

local function AllPoints(obj, frame, inset)
	if not inset then inset = 0 end
	obj:SetPoint("TOPLEFT", frame, "TOPLEFT", inset, -inset)
	obj:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -inset, inset)
end

local function FadeIn(f)
	UIFrameFadeIn(f, .4, f:GetAlpha(), 1)
end
	
local function FadeOut(f)
	UIFrameFadeOut(f, .8, f:GetAlpha(), 0)
end

local function innerBorder(f)
	if f.innerborder then f.innerborder:Show() return end
	f.innerborder = CreateFrame("Frame", nil, f)
	f.innerborder:SetPoint("TOPLEFT", T.mult, -T.mult)
	f.innerborder:SetPoint("BOTTOMRIGHT", -T.mult, T.mult)
	f.innerborder:SetBackdrop({
		edgeFile = C["media"].blank, 
		edgeSize = T.mult, 
		insets = { left = T.mult, right = T.mult, top = T.mult, bottom = T.mult }
	})
	f.innerborder:SetBackdropBorderColor(0,0,0)
	
end

local function outerBorder(f)
	if f.outerborder then f.outerborder:Show() return end
	f.outerborder = CreateFrame("Frame", nil, f)
	f.outerborder:SetPoint("TOPLEFT", -T.mult, T.mult)
	f.outerborder:SetPoint("BOTTOMRIGHT", T.mult, -T.mult)
	f.outerborder:SetBackdrop({
		edgeFile = C["media"].blank, 
		edgeSize = T.mult, 
		insets = { left = T.mult, right = T.mult, top = T.mult, bottom = T.mult }
	})
	f.outerborder:SetBackdropBorderColor(0,0,0)
	
end

local function ThickBorder(f, force)
	if f.backdrop and not force then
		outerBorder(f.backdrop)
		innerBorder(f.backdrop)
	else
		outerBorder(f)
		innerBorder(f)
	end
end

local function addapi(object)
	local mt = getmetatable(object).__index
	if not object.CreateBorder then mt.CreateBorder = CreateBorder end
	if not object.CreateBorders then mt.CreateBorders = CreateBorders end
	if not object.CreateOverlay then mt.CreateOverlay = CreateOverlay end
	if not object.AllPoints then mt.AllPoints = AllPoints end
	if not object.FadeIn then mt.FadeIn = FadeIn end
	if not object.FadeOut then mt.FadeOut = FadeOut end
	if not object.ThickBorder then mt.ThickBorder = ThickBorder end
	if not object.InnerBorder then mt.Innerborder = innerBorder end
	if not object.OuterBorder then mt.Outerborder = outerBorder end
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
