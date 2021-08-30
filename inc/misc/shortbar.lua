local SUI=CreateFrame("Frame")
SUI:RegisterEvent("PLAYER_LOGIN")
SUI:SetScript("OnEvent", function(self, event)

if not SUIDB.A_SHORTBAR == true then return end

local size = 38
local spacing = 5

local invisible = CreateFrame("Frame", nil)
invisible:EnableMouse(false)
invisible:Hide()

local BlizzArt = {
	MainMenuBarArtFrameBackground.BackgroundLarge,
	MainMenuBarArtFrameBackground.BackgroundSmall,
	MainMenuBarTexture0,
	MainMenuBarTexture1,
	MainMenuBarTexture2,
	MainMenuBarTexture3,
	MainMenuBarArtFrame.LeftEndCap,
	MainMenuBarArtFrame.RightEndCap,
	ActionBarUpButton,
	ActionBarDownButton,
	ReputationWatchBar,
	MainMenuExpBar,
	ArtifactWatchBar,
	HonorWatchBar,
	MainMenuBarArtFrame.PageNumber,
}

for _, frame in pairs(BlizzArt) do
	frame:SetParent(invisible)
	StatusTrackingBarManager:SetAlpha(0)
end

local holder = CreateFrame("Frame", "MainMenuBarHolderFrame", UIParent, "SecureHandlerStateTemplate")
holder:SetSize(size * 12 + spacing * 11, size)
holder:SetPoint("BOTTOM", UIParent, 0, 22)
holder:RegisterEvent("PLAYER_ENTERING_WORLD")
holder:SetScript("OnEvent", function() 
	ActionButton1:ClearAllPoints()
	ActionButton1:SetPoint("BOTTOMLEFT", holder, -5, 0)
	
	MultiBarBottomLeftButton1:ClearAllPoints()
	MultiBarBottomLeftButton1:SetPoint("BOTTOMLEFT", ActionButton1, "TOPLEFT", 0, 5)
	
	MultiBarBottomRightButton1:ClearAllPoints()
	MultiBarBottomRightButton1:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton1, "TOPLEFT", 0, 6)
	
	MultiBarBottomRightButton7:ClearAllPoints()
	MultiBarBottomRightButton7:SetPoint("BOTTOMLEFT", MultiBarBottomLeftButton7, "TOPLEFT", 0, 6)
	
	StanceBarFrame:ClearAllPoints();
	StanceBarFrame:SetMovable(true);
	StanceBarFrame:SetUserPlaced(true);
	StanceBarFrame:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1, "TOPLEFT", 10, 6);

	PetActionButton1:ClearAllPoints()
	PetActionButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1, "TOPLEFT", 25, 6)
	
	PossessButton1:ClearAllPoints()
	PossessButton1:SetPoint("BOTTOMLEFT", MultiBarBottomRightButton1, "TOPLEFT", 25, 30)
	
	for i = 1, NUM_ACTIONBAR_BUTTONS do
		local ab = _G["ActionButton" .. i]
		local mbbl = _G["MultiBarBottomLeftButton" .. i]
		local mbbr = _G["MultiBarBottomRightButton" .. i]
		local mbl = _G["MultiBarLeftButton" .. i]
		local mbr = _G["MultiBarRightButton" .. i]
		local pab = _G["PetActionButton" .. i]
		local mcab = _G["MultiCastActionButton" .. i]
		local pb = _G["PossessButton" .. i]
	
		ab:SetSize(size, size)
		mbbl:SetSize(size, size)
		mbbr:SetSize(size, size)
		mbl:SetSize(size, size)
		mbr:SetSize(size, size)
		if pb then pb:SetSize(size, size) end
	end
end)
end)