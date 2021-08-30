local event_frame = CreateFrame("Frame")
local errormessage_blocks = {
    "Ability is not ready yet",
    "Another action is in progress",
    "Can't attack while mounted",
    "Can't do that while moving",
    "Item is not ready yet",
    "Not enough",
    "Nothing to attack",
    "Spell is not ready yet",
    "You have no target",
    "You can't do that yet"
}
local enable
local onevent
local uierrorsframe_addmessage
local old_uierrosframe_addmessage
function enable()
    old_uierrosframe_addmessage = UIErrorsFrame.AddMessage
    UIErrorsFrame.AddMessage = uierrorsframe_addmessage
end

function uierrorsframe_addmessage(frame, text, red, green, blue, id)
    for i, v in ipairs(errormessage_blocks) do
        if text and text:match(v) then
            return
        end
    end
    old_uierrosframe_addmessage(frame, text, red, green, blue, id)
end

function onevent(frame, event, ...)
    if event == "PLAYER_LOGIN" then
        enable()
    end
end
event_frame:SetScript("OnEvent", onevent)
event_frame:RegisterEvent("PLAYER_LOGIN")

SlashCmdList["RELOAD"] = function()
    ReloadUI()
end
SLASH_RELOAD1 = "/rl"

local f = CreateFrame("Frame")
function f:OnEvent(event, addon)
    if not SUIDB.A_TALKINGHEAD == true then
        if addon == "Blizzard_TalkingHeadUI" then
            hooksecurefunc(
                "TalkingHeadFrame_PlayCurrent",
                function()
                    TalkingHeadFrame:Hide()
                end
            )
            self:UnregisterEvent(event)
        end
    end
end
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)

local CF = CreateFrame("Frame")
CF:RegisterEvent("PLAYER_ENTERING_WORLD")
CF:RegisterEvent("GROUP_ROSTER_UPDATE")

function ColorRaid()
    for g = 1, NUM_RAID_GROUPS do
        local group = _G["CompactRaidGroup" .. g .. "BorderFrame"]
        if group then
            for _, region in pairs({group:GetRegions()}) do
                if region:IsObjectType("Texture") then
                    region:SetVertexColor(.15, .15, .15)
                end
            end
        end
        for m = 1, 5 do
            local frame = _G["CompactRaidGroup" .. g .. "Member" .. m]
            if frame then
                groupcolored = true
                for _, region in pairs({frame:GetRegions()}) do
                    if region:GetName():find("Border") then
                        region:SetVertexColor(.15, .15, .15)
                    end
                end
            end
            local frame = _G["CompactRaidFrame" .. m]
            if frame then
                singlecolored = true
                for _, region in pairs({frame:GetRegions()}) do
                    if region:GetName():find("Border") then
                        region:SetVertexColor(.15, .15, .15)
                    end
                end
            end
        end
    end
    for _, region in pairs({CompactRaidFrameContainerBorderFrame:GetRegions()}) do
        if region:IsObjectType("Texture") then
            region:SetVertexColor(.15, .15, .15)
        end
    end
end

