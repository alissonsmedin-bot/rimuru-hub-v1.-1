--// 💥 RIMURU HUB
--// UI Drag System
--// Window Movement
--// Modular UI Architecture

local UserInputService =
    game:GetService(
        "UserInputService"
    )

local Drag = {}

--==================================================
-- INIT
--==================================================

function Drag:Init(Context)

    self.Context =
        Context or {}

    self.UI =
        self.Context.UI

    self.Target =
        nil

    self.Dragging =
        false

    self.DragStart =
        nil

    self.StartPosition =
        nil

    self.InputChanged =
        nil

    self:_Setup()

end

--==================================================
-- SETUP
--==================================================

function Drag:_Setup()

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

    local Handle =
        self.UI.DragHandle

    if not Handle then

        Handle =
            self.Target:FindFirstChild(
                "Topbar"
            )

    end

    if not Handle
    or not Handle:IsA(
        "GuiObject"
    )
    then
        return false
    end

    Handle.InputBegan:
        Connect(
            function(Input)

                if Input.UserInputType ==
                    Enum.UserInputType.MouseButton1
                or Input.UserInputType ==
                    Enum.UserInputType.Touch
                then

                    self.Dragging =
                        true

                    self.DragStart =
                        Input.Position

                    self.StartPosition =
                        self.Target.Position

                    Input.Changed:
                        Connect(
                            function()

                                if Input.UserInputState ==
                                    Enum.UserInputState.End
                                then

                                    self.Dragging =
                                        false

                                end

                            end
                        )

                end

            end
        )

    self.InputChanged =
        UserInputService.InputChanged:
        Connect(
            function(Input)

                if not self.Dragging then
                    return
                end

                if Input.UserInputType ~=
                    Enum.UserInputType.MouseMovement
                and Input.UserInputType ~=
                    Enum.UserInputType.Touch
                then
                    return
                end

                local Delta =
                    Input.Position -
                    self.DragStart

                self.Target.Position =
                    UDim2.new(
                        self.StartPosition.X.Scale,
                        self.StartPosition.X.Offset
                            + Delta.X,
                        self.StartPosition.Y.Scale,
                        self.StartPosition.Y.Offset
                            + Delta.Y
                    )

            end
        )

    return true

end

--==================================================
-- SET TARGET
--==================================================

function Drag:SetTarget(
    Target
)

    if typeof(Target) ~=
        "Instance"
    then
        return false
    end

    self.Target =
        Target

    return true

end

--==================================================
-- STOP
--==================================================

function Drag:Stop()

    self.Dragging =
        false

end

--==================================================
-- DESTROY
--==================================================

function Drag:Destroy()

    self.Dragging =
        false

    if self.InputChanged then

        self.InputChanged:
            Disconnect()

        self.InputChanged =
            nil

    end

end

return Drag
