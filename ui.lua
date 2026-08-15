--// 💥 RIMURU HUB
--// UI System
--// FIX: Drag system sem Main.InputBegan
--// FIX: BackgroundImage dos temas

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local UI = {}

--==================================================
-- INIT
--==================================================

function UI:Init(Context)

    self.Context = Context or {}

    self.Player =
        self.Context.Player
        or Players.LocalPlayer

    if not self.Player then
        return
    end

    self.PlayerGui =
        self.Context.PlayerGui
        or self.Player:WaitForChild("PlayerGui")

    self.Config =
        self.Context.Config

    self.Theme =
        self.Context.Theme

    if not self.Theme then

        warn(
            "[Rimuru Hub] Theme não encontrado."
        )

        return

    end

    self:Create()

end

--==================================================
-- REMOVE OLD VERSION
--==================================================

function UI:RemoveOld()

    pcall(function()

        local Old =
            self.PlayerGui:FindFirstChild("RimuruHub")

        if Old then
            Old:Destroy()
        end

    end)

end

--==================================================
-- CREATE GUI
--==================================================

function UI:Create()

    self:RemoveOld()

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then

        warn(
            "[Rimuru Hub] Não foi possível obter o tema atual."
        )

        return

    end

    --==================================================
    -- SCREEN GUI
    --==================================================

    local Gui =
        Instance.new("ScreenGui")

    Gui.Name =
        "RimuruHub"

    Gui.ResetOnSpawn =
        false

    Gui.IgnoreGuiInset =
        true

    Gui.ZIndexBehavior =
        Enum.ZIndexBehavior.Global

    Gui.DisplayOrder =
        999999

    Gui.Parent =
        self.PlayerGui

    self.Gui =
        Gui

    --==================================================
    -- MAIN
    --==================================================

    local Main =
        Instance.new("Frame")

    Main.Name =
        "Main"

    Main.Size =
        UDim2.new(
            0,
            600,
            0,
            400
        )

    Main.Position =
        UDim2.new(
            0.5,
            -300,
            0.5,
            -200
        )

    Main.BackgroundColor3 =
        CurrentTheme.Main

    Main.BorderSizePixel =
        0

    Main.Visible =
        false

    Main.ZIndex =
        500

    Main.Parent =
        Gui

    self.Main =
        Main

    --==================================================
    -- MAIN CORNER
    --==================================================

    local MainCorner =
        Instance.new("UICorner")

    MainCorner.CornerRadius =
        UDim.new(
            0,
            12
        )

    MainCorner.Parent =
        Main

    --==================================================
    -- MAIN STROKE
    --==================================================

    local MainStroke =
        Instance.new("UIStroke")

    MainStroke.Color =
        self.Theme:GetAccent()

    MainStroke.Thickness =
        1.5

    MainStroke.Parent =
        Main

    self.MainStroke =
        MainStroke

    --==================================================
    -- BACKGROUND IMAGE
    --==================================================

    local BackgroundImage =
        Instance.new("ImageLabel")

    BackgroundImage.Name =
        "BackgroundImage"

    BackgroundImage.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    BackgroundImage.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    BackgroundImage.BackgroundTransparency =
        1

    BackgroundImage.BorderSizePixel =
        0

    BackgroundImage.Image =
        CurrentTheme.BackgroundImage
        or ""

    BackgroundImage.ImageTransparency =
        CurrentTheme.BackgroundTransparency
        or 0.78

    BackgroundImage.ScaleType =
        Enum.ScaleType.Crop

    BackgroundImage.Active =
        false

    BackgroundImage.ZIndex =
        501

    BackgroundImage.Parent =
        Main

    local BackgroundCorner =
        Instance.new("UICorner")

    BackgroundCorner.CornerRadius =
        UDim.new(
            0,
            12
        )

    BackgroundCorner.Parent =
        BackgroundImage

    self.BackgroundImage =
        BackgroundImage

    --==================================================
    -- MAIN DRAG
    --==================================================

    self:SetupDrag()

    --==================================================
    -- HEADER
    --==================================================

    local Header =
        Instance.new("Frame")

    Header.Name =
        "Header"

    Header.Size =
        UDim2.new(
            1,
            0,
            0,
            58
        )

    Header.BackgroundTransparency =
        1

    Header.ZIndex =
        502

    Header.Parent =
        Main

    self.Header =
        Header

    --==================================================
    -- HEADER LOGO
    --==================================================

    local HeaderLogo =
        Instance.new("ImageLabel")

    HeaderLogo.Name =
        "Logo"

    HeaderLogo.Size =
        UDim2.new(
            0,
            40,
            0,
            40
        )

    HeaderLogo.Position =
        UDim2.new(
            0,
            10,
            0,
            8
        )

    HeaderLogo.BackgroundTransparency =
        1

    HeaderLogo.Image =
        "rbxassetid://6691708227"

    HeaderLogo.ScaleType =
        Enum.ScaleType.Fit

    HeaderLogo.ZIndex =
        503

    HeaderLogo.Parent =
        Header

    self.HeaderLogo =
        HeaderLogo

    --==================================================
    -- TITLE
    --==================================================

    local Title =
        Instance.new("TextLabel")

    Title.Name =
        "Title"

    Title.Position =
        UDim2.new(
            0,
            60,
            0,
            7
        )

    Title.Size =
        UDim2.new(
            1,
            -105,
            0,
            25
        )

    Title.BackgroundTransparency =
        1

    Title.Text =
        "Rimuru Hub"

    Title.TextColor3 =
        CurrentTheme.Text

    Title.TextSize =
        19

    Title.Font =
        Enum.Font.GothamBold

    Title.TextXAlignment =
        Enum.TextXAlignment.Left

    Title.ZIndex =
        503

    Title.Parent =
        Header

    self.Title =
        Title

    --==================================================
    -- SUBTITLE
    --==================================================

    local Subtitle =
        Instance.new("TextLabel")

    Subtitle.Name =
        "Subtitle"

    Subtitle.Position =
        UDim2.new(
            0,
            61,
            0,
            31
        )

    Subtitle.Size =
        UDim2.new(
            1,
            -75,
            0,
            18
        )

    Subtitle.BackgroundTransparency =
        1

    Subtitle.Text =
        "Sound Library"

    Subtitle.TextColor3 =
        CurrentTheme.SubText

    Subtitle.TextSize =
        11

    Subtitle.Font =
        Enum.Font.Gotham

    Subtitle.TextXAlignment =
        Enum.TextXAlignment.Left

    Subtitle.ZIndex =
        503

    Subtitle.Parent =
        Header

    self.Subtitle =
        Subtitle

    --==================================================
    -- CLOSE
    --==================================================

    local Close =
        Instance.new("TextButton")

    Close.Name =
        "Close"

    Close.Size =
        UDim2.new(
            0,
            30,
            0,
            30
        )

    Close.Position =
        UDim2.new(
            1,
            -38,
            0,
            14
        )

    Close.BackgroundColor3 =
        CurrentTheme.Close

    Close.BorderSizePixel =
        0

    Close.Text =
        "X"

    Close.TextColor3 =
        CurrentTheme.Text

    Close.TextSize =
        12

    Close.Font =
        Enum.Font.GothamBold

    Close.AutoButtonColor =
        false

    Close.ZIndex =
        504

    Close.Parent =
        Header

    local CloseCorner =
        Instance.new("UICorner")

    CloseCorner.CornerRadius =
        UDim.new(
            0,
            7
        )

    CloseCorner.Parent =
        Close

    self.Close =
        Close

    --==================================================
    -- CLOSE FUNCTION
    --==================================================

    pcall(function()

        Close.Activated:Connect(function()

            self:SetVisible(false)

        end)

    end)

    --==================================================
    -- SIDEBAR
    --==================================================

    local Sidebar =
        Instance.new("Frame")

    Sidebar.Name =
        "Sidebar"

    Sidebar.Position =
        UDim2.new(
            0,
            10,
            0,
            65
        )

    Sidebar.Size =
        UDim2.new(
            0,
            165,
            1,
            -75
        )

    Sidebar.BackgroundColor3 =
        CurrentTheme.Sidebar

    Sidebar.BorderSizePixel =
        0

    Sidebar.ZIndex =
        502

    Sidebar.Parent =
        Main

    local SidebarCorner =
        Instance.new("UICorner")

    SidebarCorner.CornerRadius =
        UDim.new(
            0,
            9
        )

    SidebarCorner.Parent =
        Sidebar

    local SidebarPadding =
        Instance.new("UIPadding")

    SidebarPadding.PaddingTop =
        UDim.new(
            0,
            8
        )

    SidebarPadding.PaddingLeft =
        UDim.new(
            0,
            7
        )

    SidebarPadding.PaddingRight =
        UDim.new(
            0,
            7
        )

    SidebarPadding.Parent =
        Sidebar

    local SidebarLayout =
        Instance.new("UIListLayout")

    SidebarLayout.Padding =
        UDim.new(
            0,
            5
        )

    SidebarLayout.SortOrder =
        Enum.SortOrder.LayoutOrder

    SidebarLayout.Parent =
        Sidebar

    self.Sidebar =
        Sidebar

    --==================================================
    -- CONTENT
    --==================================================

    local Content =
        Instance.new("Frame")

    Content.Name =
        "Content"

    Content.Position =
        UDim2.new(
            0,
            185,
            0,
            65
        )

    Content.Size =
        UDim2.new(
            1,
            -195,
            1,
            -75
        )

    Content.BackgroundColor3 =
        CurrentTheme.Content

    Content.BorderSizePixel =
        0

    Content.ZIndex =
        502

    Content.Parent =
        Main

    local ContentCorner =
        Instance.new("UICorner")

    ContentCorner.CornerRadius =
        UDim.new(
            0,
            9
        )

    ContentCorner.Parent =
        Content

    self.Content =
        Content

    --==================================================
    -- CONTENT TITLE
    --==================================================

    local ContentTitle =
        Instance.new("TextLabel")

    ContentTitle.Name =
        "ContentTitle"

    ContentTitle.Position =
        UDim2.new(
            0,
            14,
            0,
            10
        )

    ContentTitle.Size =
        UDim2.new(
            1,
            -28,
            0,
            25
        )

    ContentTitle.BackgroundTransparency =
        1

    ContentTitle.Text =
        "Principal"

    ContentTitle.TextColor3 =
        CurrentTheme.Text

    ContentTitle.TextSize =
        17

    ContentTitle.Font =
        Enum.Font.GothamBold

    ContentTitle.TextXAlignment =
        Enum.TextXAlignment.Left

    ContentTitle.ZIndex =
        503

    ContentTitle.Parent =
        Content

    self.ContentTitle =
        ContentTitle

    --==================================================
    -- CONTENT SCROLL
    --==================================================

    local Scroll =
        Instance.new("ScrollingFrame")

    Scroll.Name =
        "ContentScroll"

    Scroll.Position =
        UDim2.new(
            0,
            10,
            0,
            42
        )

    Scroll.Size =
        UDim2.new(
            1,
            -20,
            1,
            -52
        )

    Scroll.BackgroundTransparency =
        1

    Scroll.BorderSizePixel =
        0

    Scroll.ScrollBarThickness =
        5

    Scroll.ScrollBarImageColor3 =
        self.Theme:GetAccent()

    Scroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Scroll.ScrollingDirection =
        Enum.ScrollingDirection.Y

    Scroll.ZIndex =
        503

    Scroll.Parent =
        Content

    local ScrollPadding =
        Instance.new("UIPadding")

    ScrollPadding.PaddingBottom =
        UDim.new(
            0,
            6
        )

    ScrollPadding.Parent =
        Scroll

    local ScrollLayout =
        Instance.new("UIListLayout")

    ScrollLayout.Padding =
        UDim.new(
            0,
            5
        )

    ScrollLayout.SortOrder =
        Enum.SortOrder.LayoutOrder

    ScrollLayout.Parent =
        Scroll

    self.Scroll =
        Scroll

