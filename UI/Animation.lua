--// 💥 RIMURU HUB
--// UI Animation System
--// Open / Close / Effects
--// Modular UI Architecture

local TweenService =
    game:GetService(
        "TweenService"
    )

local Animation = {}

--==================================================
-- DEFAULTS
--==================================================

local DEFAULT_TIME =
    0.25

local DEFAULT_STYLE =
    Enum.EasingStyle.Quart

local DEFAULT_DIRECTION =
    Enum.EasingDirection.Out

--==================================================
-- INIT
--==================================================

function Animation:Init(Context)

    self.Context =
        Context or {}

    self.UI =
        self.Context.UI

    self.Target =
        nil

    self.OpenPosition =
        nil

    self.ClosedPosition =
        nil

    self:_Setup()

end

--==================================================
-- SETUP
--==================================================

function Animation:_Setup()

    if not self.UI then
        return false
    end

    self.Target =
        self.UI.Main
        or self.UI.Window

    if not self.Target
    or typeof(self.Target) ~= "Instance"
    then
        return false
    end

    self.OpenPosition =
        self.Target.Position

    self.ClosedPosition =
        UDim2.new(
            self.OpenPosition.X.Scale,
            self.OpenPosition.X.Offset,
            1.15,
            self.OpenPosition.Y.Offset
        )

    return true

end

--==================================================
-- TWEEN
--==================================================

function Animation:Tween(
    Properties,
    Duration
)

    if not self.Target then
        return nil
    end

    if type(Properties) ~=
        "table"
    then
        return nil
    end

    local Info =
        TweenInfo.new(
            tonumber(Duration)
                or DEFAULT_TIME,
            DEFAULT_STYLE,
            DEFAULT_DIRECTION
        )

    local Tween =
        TweenService:Create(
            self.Target,
            Info,
            Properties
        )

    Tween:Play()

    return Tween

end

--==================================================
-- OPEN
--==================================================

function Animation:Open(
    Duration
)

    if not self.Target then
        return false
    end

    self.Target.Visible =
        true

    self:Tween(
        {
            Position =
                self.OpenPosition
        },
        Duration
    )

    return true

end

--==================================================
-- CLOSE
--==================================================

function Animation:Close(
    Duration
)

    if not self.Target then
        return false
    end

    local Tween =
        self:Tween(
            {
                Position =
                    self.ClosedPosition
            },
            Duration
        )

    if Tween then

        Tween.Completed:
            Connect(
                function()

                    if self.Target then

                        self.Target.Visible =
                            false

                    end

                end
            )

    else

        self.Target.Visible =
            false

    end

    return true

end

--==================================================
-- RESET
--==================================================

function Animation:Reset()

    if not self.Target then
        return false
    end

    self.Target.Position =
        self.OpenPosition

    self.Target.Visible =
        true

    return true

end

--==================================================
-- SET TARGET
--==================================================

function Animation:SetTarget(
    Target
)

    if typeof(Target) ~=
        "Instance"
    then
        return false
    end

    self.Target =
        Target

    self.OpenPosition =
        Target.Position

    self.ClosedPosition =
        UDim2.new(
            self.OpenPosition.X.Scale,
            self.OpenPosition.X.Offset,
            1.15,
            self.OpenPosition.Y.Offset
        )

    return true

end

return Animation
