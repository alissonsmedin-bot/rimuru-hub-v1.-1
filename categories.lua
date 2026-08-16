--// 💥 RIMURU HUB
--// Categories System

local Categories = {}

--==================================================
-- CATEGORY ICONS
--==================================================

local CategoryIcons = {

    ["Outro"] =
        "🏠",

    ["Heian Sukuna Sounds"] =
        "👹",

    ["Configuração"] =
        "⚙️"

}

--==================================================
-- INIT
--==================================================

function Categories:Init(Context)

    self.Context =
        Context

    self.Config =
        Context.Config

    self.Sounds =
        Context.Sounds

    self.Theme =
        Context.Theme

    self.UI =
        Context.UI

    self.Cards =
        Context.Cards

    self.Sidebar =
        self.UI.Sidebar

    self.Scroll =
        self.UI.Scroll

    self.ContentTitle =
        self.UI.ContentTitle

    self.SelectedButton =
        nil

    self.CategoryButtons =
        {}

end

--==================================================
-- GET CATEGORY ICON
--==================================================

function Categories:GetIcon(CategoryName)

    return CategoryIcons[CategoryName]
        or "📁"

end

--==================================================
-- CLEAR CONTENT
--==================================================

function Categories:ClearContent()

    for _, Object in
        ipairs(
            self.Scroll:GetChildren()
        ) do

        if not Object:IsA(
            "UIListLayout"
        )
        and not Object:IsA(
            "UIPadding"
        ) then

            Object:Destroy()

        end

    end

end

--==================================================
-- SHOW CATEGORY
--==================================================

function Categories:ShowCategory(
    CategoryName
)

    self:ClearContent()

    self.ContentTitle.Text =
        CategoryName

    local Category =
        self.Sounds[CategoryName]

    if not Category then
        return
    end

    for Index, Data in
        ipairs(Category) do

        self.Cards:CreateSoundCard(

            Index,

            Data

        )

    end

end

--==================================================
-- SELECT BUTTON
--==================================================

function Categories:SelectButton(
    Button
)

    if self.SelectedButton
    and self.SelectedButton ~= Button then

        self.SelectedButton.BackgroundColor3 =
            self.Theme:GetCurrent().Button

        self.SelectedButton.TextColor3 =
            self.Theme:GetCurrent().SubText

    end

    self.SelectedButton =
        Button

    Button.BackgroundColor3 =
        self.Theme:GetAccent()

    Button.TextColor3 =
        Color3.fromRGB(
            255,
            255,
            255
        )

end

--==================================================
-- CREATE CATEGORY BUTTON
--==================================================

function Categories:CreateCategoryButton(

    CategoryName,

    Order,

    ShowSoundCategory

)

    if ShowSoundCategory == nil then

        ShowSoundCategory =
            true

    end

    local CurrentTheme =
        self.Theme:GetCurrent()

    local Button =
        Instance.new(
            "TextButton"
        )

    Button.Name =
        CategoryName

    Button.Size =
        UDim2.new(
            1,
            0,
            0,
            38
        )

    Button.BackgroundColor3 =
        CurrentTheme.Button

    Button.BorderSizePixel =
        0

    --==================================================
    -- CATEGORY ICON
    --==================================================

    local Icon =
        self:GetIcon(
            CategoryName
        )

    Button.Text =
        Icon ..
        "  " ..
        CategoryName

    Button.TextColor3 =
        CurrentTheme.SubText

    Button.TextSize =
        11

    Button.Font =
        Enum.Font.GothamMedium

    Button.TextXAlignment =
        Enum.TextXAlignment.Left

    Button.AutoButtonColor =
        false

    Button.LayoutOrder =
        Order

    Button.ZIndex =
        503

    Button.Parent =
        self.Sidebar

    --==================================================
    -- PADDING
    --==================================================

    local ButtonPadding =
        Instance.new(
            "UIPadding"
        )

    ButtonPadding.PaddingLeft =
        UDim.new(
            0,
            10
        )

    ButtonPadding.Parent =
        Button

    --==================================================
    -- CORNER
    --==================================================

    local ButtonCorner =
        Instance.new(
            "UICorner"
        )

    ButtonCorner.CornerRadius =
        UDim.new(
            0,
            7
        )

    ButtonCorner.Parent =
        Button

    --==================================================
    -- CLICK
    --==================================================

    Button.MouseButton1Click:Connect(

        function()

            self:SelectButton(
                Button
            )

            if ShowSoundCategory then

                self:ShowCategory(
                    CategoryName
                )

            end

        end

    )

    self.CategoryButtons[
        CategoryName
    ] =
        Button

    return Button

end

--==================================================
-- CREATE ALL CATEGORIES
--==================================================

function Categories:CreateCategories()

    local CategoryIndex =
        0

    for CategoryName in
        pairs(
            self.Sounds
        ) do

        CategoryIndex += 1

        self:CreateCategoryButton(

            CategoryName,

            CategoryIndex,

            true

        )

    end

    --==================================================
    -- CONFIGURATION BUTTON
    --==================================================

    local ConfigButton =
        self:CreateCategoryButton(

            "Configuração",

            CategoryIndex + 1,

            false

        )

    self.ConfigButton =
        ConfigButton

    return CategoryIndex

end

--==================================================
-- DEFAULT CATEGORY
--==================================================

function Categories:SetDefaultCategory()

    if not self.Sounds[
        "Outro"
    ] then

        return

    end

    self:ShowCategory(
        "Outro"
    )

    local PrincipalButton =
        self.CategoryButtons[
            "Outro"
        ]

    if PrincipalButton then

        self:SelectButton(
            PrincipalButton
        )

    end

end

--==================================================
-- GET SELECTED BUTTON
--==================================================

function Categories:GetSelectedButton()

    return self.SelectedButton

end

--==================================================
-- GET CATEGORY BUTTON
--==================================================

function Categories:GetButton(
    CategoryName
)

    return self.CategoryButtons[
        CategoryName
    ]

end

--==================================================
-- APPLY THEME
--==================================================

function Categories:ApplyTheme()

    local CurrentTheme =
        self.Theme:GetCurrent()

    for _, Button in
        pairs(
            self.CategoryButtons
        ) do

        if Button ==
            self.SelectedButton then

            Button.BackgroundColor3 =
                self.Theme:GetAccent()

            Button.TextColor3 =
                Color3.fromRGB(
                    255,
                    245,
                    235
                )

        else

            Button.BackgroundColor3 =
                CurrentTheme.Button

            Button.TextColor3 =
                CurrentTheme.SubText

        end

    end

end

--==================================================
-- RETURN
--==================================================

return Categories
