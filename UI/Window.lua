--// 💥 RIMURU HUB
--// UI WINDOW SYSTEM
--// Open / Close / Toggle
--// Safe Window Controller

local Window = {}

--==================================================
-- INIT
--==================================================

function Window:Init(Context)

    self.Context =
        Context or {}

    self.References =
        self.Context.UIReferences

    self.Main =
        nil

    self:_FindMain()

end

--==================================================
-- FIND MAIN
--==================================================

function Window:_FindMain()

    --==================================================
    -- REFERENCES MODULE
    --==================================================

    if self.References then

        if self.References.Main then

            self.Main =
                self.References.Main

            return self.Main

        end

        if type(
            self.References.Get
        ) == "function"
        then

            local Success,
                Result =
                pcall(
                    function()

                        return self.References:
                            Get("Main")

                    end
                )

            if Success
            and typeof(Result) == "Instance"
            then

                self.Main =
                    Result

                return self.Main

            end

        end

    end

    return nil

end

--==================================================
-- REFRESH
--==================================================

function Window:Refresh()

    return self:_FindMain()

end

--==================================================
-- GET MAIN
--==================================================

function Window:GetMain()

    if self.Main
    and self.Main.Parent
    then

        return self.Main

    end

    return self:_FindMain()

end

--==================================================
-- OPEN
--==================================================

function Window:Open()

    local Main =
        self:GetMain()

    if not Main then

        warn(
            "[Rimuru Hub] Window: Main não encontrado."
        )

        return false

    end

    if Main:IsA("GuiObject") then

        Main.Visible =
            true

        return true

    end

    return false

end

--==================================================
-- CLOSE
--==================================================

function Window:Close()

    local Main =
        self:GetMain()

    if not Main then

        return false

    end

    if Main:IsA("GuiObject") then

        Main.Visible =
            false

        return true

    end

    return false

end

--==================================================
-- TOGGLE
--==================================================

function Window:Toggle()

    local Main =
        self:GetMain()

    if not Main then

        return false

    end

    if not Main:IsA("GuiObject") then

        return false

    end

    Main.Visible =
        not Main.Visible

    return Main.Visible

end

--==================================================
-- IS OPEN
--==================================================

function Window:IsOpen()

    local Main =
        self:GetMain()

    if not Main then

        return false

    end

    if not Main:IsA("GuiObject") then

        return false

    end

    return Main.Visible == true

end

--==================================================
-- SET VISIBLE
--==================================================

function Window:SetVisible(
    Visible
)

    local Main =
        self:GetMain()

    if not Main then

        return false

    end

    if not Main:IsA("GuiObject") then

        return false

    end

    Main.Visible =
        Visible == true

    return true

end

--==================================================
-- RETURN
--==================================================

return Window
