--// 💥 RIMURU HUB
--// Background System
--// External Image + Local Asset Fallback
--// Rimuru Dark / Slime
--// Automatic Theme Background Switching

local Background = {}

--==================================================
-- SERVICES
--==================================================

local Players =
    game:GetService("Players")

--==================================================
-- BACKGROUND DATABASE
--==================================================

Background.Images = {

    ["Rimuru Dark"] = {

        URL =
            "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/main/images/rimuru-dark.jpeg",

        Local =
            "rimuru-dark.jpeg",

    },

    ["Slime"] = {

        URL =
            "https://raw.githubusercontent.com/alissonsmedin-bot/rimuru-hub-v1.-1/main/images/slime.jpeg",

        Local =
            "slime.jpeg",

    },

}

--==================================================
-- INIT
--==================================================

function Background:Init(
    Context
)

    self.Context =
        Context or {}

    self.Config =
        self.Context.Config

    self.Theme =
        self.Context.Theme

    self.UI =
        self.Context.UI

    self.Gui =
        self.UI
        and self.UI.Gui

    self.CurrentTheme =
        nil

    self.CurrentImage =
        nil

    self.BackgroundImage =
        nil

    self.BackgroundFrame =
        nil

    self.Enabled =
        true

end

--==================================================
-- GET DATA
--==================================================

function Background:GetData(
    ThemeName
)

    return self.Images[
        ThemeName
    ]

end

--==================================================
-- LOAD EXTERNAL
--==================================================

function Background:LoadExternal(
    URL,
    FileName
)

    if not URL
    or URL == ""
    then

        return nil

    end

    local Success,
        Content =
        pcall(
            function()

                return game:HttpGet(
                    URL
                )

            end
        )

    if not Success
    or not Content
    or Content == ""
    then

        return nil

    end

    --==================================================
    -- SAVE FILE
    --==================================================

    if writefile then

        if isfile then

            if not isfile(
                FileName
            ) then

                pcall(
                    function()

                        writefile(
                            FileName,
                            Content
                        )

                    end
                )

            end

        else

            pcall(
                function()

                    writefile(
                        FileName,
                        Content
                    )

                end
            )

        end

    end

    --==================================================
    -- GET CUSTOM ASSET
    --==================================================

    if getcustomasset
    and isfile
    and isfile(
        FileName
    )
    then

        local SuccessAsset,
            Asset =
            pcall(
                function()

                    return getcustomasset(
                        FileName
                    )

                end
            )

        if SuccessAsset
        and Asset
        then

            return Asset

        end

    end

    return nil

end

--==================================================
-- LOAD LOCAL
--==================================================

function Background:LoadLocal(
    FileName
)

    if not FileName
    or not getcustomasset
    then

        return nil

    end

    if isfile
    and not isfile(
        FileName
    )
    then

        return nil

    end

    local Success,
        Asset =
        pcall(
            function()

                return getcustomasset(
                    FileName
                )

            end
        )

    if Success
    and Asset
    then

        return Asset

    end

    return nil

end

--==================================================
-- GET ASSET
--==================================================

function Background:GetAsset(
    ThemeName
)

    local Data =
        self:GetData(
            ThemeName
        )

    if not Data then
        return nil
    end

    --==================================================
    -- EXTERNAL FIRST
    --==================================================

    if Data.URL then

        local FileName =
            Data.Local
            or (
                "RimuruHub_"
                .. ThemeName
                .. ".image"
            )

        local Asset =
            self:LoadExternal(
                Data.URL,
                FileName
            )

        if Asset then
            return Asset
        end

    end

    --==================================================
    -- LOCAL FALLBACK
    --==================================================

    if Data.Local then

        local Asset =
            self:LoadLocal(
                Data.Local
            )

        if Asset then
            return Asset
        end

    end

    return nil

end

--==================================================
-- CREATE
--==================================================

