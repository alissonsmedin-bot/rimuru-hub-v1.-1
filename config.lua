--// 💥 RIMURU HUB
--// Config System
--// Central Configuration
--// UI + Theme + Background + Animation + RGB
--// Compatível com Settings / UI / Theme

local Config = {}

--==================================================
-- DEFAULT CONFIGURATION
--==================================================

local Defaults = {

    --================================================
    -- UI
    --================================================

    UI = {

        Width = 600,

        Height = 400,

        CornerRadius = 12,

        Visible = false,

        Draggable = true,

    },

    --================================================
    -- BACKGROUND
    --================================================

    Background = {

        Enabled = true,

        Selected = "Rimuru Dark",

        Transparency = 0.78,

    },

    --================================================
    -- ANIMATIONS
    --================================================

    Animations = {

        Enabled = true,

        Speed = 0.25,

        Open = true,

        Close = true,

        ThemeChange = true,

    },

    --================================================
    -- RGB
    --================================================

    RGB = {

        Enabled = false,

        Speed = 1,

        Saturation = 1,

        Brightness = 1,

    },

    --================================================
    -- SOUND
    --================================================

    Sound = {

        Enabled = true,

        Volume = 1,

    },

    --================================================
    -- THEME
    --================================================

    Theme = {

        Selected = "Rimuru Dark",

    },

    --================================================
    -- SETTINGS
    --================================================

    Settings = {

        ShowColorPanel = false,

        RememberTheme = true,

        RememberBackground = true,

    },

}

--==================================================
-- INTERNAL DATA
--==================================================

local Data = {}

--==================================================
-- DEEP COPY
--==================================================

local function DeepCopy(Source)

    local Copy = {}

    for Key, Value in pairs(Source) do

        if type(Value) == "table" then

            Copy[Key] =
                DeepCopy(Value)

        else

            Copy[Key] =
                Value

        end

    end

    return Copy

end

--==================================================
-- INIT
--==================================================

function Config:Init()

    Data =
        DeepCopy(
            Defaults
        )

    return self

end

--==================================================
-- GET
--==================================================

function Config:Get(
    Section,
    Key
)

    if not Section then
        return nil
    end

    local SectionData =
        Data[Section]

    if not SectionData then
        return nil
    end

    if Key == nil then

        return SectionData

    end

    return SectionData[Key]

end

--==================================================
-- SET
--==================================================

function Config:Set(
    Section,
    Key,
    Value
)

    if not Section
    or Key == nil then

        return false

    end

    if not Data[Section] then

        Data[Section] = {}

    end

    Data[Section][Key] =
        Value

    return true

end

--==================================================
-- GET SECTION
--==================================================

function Config:GetSection(
    Section
)

    return Data[Section]

end

--==================================================
-- SET SECTION
--==================================================

function Config:SetSection(
    Section,
    Values
)

    if type(Values) ~= "table" then
        return false
    end

    Data[Section] =
        Values

    return true

end

--==================================================
-- UI
--==================================================

function Config:GetUI(
    Key
)

    return self:Get(
        "UI",
        Key
    )

end

function Config:SetUI(
    Key,
    Value
)

    return self:Set(
        "UI",
        Key,
        Value
    )

end

--==================================================
-- BACKGROUND
--==================================================

function Config:GetBackground(
    Key
)

    return self:Get(
        "Background",
        Key
    )

end

function Config:SetBackground(
    Key,
    Value
)

    return self:Set(
        "Background",
        Key,
        Value
    )

end

--==================================================
-- ANIMATIONS
--==================================================

function Config:GetAnimation(
    Key
)

    return self:Get(
        "Animations",
        Key
    )

end

function Config:SetAnimation(
    Key,
    Value
)

    return self:Set(
        "Animations",
        Key,
        Value
    )

end

--==================================================
-- RGB
--==================================================

function Config:GetRGB(
    Key
)

    return self:Get(
        "RGB",
        Key
    )