CF:SetScript(
    "OnEvent",
    function(self, event)
        if SUIDB.A_DARKFRAMES == true then
            ColorRaid()
            CF:SetScript(
                "OnUpdate",
                function()
                    if CompactRaidGroup1 and not groupcolored == true then
                        ColorRaid()
                    end
                    if CompactRaidFrame1 and not singlecolored == true then
                        ColorRaid()
                    end
                end
            )
            if event == "GROUP_ROSTER_UPDATE" then
                return
            end
            if
                not (IsAddOnLoaded("Shadowed Unit Frames") or IsAddOnLoaded("PitBull Unit Frames 4.0") or
                IsAddOnLoaded("X-Perl UnitFrames"))
            then
                for i, v in pairs(
                    {
                        PlayerFrameTexture,
                        TargetFrameTextureFrameTexture,
                        PlayerFrameAlternateManaBarBorder,
                        PlayerFrameAlternateManaBarLeftBorder,
                        PlayerFrameAlternateManaBarRightBorder,
                        PaladinPowerBarFrameBG,
                        PaladinPowerBarFrameBankBG,
                        ComboPointPlayerFrame.Background,
                        ComboPointPlayerFrame.Combo1.PointOff,
                        ComboPointPlayerFrame.Combo2.PointOff,
                        ComboPointPlayerFrame.Combo3.PointOff,
                        ComboPointPlayerFrame.Combo4.PointOff,
                        ComboPointPlayerFrame.Combo5.PointOff,
                        ComboPointPlayerFrame.Combo6.PointOff,
                        AlternatePowerBarBorder,
                        AlternatePowerBarLeftBorder,
                        AlternatePowerBarRightBorder,
                        PetFrameTexture,
                        PartyMemberFrame1Texture,
                        PartyMemberFrame2Texture,
                        PartyMemberFrame3Texture,
                        PartyMemberFrame4Texture,
                        PartyMemberFrame1PetFrameTexture,
                        PartyMemberFrame2PetFrameTexture,
                        PartyMemberFrame3PetFrameTexture,
                        PartyMemberFrame4PetFrameTexture,
                        FocusFrameTextureFrameTexture,
                        TargetFrameToTTextureFrameTexture,
                        FocusFrameToTTextureFrameTexture,
                        Boss1TargetFrameTextureFrameTexture,
                        Boss2TargetFrameTextureFrameTexture,
                        Boss3TargetFrameTextureFrameTexture,
                        Boss4TargetFrameTextureFrameTexture,
                        Boss5TargetFrameTextureFrameTexture,
                        Boss1TargetFrameSpellBar.Border,
                        Boss2TargetFrameSpellBar.Border,
                        Boss3TargetFrameSpellBar.Border,
                        Boss4TargetFrameSpellBar.Border,
                        Boss5TargetFrameSpellBar.Border,
                        CastingBarFrame.Border,
                        FocusFrameSpellBar.Border,
                        TargetFrameSpellBar.Border,
                        StatusTrackingBarManager.SingleBarLargeUpper,
                        StatusTrackingBarManager.SingleBarSmallUpper,
                    }
                ) do
                    v:SetVertexColor(.15, .15, .15)
                end

                for _, region in pairs({StopwatchFrame:GetRegions()}) do
                    region:SetVertexColor(.15, .15, .15)
                end

                for _, region in pairs({CompactRaidFrameManager:GetRegions()}) do
                    if region:IsObjectType("Texture") then
                        region:SetVertexColor(.15, .15, .15)
                    end
                end
                for _, region in pairs({CompactRaidFrameManagerContainerResizeFrame:GetRegions()}) do
                    if region:GetName():find("Border") then
                        region:SetVertexColor(.15, .15, .15)
                    end
                end
                CompactRaidFrameManagerToggleButton:SetNormalTexture(
                    "Interface\\AddOns\\SUI\\inc\\media\\raid\\RaidPanel-Toggle"
                )

                for i, v in pairs(
                    {
                        PlayerPVPIcon,
                        TargetFrameTextureFramePVPIcon,
                        FocusFrameTextureFramePVPIcon
                    }
                ) do
                    v:SetAlpha(0)
                end
                for i = 1, 4 do
                    _G["PartyMemberFrame" .. i .. "PVPIcon"]:SetAlpha(0)
                    _G["PartyMemberFrame" .. i .. "NotPresentIcon"]:Hide()
                    _G["PartyMemberFrame" .. i .. "NotPresentIcon"].Show = function()
                    end
                end
                PlayerFrameGroupIndicator:SetAlpha(0)
                PlayerHitIndicator:SetText(nil)
                PlayerHitIndicator.SetText = function()
                end
                PetHitIndicator:SetText(nil)
                PetHitIndicator.SetText = function()
                end
                for _, child in pairs({WarlockPowerFrame:GetChildren()}) do
                    for _, region in pairs({child:GetRegions()}) do
                        if region:GetDrawLayer() == "BORDER" then
                            region:SetVertexColor(.15, .15, .15)
                        end
                    end
                end
            else
                CastingBarFrameBorder:SetVertexColor(.15, .15, .15)
            end

            for i, v in pairs(
                {
                    MicroButtonAndBagsBar.MicroBagBar,
                    MainMenuBarArtFrameBackground.BackgroundLarge,
                    MainMenuBarArtFrameBackground.BackgroundLarge2,
                    MainMenuBarArtFrameBackground.BackgroundSmall,
                    MainMenuBarArtFrameBackground.BagsArt,
                    MainMenuBarArtFrameBackground.MicroButtonArt,
                    StatusTrackingBarManager.SingleBarLarge,
                    StatusTrackingBarManager.SingleBarSmall,
                    SlidingActionBarTexture0,
                    SlidingActionBarTexture1,
                    MainMenuBarTexture0,
                    MainMenuBarTexture1,
                    MainMenuBarTexture2,
                    MainMenuBarTexture3,
                    MainMenuMaxLevelBar0,
                    MainMenuMaxLevelBar1,
                    MainMenuMaxLevelBar2,
                    MainMenuMaxLevelBar3,
                    MainMenuXPBarTextureLeftCap,
                    MainMenuXPBarTextureRightCap,
                    MainMenuXPBarTextureMid,
                    ReputationWatchBarTexture0,
                    ReputationWatchBarTexture1,
                    ReputationWatchBarTexture2,
                    ReputationWatchBarTexture3,
                    ReputationXPBarTexture0,
                    ReputationXPBarTexture1,
                    ReputationXPBarTexture2,
                    ReputationXPBarTexture3,
                }
            ) do
                v:SetVertexColor(.2, .2, .2)
            end
            for i, v in pairs(
                {
                    MainMenuBarArtFrame.LeftEndCap,
                    MainMenuBarArtFrame.RightEndCap,
                    StanceBarLeft,
                    StanceBarMiddle,
                    StanceBarRight
                }
            ) do
                v:SetVertexColor(.2, .2, .2)
            end
        end
    end
)

