local SUI = CreateFrame("Frame")
SUI:RegisterEvent("PLAYER_LOGIN")
SUI:SetScript("OnEvent",function(self, event)
    if not (IsAddOnLoaded("SexyMap")) then
        if SUIDB.A_DARKFRAMES == true then
            for i, v in pairs(
                {
                    MinimapBorder,
                    MiniMapMailBorder,
                    QueueStatusMinimapButtonBorder,
                    select(1, TimeManagerClockButton:GetRegions())
                }
            ) do
                v:SetVertexColor(.15, .15, .15)
            end
        end
        select(2, TimeManagerClockButton:GetRegions()):SetVertexColor(1, 1, 1)

        if SUIDB.A_DARKFRAMES == true then
            hooksecurefunc("GarrisonLandingPageMinimapButton_UpdateIcon", function(self)
                local garrisonType = C_Garrison.GetLandingPageGarrisonType();
                if not (SUIDB.MINIMAP.OLDSYMBOL) then
                    if (garrisonType == Enum.GarrisonType.Type_8_0) then
                        if select(1,UnitFactionGroup("player")) == "Horde" then
                            if not gb then
                                gb = CreateFrame("Frame", nil, GarrisonLandingPageMinimapButton)
                                gb:SetFrameLevel(GarrisonLandingPageMinimapButton:GetFrameLevel() - 1)
                                gb:SetPoint("CENTER", -1, 2)
                                gb:SetSize(37,37)
            
                                gb.border = CreateFrame("Frame", nil, gb)
                                gb.border:SetFrameLevel(gb:GetFrameLevel() + 1)
                                gb.border:SetAllPoints()
                                gb.border.texture = gb.border:CreateTexture(nil, "OVERLAY")
                                gb.border.texture:SetTexture("Interface\\AddOns\\SUI\\inc\\media\\map\\OrderHallLandingButtonHordeborder")
                                gb.border.texture:SetTexCoord(0.40625, 0.757812, 0.421875, 0.820312)
                                if SUIDB.A_DARKFRAMES == true then
                                    gb.border.texture:SetVertexColor(.15, .15, .15)
                                end
                                gb.border.texture:SetPoint("CENTER", 1, -2)
                                gb.border.texture:SetSize(45,50)
                            end
                        else
                            if not gb then
                                gb = CreateFrame("Frame", nil, GarrisonLandingPageMinimapButton)
                                gb:SetFrameLevel(GarrisonLandingPageMinimapButton:GetFrameLevel())
                                gb:SetPoint("CENTER", -1, 2)
                                gb:SetSize(37,37)
            
                                gb.border = CreateFrame("Frame", nil, gb)
                                gb.border:SetFrameLevel(gb:GetFrameLevel() + 1)
                                gb.border:SetAllPoints()
                                gb.border.texture = gb.border:CreateTexture(nil, "OVERLAY")
                                gb.border.texture:SetTexture("Interface\\AddOns\\SUI\\inc\\media\\map\\OrderHallLandingButtonHordeborder")
                                gb.border.texture:SetTexCoord(0.382812, 0.742188, 0.0078125, 0.40625)
                                if SUIDB.A_DARKFRAMES == true then
                                    gb.border.texture:SetVertexColor(.15, .15, .15)
                                end
                                gb.border.texture:SetPoint("CENTER", 1, -2)
                                gb.border.texture:SetSize(45,50)
                            end
                        end
                    elseif (garrisonType <= Enum.GarrisonType.Type_7_0) then
                        self:GetNormalTexture():SetTexture(nil)
                        self:GetPushedTexture():SetTexture(nil)
                        if not gb then
                            gb = CreateFrame("Frame", nil, GarrisonLandingPageMinimapButton)
                            gb:SetFrameLevel(GarrisonLandingPageMinimapButton:GetFrameLevel() - 1)
                            gb:SetPoint("CENTER", 0, 0)
                            gb:SetSize(36,36)
                            gb.icon = gb:CreateTexture(nil, "ARTWORK")
                            gb.icon:SetPoint("CENTER", 0, 0)
                            gb.icon:SetSize(36,36)
                    
                            gb.border = CreateFrame("Frame", nil, gb)
                            gb.border:SetFrameLevel(gb:GetFrameLevel() + 1)
                            gb.border:SetAllPoints()
                            gb.border.texture = gb.border:CreateTexture(nil, "ARTWORK")
                            gb.border.texture:SetTexture("Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Ring")
                            if SUIDB.A_DARKFRAMES == true then
                                gb.border.texture:SetVertexColor(.15, .15, .15)
                            end
                            gb.border.texture:SetPoint("CENTER", 1, -2)
                            gb.border.texture:SetSize(45,45)
                        end
                        if (garrisonType == 2) then
                            if select(1,UnitFactionGroup("player")) == "Alliance" then	
                                SetPortraitToTexture(gb.icon, select(3,GetSpellInfo(61573)))
                            elseif select(1,UnitFactionGroup("player")) == "Horde" then
                                SetPortraitToTexture(gb.icon, select(3,GetSpellInfo(61574)))
                            end
                        else
                            local t = CLASS_ICON_TCOORDS[select(2,UnitClass("player"))]
                              gb.icon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
                              gb.icon:SetTexCoord(unpack(t))
                        end
                    end
                else
                    self:GetNormalTexture():SetTexture(nil)
                    self:GetPushedTexture():SetTexture(nil)
                    if not gb then

                        gb = CreateFrame("Frame", nil, GarrisonLandingPageMinimapButton)
                        gb:SetFrameLevel(5)
                        gb:SetPoint("CENTER", 0, 0)
                        gb:SetSize(36,36)
                        gb.icon = gb:CreateTexture(nil, "ARTWORK")
                        gb.icon:SetPoint("CENTER", 0, 0)
                        gb.icon:SetSize(36,36)
                        GarrisonLandingPageMinimapButton:SetFrameLevel(gb:GetFrameLevel() + 1)
                        gb.border = CreateFrame("Frame", nil, gb)
                        gb.border:SetFrameLevel(gb:GetFrameLevel() + 1)
                        gb.border:SetAllPoints()
                        gb.border.texture = gb.border:CreateTexture(nil, "ARTWORK")
                        gb.border.texture:SetTexture("Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Ring")
                        gb.border.texture:SetVertexColor(.1, .1, .1)
                        gb.border.texture:SetPoint("CENTER", 1, -2)
                        gb.border.texture:SetSize(45,45)
                    end
                    if (garrisonType == 2) then
                        if select(1,UnitFactionGroup("player")) == "Alliance" then	
                            SetPortraitToTexture(gb.icon, select(3,GetSpellInfo(61573)))
                        elseif select(1,UnitFactionGroup("player")) == "Horde" then
                            SetPortraitToTexture(gb.icon, select(3,GetSpellInfo(61574)))
                        end
                    else
                        local t = CLASS_ICON_TCOORDS[select(2,UnitClass("player"))]
                          gb.icon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
                          gb.icon:SetTexCoord(unpack(t))
                    end
                end
            end)
        end

        MinimapBorderTop:Hide()
        MinimapZoomIn:Hide()
        MinimapZoomOut:Hide()
        MiniMapWorldMapButton:Hide()
        MinimapZoneText:SetPoint("CENTER", Minimap, 0, 80)
        GameTimeFrame:Hide()
        GameTimeFrame:UnregisterAllEvents()
        GameTimeFrame.Show = kill
        MiniMapTracking:Hide()
        MiniMapTracking.Show = kill
        MiniMapTracking:UnregisterAllEvents()
        Minimap:EnableMouseWheel(true)
        Minimap:SetScript(
            "OnMouseWheel",
            function(self, z)
                local c = Minimap:GetZoom()
                if (z > 0 and c < 5) then
                    Minimap:SetZoom(c + 1)
                elseif (z < 0 and c > 0) then
                    Minimap:SetZoom(c - 1)
                end
            end
        )
        Minimap:SetScript(
            "OnMouseUp",
            function(self, btn)
                if btn == "RightButton" then
                    _G.GameTimeFrame:Click()
                elseif btn == "MiddleButton" then
                    _G.ToggleDropDownMenu(1, nil, _G.MiniMapTrackingDropDown, self)
                else
                    _G.Minimap_OnClick(self)
                end
            end
        )
    end
end
)