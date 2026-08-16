--// 🎨 RIMURU HUB
--// Theme System
--// Theme Core
--// Compatible with Config + UI + Settings + RGB + Background
--// Runtime Color Editing + Background Switching

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
            0.78,

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
            0.78,

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
            0.78,

        RGB =
            true,

    },

}

--==================================================
-- CLONE
--==================================================

local function CloneTable(
    Source
)

    local Result = {}

    if type(Source) ~= "table" then
        return Result
    end

    for Key, Value in
        pairs(Source)
    do

        if type(Value) == "table" then

            Result[Key] =
                CloneTable(
                    Value
                )

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

function Theme:Init(
    Context
)

    self.Context =
        Context or {}

    self.Config =
        self.Context.Config

    self.Background =
        self.Context.Background

    self.Themes = {}

    --==================================================
    -- COPY DEFAULT THEMES
    --==================================================

    for Name, Data in
        pairs(DefaultThemes)
    do

        self.Themes[Name] =
            CloneTable(
                Data
            )

    end

    --==================================================
    -- CUSTOM THEMES
    --==================================================

    if self.Config then

        local ConfigThemes

        if type(
            self.Config.Get
        ) == "function"
        then

            ConfigThemes =
                self.Config:Get(
                    "Theme",
                    "Themes"
                )

        end

        if type(
            ConfigThemes
        ) == "table"
        then

            for Name, Data in
                pairs(ConfigThemes)
            do

                if type(Data) ==
                    "table"
                then

                    self.Themes[Name] =
                        CloneTable(
                            Data
                        )

                end

            end

        end

    end

    --==================================================
    -- DEFAULT THEME
    --==================================================

    self.Name =
        "Rimuru Dark"

    if self.Config
    and type(
        self.Config.GetSelectedTheme
    ) == "function"
    then

        local SavedTheme =
            self.Config:
                GetSelectedTheme()

        if type(SavedTheme) ==
            "string"
        and self.Themes[
            SavedTheme
        ]
        then

            self.Name =
                SavedTheme

        end

    end

    --==================================================
    -- FALLBACK
    --==================================================

    if not self.Themes[
        self.Name
    ]
    then

        for ThemeName in
            pairs(self.Themes)
        do

            self.Name =
                ThemeName

            break

        end

    end

    --==================================================
    -- CURRENT
    --==================================================

    self.Current =
        self.Themes[
            self.Name
        ]

    self.RGBHue =
        0

    self.RGBEnabled =
        false

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

function Theme:SetTheme(
    Name
)

    if not self.Themes[
        Name
    ]
    then

        return false

    end

    self.Name =
        Name

    self.Current =
        self.Themes[
            Name
        ]

    self.RGBHue =
        0

    --==================================================
    -- SAVE
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
    -- TRANSPARENCY
    --==================================================

    self.BackgroundTransparency =
        self:GetBackgroundTransparency()

    --==================================================
    -- APPLY BACKGROUND
    --==================================================

    if self.Background
    and type(
        self.Background.Apply
    ) == "function"
    then

        task.defer(
            function()

                local Success,
                    Error =
                    pcall(
                        function()

                            self.Background:
                                Apply(
                                    Name
                                )

                        end
                    )

                if not Success then

                    warn(
                        "[Rimuru Hub] Erro ao trocar background: "
                        .. tostring(Error)
                    )

                end

            end
        )

    end

    --==================================================
    -- APPLY UI THEME
    --==================================================

    if self.Context
    and self.Context.Settings
    and type(
        self.Context.Settings.ApplyTheme
    ) == "function"
    then

        task.defer(
            function()

                pcall(
                    function()

                        self.Context.Settings:
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

    if self.Background
    and type(
        self.Background.GetData
    ) == "function"
    then

        local Data =
            self.Background:
                GetData(
                    self.Name
                )

        if Data then

            return Data.URL

        end

    end

    return nil

end

--==================================================
-- HAS BACKGROUND IMAGE
--==================================================

function Theme:HasBackgroundImage()

    return
        self:GetBackgroundImage()
        ~= nil

end

--==================================================
-- GET BACKGROUND TRANSPARENCY
--==================================================

function Theme:GetBackgroundTransparency()

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
        and type(Value) ==
            "number"
        then

            return math.clamp(
                Value,
                0,
                1
            )

        end

    end

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
        tonumber(
            Value
        )

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
    -- CONFIG
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
    -- REAL BACKGROUND
    --==================================================

    if self.Background
    and type(
        self.Background.SetTransparency
    ) == "function"
    then

        pcall(
            function()

                self.Background:
                    SetTransparency(
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

function Theme:GetTheme(
    Name
)

    return self.Themes[
        Name
    ]

end

--==================================================
-- HAS THEME
--==================================================

function Theme:HasTheme(
    Name
)

    return self.Themes[
        Name
    ] ~= nil

end

--==================================================
-- GET THEME NAMES
--==================================================

function Theme:GetThemeNames()

    local Names =
        {}

    for Name in
        pairs(self.Themes)
    do

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

    if typeof(Color) ~=
        "Color3"
    then

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

    if not Allowed[
        Name
    ]
    then

        return false

    end

    self.Current[
        Name
    ] =
        Color

    return true

end

--==================================================
-- GET COLOR
--==================================================

function Theme:GetColor(
    Name
)

    if not self.Current then
        return nil
    end

    if Name == "Accent" then

        return self:GetAccent()

    end

    return self.Current[
        Name
    ]

end

--==================================================
-- RESET CURRENT
--==================================================

function Theme:ResetCurrent()

    if not self.Name then
        return false
    end

    local Default =
        DefaultThemes[
            self.Name
        ]

    if not Default then
        return false
    end

    self.Current =
        CloneTable(
            Default
        )

    self.Themes[
        self.Name
    ] =
        self.Current

    self.RGBHue =
        0

    self.BackgroundTransparency =
        self.Current.BackgroundTransparency
        or 0.78

    --==================================================
    -- RESET BACKGROUND
    --==================================================

    if self.Background
    and type(
        self.Background.Apply
    ) == "function"
    then

        task.defer(
            function()

                pcall(
                    function()

                        self.Background:
                            Apply(
                                self.Name
                            )

                    end
                )

            end
        )

    end

    return true

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

        Data[Key] =
            Value

    end

    return Data

end

--==================================================
-- RETURN
--==================================================

return Theme