end

function Config:SetRGB(
    Key,
    Value
)

    return self:Set(
        "RGB",
        Key,
        Value
    )

end

--==================================================
-- SOUND
--==================================================

function Config:GetSound(
    Key
)

    return self:Get(
        "Sound",
        Key
    )

end

function Config:SetSound(
    Key,
    Value
)

    return self:Set(
        "Sound",
        Key,
        Value
    )

end

--==================================================
-- THEME
--==================================================

function Config:GetTheme(
    Key
)

    return self:Get(
        "Theme",
        Key
    )

end

function Config:SetTheme(
    Key,
    Value
)

    return self:Set(
        "Theme",
        Key,
        Value
    )

end

--==================================================
-- SETTINGS
--==================================================

function Config:GetSetting(
    Key
)

    return self:Get(
        "Settings",
        Key
    )

end

function Config:SetSetting(
    Key,
    Value
)

    return self:Set(
        "Settings",
        Key,
        Value
    )

end

--==================================================
-- BACKGROUND TRANSPARENCY
--==================================================

function Config:GetBackgroundTransparency()

    local Value =
        self:GetBackground(
            "Transparency"
        )

    if type(Value) ~= "number" then

        return 0.78

    end

    return math.clamp(
        Value,
        0,
        1
    )

end

function Config:SetBackgroundTransparency(
    Value
)

    if type(Value) ~= "number" then
        return false
    end

    Value =
        math.clamp(
            Value,
            0,
            1
        )

    return self:SetBackground(
        "Transparency",
        Value
    )

end

--==================================================
-- UI SIZE
--==================================================

function Config:GetUISize()

    local Width =
        self:GetUI(
            "Width"
        )

    local Height =
        self:GetUI(
            "Height"
        )

    if type(Width) ~= "number" then
        Width = 600
    end

    if type(Height) ~= "number" then
        Height = 400
    end

    return Width, Height

end

function Config:SetUISize(
    Width,
    Height
)

    if type(Width) ~= "number"
    or type(Height) ~= "number" then

        return false

    end

    self:SetUI(
        "Width",
        Width
    )

    self:SetUI(
        "Height",
        Height
    )

    return true

end

--==================================================
-- SELECTED THEME
--==================================================

function Config:GetSelectedTheme()

    return self:GetTheme(
        "Selected"
    )

end

function Config:SetSelectedTheme(
    ThemeName
)

    if type(ThemeName) ~= "string"
    or ThemeName == "" then

        return false

    end

    return self:SetTheme(
        "Selected",
        ThemeName
    )

end

--==================================================
-- SELECTED BACKGROUND
--==================================================

function Config:GetSelectedBackground()

    return self:GetBackground(
        "Selected"
    )

end

function Config:SetSelectedBackground(
    BackgroundName
)

    if type(BackgroundName) ~= "string"
    or BackgroundName == "" then

        return false

    end

    return self:SetBackground(
        "Selected",
        BackgroundName
    )

end

--==================================================
-- RESET
--==================================================

function Config:Reset()

    Data =
        DeepCopy(
            Defaults
        )

    return true

end

--==================================================
-- RESET SECTION
--==================================================

function Config:ResetSection(
    Section
)

    if not Defaults[Section] then
        return false
    end

    Data[Section] =
        DeepCopy(
            Defaults[Section]
        )

    return true

end

--==================================================
-- GET ALL
--==================================================

function Config:GetAll()

    return Data

end

--==================================================
-- EXPORT
--==================================================

function Config:Export()

    return DeepCopy(
        Data
    )

end

--==================================================
-- IMPORT
--==================================================

function Config:Import(
    NewData
)

    if type(NewData) ~= "table" then
        return false
    end

    Data =
        DeepCopy(
            NewData
        )

    return true

end

--==================================================
-- INITIALIZE
--==================================================

Config:Init()

--==================================================
-- RETURN
--==================================================

return Config
