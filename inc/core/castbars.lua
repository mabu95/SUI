local SUI=CreateFrame("Frame")
SUI:RegisterEvent("PLAYER_LOGIN")
SUI:SetScript("OnEvent", function(self, event)

        if not (SUIDB.A_CASTBARS) then return end

        local format = string.format
        local max = math.max

        local FONT = STANDARD_TEXT_FONT

        if not InCombatLockdown() then
            -- Player Castbar
            CastingBarFrame.ignoreFramePositionManager = true
            CastingBarFrame:SetMovable(true)
            CastingBarFrame:ClearAllPoints()
            CastingBarFrame:SetScale(1)
            CastingBarFrame:SetPoint(SUIDB.PLAYERCASTBAR.POINT, MainMenuBar, SUIDB.PLAYERCASTBAR.RELPOINT, SUIDB.PLAYERCASTBAR.X, SUIDB.PLAYERCASTBAR.Y)
            CastingBarFrame:SetUserPlaced(true)
            CastingBarFrame:SetMovable(false)
            CastingBarFrame.Icon:Show()
            CastingBarFrame.Icon:ClearAllPoints()
            CastingBarFrame.Icon:SetSize(20, 20)
            CastingBarFrame.Icon:SetPoint("RIGHT", CastingBarFrame, "LEFT", -5, 0)
            CastingBarFrame.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small")
            CastingBarFrame.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small")
            CastingBarFrame.Text:ClearAllPoints()
            CastingBarFrame.Text:SetPoint("CENTER", 0, 1)
            CastingBarFrame.Border:SetWidth(CastingBarFrame.Border:GetWidth() + 4)
            CastingBarFrame.Flash:SetWidth(CastingBarFrame.Flash:GetWidth() + 4)
            CastingBarFrame.BorderShield:SetWidth(CastingBarFrame.BorderShield:GetWidth() + 4)
            CastingBarFrame.Border:SetPoint("TOP", 0, 26)
            CastingBarFrame.Flash:SetPoint("TOP", 0, 26)
            CastingBarFrame.BorderShield:SetPoint("TOP", 0, 26)

            if (SUIDB.A_TEXTURES) then
                CastingBarFrame:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar")
            end

            if (SUIDB.PLAYERCASTBAR.TIMER) then
                CastingBarFrame.timer = CastingBarFrame:CreateFontString(nil)
                CastingBarFrame.timer:SetFont(FONT, 14, "THINOUTLINE")
                CastingBarFrame.timer:SetPoint("LEFT", CastingBarFrame, "RIGHT", 5, 0)
                CastingBarFrame.update = 0.1
            end

            -- Target Castbar
            TargetFrameSpellBar.ignoreFramePositionManager = true
            TargetFrameSpellBar:SetMovable(true)
            TargetFrameSpellBar:ClearAllPoints()
            TargetFrameSpellBar:SetScale(1.3)
            TargetFrameSpellBar:SetPoint(SUIDB.TARGETCASTBAR.POINT, MainMenuBar, SUIDB.TARGETCASTBAR.RELPOINT, SUIDB.TARGETCASTBAR.X , SUIDB.TARGETCASTBAR.Y)
            TargetFrameSpellBar:SetUserPlaced(false)
            TargetFrameSpellBar:SetMovable(false)
            TargetFrameSpellBar.Icon:SetPoint("RIGHT", TargetFrameSpellBar, "LEFT", -3, 0)
            TargetFrameSpellBar.SetPoint = function()end
            TargetFrameSpellBar:SetStatusBarColor(1, 0, 0)
            TargetFrameSpellBar.SetStatusBarColor = function()end

            if (SUIDB.A_TEXTURES) then
                TargetFrameSpellBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar")
            end

            if SUIDB.TARGETCASTBAR.TIMER == true then
                TargetFrameSpellBar.timer = TargetFrameSpellBar:CreateFontString(nil)
                TargetFrameSpellBar.timer:SetFont(FONT, 11, "THINOUTLINE")
                TargetFrameSpellBar.timer:SetPoint("LEFT", TargetFrameSpellBar, "RIGHT", 4, 0)
                TargetFrameSpellBar.update = 0.1
            end

            -- Focus Castbar
            if (SUIDB.A_TEXTURES) then
                FocusFrameSpellBar:SetStatusBarTexture("Interface\\Addons\\SUI\\inc\\media\\unitframes\\UI-StatusBar")
            end

            self:UnregisterEvent("ADDON_LOADED")
            self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        end

        -- CastBar timer function
        local function CastingBarFrame_OnUpdate_Hook(self, elapsed)
            if not self.timer then
                return
            end
            if self.update and self.update < elapsed then
                if self.casting then
                    self.timer:SetText(format("%.1f", max(self.maxValue - self.value, 0)))
                elseif self.channeling then
                    self.timer:SetText(format("%.1f", max(self.value, 0)))
                else
                    self.timer:SetText("")
                end
                self.update = .1
            else
                self.update = self.update - elapsed
            end
        end

        CastingBarFrame:HookScript("OnUpdate", CastingBarFrame_OnUpdate_Hook)
        TargetFrameSpellBar:HookScript("OnUpdate", CastingBarFrame_OnUpdate_Hook)

end)