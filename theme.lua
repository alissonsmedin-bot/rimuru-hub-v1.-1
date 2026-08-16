--// 🎨 RIMURU HUB
--// Theme System
--// CLEAN REWORK
--// Theme Core
--// Compatible with Config + UI + Settings + RGB
--// Runtime Color Editing
--// Background handled by UI.lua
--// No dependency on Background.lua

local Theme = {}

--==================================================
-- DEFAULT THEMES
--==================================================

local DefaultThemes = {

    ["Rimuru Dark"] = {

        Main =
            Color3.fromRGB(
                15,
                17,
                22
            ),

        Sidebar =
            Color3.fromRGB(
                18,
                21,
                28
            ),

        Content =
            Color3.fromRGB(
                20,
                23,
                30
            ),

        Card =
            Color3.fromRGB(
                28,
                32,
                40
            ),

        Button =
            Color3.fromRGB(
                35,
                40,
                50
            ),

        Text =
            Color3.fromRGB(
                240,
                245,
                255
            ),

        SubText =
            Color3.fromRGB(
                160,
                170,
                185
            ),

        Accent =
            Color3.fromRGB(
                80,
                170,
                255
            ),

        LogoBackground =
            Color3.fromRGB(
                25,
                30,
                40
            ),

        Close =
            Color3.fromRGB(
                150,
                45,
                55
            ),

        BackgroundTransparency =
            0.35,

        RGB =
            false,

    },

    ["Slime"] = {

        Main =
            Color3.fromRGB(
                12,
                25,
                23
            ),

        Sidebar =
            Color3.fromRGB(
                15,
                35,
                31
            ),

        Content =
            Color3.fromRGB(
                17,
                42,
                36
            ),

        Card =
            Color3.fromRGB(
                25,
                55,
                47
            ),

        Button =
            Color3.fromRGB(
                30,
                70,
                58
            ),

        Text =
            Color3.fromRGB(
                235,
                255,
                245
            ),

        SubText =
            Color3.fromRGB(
                155,
                195,
                175
            ),

        Accent =
            Color3.fromRGB(
                75,
                220,
                145
            ),

        LogoBackground =
            Color3.fromRGB(
                20,
                55,
                45
            ),

        Close =
            Color3.fromRGB(
                150,
                55,
                65
            ),

        BackgroundTransparency =
            0.35,

        RGB =
            false,

    },

    ["RGB"] = {

        Main =
            Color3.fromRGB(
                15,
                15,
                20
            ),

        Sidebar =
            Color3.fromRGB(
                20,
                20,
                27
            ),

        Content =
            Color3.fromRGB(
                23,
                23,
                30
            ),

        Card =
            Color3.fromRGB(
                30,
                30,
                40
            ),

        Button =
            Color3.fromRGB(
                38,
                38,
                50
            ),

        Text =
            Color3.fromRGB(
                245,
                245,
                255
            ),

        SubText =
            Color3.fromRGB(
                165,
                165,
                180
            ),

        Accent =
            Color3.fromRGB(
                255,
                0,
                255
            ),

        LogoBackground =
            Color3.fromRGB(
                25,
                25,
                35
            ),

        Close =
            Color3.fromRGB(
                160,
                45,
                60
            ),

        BackgroundTransparency =
            0.30,

        RGB =
            true,

    },

}

--==================================================
-- CLONE TABLE
--==================================================

local function CloneTable(Source)

    local Result = {}

    if type(Source) ~= "table" then
        return Result
    end

    for Key, Value in pairs(Source) do

        if type(Value) == "table" then

            Result[Key] =
                CloneTable(Value)

        else

            Result[Key] =
                Value

        end

    end

    return Result

end

--==================================================
-- INIT
--==================================================

