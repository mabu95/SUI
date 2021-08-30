local Locked = true;
local Frames = { 
	"PlayerFrame", 
	"TargetFrame", 
	"FocusFrame", 
	"ObjectiveTrackerFrame", 
	"MinimapCluster",
	"MenuFrame",
	"CastingBarFrame",
	"TargetFrameSpellBar"
}
  
-- Drag
function dragFrame(frame)
	self = _G[frame]
	local dragFrame = CreateFrame("Frame", "DragFrame", self)
	dragFrame:SetAllPoints(self)
	dragFrame:SetFrameStrata("HIGH")
	dragFrame:SetHitRectInsets(0,0,0,0)
	dragFrame:SetScript("OnDragStart", function(self) if IsAltKeyDown() then self:GetParent():StartMoving() end end)
	dragFrame:SetScript("OnDragStop", function(self) self:GetParent():StopMovingOrSizing() end)
	dragFrame:SetScript("OnMouseDown", function (self, button)
		if IsShiftKeyDown() then
			if (button == "LeftButton") then 
				self:GetParent():SetScale(self:GetParent():GetScale() + 0.1)
			elseif (button == "RightButton") then
				self:GetParent():SetScale(self:GetParent():GetScale() - 0.1)
			end
		end
	end)

	dragFrame.texture = dragFrame:CreateTexture("ARTWORK")
	dragFrame.texture:SetAllPoints(dragFrame)
	dragFrame.texture:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background")
	dragFrame.texture:SetColorTexture(.035, .035, .035, .3)

    dragFrame.texture.text = dragFrame.text or dragFrame:CreateFontString(nil, "ARTWORK", "QuestMapRewardsFont")
	dragFrame.texture.text:SetAllPoints(true)
	dragFrame.texture.text:SetJustifyH("TOP")
	dragFrame.texture.text:SetJustifyV("TOP")
    dragFrame.texture.text:SetText(self:GetName())
	dragFrame.texture.text:SetFont("Fonts\\FRIZQT__.TTF", 14, "THICKOUTLINE")

	dragFrame:Hide()
	self.dragframe = dragFrame
	self:SetClampedToScreen(true)
	self:SetMovable(true)
	self:SetUserPlaced(true)
end

-- Grid
local grid
local function Grid()
	if grid then
		grid:Hide()
		grid = nil
	else
		grid = CreateFrame('Frame', nil, UIParent)
		grid:SetAllPoints(UIParent)
		local w = GetScreenWidth() / 64
		local h = GetScreenHeight() / 36
		for i = 0, 64 do
			local t = grid:CreateTexture(nil, 'BACKGROUND')
			if i == 32 then
				t:SetColorTexture(1, 1, 0, 0.5)
			else
				t:SetColorTexture(1, 1, 1, 0.15)
			end
			t:SetPoint('TOPLEFT', grid, 'TOPLEFT', i * w - 1, 0)
			t:SetPoint('BOTTOMRIGHT', grid, 'BOTTOMLEFT', i * w + 1, 0)
			grid:SetFrameStrata("HIGH")
		end
		for i = 0, 36 do
			local t = grid:CreateTexture(nil, 'BACKGROUND')
			if i == 18 then
				t:SetColorTexture(1, 1, 0, 0.5)
			else
				t:SetColorTexture(1, 1, 1, 0.15)
			end
			t:SetPoint('TOPLEFT', grid, 'TOPLEFT', 0, -i * h + 1)
			t:SetPoint('BOTTOMRIGHT', grid, 'TOPRIGHT', 0, -i * h - 1)
			grid:SetFrameStrata("LOW")
		end
		
	end
end

-- Unlock
local function unlockFrame(frame)	
	
	CastingBarFrame:Show()

	local function testhook()
		if not (Locked) then
			print('test')
			CastingBarFrame:Show()
			TargetFrameSpellBar:Show()
		end
	end

	self = _G[frame]
	if not self:IsUserPlaced() then return end
	if (Locked) then
		self:Show()
		self.dragframe:Show()
		self.dragframe:EnableMouse(true)
		self.dragframe:RegisterForDrag("LeftButton")
		self.dragframe:SetScript("OnEnter", function(self)
		  GameTooltip:SetOwner(self, "ANCHOR_TOP")
		  GameTooltip:AddLine(self:GetParent():GetName(), 0, 1, 0.5, 1, 1, 1)
		  GameTooltip:AddLine("Hold down ALT to drag!", 1, 1, 1, 1, 1, 1)
		  GameTooltip:Show()
		end)
		self.dragframe:SetScript("OnLeave", function() GameTooltip:Hide() end)

        CastingBarFrame:HookScript("OnEvent", testhook)
        TargetFrameSpellBar:HookScript("OnEvent", testhook)

	else
		self.dragframe:Hide()
		CastingBarFrame:SetScript("OnUpdate", nil)
		TargetFrameSpellBar:SetScript("OnUpdate", nil)
	end
end

-- Init
for i , v in pairs (Frames) do dragFrame(v) end

-- Slash
SLASH_DRAG1 = '/drag'
function SlashCmdList.DRAG()
	if (Locked) then
		Grid()
		for i , v in pairs (Frames) do unlockFrame(v) end
		Locked = false
	else 
		Grid()
		for i , v in pairs (Frames) do unlockFrame(v) end
		Locked = true
	end
end