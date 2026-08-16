--// 💥 RIMURU HUB
--// UI EVENTS SYSTEM
--// Centralized Event Connections
--// Safe Event Controller

local Events = {}

--==================================================
-- INIT
--==================================================

function Events:Init(Context)

    self.Context =
        Context or {}

    self.References =
        self.Context.UIReferences

    self.Window =
        self.Context.UIWindow

    self.Search =
        self.Context.UISearch

    self.Connections =
        {}

end

--==================================================
-- SAFE CONNECT
--==================================================

function Events:Connect(
    Signal,
    Callback
)

    if not Signal then
        return nil
    end

    if type(Callback) ~= "function" then
        return nil
    end

    local Success,
        Connection =
        pcall(
            function()

                return Signal:Connect(
                    Callback
                )

            end
        )

    if not Success then

        return nil

    end

    if Connection then

        table.insert(
            self.Connections,
            Connection
        )

    end

    return Connection

end

--==================================================
-- DISCONNECT
--==================================================

function Events:Disconnect(
    Connection
)

    if not Connection then
        return false
    end

    local Success =
        pcall(
            function()

                Connection:Disconnect()

            end
        )

    return Success

end

--==================================================
-- DISCONNECT ALL
--==================================================

function Events:DisconnectAll()

    for _, Connection in
        ipairs(
            self.Connections
        )
    do

        if Connection then

            pcall(
                function()

                    Connection:Disconnect()

                end
            )

        end

    end

    table.clear(
        self.Connections
    )

end

--==================================================
-- CONNECT BUTTON
--==================================================

function Events:ConnectButton(
    Button,
    Callback
)

    if not Button then
        return nil
    end

    if not Button:IsA(
        "GuiButton"
    )
    then

        return nil

    end

    return self:Connect(
        Button.MouseButton1Click,
        Callback
    )

end

--==================================================
-- CONNECT SEARCH
--==================================================

function Events:ConnectSearch(
    Callback
)

    if not self.Search then
        return nil
    end

    if type(
        self.Search.Connect
    ) ~= "function"
    then

        return nil

    end

    local Success,
        Connection =
        pcall(
            function()

                return self.Search:
                    Connect(
                        Callback
                    )

            end
        )

    if Success
    and Connection
    then

        table.insert(
            self.Connections,
            Connection
        )

    end

    return Connection

end

--==================================================
-- CONNECT CLOSE
--==================================================

function Events:ConnectClose(
    Callback
)

    if not self.References then
        return nil
    end

    local Close =
        self.References.Close

    if not Close then
        return nil
    end

    return self:ConnectButton(
        Close,
        Callback
    )

end

--==================================================
-- CONNECT TOGGLE
--==================================================

function Events:ConnectToggle(
    Button
)

    if not Button then
        return nil
    end

    if not self.Window then
        return nil
    end

    return self:ConnectButton(
        Button,
        function()

            if type(
                self.Window.Toggle
            ) == "function"
            then

                self.Window:
                    Toggle()

            end

        end
    )

end

--==================================================
-- GET CONNECTION COUNT
--==================================================

function Events:GetConnectionCount()

    return #self.Connections

end

--==================================================
-- CLEAR INVALID
--==================================================

function Events:Cleanup()

    local Valid =
        {}

    for _, Connection in
        ipairs(
            self.Connections
        )
    do

        if Connection then

            table.insert(
                Valid,
                Connection
            )

        end

    end

    self.Connections =
        Valid

end

--==================================================
-- DESTROY
--==================================================

function Events:Destroy()

    self:DisconnectAll()

    self.Context =
        nil

    self.References =
        nil

    self.Window =
        nil

    self.Search =
        nil

end

--==================================================
-- RETURN
--==================================================

return Events