function Theme:Init(Context)

    self.Context =
        Context or {}

    self.Config =
        self.Context.Config

    self.UI =
        self.Context.UI

    self.Themes = {}

    --==================================================
    -- COPY DEFAULT THEMES
    --==================================================

    for Name, Data in pairs(DefaultThemes) do

        self.Themes[Name] =
            CloneTable(Data)

    end

    --==================================================
    -- LOAD CUSTOM THEMES FROM CONFIG
    --==================================================

    if self.Config
    and type(self.Config.Get) == "function"
    then

        local Success,
            ConfigThemes =
            pcall(
                function()

                    return self.Config:Get(
                        "Theme",
                        "Themes"
                    )

                end
            )

        if Success
        and type(ConfigThemes) == "table"
        then

            for Name, Data in pairs(ConfigThemes) do

                if type(Data) == "table" then

                    self.Themes[Name] =
                        CloneTable(Data)

                end

            end

        end

    end

    --==================================================
    -- DEFAULT THEME
    --==================================================

    self.Name =
        "Rimuru Dark"

    --==================================================
    -- LOAD SAVED THEME
    --==================================================

    if self.Config
    and type(
        self.Config.GetSelectedTheme
    ) == "function"
    then

        local Success,
            SavedTheme =
            pcall(
                function()

                    return self.Config:
                        GetSelectedTheme()

                end
            )

        if Success
        and type(SavedTheme) == "string"
        and self.Themes[SavedTheme]
        then

            self.Name =
                SavedTheme

        end

    end

    --==================================================
    -- FALLBACK
    --==================================================

    if not self.Themes[self.Name] then

        for ThemeName in pairs(self.Themes) do

            self.Name =
                ThemeName

            break

        end

    end

    --==================================================
    -- CURRENT THEME
    --==================================================

    self.Current =
        self.Themes[self.Name]

    --==================================================
    -- RGB
    --==================================================

    self.RGBHue =
        0

    self.RGBEnabled =
        false

    --==================================================
    -- BACKGROUND TRANSPARENCY
    --==================================================

    self.BackgroundTransparency =
        self:GetBackgroundTransparency()

end

--==================================================
-- GET ACCENT
--==================================================

function Theme:GetAccent()

    if not self.Current then

        return Color3.fromRGB(
            80,
            170,
            255
        )

    end

    if self.Current.RGB then

        return Color3.fromHSV(
            self.RGBHue,
            0.9,
            1
        )

    end

    return self.Current.Accent
        or Color3.fromRGB(
            80,
            170,
            255
        )

end

--==================================================
-- SET THEME
--==================================================

function Theme:SetTheme(Name)

    if type(Name) ~= "string" then
        return false
    end

    if not self.Themes[Name] then
        return false
    end

    self.Name =
        Name

    self.Current =
        self.Themes[Name]

    self.RGBHue =
        0

    --==================================================
    -- SAVE SELECTED THEME
    --==================================================

    if self.Config then

        if type(
            self.Config.SetSelectedTheme
        ) == "function"
        then

            pcall(
                function()

                    self.Config:
                        SetSelectedTheme(
                            Name
                        )

                end
            )

        elseif type(
            self.Config.Set
        ) == "function"
        then

            pcall(
                function()

                    self.Config:Set(
                        "Theme",
                        "Selected",
                        Name
                    )

                end
            )

        end

    end

    --==================================================
    -- UPDATE TRANSPARENCY
    --==================================================

    self.BackgroundTransparency =
        self:GetBackgroundTransparency()

    --==================================================
    -- APPLY UI
    --==================================================

    if self.UI
    and type(
        self.UI.ApplyTheme
    ) == "function"
    then

        task.defer(
            function()

                pcall(
                    function()

                        self.UI:
                            ApplyTheme()

                    end
                )

            end
        )

    end

    return true

end

--==================================================
-- GET BACKGROUND IMAGE
--==================================================

function Theme:GetBackgroundImage()

    -- Background loading is handled by UI.lua.
    -- This function remains for compatibility.

    if self.UI
    and type(
        self.UI.GetBackground
    ) == "function"
    then

        local Background =
            self.UI:GetBackground()

        if Background
        and Background.Image
        and Background.Image ~= ""
        then

            return Background.Image

        end

    end

    return nil

end

--==================================================
-- HAS BACKGROUND IMAGE
--==================================================

function Theme:HasBackgroundImage()

    if self.UI
    and type(
        self.UI.GetBackground
    ) == "function"
    then

        local Background =
            self.UI:GetBackground()

        if Background
        and Background.Image
        and Background.Image ~= ""
        then

            return true

        end

    end

    return false

end

--==================================================
-- GET BACKGROUND TRANSPARENCY
--==================================================

function Theme:GetBackgroundTransparency()

    --==================================================
    -- CONFIG
    --==================================================

    if self.Config
    and type(
        self.Config.GetBackgroundTransparency
    ) == "function"
    then

        local Success,
            Value =
            pcall(
                function()

                    return self.Config:
                        GetBackgroundTransparency()

                end
            )

        if Success
        and type(Value) == "number"
        then

            return math.clamp(
                Value,
                0,
                1
            )

        end

    end

    --==================================================
    -- CURRENT THEME
    --==================================================

    if self.Current
    and self.Current.BackgroundTransparency
        ~= nil
    then

        return math.clamp(
            self.Current.BackgroundTransparency,
            0,
            1
        )

    end

    --==================================================
    -- INTERNAL VALUE
    --==================================================

    if type(
        self.BackgroundTransparency
    ) == "number"
    then

        return math.clamp(
            self.BackgroundTransparency,
            0,
            1
        )

    end

    return 0.78