function Background:Create()

    if not self.Gui then
        return nil
    end

    self:Remove()

    --==================================================
    -- BACKGROUND FRAME
    --==================================================

    local Frame =
        Instance.new(
            "Frame"
        )

    Frame.Name =
        "RimuruBackground"

    Frame.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    Frame.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Frame.BackgroundTransparency =
        1

    Frame.BorderSizePixel =
        0

    Frame.ZIndex =
        0

    Frame.ClipsDescendants =
        true

    Frame.Parent =
        self.Gui

    self.BackgroundFrame =
        Frame

    --==================================================
    -- IMAGE
    --==================================================

    local Image =
        Instance.new(
            "ImageLabel"
        )

    Image.Name =
        "BackgroundImage"

    Image.Size =
        UDim2.new(
            1,
            0,
            1,
            0
        )

    Image.Position =
        UDim2.new(
            0,
            0,
            0,
            0
        )

    Image.BackgroundTransparency =
        1

    Image.BorderSizePixel =
        0

    Image.Image =
        ""

    Image.ScaleType =
        Enum.ScaleType.Crop

    Image.ZIndex =
        0

    Image.Parent =
        Frame

    self.BackgroundImage =
        Image

    --==================================================
    -- REGISTER WITH UI
    --==================================================

    if self.UI then

        self.UI.BackgroundImage =
            Image

    end

    return Image

end

--==================================================
-- APPLY
--==================================================

function Background:Apply(
    ThemeName
)

    if not self.Enabled then

        return false

    end

    if not ThemeName then

        return false

    end

    --==================================================
    -- REMOVE CURRENT IMAGE FIRST
    --==================================================

    self:Remove()

    self.CurrentTheme =
        ThemeName

    self.CurrentImage =
        nil

    --==================================================
    -- GET DATA
    --==================================================

    local Data =
        self:GetData(
            ThemeName
        )

    --==================================================
    -- THEME WITHOUT IMAGE
    --==================================================

    if not Data then

        return true

    end

    --==================================================
    -- LOAD IMAGE
    --==================================================

    local Asset =
        self:GetAsset(
            ThemeName
        )

    if not Asset then

        warn(
            "[Rimuru Hub] Background não carregado: "
            .. ThemeName
        )

        return false

    end

    --==================================================
    -- CREATE IMAGE
    --==================================================

    local Image =
        self:Create()

    if not Image then

        return false

    end

    Image.Image =
        Asset

    Image.ImageTransparency =
        self:GetTransparency()

    self.CurrentImage =
        Asset

    return true

end

--==================================================
-- GET TRANSPARENCY
--==================================================

function Background:GetTransparency()

    if self.Config
    and self.Config.UI
    and self.Config.UI.BackgroundTransparency
    then

        return math.clamp(
            self.Config.UI.BackgroundTransparency,
            0,
            1
        )

    end

    if self.UI
    and type(
        self.UI.GetBackgroundTransparency
    ) == "function"
    then

        local Success,
            Value =
            pcall(
                function()

                    return self.UI:
                        GetBackgroundTransparency()

                end
            )

        if Success
        and typeof(Value) ==
            "number"
        then

            return math.clamp(
                Value,
                0,
                1
            )

        end

    end

    return 0.15

end

--==================================================
-- SET TRANSPARENCY
--==================================================

function Background:SetTransparency(
    Value
)

    Value =
        math.clamp(
            tonumber(Value) or 0,
            0,
            1
        )

    if self.Config
    and self.Config.UI
    then

        self.Config.UI:
            BackgroundTransparency =
            Value

    end

    if self.BackgroundImage then

        self.BackgroundImage:
            ImageTransparency =
            Value

    end

end

--==================================================
-- REMOVE
--==================================================

function Background:Remove()

    if self.BackgroundFrame then

        pcall(
            function()

                self.BackgroundFrame:
                    Destroy()

            end
        )

    end

    self.BackgroundFrame =
        nil

    self.BackgroundImage =
        nil

    if self.UI then

        self.UI.BackgroundImage =
            nil

    end

end

--==================================================
-- REFRESH
--==================================================

function Background:Refresh()

    if not self.CurrentTheme then
        return false
    end

    return self:Apply(
        self.CurrentTheme
    )

end

--==================================================
-- ENABLE
--==================================================

function Background:SetEnabled(
    Value
)

    self.Enabled =
        Value == true

    if not self.Enabled then

        self:Remove()

        return true

    end

    if self.CurrentTheme then

        return self:Apply(
            self.CurrentTheme
        )

    end

    return true

end

--==================================================
-- IS ENABLED
--==================================================

function Background:IsEnabled()

    return self.Enabled == true

end

--==================================================
-- GET CURRENT THEME
--==================================================

function Background:GetCurrentTheme()

    return self.CurrentTheme

end

--==================================================
-- GET CURRENT IMAGE
--==================================================

function Background:GetCurrentImage()

    return self.CurrentImage

end

--==================================================
-- RETURN
--==================================================

return Background
