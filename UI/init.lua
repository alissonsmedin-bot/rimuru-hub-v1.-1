--// 💥 RIMURU HUB
--// UI SYSTEM
--// UI MODULE MANAGER
--// Modular UI Architecture

local UI = {}

--==================================================
-- CONTEXT
--==================================================

function UI:Init(Context)

    self.Context =
        Context or {}

    --==================================================
    -- MODULES
    --==================================================

    self.Utils =
        self:LoadModule(
            "Utils"
        )

    self.Visuals =
        self:LoadModule(
            "Visuals"
        )

    self.Navigation =
        self:LoadModule(
            "Navigation"
        )

    self.Main =
        self:LoadModule(
            "Main"
        )

    --==================================================
    -- INITIALIZE MODULES
    --==================================================

    self:InitModule(
        "Utils",
        self.Utils
    )

    self:InitModule(
        "Visuals",
        self.Visuals
    )

    self:InitModule(
        "Navigation",
        self.Navigation
    )

    self:InitModule(
        "Main",
        self.Main
    )

    --==================================================
    -- CREATE UI
    --==================================================

    if self.Main
    and type(
        self.Main.Create
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Main:
                        Create(
                            self.Context
                        )

                end
            )

        if not Success then

            warn(
                "[Rimuru Hub] Erro ao criar UI: "
                .. tostring(Result)
            )

        end

    end

end

--==================================================
-- LOAD MODULE
--==================================================

function UI:LoadModule(Name)

    --==================================================
    -- MODULE FOLDER
    --==================================================

    local Root =
        script.Parent

    if not Root then

        warn(
            "[Rimuru Hub] UI Root não encontrado."
        )

        return nil

    end

    --==================================================
    -- FIND MODULE
    --==================================================

    local Module =
        Root:FindFirstChild(
            Name
        )

    if not Module then

        warn(
            "[Rimuru Hub] UI módulo não encontrado: "
            .. tostring(Name)
        )

        return nil

    end

    --==================================================
    -- REQUIRE
    --==================================================

    local Success,
        Result =
        pcall(
            require,
            Module
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao carregar UI."
            .. tostring(Name)
            .. ": "
            .. tostring(Result)
        )

        return nil

    end

    return Result

end

--==================================================
-- INIT MODULE
--==================================================

function UI:InitModule(
    Name,
    Module
)

    if not Module then

        return false

    end

    if type(
        Module.Init
    ) ~= "function"
    then

        return true

    end

    local Success,
        Error =
        pcall(
            function()

                Module:Init(
                    self.Context
                )

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] Erro ao iniciar UI/"
            .. tostring(Name)
            .. ": "
            .. tostring(Error)
        )

        return false

    end

    return true

end

--==================================================
-- OPEN
--==================================================

function UI:Open()

    if self.Main
    and type(
        self.Main.Open
    ) == "function"
    then

        return self.Main:
            Open()

    end

    if self.Main
    and self.Main.Main
    then

        self.Main.Main.Visible =
            true

        return true

    end

    return false

end

--==================================================
-- CLOSE
--==================================================

function UI:Close()

    if self.Main
    and type(
        self.Main.Close
    ) == "function"
    then

        return self.Main:
            Close()

    end

    if self.Main
    and self.Main.Main
    then

        self.Main.Main.Visible =
            false

        return true

    end

    return false

end

--==================================================
-- TOGGLE
--==================================================

function UI:Toggle()

    if self.Main
    and type(
        self.Main.Toggle
    ) == "function"
    then

        return self.Main:
            Toggle()

    end

    if self.Main
    and self.Main.Main
    then

        self.Main.Main.Visible =
            not self.Main.Main.Visible

        return self.Main.Main.Visible

    end

    return false

end

--==================================================
-- GET MAIN
--==================================================

function UI:GetMain()

    if self.Main
    and self.Main.Main
    then

        return self.Main.Main

    end

    return nil

end

--==================================================
-- GET SCROLL
--==================================================

function UI:GetScroll()

    if self.Main
    and type(
        self.Main.GetScroll
    ) == "function"
    then

        return self.Main:
            GetScroll()

    end

    return nil

end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

    if self.Main
    and type(
        self.Main.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Main:
                    ApplyTheme()

            end
        )

    end

    if self.Visuals
    and type(
        self.Visuals.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Visuals:
                    ApplyTheme()

            end
        )

    end

    if self.Navigation
    and type(
        self.Navigation.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Navigation:
                    ApplyTheme()

            end
        )

    end

end

--==================================================
-- SET VISIBLE
--==================================================

function UI:SetVisible(
    Visible
)

    if Visible then

        return self:Open()

    end

    return self:Close()

end

--==================================================
-- RETURN
--==================================================

return UI
