--// 💥 RIMURU HUB
--// UI REFERENCES
--// Finds and stores UI objects safely

local References = {}

--==================================================
-- INIT
--==================================================

function References:Init(Context)

    self.Context =
        Context or {}

    self.Player =
        self.Context.Player

    self.PlayerGui =
        self.Context.PlayerGui

    self.Root =
        nil

    self.Main =
        nil

    self.Sidebar =
        nil

    self.Content =
        nil

    self.Scroll =
        nil

    self.Search =
        nil

    self.Close =
        nil

    self:_Find()

end

--==================================================
-- FIND
--==================================================

function References:_Find()

    if not self.PlayerGui then
        return false
    end

    --==================================================
    -- SEARCH ROOT
    --==================================================

    local RootNames = {

        "RimuruHub",
        "Rimuru Hub",
        "Rimuru",
        "Main",
        "UI",

    }

    for _, Name in
        ipairs(RootNames)
    do

        local Object =
            self.PlayerGui:FindFirstChild(
                Name,
                true
            )

        if Object then

            self.Root =
                Object

            break

        end

    end

    --==================================================
    -- MAIN
    --==================================================

    if self.Root then

        self.Main =
            self.Root:FindFirstChild(
                "Main",
                true
            )

    end

    --==================================================
    -- SIDEBAR
    --==================================================

    if self.Root then

        self.Sidebar =
            self.Root:FindFirstChild(
                "Sidebar",
                true
            )

    end

    --==================================================
    -- CONTENT
    --==================================================

    if self.Root then

        self.Content =
            self.Root:FindFirstChild(
                "Content",
                true
            )

    end

    --==================================================
    -- SCROLL
    --==================================================

    if self.Root then

        local ScrollNames = {

            "Scroll",
            "ScrollingFrame",
            "SoundList",
            "Results",
            "Items",

        }

        for _, Name in
            ipairs(ScrollNames)
        do

            local Object =
                self.Root:FindFirstChild(
                    Name,
                    true
                )

            if Object
            and Object:IsA(
                "ScrollingFrame"
            )
            then

                self.Scroll =
                    Object

                break

            end

        end

    end

    --==================================================
    -- SEARCH
    --==================================================

    if self.Root then

        local SearchNames = {

            "Search",
            "SearchBox",
            "SearchBar",

        }

        for _, Name in
            ipairs(SearchNames)
        do

            local Object =
                self.Root:FindFirstChild(
                    Name,
                    true
                )

            if Object
            and (
                Object:IsA("TextBox")
                or Object:IsA("TextButton")
            )
            then

                self.Search =
                    Object

                break

            end

        end

    end

    --==================================================
    -- CLOSE
    --==================================================

    if self.Root then

        self.Close =
            self.Root:FindFirstChild(
                "Close",
                true
            )

    end

    return true

end

--==================================================
-- REFRESH
--==================================================

function References:Refresh()

    return self:_Find()

end

--==================================================
-- GET
--==================================================

function References:Get(Name)

    return self[Name]

end

--==================================================
-- STATUS
--==================================================

function References:IsReady()

    return self.Root ~= nil

end

--==================================================
-- RETURN
--==================================================

return References
