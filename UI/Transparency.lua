--// 💥 RIMURU HUB
--// UI TRANSPARENCY SYSTEM
--// Centralized Transparency Controller
--// Default: 0.75

local Transparency = {}

--==================================================
-- DEFAULT
--==================================================

local DEFAULT_TRANSPARENCY = 0.75

--==================================================
-- INIT
--==================================================

function Transparency:Init(Context)

    self.Context =
        Context or {}

    self.Config =
        self.Context.Config

    self.Theme =
        self.Context.Theme

    self.References =
        self.Context.UIReferences

    self.Value =
        DEFAULT_TRANSPARENCY

    self:_Load()

end

--==================================================
-- LOAD
--==================================================

function Transparency:_Load()

    --==================================================
    -- CONFIG
    --==================================================

    if self.Config then

        if self.Config.UI
        and self.Config.UI.Transparency
        ~= nil
        then

            local Value =
                tonumber(
                    self.Config.UI.Transparency
                )

            if Value then

                self.Value =
                    math.clamp(
                        Value,
                        0,
                        1
                    )

                return self.Value

            end

        end

        if self.Config.UI
        and self.Config.UI.CardTransparency
        ~= nil
        then

            local Value =
                tonumber(
                    self.Config.UI.CardTransparency
                )

            if Value then

                self.Value =
                    math.clamp(
                        Value,
                        0,
                        1
                    )

                return self.Value

            end

        end

    end

    --==================================================
    -- DEFAULT
    --==================================================

    self.Value =
        DEFAULT_TRANSPARENCY

    return self.Value

end

--==================================================
-- GET
--==================================================

function Transparency:Get()

    return self.Value
        or DEFAULT_TRANSPARENCY

end

--==================================================
-- SET
--==================================================

function Transparency:Set(
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

    self.Value =
        Value

    --==================================================
    -- SAVE CONFIG
    --==================================================

    if self.Config then

        if self.Config.UI then

            self.Config.UI.Transparency =
                Value

            self.Config.UI.CardTransparency =
                Value

        end

        if type(
            self.Config.SetCardTransparency
        ) == "function"
        then

            pcall(
                function()

                    self.Config:
                        SetCardTransparency(
                            Value
                        )

                end
            )

        end

    end

    --==================================================
    -- APPLY
    --==================================================

    self:Apply()

    return true

end

--==================================================
-- APPLY
--==================================================

function Transparency:Apply()

    local Root =
        nil

    --==================================================
    -- GET ROOT
    --==================================================

    if self.References then

        Root =
            self.References.Root

        if not Root
        and type(
            self.References.Get
        ) == "function"
        then

            local Success,
                Result =
                pcall(
                    function()

                        return self.References:
                            Get("Root")

                    end
                )

            if Success then

                Root =
                    Result

            end

        end

    end

    if not Root then
        return false
    end

    --==================================================
    -- APPLY TO UI OBJECTS
    --==================================================

    local Value =
        self:Get()

    for _, Object in
        ipairs(
            Root:GetDescendants()
        )
    do

        if Object:IsA("Frame")
        or Object:IsA("ScrollingFrame")
        or Object:IsA("TextButton")
        then

            -- Não mexer em botões que já
            -- possuem transparência total.

            if Object.Name ~= "Favorite"
            and Object.Name ~= "Close"
            then

                if Object.BackgroundTransparency
                    < 1
                then

                    Object.BackgroundTransparency =
                        Value

                end

            end

        end

    end

    return true

end

--==================================================
-- RESET
--==================================================

function Transparency:Reset()

    return self:Set(
        DEFAULT_TRANSPARENCY
    )

end

--==================================================
-- GET DEFAULT
--==================================================

function Transparency:GetDefault()

    return DEFAULT_TRANSPARENCY

end

--==================================================
-- RETURN
--==================================================

return Transparency
