--// 💥 RIMURU HUB
--// UI CORE
--// Modular UI Controller
--// Connects all UI modules safely

local UI = {}

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

local Player =
    Players.LocalPlayer

--==================================================
-- MODULES
--==================================================

local ModuleFolder =
    script.Parent

local function LoadModule(Name)

    local Module =
        ModuleFolder:FindFirstChild(
            Name
        )

    if not Module then

        warn(
            "[Rimuru Hub] UI module not found: "
            .. Name
        )

        return nil

    end

    local Success,
        Result =
        pcall(
            require,
            Module
        )

    if not Success then

        warn(
            "[Rimuru Hub] UI module error: "
            .. Name
            .. " | "
            .. tostring(Result)
        )

        return nil

    end

    return Result

end

--==================================================
-- MODULE REFERENCES
--==================================================

UI.Window =
    LoadModule(
        "Window"
    )

UI.Sidebar =
    LoadModule(
        "Sidebar"
    )

UI.Categories =
    LoadModule(
        "Categories"
    )

UI.Results =
    LoadModule(
        "Results"
    )

UI.Topbar =
    LoadModule(
        "Topbar"
    )

UI.Drag =
    LoadModule(
        "Drag"
    )

UI.Animation =
    LoadModule(
        "Animation"
    )

UI.Logo =
    LoadModule(
        "Logo"
    )

UI.Transparency =
    LoadModule(
        "Transparency"
    )

--==================================================
-- CONTEXT
--==================================================

UI.Context =
    {}

--==================================================
-- SAFE INIT
--==================================================