end

--==================================================
-- SET BACKGROUND TRANSPARENCY
--==================================================

function Theme:SetBackgroundTransparency(
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

    self.BackgroundTransparency =
        Value

    if self.Current then

        self.Current.BackgroundTransparency =
            Value

    end

    --==================================================
    -- SAVE CONFIG
    --==================================================

    if self.Config
    and type(
        self.Config.SetBackgroundTransparency
    ) == "function"
    then

        pcall(
            function()

                self.Config:
                    SetBackgroundTransparency(
                        Value
                    )

            end
        )

    end

    --==================================================
    -- UPDATE UI BACKGROUND
    --==================================================

    if self.UI
    and type(
        self.UI.SetBackgroundTransparency
    ) == "function"
    then

        pcall(
            function()

                self.UI:
                    SetBackgroundTransparency(
                        Value
                    )

            end
        )

    end

    return true

end

--==================================================
-- GET BACKGROUND SETTINGS
--==================================================

function Theme:GetBackgroundSettings()

    return {

        Image =
            self:GetBackgroundImage(),

        Transparency =
            self:GetBackgroundTransparency(),

        Theme =
            self.Name,

    }

end

--==================================================
-- UPDATE RGB
--==================================================

function Theme:UpdateRGB()

    if not self.Current then
        return nil
    end

    if not self.Current.RGB then
        return nil
    end

    self.RGBHue +=
        0.0025

    if self.RGBHue >= 1 then

        self.RGBHue =
            0

    end

    return Color3.fromHSV(
        self.RGBHue,
        0.9,
        1
    )

end

--==================================================
-- SET RGB HUE
--==================================================

function Theme:SetRGBHue(Value)

    Value =
        tonumber(Value)

    if not Value then
        return false
    end

    self.RGBHue =
        math.clamp(
            Value,
            0,
            1
        )

    return true

end

--==================================================
-- GET RGB HUE
--==================================================

function Theme:GetRGBHue()

    return self.RGBHue or 0

end

--==================================================
-- IS RGB
--==================================================

function Theme:IsRGB()

    if not self.Current then
        return false
    end

    return
        self.Current.RGB == true

end

--==================================================
-- GET CURRENT
--==================================================

function Theme:GetCurrent()

    return self.Current

end

--==================================================
-- GET NAME
--==================================================

function Theme:GetName()

    return self.Name

end

--==================================================
-- GET CURRENT THEME NAME
--==================================================

function Theme:GetCurrentThemeName()

    return self.Name

end

--==================================================
-- GET THEMES
--==================================================

function Theme:GetThemes()

    return self.Themes

end

--==================================================
-- GET THEME
--==================================================

function Theme:GetTheme(Name)

    return self.Themes[Name]

end

--==================================================
-- HAS THEME
--==================================================

function Theme:HasTheme(Name)

    return
        self.Themes[Name] ~= nil

end

--==================================================
-- GET THEME NAMES
--==================================================

function Theme:GetThemeNames()

    local Names =
        {}

    for Name in pairs(self.Themes) do

        table.insert(
            Names,
            Name
        )

    end

    table.sort(
        Names
    )

    return Names

end

--==================================================
-- SET COLOR
--==================================================

function Theme:SetColor(
    Name,
    Color
)

    if not self.Current then
        return false
    end

    if typeof(Color) ~= "Color3" then
        return false
    end

    local Allowed = {

        Main = true,

        Sidebar = true,

        Content = true,

        Card = true,

        Button = true,

        Text = true,

        SubText = true,

        Accent = true,

        LogoBackground = true,

        Close = true,

    }

    if not Allowed[Name] then
        return false
    end

    self.Current[Name] =
        Color

    --==================================================
    -- APPLY
    --==================================================

    if self.UI
    and type(
        self.UI.ApplyTheme
    ) == "function"
    then

        task.defer(
            function()

                pcall(
                    function()

                        self.UI:
                            ApplyTheme()

                    end
                )

            end
        )

    end

    return true

end

--==================================================
-- GET COLOR
--==================================================

function Theme:GetColor(Name)

    if not self.Current then
        return nil
    end

    if Name == "Accent" then

        return self:GetAccent()

    end

    return self.Current[Name]

end

--==================================================
-- RESET CURRENT
--==================================================

function Theme:ResetCurrent()

    if not self.Name then
        return false
    end

    local Default =
        DefaultThemes[self.Name]

    if not Default then
        return false
    end

    self.Current =
        CloneTable(Default)

    self.Themes[self.Name] =
        self.Current

    self.RGBHue =
        0

    self.BackgroundTransparency =
        self.Current.BackgroundTransparency
        or 0.78

    --==================================================
    -- SAVE TRANSPARENCY
    --==================================================

    if self.Config
    and type(
        self.Config.SetBackgroundTransparency
    ) == "function"
    then

        pcall(
            function()

                self.Config:
                    SetBackgroundTransparency(
                        self.BackgroundTransparency
                    )

            end
        )

    end

    --==================================================
    -- APPLY RESET TO UI
    --==================================================

    if self.UI
    and type(
        self.UI.ApplyTheme
    ) == "function"
    then

        task.defer(
            function()

                pcall(
                    function()

                        self.UI:
                            ApplyTheme()

                    end
                )

            end
        )

    end

    return true

end

--==================================================
-- SAVE CUSTOM THEME
--==================================================

function Theme:SaveTheme(
    Name
)

    if type(Name) ~= "string"
    or Name == ""
    then

        return false

    end

    if not self.Current then

        return false

    end

    self.Themes[Name] =
        CloneTable(
            self.Current
        )

    --==================================================
    -- CONFIG
    --==================================================

    if self.Config
    and type(
        self.Config.Set
    ) == "function"
    then

        pcall(
            function()

                self.Config:Set(
                    "Theme",
                    "Themes",
                    self.Themes
                )

            end
        )

    end

    return true

end

--==================================================
-- DELETE THEME
--==================================================

function Theme:DeleteTheme(
    Name
)

    if type(Name) ~= "string" then
        return false
    end

    --==================================================
    -- PROTECT DEFAULT THEMES
    --==================================================

    if DefaultThemes[Name] then

        return false

    end

    if not self.Themes[Name] then

        return false

    end

    --==================================================
    -- DELETE
    --==================================================

    self.Themes[Name] =
        nil

    --==================================================
    -- SAVE
    --==================================================

    if self.Config
    and type(
        self.Config.Set
    ) == "function"
    then

        pcall(
            function()

                self.Config:Set(
                    "Theme",
                    "Themes",
                    self.Themes
                )

            end
        )

    end

    --==================================================
    -- FALLBACK CURRENT
    --==================================================

    if self.Name == Name then

        self:SetTheme(
            "Rimuru Dark"
        )

    end

    return true

end

--==================================================
-- CREATE THEME
--==================================================

function Theme:CreateTheme(
    Name,
    BaseTheme
)

    if type(Name) ~= "string"
    or Name == ""
    then

        return false

    end

    if self.Themes[Name] then

        return false

    end

    local Source

    if type(BaseTheme) == "string" then

        Source =
            self.Themes[
                BaseTheme
            ]

    end

    if not Source then

        Source =
            self.Current

    end

    if not Source then

        Source =
            DefaultThemes[
                "Rimuru Dark"
            ]

    end

    self.Themes[Name] =
        CloneTable(
            Source
        )

    --==================================================
    -- CUSTOM THEME IS NOT RGB
    --==================================================

    self.Themes[Name].RGB =
        false

    --==================================================
    -- SAVE
    --==================================================

    if self.Config
    and type(
        self.Config.Set
    ) == "function"
    then

        pcall(
            function()

                self.Config:Set(
                    "Theme",
                    "Themes",
                    self.Themes
                )

            end
        )

    end

    return true

end

--==================================================
-- COPY THEME
--==================================================

function Theme:CopyTheme(
    SourceName,
    NewName
)

    if type(SourceName) ~= "string"
    or type(NewName) ~= "string"
    then

        return false

    end

    if NewName == "" then

        return false

    end

    if not self.Themes[
        SourceName
    ]
    then

        return false

    end

    if self.Themes[
        NewName
    ]
    then

        return false

    end

    self.Themes[
        NewName
    ] =
        CloneTable(
            self.Themes[
                SourceName
            ]
        )

    --==================================================
    -- SAVE
    --==================================================

    if self.Config
    and type(
        self.Config.Set
    ) == "function"
    then

        pcall(
            function()

                self.Config:Set(
                    "Theme",
                    "Themes",
                    self.Themes
                )

            end
        )

    end

    return true

end

--==================================================
-- SET CURRENT THEME COLOR
--==================================================

function Theme:SetCurrentColor(
    ColorName,
    Color
)

    return self:SetColor(
        ColorName,
        Color
    )

end

--==================================================
-- GET CURRENT COLOR
--==================================================

function Theme:GetCurrentColor(
    ColorName
)

    return self:GetColor(
        ColorName
    )

end

--==================================================
-- GET DEFAULT THEME
--==================================================

function Theme:GetDefaultTheme(
    Name
)

    if type(Name) ~= "string" then

        return nil

    end

    local Default =
        DefaultThemes[
            Name
        ]

    if not Default then

        return nil

    end

    return CloneTable(
        Default
    )

end

--==================================================
-- IS DEFAULT THEME
--==================================================

function Theme:IsDefaultTheme(
    Name
)

    if type(Name) ~= "string" then

        return false

    end

    return
        DefaultThemes[
            Name
        ] ~= nil

end

--==================================================
-- GET DEFAULT THEMES
--==================================================

function Theme:GetDefaultThemes()

    local Result =
        {}

    for Name, Data in
        pairs(DefaultThemes)
    do

        Result[Name] =
            CloneTable(
                Data
            )

    end

    return Result

end

--==================================================
-- GET THEME COUNT
--==================================================

function Theme:GetThemeCount()

    local Count =
        0

    for _ in pairs(
        self.Themes
    )
    do

        Count +=
            1

    end

    return Count

end

--==================================================
-- REFRESH
--==================================================

function Theme:Refresh()

    if not self.Name then

        return false

    end

    if not self.Themes[
        self.Name
    ]
    then

        return false

    end

    self.Current =
        self.Themes[
            self.Name
        ]

    self.BackgroundTransparency =
        self:GetBackgroundTransparency()

    if self.UI
    and type(
        self.UI.ApplyTheme
    ) == "function"
    then

        task.defer(
            function()

                pcall(
                    function()

                        self.UI:
                            ApplyTheme()

                    end
                )

            end
        )

    end

    return true

end

--==================================================
-- APPLY
--==================================================

function Theme:Apply()

    return self:Refresh()

end

--==================================================
-- EXPORT
--==================================================

function Theme:Export()

    local Data =
        {}

    if not self.Current then

        return Data

    end

    for Key, Value in
        pairs(
            self.Current
        )
    do

        if type(Value) == "table" then

            Data[Key] =
                CloneTable(
                    Value
                )

        else

            Data[Key] =
                Value

        end

    end

    return Data

end

--==================================================
-- EXPORT ALL
--==================================================

function Theme:ExportAll()

    local Data =
        {}

    for Name, ThemeData in
        pairs(
            self.Themes
        )
    do

        Data[Name] =
            CloneTable(
                ThemeData
            )

    end

    return Data

end

--==================================================
-- IMPORT THEME
--==================================================

function Theme:Import(
    Name,
    Data
)

    if type(Name) ~= "string"
    or Name == ""
    then

        return false

    end

    if type(Data) ~= "table" then

        return false

    end

    self.Themes[Name] =
        CloneTable(
            Data
        )

    if self.Name == Name then

        self.Current =
            self.Themes[Name]

        self.RGBHue =
            0

        self.BackgroundTransparency =
            self:GetBackgroundTransparency()

    end

    --==================================================
    -- SAVE
    --==================================================

    if self.Config
    and type(
        self.Config.Set
    ) == "function"
    then

        pcall(
            function()

                self.Config:Set(
                    "Theme",
                    "Themes",
                    self.Themes
                )

            end
        )

    end

    return true

end

--==================================================
-- GET RGB COLOR
--==================================================

function Theme:GetRGBColor()

    if not self:IsRGB() then

        return self:GetAccent()

    end

    return Color3.fromHSV(
        self.RGBHue or 0,
        0.9,
        1
    )

end

--==================================================
-- ENABLE RGB
--==================================================

function Theme:SetRGBEnabled(
    Enabled
)

    self.RGBEnabled =
        Enabled == true

    return self.RGBEnabled

end

--==================================================
-- IS RGB ENABLED
--==================================================

function Theme:IsRGBEnabled()

    return
        self.RGBEnabled == true
        or self:IsRGB()

end

--==================================================
-- RESET RGB
--==================================================

function Theme:ResetRGB()

    self.RGBHue =
        0

    self.RGBEnabled =
        false

    return true

end

--==================================================
-- RETURN
--==================================================

return Theme