if (IsAddOnLoaded("ClassicUI")) then
   
end

local CF = CreateFrame("Frame")
local _, instanceType = IsInInstance()
CF:RegisterEvent("ADDON_LOADED")
CF:RegisterEvent("PLAYER_ENTERING_WORLD")
CF:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
CF:SetScript(
    "OnEvent",
    function(self, event, addon)
        if SUIDB.A_DARKFRAMES == true then
            if addon == "Blizzard_ArenaUI" and not (IsAddOnLoaded("Shadowed Unit Frames")) then
                for i, v in pairs(
                    {
                        ArenaEnemyFrame1Texture,
                        ArenaEnemyFrame2Texture,
                        ArenaEnemyFrame3Texture,
                        ArenaEnemyFrame4Texture,
                        ArenaEnemyFrame5Texture,
                        ArenaEnemyFrame1SpecBorder,
                        ArenaEnemyFrame2SpecBorder,
                        ArenaEnemyFrame3SpecBorder,
                        ArenaEnemyFrame4SpecBorder,
                        ArenaEnemyFrame5SpecBorder,
                        ArenaEnemyFrame1PetFrameTexture,
                        ArenaEnemyFrame2PetFrameTexture,
                        ArenaEnemyFrame3PetFrameTexture,
                        ArenaEnemyFrame4PetFrameTexture,
                        ArenaEnemyFrame5PetFrameTexture
                    }
                ) do
                    v:SetVertexColor(.15, .15, .15)
                end
            elseif
                event == "ARENA_PREP_OPPONENT_SPECIALIZATIONS" or (event == "PLAYER_ENTERING_WORLD" and instanceType == "arena")
            then
                for i, v in pairs(
                    {
                        ArenaPrepFrame1Texture,
                        ArenaPrepFrame2Texture,
                        ArenaPrepFrame3Texture,
                        ArenaPrepFrame4Texture,
                        ArenaPrepFrame5Texture,
                        ArenaPrepFrame1SpecBorder,
                        ArenaPrepFrame2SpecBorder,
                        ArenaPrepFrame3SpecBorder,
                        ArenaPrepFrame4SpecBorder,
                        ArenaPrepFrame5SpecBorder
                    }
                ) do
                    v:SetVertexColor(.15, .15, .15)
                end
            end

            if IsAddOnLoaded("Blizzard_ArenaUI") then
                for i, v in pairs(
                    {
                        ArenaEnemyFrame1Texture,
                        ArenaEnemyFrame2Texture,
                        ArenaEnemyFrame3Texture,
                        ArenaEnemyFrame4Texture,
                        ArenaEnemyFrame5Texture,
                        ArenaEnemyFrame1SpecBorder,
                        ArenaEnemyFrame2SpecBorder,
                        ArenaEnemyFrame3SpecBorder,
                        ArenaEnemyFrame4SpecBorder,
                        ArenaEnemyFrame5SpecBorder,
                        ArenaEnemyFrame1PetFrameTexture,
                        ArenaEnemyFrame2PetFrameTexture,
                        ArenaEnemyFrame3PetFrameTexture,
                        ArenaEnemyFrame4PetFrameTexture,
                        ArenaEnemyFrame5PetFrameTexture
                    }
                ) do
                    v:SetVertexColor(.15, .15, .15)
                end
            end
        end
    end
)