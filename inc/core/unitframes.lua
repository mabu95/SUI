local SUI=CreateFrame("Frame")
SUI:RegisterEvent("PLAYER_LOGIN")
SUI:SetScript("OnEvent", function(self, event)

        -- CLASS COLORS
        function SUIUnitClass(healthbar, unit)
            if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) and (SUIDB.UNITFRAMES.CLASSCOLOR) then
                _, class = UnitClass(unit);
                local c = RAID_CLASS_COLORS[class];
                healthbar:SetStatusBarColor(c.r, c.g, c.b);
            elseif UnitIsPlayer(unit) and (not UnitIsConnected(unit)) then
                healthbar:SetStatusBarColor(0.5,0.5,0.5);
            else
                healthbar:SetStatusBarColor(0,0.9,0);
            end
        end
        hooksecurefunc("UnitFrameHealthBar_Update", SUIUnitClass)
        hooksecurefunc("HealthBar_OnValueChanged", function(self)
            SUIUnitClass(self, self.unit)
        end)

        -- FACTION COLORS
        function SUIUnitReaction(healthbar, unit)
            if UnitExists(unit) and (not UnitIsPlayer(unit)) then
                if (UnitIsTapDenied(unit)) and not UnitPlayerControlled(unit) then
                    healthbar:SetStatusBarColor(0.5, 0.5, 0.5)
                elseif (not UnitIsTapDenied(unit)) then
                    local reaction = FACTION_BAR_COLORS[UnitReaction(unit,"player")];
                    if reaction then
                        healthbar:SetStatusBarColor(reaction.r, reaction.g, reaction.b);
                    else
                        healthbar:SetStatusBarColor(0,0.6,0.1)
                    end
                end
            end
        end
        hooksecurefunc("UnitFrameHealthBar_Update", SUIUnitReaction)
        hooksecurefunc("HealthBar_OnValueChanged", function(self)
            SUIUnitReaction(self, self.unit)
        end)

        --HIDE STUFF
        hooksecurefunc("PlayerFrame_UpdateStatus",function()
            if (SUIDB.A_UNITFRAMES) then
                PlayerStatusTexture:Hide()
                PlayerRestGlow:Hide()
                PlayerStatusGlow:Hide()
            end
            if (SUIDB.UNITFRAMES.HIDESTUFF) then
                PlayerPrestigeBadge:SetAlpha(0)
                PlayerPrestigePortrait:SetAlpha(0)
                TargetFrameTextureFramePrestigeBadge:SetAlpha(0)
                TargetFrameTextureFramePrestigePortrait:SetAlpha(0)
                FocusFrameTextureFramePrestigeBadge:SetAlpha(0)
                FocusFrameTextureFramePrestigePortrait:SetAlpha(0)
            end
        end)

        if (SUIDB.UNITFRAMES.HIDEBACK) then
            hooksecurefunc('TargetFrame_CheckFaction', function(self)
                self.nameBackground:SetVertexColor(0.0, 0.0, 0.0, 0.5);
            end)
        end

        -- START CUSTOM UNITFRAMES
        if (SUIDB.A_UNITFRAMES) then

        -- PLAYER
        function SUIPlayerFrame(self)
            if (SUIDB.A_TEXTURES) then
                self.healthbar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                self.healthbar.AnimatedLossBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                PlayerFrameMyHealPredictionBar:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                PlayerFrameAlternateManaBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                PlayerFrameManaBar.FeedbackFrame.BarTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                PlayerFrameManaBar.FeedbackFrame.LossGlowTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                PlayerFrameManaBar.FeedbackFrame.GainGlowTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
            end
            PlayerFrameTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-TargetingFrame");
            self.name:Hide();
            self.name:ClearAllPoints();
            self.name:SetPoint("CENTER", PlayerFrame, "CENTER",50.5, 36);
            self.healthbar:SetPoint("TOPLEFT",106,-24);
            self.healthbar:SetHeight(26);
            self.healthbar.LeftText:ClearAllPoints();
            self.healthbar.LeftText:SetPoint("LEFT",self.healthbar,"LEFT",8,0);
            self.healthbar.RightText:ClearAllPoints();
            self.healthbar.RightText:SetPoint("RIGHT",self.healthbar,"RIGHT",-5,0);
            self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
            self.manabar:SetPoint("TOPLEFT",106,-52);
            self.manabar:SetHeight(13);
            self.manabar.LeftText:ClearAllPoints();
            self.manabar.LeftText:SetPoint("LEFT",self.manabar,"LEFT",8,0)		;
            self.manabar.RightText:ClearAllPoints();
            self.manabar.RightText:SetPoint("RIGHT",self.manabar,"RIGHT",-5,0);
            self.manabar.TextString:SetPoint("CENTER",self.manabar,"CENTER",0,0);
            self.manabar.FullPowerFrame.SpikeFrame.AlertSpikeStay:ClearAllPoints();
            self.manabar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetPoint("CENTER", self.manabar.FullPowerFrame, "RIGHT", -6, -3);
            self.manabar.FullPowerFrame.SpikeFrame.AlertSpikeStay:SetSize(30,29);
            self.manabar.FullPowerFrame.PulseFrame:ClearAllPoints();
            self.manabar.FullPowerFrame.PulseFrame:SetPoint("CENTER", self.manabar.FullPowerFrame,"CENTER",-6,-2);
            self.manabar.FullPowerFrame.SpikeFrame.BigSpikeGlow:ClearAllPoints();
            self.manabar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetPoint("CENTER",self.manabar.FullPowerFrame,"RIGHT",5,-4);
            self.manabar.FullPowerFrame.SpikeFrame.BigSpikeGlow:SetSize(30,50);
            PlayerFrameGroupIndicatorText:ClearAllPoints();
            PlayerFrameGroupIndicatorText:SetPoint("BOTTOMLEFT", PlayerFrame,"TOP",0,-20);
            PlayerFrameGroupIndicatorLeft:Hide();
            PlayerFrameGroupIndicatorMiddle:Hide();
            PlayerFrameGroupIndicatorRight:Hide();
        end
        hooksecurefunc("PlayerFrame_ToPlayerArt", SUIPlayerFrame)

        -- TARGET
        function SUITargetFrame (self, forceNormalTexture)
            local classification = UnitClassification(self.unit);
            self.highLevelTexture:SetPoint("CENTER", self.levelText, "CENTER", 0,0);
            self.deadText:SetPoint("CENTER", self.healthbar, "CENTER",0,0);
            self.nameBackground:Hide();
            self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
            self.name:SetPoint("LEFT", self, 15, 36);
            self.healthbar:SetSize(119, 26);
            self.healthbar:SetPoint("TOPLEFT", 5, -24);
            self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 8, 0);
            self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -5, 0);
            self.healthbar.TextString:SetPoint("CENTER", self.healthbar, "CENTER", 0, 0);
            self.manabar:SetPoint("TOPLEFT", 5, -52);
            self.manabar:SetSize(119, 13);
            self.manabar.LeftText:SetPoint("LEFT", self.manabar, "LEFT", 8, 0);
            self.manabar.RightText:ClearAllPoints();
            self.manabar.RightText:SetPoint("RIGHT", self.manabar, "RIGHT", -5, 0);
            self.manabar.TextString:SetPoint("CENTER", self.manabar, "CENTER", 0, 0);
            if TargetFrame.threatNumericIndicator:IsShown() then
                TargetFrame.threatNumericIndicator:SetPoint("BOTTOM", PlayerFrame, "TOP", 72, -21);
            end
            FocusFrame.threatNumericIndicator:SetAlpha(0);
            if ( forceNormalTexture ) then
                self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame");
            elseif ( classification == "minus" ) then
                self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus");
                forceNormalTexture = true;
            elseif ( classification == "worldboss" or classification == "elite" ) then
                self.borderTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-TargetingFrame-Elite");
            elseif ( classification == "rareelite" ) then
                self.borderTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-TargetingFrame-Rare-Elite");
            elseif ( classification == "rare" ) then
                self.borderTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-TargetingFrame-Rare");
            else
                self.borderTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-TargetingFrame");
                forceNormalTexture = true;
            end
            if ( forceNormalTexture ) then
                self.haveElite = nil;
                if ( classification == "minus" ) then
                    self.Background:SetSize(119,12);
                    self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 47);
                    self.name:SetPoint("LEFT", self, 16, 19);
                    self.healthbar:ClearAllPoints();
                    self.healthbar:SetPoint("LEFT", 5, 3);
                    self.healthbar:SetHeight(12);
                    self.healthbar.LeftText:SetPoint("LEFT", self.healthbar, "LEFT", 3, 0);
                    self.healthbar.RightText:SetPoint("RIGHT", self.healthbar, "RIGHT", -2, 0);
                else
                    self.Background:SetSize(119,42);
                    self.Background:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", 7, 35);
                end
                if ( self.threatIndicator ) then
                    if ( classification == "minus" ) then
                        self.threatIndicator:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Minus-Flash");
                        self.threatIndicator:SetTexCoord(0, 1, 0, 1);
                        self.threatIndicator:SetWidth(256);
                        self.threatIndicator:SetHeight(128);
                        self.threatIndicator:SetPoint("TOPLEFT", self, "TOPLEFT", -24, 0);
                    else
                        self.threatIndicator:SetTexCoord(0, 0.9453125, 0, 0.181640625);
                        self.threatIndicator:SetWidth(242);
                        self.threatIndicator:SetHeight(93);
                        self.threatIndicator:SetPoint("TOPLEFT", self, "TOPLEFT", -24, 0);
                    end
                end
            else
                self.haveElite = true;
                self.Background:SetSize(119,42);
                if ( self.threatIndicator ) then
                    self.threatIndicator:SetTexCoord(0, 0.9453125, 0.181640625, 0.400390625);
                    self.threatIndicator:SetWidth(242);
                    self.threatIndicator:SetHeight(112);
                end
            end
            self.healthbar.lockColor = true;
            if ( SUIDB.A_TEXTURES ) then
                self.healthbar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                TargetFrameMyHealPredictionBar:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
            end
        end
        hooksecurefunc("TargetFrame_CheckClassification", SUITargetFrame)

        -- TEXTURE
        function SUIManaTexture (manaBar)
            local powerType, powerToken, altR, altG, altB = UnitPowerType(manaBar.unit);
            local info = PowerBarColor[powerToken];
            if ( info ) then
                if ( not manaBar.lockColor ) then
                    if not ( info.atlas ) and ( SUIDB.A_TEXTURES ) then
                        manaBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                    end
                end
            end
        end
        hooksecurefunc("UnitFrameManaBar_UpdateType", SUIManaTexture)

        -- ToT
        function SUIToTFrame()
            if (SUIDB.A_TEXTURES) then
                TargetFrameToTHealthBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                TargetFrameToTManaBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
            end
            TargetFrameToTTextureFrameDeadText:ClearAllPoints();
            TargetFrameToTTextureFrameDeadText:SetPoint("CENTER", "TargetFrameToTHealthBar","CENTER",1, 0);
            TargetFrameToTTextureFrameName:SetSize(65,10);
            TargetFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-TargetofTargetFrame");
            TargetFrameToTHealthBar:ClearAllPoints();
            TargetFrameToTHealthBar:SetPoint("TOPLEFT", 45, -15);
            TargetFrameToTHealthBar:SetHeight(10);
            TargetFrameToTManaBar:ClearAllPoints();
            TargetFrameToTManaBar:SetPoint("TOPLEFT", 45, -25);
            TargetFrameToTManaBar:SetHeight(5);
            FocusFrameToTTextureFrameDeadText:ClearAllPoints();
            FocusFrameToTTextureFrameDeadText:SetPoint("CENTER", "FocusFrameToTHealthBar" ,"CENTER",1, 0);
            FocusFrameToTTextureFrameName:SetSize(65,10);
            FocusFrameToTTextureFrameTexture:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-TargetofTargetFrame");
            FocusFrameToTHealthBar:ClearAllPoints();
            FocusFrameToTHealthBar:SetPoint("TOPLEFT", 43, -15);
            FocusFrameToTHealthBar:SetHeight(10);
            FocusFrameToTManaBar:ClearAllPoints();
            FocusFrameToTManaBar:SetPoint("TOPLEFT", 43, -25);
            FocusFrameToTManaBar:SetHeight(5);
        end
        hooksecurefunc("TargetFrame_CheckClassification", SUIToTFrame)

        --PET
        if (SUIDB.A_TEXTURES) then
            PetFrameHealthBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
            PetFrameManaBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
        end
        PetFrameHealthBar:ClearAllPoints()
        PetFrameHealthBar:SetPoint("TOPLEFT", 45, -22)
        PetFrameHealthBar:SetHeight(10)
        PetFrameManaBar:ClearAllPoints()
        PetFrameManaBar:SetPoint("TOPLEFT", 45, -32)
        PetFrameManaBar:SetHeight(5)

        -- BOSS
        function SUIBossFrames()
            for i = 1, MAX_BOSS_FRAMES do
                if (SUIDB.A_TEXTURES) then
                    _G["Boss"..i.."TargetFrameHealthBar"]:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                    _G["Boss"..i.."TargetFrameManaBar"]:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                end
                _G["Boss"..i.."TargetFrameTextureFrameDeadText"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameTextureFrameDeadText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameHealthBar"],"CENTER",0,0);
                _G["Boss"..i.."TargetFrameTextureFrameName"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameTextureFrameName"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameManaBar"],"CENTER",0,0);
                _G["Boss"..i.."TargetFrameTextureFrameTexture"]:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-UNITFRAME-BOSS");
                _G["Boss"..i.."TargetFrameNameBackground"]:Hide();
                _G["Boss"..i.."TargetFrameHealthBar"]:SetSize(116,18);
                _G["Boss"..i.."TargetFrameHealthBar"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameHealthBar"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-51,18);
                _G["Boss"..i.."TargetFrameManaBar"]:SetSize(116,18);
                _G["Boss"..i.."TargetFrameManaBar"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameManaBar"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrame"],"CENTER",-51,-3);
                _G["Boss"..i.."TargetFrameTextureFrameHealthBarTextLeft"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameTextureFrameHealthBarTextLeft"]:SetPoint("LEFT",_G["Boss"..i.."TargetFrameHealthBar"],"LEFT",0,0);
                _G["Boss"..i.."TargetFrameTextureFrameHealthBarTextRight"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameTextureFrameHealthBarTextRight"]:SetPoint("RIGHT",_G["Boss"..i.."TargetFrameHealthBar"],"RIGHT",0,0);
                _G["Boss"..i.."TargetFrameTextureFrameHealthBarText"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameTextureFrameHealthBarText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameHealthBar"],"CENTER",0,0);
                _G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:SetPoint("LEFT",_G["Boss"..i.."TargetFrameManaBar"],"LEFT",0,0);
                _G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:SetPoint("RIGHT",_G["Boss"..i.."TargetFrameManaBar"],"RIGHT",0,0);
                _G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:ClearAllPoints();
                _G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:SetPoint("CENTER",_G["Boss"..i.."TargetFrameManaBar"],"CENTER",0,0);
            end
        end
        function SUIBossFramesText()
            for i = 1, MAX_BOSS_FRAMES do
                _G["Boss"..i.."TargetFrameTextureFrameManaBarTextLeft"]:SetText(" ");
                _G["Boss"..i.."TargetFrameTextureFrameManaBarTextRight"]:SetText(" ");
                _G["Boss"..i.."TargetFrameTextureFrameManaBarText"]:SetText(" ");
            end
        end
        hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", SUIBossFramesText)
        SUIBossFrames();

        --	VEHICLE.
        function SUIVehicleFrame(self, vehicleType)
            if ( vehicleType == "Natural" ) then
                PlayerFrameVehicleTexture:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Organic");
                PlayerFrameFlash:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Organic-Flash");
                PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86);
                self.healthbar:SetSize(103,12);
                self.healthbar:SetPoint("TOPLEFT",116,-41);
                self.manabar:SetSize(103,12);
                self.manabar:SetPoint("TOPLEFT",116,-52);
            else
                PlayerFrameVehicleTexture:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame");
                PlayerFrameFlash:SetTexture("Interface\\Vehicles\\UI-Vehicle-Frame-Flash");
                PlayerFrameFlash:SetTexCoord(-0.02, 1, 0.07, 0.86);
                self.healthbar:SetSize(100,12);
                self.healthbar:SetPoint("TOPLEFT",119,-41);
                self.manabar:SetSize(100,12);
                self.manabar:SetPoint("TOPLEFT",119,-52);
            end
            PlayerName:SetPoint("CENTER",50,23);
            PlayerFrameBackground:SetWidth(114);
        end
        hooksecurefunc("PlayerFrame_ToVehicleArt", SUIVehicleFrame)

        -- TEXT FORMAT
        hooksecurefunc("TextStatusBar_UpdateTextStringWithValues",function(self,_,value,_,maxValue)
            if self.RightText and value and maxValue>0 and not self.showPercentage and GetCVar("statusTextDisplay")=="BOTH" then
                local k,m=1e3
                m=k*k
                self.RightText:SetText((value>1e3 and value<1e5 and format("%1.3f",value/k)) or (value>=1e5 and value<1e6 and format("%1.0f K",value/k)) or (value>=1e6 and value<1e9 and format("%1.1f M",value/m)) or (value>=1e9 and format("%1.1f M",value/m)) or value )
                if value == 0 then
                    self.RightText:SetText(" ");
                end
            end
        end)

        -- DEAD TEXT
        hooksecurefunc("TextStatusBar_UpdateTextStringWithValues",function(self)
            local deadText = DEAD;
            local ghostText = "Ghost";

            if UnitIsDead("player") or UnitIsGhost("player") then
                PlayerFrameHealthBarText:SetFontObject(GameFontNormalSmall);
                for i, v in pairs({	PlayerFrameHealthBar.LeftText, PlayerFrameHealthBar.RightText, PlayerFrameManaBar.LeftText, PlayerFrameManaBar.RightText, PlayerFrameTextureFrameManaBarText, PlayerFrameManaBar }) do v:SetAlpha(0); end
                if GetCVar("statusTextDisplay")=="BOTH" then
                    PlayerFrameHealthBarText:Show();
                end
                if UnitIsDead("player") then
                    PlayerFrameHealthBarText:SetText(deadText);
                elseif UnitIsGhost("player") then
                    PlayerFrameHealthBarText:SetText(ghostText);
                end
            elseif not UnitIsDead("player") and not UnitIsGhost("player") then
                PlayerFrameHealthBarText:SetFontObject(TextStatusBarText);
                for i, v in pairs({	PlayerFrameHealthBar.LeftText, PlayerFrameHealthBar.RightText, PlayerFrameManaBar.LeftText, PlayerFrameManaBar.RightText, PlayerFrameTextureFrameManaBarText, PlayerFrameManaBar }) do v:SetAlpha(1); end
            end

            if UnitExists("target") and UnitIsDead("target") or UnitIsGhost("target") then
                TargetFrameTextureFrameHealthBarText:SetFontObject(GameFontNormalSmall);
                if GetCVar("statusTextDisplay")=="BOTH" then
                    TargetFrameTextureFrameHealthBarText:Show();
                end
                for i, v in pairs({	TargetFrameHealthBar.LeftText, TargetFrameHealthBar.RightText, TargetFrameManaBar.LeftText, TargetFrameManaBar.RightText, TargetFrameTextureFrameManaBarText, TargetFrameManaBar }) do v:SetAlpha(0); end
                if UnitIsGhost("target") and not UnitIsDead("target") then
                    TargetFrameTextureFrameHealthBarText:SetText(ghostText);
                end
            elseif not UnitIsDead("target") and not UnitIsGhost("target") then
                TargetFrameTextureFrameHealthBarText:SetFontObject(TextStatusBarText);
                for i, v in pairs({	TargetFrameHealthBar.LeftText, TargetFrameHealthBar.RightText, TargetFrameManaBar.LeftText, TargetFrameManaBar.RightText, TargetFrameTextureFrameManaBarText, TargetFrameManaBar }) do v:SetAlpha(1); end
            end

            if UnitExists("focus") and UnitIsDead("focus") or UnitIsGhost("focus") then
                FocusFrameTextureFrameHealthBarText:SetFontObject(GameFontNormalSmall);
                if GetCVar("statusTextDisplay")=="BOTH" then
                    FocusFrameTextureFrameHealthBarText:Show();
                end
                for i, v in pairs({	FocusFrameHealthBar.LeftText, FocusFrameHealthBar.RightText, FocusFrameManaBar.LeftText, FocusFrameManaBar.RightText, FocusFrameTextureFrameManaBarText, FocusFrameManaBar }) do v:SetAlpha(0); end
                if UnitIsGhost("focus") then
                    FocusFrameTextureFrameHealthBarText:SetText(ghostText);
                end
            elseif not UnitIsDead("focus") and not UnitIsGhost("focus") then
                FocusFrameTextureFrameHealthBarText:SetFontObject(TextStatusBarText);
                for i, v in pairs({	FocusFrameHealthBar.LeftText, FocusFrameHealthBar.RightText, FocusFrameManaBar.LeftText, FocusFrameManaBar.RightText, FocusFrameTextureFrameManaBarText, FocusFrameManaBar }) do v:SetAlpha(1); end
            end
        end)

        -- AURA SIZE
        local AURA_START_X = 5
        local AURA_START_Y = 28
        local LARGE_AURA_SIZE = SUIDB.UNITFRAMES.LBUFF	--	Default 21.
        local SMALL_AURA_SIZE = SUIDB.UNITFRAMES.SBUFF  --	Default 17.
        local AURA_OFFSET_Y = 3;
        local AURA_ROW_WIDTH = 122;
        local NUM_TOT_AURA_ROWS = 2;

        function SUIAuraResize(self, auraName, numAuras, numOppositeAuras, largeAuraList, updateFunc, maxRowWidth, offsetX, mirrorAurasVertically)
            local size;
            local offsetY = AURA_OFFSET_Y;
            local rowWidth = 0;
            local firstBuffOnRow = 1;
            for i=1, numAuras do
                if ( largeAuraList[i] ) then
                    size = LARGE_AURA_SIZE;
                    offsetY = AURA_OFFSET_Y + AURA_OFFSET_Y;
                else
                    size = SMALL_AURA_SIZE;
                end
                if ( i == 1 ) then
                    rowWidth = size;
                    self.auraRows = self.auraRows + 1;
                else
                    rowWidth = rowWidth + size + offsetX;
                end
                if ( rowWidth > maxRowWidth ) then
                    updateFunc(self, auraName, i, numOppositeAuras, firstBuffOnRow, size, offsetX, offsetY, mirrorAurasVertically);
                    rowWidth = size;
                    self.auraRows = self.auraRows + 1;
                    firstBuffOnRow = i;
                    offsetY = AURA_OFFSET_Y;
                    if ( self.auraRows > NUM_TOT_AURA_ROWS ) then
                        maxRowWidth = AURA_ROW_WIDTH;
                    end
                else
                    updateFunc(self, auraName, i, numOppositeAuras, i - 1, size, offsetX, offsetY, mirrorAurasVertically);
                end
            end
        end
        hooksecurefunc("TargetFrame_UpdateAuraPositions", SUIAuraResize)

        --BUFF ANCHOR
        function SUIBuffAnchor(self, buffName, index, numDebuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
            local point, relativePoint
            local startY, auraOffsetY

            if (mirrorVertically) then
                point = "BOTTOM"
                relativePoint = "TOP"
                startY = -6
                offsetY = -offsetY
                auraOffsetY = -AURA_OFFSET_Y
            else
                point = "TOP"
                relativePoint = "BOTTOM"
                startY = AURA_START_Y
                auraOffsetY = AURA_OFFSET_Y
            end

            local buff = _G[buffName .. index]
            if (index == 1) then
                if (UnitIsFriend("player", self.unit) or numDebuffs == 0) then
                    buff:SetPoint(point .. "LEFT", self, relativePoint .. "LEFT", AURA_START_X, startY)
                else
                    buff:SetPoint(point .. "LEFT", self.debuffs, relativePoint .. "LEFT", 0, -offsetY)
                end
                self.buffs:SetPoint(point .. "LEFT", buff, point .. "LEFT", 0, 0)
                self.buffs:SetPoint(relativePoint .. "LEFT", buff, relativePoint .. "LEFT", 0, -auraOffsetY)
                self.spellbarAnchor = buff
            elseif (anchorIndex ~= (index - 1)) then
                buff:SetPoint(point .. "LEFT", _G[buffName .. anchorIndex], relativePoint .. "LEFT", 0, -offsetY)
                self.buffs:SetPoint(relativePoint .. "LEFT", buff, relativePoint .. "LEFT", 0, -auraOffsetY)
                self.spellbarAnchor = buff
            else
                buff:SetPoint(point .. "LEFT", _G[buffName .. anchorIndex], point .. "RIGHT", offsetX, 0)
            end
        end
        hooksecurefunc("TargetFrame_UpdateBuffAnchor", SUIBuffAnchor)

        --DEBUFF ANCHOR
        function SUIDebuffAnchor(self, debuffName, index, numBuffs, anchorIndex, size, offsetX, offsetY, mirrorVertically)
            local buff = _G[debuffName .. index]
            local isFriend = UnitIsFriend("player", self.unit)

            if (mirrorVertically) then
                point = "BOTTOM"
                relativePoint = "TOP"
                startY = -8
                offsetY = -offsetY
                auraOffsetY = -AURA_OFFSET_Y
            else
                point = "TOP"
                relativePoint = "BOTTOM"
                startY = AURA_START_Y
                auraOffsetY = AURA_OFFSET_Y
            end

            if (index == 1) then
                if (isFriend and numBuffs > 0) then
                    buff:SetPoint(point .. "LEFT", self.buffs, relativePoint .. "LEFT", 0, -offsetY)
                else
                    buff:SetPoint(point .. "LEFT", self, relativePoint .. "LEFT", AURA_START_X, startY)
                end
                self.debuffs:SetPoint(point .. "LEFT", buff, point .. "LEFT", 0, 0)
                self.debuffs:SetPoint(relativePoint .. "LEFT", buff, relativePoint .. "LEFT", 0, -auraOffsetY)
                if ((isFriend) or (not isFriend and numBuffs == 0)) then
                    self.spellbarAnchor = buff
                end
            elseif (anchorIndex ~= (index - 1)) then
                buff:SetPoint(point .. "LEFT", _G[debuffName .. anchorIndex], relativePoint .. "LEFT", 0, -offsetY)
                self.debuffs:SetPoint(relativePoint .. "LEFT", buff, relativePoint .. "LEFT", 0, -auraOffsetY)
                if ((isFriend) or (not isFriend and numBuffs == 0)) then
                    self.spellbarAnchor = buff
                end
            else
                buff:SetPoint(point .. "LEFT", _G[debuffName .. (index - 1)], point .. "RIGHT", offsetX, 0)
            end
        end
        hooksecurefunc("TargetFrame_UpdateDebuffAnchor", SUIDebuffAnchor)

        -- END CUSTOM UNITFRAMES
        end

        -- PARTY
        function SUIPartyFrames()
            local useCompact = GetCVarBool("useCompactPartyFrames");
            if (SUIDB.A_PARTYFRAMES) and IsInGroup(player) and (not IsInRaid(player)) and (not useCompact) then
                for i = 1, 4 do
                    if (SUIDB.A_TEXTURES) then
                        _G["PartyMemberFrame"..i.."HealthBar"]:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                        _G["PartyMemberFrame"..i.."ManaBar"]:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar");
                    end
                        _G["PartyMemberFrame"..i.."Name"]:SetSize(75,10);
                        _G["PartyMemberFrame"..i.."Texture"]:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-PartyFrame");
                        _G["PartyMemberFrame"..i.."Flash"]:SetTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-PARTYFRAME-FLASH");
                        _G["PartyMemberFrame"..i.."HealthBar"]:ClearAllPoints();
                        _G["PartyMemberFrame"..i.."HealthBar"]:SetPoint("TOPLEFT", 45, -13);
                        _G["PartyMemberFrame"..i.."HealthBar"]:SetHeight(12);
                        _G["PartyMemberFrame"..i.."ManaBar"]:ClearAllPoints();
                        _G["PartyMemberFrame"..i.."ManaBar"]:SetPoint("TOPLEFT", 45, -26);
                        _G["PartyMemberFrame"..i.."ManaBar"]:SetHeight(5);
                        _G["PartyMemberFrame"..i.."HealthBarTextLeft"]:ClearAllPoints();
                        _G["PartyMemberFrame"..i.."HealthBarTextLeft"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."HealthBar"], "LEFT", 0, 0);
                        _G["PartyMemberFrame"..i.."HealthBarTextRight"]:ClearAllPoints();
                        _G["PartyMemberFrame"..i.."HealthBarTextRight"]:SetPoint("RIGHT", _G["PartyMemberFrame"..i.."HealthBar"], "RIGHT", 0, 0);
                        _G["PartyMemberFrame"..i.."ManaBarTextLeft"]:ClearAllPoints();
                        _G["PartyMemberFrame"..i.."ManaBarTextLeft"]:SetPoint("LEFT", _G["PartyMemberFrame"..i.."ManaBar"], "LEFT", 0, 0);
                        _G["PartyMemberFrame"..i.."ManaBarTextRight"]:ClearAllPoints();
                        _G["PartyMemberFrame"..i.."ManaBarTextRight"]:SetPoint("RIGHT", _G["PartyMemberFrame"..i.."ManaBar"], "RIGHT", 0, 0);
                        _G["PartyMemberFrame"..i.."HealthBarText"]:ClearAllPoints();
                        _G["PartyMemberFrame"..i.."HealthBarText"]:SetPoint("CENTER", _G["PartyMemberFrame"..i.."HealthBar"], "CENTER", 0, 0);
                        _G["PartyMemberFrame"..i.."ManaBarText"]:ClearAllPoints();
                        _G["PartyMemberFrame"..i.."ManaBarText"]:SetPoint("CENTER", _G["PartyMemberFrame"..i.."ManaBar"], "CENTER", 0, 0);
                    end
                end
            end
            function SUIPartyText()
                if (SUIDB.A_PARTYFRAMES) then
                    for i = 1, 4 do
                        _G["PartyMemberFrame"..i.."ManaBarText"]:SetText(" ");
                        _G["PartyMemberFrame"..i.."ManaBarTextLeft"]:SetText(" ");
                        _G["PartyMemberFrame"..i.."ManaBarTextRight"]:SetText(" ");
                    end
                end
        end
        hooksecurefunc("UnitFrame_Update", SUIPartyFrames)
        hooksecurefunc("PartyMemberFrame_ToPlayerArt", SUIPartyFrames)
        hooksecurefunc("TextStatusBar_UpdateTextStringWithValues", SUIPartyText)
end)