end

--==================================================
-- CHECK IF POINT IS INSIDE MAIN
--==================================================

function UI:IsPointInsideMain(Position)

    if not self.Main then
        return false
    end

    local Main =
        self.Main

    local AbsolutePosition =
        Main.AbsolutePosition

    local AbsoluteSize =
        Main.AbsoluteSize

    return
        Position.X >= AbsolutePosition.X
        and
        Position.X <=
            AbsolutePosition.X +
            AbsoluteSize.X
        and
        Position.Y >= AbsolutePosition.Y
        and
        Position.Y <=
            AbsolutePosition.Y +
            AbsoluteSize.Y

end

--==================================================
-- MAIN DRAG
--==================================================

function UI:SetupDrag()

    local Main =
        self.Main

    if not Main then
        return
    end

    local Config =
        self.Config

    local CanDrag =
        true

    pcall(function()

        if Config
        and Config.UI
        and Config.UI.MainMenuDraggable ~= nil then

            CanDrag =
                Config.UI.MainMenuDraggable

        end

    end)

    if not CanDrag then
        return
    end

    local Dragging =
        false

    local DragStart =
        nil

    local StartPosition =
        nil

    --==================================================
    -- INPUT BEGAN
    --==================================================

    self.DragInputBegan =
        UIS.InputBegan:Connect(function(Input, GameProcessed)

            if GameProcessed then
                return
            end

            if not self.Main then
                return
            end

            if not self.Main.Visible then
                return
            end

            local InputType =
                Input.UserInputType

            local IsMouse =
                InputType ==
                Enum.UserInputType.MouseButton1

            local IsTouch =
                InputType ==
                Enum.UserInputType.Touch

            if not IsMouse
            and not IsTouch then
                return
            end

            local Position =
                Input.Position

            if not self:IsPointInsideMain(Position) then
                return
            end

            Dragging =
                true

            DragStart =
                Position

            StartPosition =
                Main.Position

        end)

    --==================================================
    -- INPUT CHANGED
    --==================================================

    self.DragInputChanged =
        UIS.InputChanged:Connect(function(Input)

            if not Dragging then
                return
            end

            local InputType =
                Input.UserInputType

            if InputType ~=
                Enum.UserInputType.MouseMovement
            and InputType ~=
                Enum.UserInputType.Touch then

                return

            end

            if not DragStart
            or not StartPosition then

                return

            end

            local Delta =
                Input.Position -
                DragStart

            Main.Position =
                UDim2.new(

                    StartPosition.X.Scale,

                    StartPosition.X.Offset +
                    Delta.X,

                    StartPosition.Y.Scale,

                    StartPosition.Y.Offset +
                    Delta.Y

                )

        end)

    --==================================================
    -- INPUT ENDED
    --==================================================

    self.DragInputEnded =
        UIS.InputEnded:Connect(function(Input)

            local InputType =
                Input.UserInputType

            if InputType ==
                Enum.UserInputType.MouseButton1

            or InputType ==
                Enum.UserInputType.Touch then

                Dragging =
                    false

                DragStart =
                    nil

                StartPosition =
                    nil

            end

        end)

