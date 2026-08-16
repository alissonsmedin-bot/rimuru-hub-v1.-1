--// 💥 RIMURU HUB
--// UI Results System
--// Results / Cards Container
--// Modular UI Architecture

local Results = {}

--==================================================
-- INIT
--==================================================

function Results:Init(Context)

    self.Context =
        Context or {}

    self.UI =
        self.Context.UI

    self.Theme =
        self.Context.Theme

    self.Config =
        self.Context.Config

    self.Container =
        nil

    self.Scroll =
        nil

    self:_Create()

end

--==================================================
-- CREATE
--==================================================

function Results:_Create()

    if not self.UI then
        return false
    end

    local Parent =
        self.UI.Content
        or self.UI.Main
        or self.UI.Window

    if not Parent
    or typeof(Parent) ~= "Instance"
    then
        return false
    end

    --==================================================
    -- CONTAINER
    --==================================================

    local Container =
        Instance.new("Frame")

    Container.Name =
        "Results"

    Container.BackgroundTransparency =
        1

    Container.BorderSizePixel =
        0

    Container.Size =
        UDim2.new(
            1,
            -20,
            1,
            -20
        )

    Container.Position =
        UDim2.new(
            0,
            10,
            0,
            10
        )

    Container.Parent =
        Parent

    self.Container =
        Container

    --==================================================
    -- SCROLL
    --==================================================

    local Scroll =
        Instance.new(
            "ScrollingFrame"
        )

    Scroll.Name =
        "Scroll"

    Scroll.BackgroundTransparency =
        1

    Scroll.BorderSizePixel =
        0

    Scroll.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    Scroll.CanvasSize =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Scroll.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Scroll.ScrollBarThickness =
        4

    Scroll.ScrollBarImageTransparency =
        0.35

    Scroll.Parent =
        Container

    self.Scroll =
        Scroll

    --==================================================
    -- LAYOUT
    --==================================================

    local Layout =
        Instance.new(
            "UIListLayout"
        )

    Layout.Name =
        "Layout"

    Layout.Padding =
        UDim.new(
            0,
            6
        )

    Layout.SortOrder =
        Enum.SortOrder.LayoutOrder

    Layout.Parent =
        Scroll

    --==================================================
    -- PADDING
    --==================================================

    local Padding =
        Instance.new(
            "UIPadding"
        )

    Padding.PaddingTop =
        UDim.new(
            0,
            4
        )

    Padding.PaddingBottom =
        UDim.new(
            0,
            8
        )

    Padding.PaddingLeft =
        UDim.new(
            0,
            2
        )

    Padding.PaddingRight =
        UDim.new(
            0,
            2
        )

    Padding.Parent =
        Scroll

    return true

end

--==================================================
-- GET SCROLL
--==================================================

function Results:GetScroll()

    if self.Scroll
    and self.Scroll.Parent
    then

        return self.Scroll

    end

    return nil

end

--==================================================
-- GET CONTAINER
--==================================================

function Results:GetContainer()

    return self.Container

end

--==================================================
-- CLEAR
--==================================================

function Results:Clear()

    local Scroll =
        self:GetScroll()

    if not Scroll then
        return false
    end

    for _, Object in
        ipairs(
            Scroll:GetChildren()
        )
    do

        if not Object:IsA(
            "UIListLayout"
        )
        and not Object:IsA(
            "UIPadding"
        )
        then

            Object:Destroy()

        end

    end

    return true

end

--==================================================
-- SET VISIBLE
--==================================================

function Results:SetVisible(
    Visible
)

    if not self.Container then
        return false
    end

    self.Container.Visible =
        Visible == true

    return true

end

--==================================================
-- GET VISIBLE
--==================================================

function Results:IsVisible()

    if not self.Container then
        return false
    end

    return self.Container.Visible

end

--==================================================
-- APPLY THEME
--==================================================

function Results:ApplyTheme()

    if not self.Scroll then
        return
    end

    -- Results intentionally
    -- remains transparent.

    self.Scroll.BackgroundTransparency =
        1

end

return Results