local function InitModule(
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

        warn(
            "[Rimuru Hub] "
            .. Name
            .. " does not have Init()."
        )

        return false

    end

    local Success,
        Error =
        pcall(
            function()

                Module:Init(
                    UI.Context
                )

            end
        )

    if not Success then

        warn(
            "[Rimuru Hub] UI "
            .. Name
            .. " Init error: "
            .. tostring(Error)
        )

        return false

    end

    return true

end

--==================================================
-- SET CONTEXT
--==================================================

function UI:SetContext(
    Context
)

    if type(Context) ~=
        "table"
    then

        return false

    end

    --==================================================
    -- COPY CONTEXT
    --==================================================

    for Key, Value in
        pairs(Context)
    do

        self.Context[Key] =
            Value

    end

    --==================================================
    -- SELF REFERENCE
    --==================================================

    self.Context.UI =
        self

    return true

end

--==================================================
-- CREATE WINDOW
--==================================================

function UI:CreateWindow()

    if not self.Window then

        warn(
            "[Rimuru Hub] Window module unavailable."
        )

        return false

    end

    if type(
        self.Window.Create
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Window:
                        Create(
                            self.Context
                        )

                end
            )

        if Success
        and Result ~= false
        then

            return true

        end

    end

    if type(
        self.Window.Init
    ) == "function"
    then

        return InitModule(
            "Window",
            self.Window
        )

    end

    return false

end

--==================================================
-- FIND MAIN
--==================================================

function UI:FindMain()

    if self.Main
    and self.Main.Parent
    then

        return self.Main

    end

    --==================================================
    -- WINDOW MODULE
    --==================================================

    if self.Window then

        if self.Window.Main
        and typeof(
            self.Window.Main
        ) == "Instance"
        then

            self.Main =
                self.Window.Main

            return self.Main

        end

        if self.Window.Window
        and typeof(
            self.Window.Window
        ) == "Instance"
        then

            self.Main =
                self.Window.Window

            return self.Main

        end

        if type(
            self.Window.Get
        ) == "function"
        then

            local Success,
                Result =
                pcall(
                    function()

                        return self.Window:
                            Get()

                    end
                )

            if Success
            and typeof(Result) ==
                "Instance"
            then

                self.Main =
                    Result

                return self.Main

            end

        end

    end

    --==================================================
    -- PLAYER GUI FALLBACK
    --==================================================

    local PlayerGui =
        Player
        and Player:FindFirstChild(
            "PlayerGui"
        )

    if PlayerGui then

        local Candidate =
            PlayerGui:FindFirstChild(
                "RimuruHub",
                true
            )

        if Candidate
        and Candidate:IsA(
            "GuiObject"
        )
        then

            self.Main =
                Candidate

            return Candidate

        end

    end

    return nil

end

--==================================================
-- UPDATE REFERENCES
--==================================================

function UI:UpdateReferences()

    self:FindMain()

    --==================================================
    -- WINDOW
    --==================================================

    if self.Main then

        self.WindowInstance =
            self.Main

    end

    --==================================================
    -- TOPBAR
    --==================================================

    if self.Topbar
    and self.Topbar.Container
    then

        self.TopbarInstance =
            self.Topbar.Container

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.Sidebar
    and self.Sidebar.Container
    then

        self.SidebarInstance =
            self.Sidebar.Container

    end

    --==================================================
    -- RESULTS
    --==================================================

    if self.Results then

        if self.Results.Scroll then

            self.Scroll =
                self.Results.Scroll

        end

        if self.Results.Container then

            self.ResultsContainer =
                self.Results.Container

        end

    end

    return true

end

--==================================================
-- INIT
--==================================================

function UI:Init(Context)

    --==================================================
    -- CONTEXT
    --==================================================

    self:SetContext(
        Context or {}
    )

    --==================================================
    -- INITIALIZE WINDOW FIRST
    --==================================================

    if self.Window then

        InitModule(
            "Window",
            self.Window
        )

    end

    --==================================================
    -- REFERENCES
    --==================================================

    self:UpdateReferences()

    --==================================================
    -- TOPBAR
    --==================================================

    if self.Topbar then

        InitModule(
            "Topbar",
            self.Topbar
        )

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.Sidebar then

        InitModule(
            "Sidebar",
            self.Sidebar
        )

    end

    --==================================================
    -- RESULTS
    --==================================================

    if self.Results then

        InitModule(
            "Results",
            self.Results
        )

    end

    --==================================================
    -- UPDATE SCROLL
    --==================================================

    self:UpdateReferences()

    --==================================================
    -- CATEGORIES
    --==================================================

    if self.Categories then

        InitModule(
            "Categories",
            self.Categories
        )

    end

    --==================================================
    -- LOGO
    --==================================================

    if self.Logo then

        InitModule(
            "Logo",
            self.Logo
        )

    end

    --==================================================
    -- TRANSPARENCY
    --==================================================

    if self.Transparency then

        InitModule(
            "Transparency",
            self.Transparency
        )

    end

    --==================================================
    -- DRAG
    --==================================================

    if self.Drag then

        InitModule(
            "Drag",
            self.Drag
        )

    end

    --==================================================
    -- ANIMATION
    --==================================================

    if self.Animation then

        InitModule(
            "Animation",
            self.Animation
        )

    end

    --==================================================
    -- FINAL REFERENCES
    --==================================================

    self:UpdateReferences()

    --==================================================
    -- APPLY TRANSPARENCY
    --==================================================

    if self.Transparency
    and type(
        self.Transparency.Apply
    ) == "function"
    then

        pcall(
            function()

                self.Transparency:
                    Apply()

            end
        )

    end

    --==================================================
    -- APPLY THEME
    --==================================================

    self:ApplyTheme()

    --==================================================
    -- DEFAULT VISIBILITY
    --==================================================

    if self.Main then

        self.Main.Visible =
            true

    end

    return true

end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

    --==================================================
    -- TOPBAR
    --==================================================

    if self.Topbar
    and type(
        self.Topbar.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Topbar:
                    ApplyTheme()

            end
        )

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.Sidebar
    and type(
        self.Sidebar.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Sidebar:
                    ApplyTheme()

            end
        )

    end

    --==================================================
    -- CATEGORIES
    --==================================================

    if self.Categories
    and type(
        self.Categories.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Categories:
                    ApplyTheme()

            end
        )

    end

    --==================================================
    -- RESULTS
    --==================================================

    if self.Results
    and type(
        self.Results.ApplyTheme
    ) == "function"
    then

        pcall(
            function()

                self.Results:
                    ApplyTheme()

            end
        )

    end

    return true

end

--==================================================
-- GET SCROLL
--==================================================

function UI:GetScroll()

    if self.Scroll
    and self.Scroll.Parent
    then

        return self.Scroll

    end

    if self.Results
    and type(
        self.Results.GetScroll
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.Results:
                        GetScroll()

                end
            )

        if Success
        and typeof(Result) ==
            "Instance"
        then

            self.Scroll =
                Result

            return Result

        end

    end

    return nil

end

--==================================================
-- GET BACKGROUND
--==================================================

function UI:GetBackground()

    if self.Background
    and typeof(
        self.Background
    ) == "Instance"
    then

        return self.Background

    end

    if self.Main then

        return self.Main:FindFirstChild(
            "Background",
            true
        )

    end

    return nil

end

--==================================================
-- SET BACKGROUND TRANSPARENCY
--==================================================

function UI:SetBackgroundTransparency(
    Value
)

    Value =
        tonumber(Value)

    if not Value then
        return false
    end

    Value =
        math.clamp(
            Value,
            0,
            1
        )

    local Background =
        self:GetBackground()

    if Background
    and Background:IsA(
        "ImageLabel"
    )
    then

        Background.ImageTransparency =
            Value

        return true

    end

    return false

end

--==================================================
-- OPEN
--==================================================

function UI:Open()

    if not self.Main then

        self:UpdateReferences()

    end

    if not self.Main then
        return false
    end

    if self.Animation
    and type(
        self.Animation.Open
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    self.Animation:
                        Open()

                end
            )

        if Success then
            return true
        end

    end

    self.Main.Visible =
        true

    return true

end

--==================================================
-- CLOSE
--==================================================

function UI:Close()

    if not self.Main then

        self:UpdateReferences()

    end

    if not self.Main then
        return false
    end

    if self.Animation
    and type(
        self.Animation.Close
    ) == "function"
    then

        local Success =
            pcall(
                function()

                    self.Animation:
                        Close()

                end
            )

        if Success then
            return true
        end

    end

    self.Main.Visible =
        false

    return true

end

--==================================================
-- TOGGLE
--==================================================

function UI:Toggle()

    if not self.Main then

        self:UpdateReferences()

    end

    if not self.Main then
        return false
    end

    if self.Main.Visible then

        self:Close()

        return false

    else

        self:Open()

        return true

    end

end

--==================================================
-- IS OPEN
--==================================================

function UI:IsOpen()

    if not self.Main then
        return false
    end

    return self.Main.Visible == true

end

--==================================================
-- GET STATUS
--==================================================

function UI:GetStatus()

    return {

        Main =
            self.Main ~= nil,

        Window =
            self.Window ~= nil,

        Topbar =
            self.Topbar ~= nil,

        Sidebar =
            self.Sidebar ~= nil,

        Categories =
            self.Categories ~= nil,

        Results =
            self.Results ~= nil,

        Logo =
            self.Logo ~= nil,

        Drag =
            self.Drag ~= nil,

        Animation =
            self.Animation ~= nil,

        Transparency =
            self.Transparency ~= nil,

        Scroll =
            self:GetScroll() ~= nil,

    }

end

--==================================================
-- READY
--==================================================

function UI:IsReady()

    return
        self.Main ~= nil
        and self:GetScroll() ~= nil

end

--==================================================
-- STARTUP
--==================================================

print(
    "[Rimuru Hub] UI Core carregado."
)

return UI