end

--==================================================
-- VISIBILITY
--==================================================

function UI:SetVisible(Value)

    if not self.Main then
        return
    end

    self.Main.Visible =
        Value

end

--==================================================
-- TOGGLE
--==================================================

function UI:Toggle()

    if not self.Main then
        return
    end

    self.Main.Visible =
        not self.Main.Visible

end

--==================================================
-- IS VISIBLE
--==================================================

function UI:IsVisible()

    if not self.Main then
        return false
    end

    return self.Main.Visible

end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

    if not self.Main then
        return
    end

    if not self.Theme then
        return
    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    if not CurrentTheme then
        return
    end

    --==================================================
    -- MAIN
    --==================================================

    self.Main.BackgroundColor3 =
        CurrentTheme.Main

    if self.MainStroke then

        self.MainStroke.Color =
            self.Theme:GetAccent()

    end

    --==================================================
    -- BACKGROUND IMAGE
    --==================================================

    if self.BackgroundImage then

        self.BackgroundImage.Image =
            CurrentTheme.BackgroundImage
            or ""

        self.BackgroundImage.ImageTransparency =
            CurrentTheme.BackgroundTransparency
            or 0.78

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.Sidebar then

        self.Sidebar.BackgroundColor3 =
            CurrentTheme.Sidebar

    end

    --==================================================
    -- CONTENT
    --==================================================

    if self.Content then

        self.Content.BackgroundColor3 =
            CurrentTheme.Content

    end

        --==================================================
    -- TEXT
    --==================================================

    if self.Title then

        self.Title.TextColor3 =
            CurrentTheme.Text

    end

    if self.Subtitle then

        self.Subtitle.TextColor3 =
            CurrentTheme.SubText

    end

    if self.ContentTitle then

        self.ContentTitle.TextColor3 =
            CurrentTheme.Text

    end

    --==================================================
    -- CLOSE
    --==================================================

    if self.Close then

        self.Close.BackgroundColor3 =
            CurrentTheme.Close

        self.Close.TextColor3 =
            CurrentTheme.Text

    end

    --==================================================
    -- HEADER LOGO
    --==================================================

    if self.HeaderLogo then

        self.HeaderLogo.ImageColor3 =
            CurrentTheme.Text

    end

    --==================================================
    -- SCROLL
    --==================================================

    if self.Scroll then

        self.Scroll.ScrollBarImageColor3 =
            self.Theme:GetAccent()

    end

end

--==================================================
-- DESTROY
--==================================================

function UI:Destroy()

    --==================================================
    -- DISCONNECT DRAG
    --==================================================

    pcall(function()

        if self.DragInputBegan then
            self.DragInputBegan:Disconnect()
        end

        if self.DragInputChanged then
            self.DragInputChanged:Disconnect()
        end

        if self.DragInputEnded then
            self.DragInputEnded:Disconnect()
        end

    end)

    self.DragInputBegan = nil
    self.DragInputChanged = nil
    self.DragInputEnded = nil

    --==================================================
    -- DESTROY GUI
    --==================================================

    pcall(function()

        if self.Gui then
            self.Gui:Destroy()
        end

    end)

    --==================================================
    -- CLEAR REFERENCES
    --==================================================

    self.Gui = nil
    self.Main = nil
    self.MainStroke = nil
    self.BackgroundImage = nil

    self.Header = nil
    self.HeaderLogo = nil

    self.Title = nil
    self.Subtitle = nil
    self.Close = nil

    self.Sidebar = nil
    self.Content = nil
    self.ContentTitle = nil
    self.Scroll = nil

end

--==================================================
-- RETURN
--==================================================

return UI
