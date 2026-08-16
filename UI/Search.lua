--// 💥 RIMURU HUB
--// UI SEARCH SYSTEM
--// Search Box Controller
--// Safe / Modular

local Search = {}

--==================================================
-- INIT
--==================================================

function Search:Init(Context)

    self.Context =
        Context or {}

    self.References =
        self.Context.UIReferences

    self.Cards =
        self.Context.Cards

    self.Sound =
        self.Context.Sound

    self.SearchBox =
        nil

    self:_FindSearch()

end

--==================================================
-- FIND SEARCH
--==================================================

function Search:_FindSearch()

    if not self.References then
        return nil
    end

    if self.References.Search then

        self.SearchBox =
            self.References.Search

        return self.SearchBox

    end

    if type(
        self.References.Get
    ) == "function"
    then

        local Success,
            Result =
            pcall(
                function()

                    return self.References:
                        Get("Search")

                end
            )

        if Success
        and typeof(Result) == "Instance"
        then

            self.SearchBox =
                Result

            return self.SearchBox

        end

    end

    return nil

end

--==================================================
-- REFRESH
--==================================================

function Search:Refresh()

    return self:_FindSearch()

end

--==================================================
-- GET TEXT
--==================================================

function Search:GetText()

    local Box =
        self.SearchBox

    if not Box
    or not Box.Parent
    then

        Box =
            self:_FindSearch()

    end

    if not Box then
        return ""
    end

    if Box:IsA("TextBox") then

        return Box.Text

    end

    return ""

end

--==================================================
-- SET TEXT
--==================================================

function Search:SetText(
    Text
)

    local Box =
        self.SearchBox

    if not Box
    or not Box.Parent
    then

        Box =
            self:_FindSearch()

    end

    if not Box then
        return false
    end

    if not Box:IsA("TextBox") then
        return false
    end

    Box.Text =
        tostring(
            Text or ""
        )

    return true

end

--==================================================
-- CLEAR
--==================================================

function Search:Clear()

    return self:SetText("")

end

--==================================================
-- CONNECT
--==================================================

function Search:Connect(
    Callback
)

    if type(Callback) ~= "function" then
        return nil
    end

    local Box =
        self.SearchBox

    if not Box
    or not Box.Parent
    then

        Box =
            self:_FindSearch()

    end

    if not Box then
        return nil
    end

    if not Box:IsA("TextBox") then
        return nil
    end

    return Box:GetPropertyChangedSignal(
        "Text"
    ):Connect(
        function()

            pcall(
                Callback,
                Box.Text
            )

        end
    )

end

--==================================================
-- FILTER DATA
--==================================================

function Search:Filter(
    Data,
    Query
)

    if type(Data) ~= "table" then
        return {}
    end

    Query =
        tostring(
            Query or ""
        )

    Query =
        string.lower(
            Query
        )

    if Query == "" then

        return Data

    end

    local Result =
        {}

    for Index, Item in
        pairs(Data)
    do

        local Name = ""

        if type(Item) == "table" then

            Name =
                tostring(
                    Item[1]
                    or Item.Name
                    or ""
                )

        else

            Name =
                tostring(Item)

        end

        if string.find(
            string.lower(Name),
            Query,
            1,
            true
        )
        then

            Result[Index] =
                Item

        end

    end

    return Result

end

--==================================================
-- HAS QUERY
--==================================================

function Search:HasQuery()

    return
        self:GetText() ~= ""

end

--==================================================
-- RETURN
--==================================================

return Search
