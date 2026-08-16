--// 💥 RIMURU HUB
--// UI Logo Integration
--// Logo Position / Container
--// Modular UI Architecture

local LogoUI = {}

--==================================================
-- INIT
--==================================================

function LogoUI:Init(Context)

    self.Context =
        Context or {}

    self.UI =
        self.Context.UI

    self.LogoSystem =
        self.Context.Logo

    self.Container =
        nil

    self:_Create()

end

--==================================================
-- CREATE
--==================================================

function LogoUI:_Create()

    if not self.UI then
        return false
    end

    local Parent =
        self.UI.Topbar
        or self.UI.Main

    if not Parent
    or typeof(Parent) ~= "Instance"
    then
        return false
    end

    local Container =
        Instance.new(
            "Frame"
        )

    Container.Name =
        "LogoContainer"

    Container.Size =
        UDim2.new(
            0,
            34,
            0,
            34
        )

    Container.Position =
        UDim2.new(
            0,
            6,
            0,
            4
        )

    Container.BackgroundTransparency =
        1

    Container.BorderSizePixel =
        0

    Container.ZIndex =
        30

    Container.Parent =
        Parent

    self.Container =
        Container

    return true

end

--==================================================
-- GET
--==================================================

function LogoUI:Get()

    return self.Container

end

--==================================================
-- SET IMAGE
--==================================================

function LogoUI:SetImage(
    Image
)

    if not self.Container then
        return false
    end

    if type(Image) ~= "string"
    or Image == ""
    then
        return false
    end

    local ImageObject =
        self.Container:FindFirstChild(
            "Image"
        )

    if not ImageObject then

        ImageObject =
            Instance.new(
                "ImageLabel"
            )

        ImageObject.Name =
            "Image"

        ImageObject.Size =
            UDim2.new(
                1,
                0,
                1,
                0
            )

        ImageObject.Position =
            UDim2.new(
                0,
                0,
                0,
                0
            )

        ImageObject.BackgroundTransparency =
            1

        ImageObject.ScaleType =
            Enum.ScaleType.Fit

        ImageObject.ZIndex =
            31

        ImageObject.Parent =
            self.Container

    end

    ImageObject.Image =
        Image

    return true

end

--==================================================
-- SET SIZE
--==================================================

function LogoUI:SetSize(
    Size
)

    if not self.Container then
        return false
    end

    if typeof(Size) ~=
        "UDim2"
    then
        return false
    end

    self.Container.Size =
        Size

    return true

end

--==================================================
-- SET POSITION
--==================================================

function LogoUI:SetPosition(
    Position
)

    if not self.Container then
        return false
    end

    if typeof(Position) ~=
        "UDim2"
    then
        return false
    end

    self.Container.Position =
        Position

    return true

end

--==================================================
-- SET VISIBLE
--==================================================

function LogoUI:SetVisible(
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

function LogoUI:IsVisible()

    if not self.Container then
        return false
    end

    return self.Container.Visible

end

return LogoUI
