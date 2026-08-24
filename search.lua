--// 💥 RIMURU HUB
--// SEARCH SYSTEM
--// CONTROLLER ONLY
--// DOES NOT CREATE SEARCH UI
--// USES UI.LUA SEARCH BAR
--// CASE-INSENSITIVE SEARCH
--// PARTIAL MATCH
--// NAME + ID SEARCH
--// CATEGORY AWARE
--// FAVORITES COMPATIBLE
--// LIVE SEARCH
--// SAFE INITIALIZATION
--// SAFE REFRESH
--// DUPLICATE CONNECTION PROTECTION
--// SEARCH STATE PROTECTION
--// PERFORMANCE SAFE
--// NO HEADER UI CREATION
--// NO DUPLICATE SEARCH BAR
--// UPDATED / STABLE

local Search = {}

--==================================================
-- SERVICES
--==================================================

-- Não precisamos mais de RenderStepped.
-- O Search não cria nem monitora uma UI própria.

--==================================================
-- CONFIG
--==================================================

local SEARCH_DEBOUNCE = 0.035

--==================================================
-- SAFE STRING
--==================================================

local function SafeString(Value)

	if Value == nil then
		return ""
	end

	return tostring(Value)

end

--==================================================
-- INIT
--==================================================

function Search:Init(Context)

	Context = Context or {}

	--==================================================
	-- DESTROY PREVIOUS INSTANCE
	--==================================================

	if self.Initialized then

		pcall(function()
			self:Destroy()
		end)

	end

	--==================================================
	-- CONTEXT
	--==================================================

	self.Context = Context

	self.Config = Context.Config
	self.Theme = Context.Theme
	self.UI = Context.UI
	self.Cards = Context.Cards
	self.Categories = Context.Categories
	self.Favorites = Context.Favorites

	self.Query = ""
	self.LastQuery = ""

	self.CurrentCategory = "Outros"

	self.Searching = false

	self.RefreshToken = 0

	self.Connections = {}

	self.Input = nil
	self.SearchBar = nil
	self.Results = nil
	self.Clear = nil
	self.NoResults = nil

	self.Initialized = false

	--==================================================
	-- UI CHECK
	--==================================================

	if not self.UI then

		warn(
			"⚠️ Rimuru Hub Search: UI não encontrado."
		)

		return false

	end

	--==================================================
	-- FIND EXISTING SEARCH BAR
	--==================================================

	self:FindExistingSearch()

	--==================================================
	-- EVENTS
	--==================================================

	self:ConnectExistingSearch()

	self.Initialized = true

	--==================================================
	-- INITIAL SEARCH
	--==================================================

	self:Search("", true)

	return true

end

--==================================================
-- FIND EXISTING SEARCH
--==================================================

function Search:FindExistingSearch()

	self.Input = nil
	self.SearchBar = nil

	--==================================================
	-- FIRST: UI EXPLICIT REFERENCES
	--==================================================

	local Candidates = {

		self.UI.SearchInput,
		self.UI.SearchBox,
		self.UI.Search,
		self.UI.SearchBar,
		self.UI.Input,

	}

	for _, Object in ipairs(Candidates) do

		if Object
			and typeof(Object) == "Instance"
			and Object:IsA("TextBox") then

			self.Input = Object
			break

		end

	end

	--==================================================
	-- SEARCH INSIDE HEADER
	--==================================================

	local Header = self.UI.Header

	if not self.Input
		and Header
		and typeof(Header) == "Instance" then

		local Names = {

			"SearchInput",
			"SearchBox",
			"Search",
			"SearchBar",
			"Input",

		}

		for _, Name in ipairs(Names) do

			local Object = Header:FindFirstChild(
				Name,
				true
			)

			if Object
				and Object:IsA("TextBox") then

				self.Input = Object
				break

			end

		end

	end

	--==================================================
	-- SEARCH ENTIRE GUI
	--==================================================

	if not self.Input then

		local Root = self.UI.Gui

		if Root
			and typeof(Root) == "Instance" then

			for _, Object in ipairs(
				Root:GetDescendants()
			) do

				if Object:IsA("TextBox") then

					local Name = string.lower(
						Object.Name
					)

					if string.find(
						Name,
						"search",
						1,
						true
					) then

						self.Input = Object
						break

					end

				end

			end

		end

	end

	--==================================================
	-- FIND PARENT SEARCH BAR
	--==================================================

	if self.Input then

		local Parent = self.Input.Parent

		if Parent
			and Parent:IsA("GuiObject") then

			self.SearchBar = Parent

		end

	end

end

--==================================================
-- CONNECT EXISTING SEARCH
--==================================================

function Search:ConnectExistingSearch()

	self:DisconnectEvents()

	if not self.Input then

		warn(
			"⚠️ Rimuru Hub Search: SearchBox existente não encontrado. " ..
			"O Search não criará uma nova barra."
		)

		return

	end

	--==================================================
	-- TEXT CHANGED
	--==================================================

	table.insert(
		self.Connections,

		self.Input:GetPropertyChangedSignal(
			"Text"
		):Connect(function()

			self:ScheduleSearch(
				self.Input.Text
			)

		end)
	)

end

--==================================================
-- DISCONNECT EVENTS
--==================================================

function Search:DisconnectEvents()

	if not self.Connections then

		self.Connections = {}

		return

	end

	for _, Connection in ipairs(
		self.Connections
	) do

		if Connection
			and type(
				Connection.Disconnect
			) == "function" then

			pcall(function()

				Connection:Disconnect()

			end)

		end

	end

	table.clear(
		self.Connections
	)

end

--==================================================
-- NORMALIZE
--==================================================

function Search:Normalize(Value)

	local Text = SafeString(Value)

	Text = Text:gsub(
		"%s+",
		" "
	)

	Text = Text:gsub(
		"^%s+",
		""
	)

	Text = Text:gsub(
		"%s+$",
		""
	)

	return string.lower(Text)

end

--==================================================
-- GET WORDS
--==================================================

function Search:GetWords(Query)

	local Words = {}

	Query = self:Normalize(Query)

	if Query == "" then
		return Words
	end

	for Word in string.gmatch(
		Query,
		"%S+"
	) do

		table.insert(
			Words,
			Word
		)

	end

	return Words

end

--==================================================
-- MATCH
--==================================================

function Search:Matches(Name, ID, Query)

	Query = self:Normalize(Query)

	if Query == "" then
		return true
	end

	local NameText = self:Normalize(Name)
	local IDText = self:Normalize(ID)

	local Combined =
		NameText
		.. " "
		.. IDText

	local Words = self:GetWords(Query)

	for _, Word in ipairs(Words) do

		if not string.find(
			Combined,
			Word,
			1,
			true
		) then

			return false

		end

	end

	return true

end

--==================================================
-- SET CATEGORY
--==================================================

function Search:SetCategory(Category)

	Category = SafeString(Category)

	if Category == "" then
		Category = "Outros"
	end

	self.CurrentCategory = Category

	-- Limpa somente a pesquisa.
	-- Não cria nem modifica elementos da UI.

	self:ClearSearch(true)

end

--==================================================
-- GET QUERY
--==================================================

function Search:GetQuery()

	return self.Query or ""

end

--==================================================
-- SET QUERY
--==================================================

function Search:SetQuery(Query)

	Query = SafeString(Query)

	self.Query = Query

	if self.Input
		and self.Input.Text ~= Query then

		self.Input.Text = Query

		return

	end

	self:Search(Query)

end

--==================================================
-- CLEAR SEARCH
--==================================================

function Search:ClearSearch(Silent)

	self.RefreshToken += 1

	self.Query = ""
	self.LastQuery = ""

	if self.Input then

		if self.Input.Text ~= "" then
			self.Input.Text = ""
		end

	end

	self:Search(
		"",
		Silent == true
	)

end

--==================================================
-- SCHEDULE SEARCH
--==================================================

function Search:ScheduleSearch(Query)

	Query = SafeString(Query)

	self.RefreshToken += 1

	local Token = self.RefreshToken

	task.delay(
		SEARCH_DEBOUNCE,
		function()

			if Token ~= self.RefreshToken then
				return
			end

			if not self.Initialized then
				return
			end

			self:Search(Query)

		end
	)

end

--==================================================
-- SOUND CARD CHECK
--==================================================

function Search:IsSoundCard(Object)

	if not Object then
		return false
	end

	if not Object:IsA("Frame") then
		return false
	end

	local Name = Object.Name

	if type(Name) ~= "string" then
		return false
	end

	--==================================================
	-- CURRENT CARD SYSTEM
	--==================================================

	if string.sub(
		Name,
		1,
		6
	) == "Sound_" then

		return true

	end

	--==================================================
	-- FUTURE CARD SYSTEM
	--==================================================

	local Attribute

	pcall(function()

		Attribute =
			Object:GetAttribute(
				"SoundCard"
			)

	end)

	if Attribute == true then
		return true
	end

	return false

end

--==================================================
-- GET CARD DATA
--==================================================

function Search:GetCardData(Card)

	if not Card then
		return "", ""
	end

	local Name = ""
	local ID = ""

	--==================================================
	-- NAME
	--==================================================

	local NameObject =
		Card:FindFirstChild("Name")

	if NameObject then

		if NameObject:IsA("TextLabel")
			or NameObject:IsA("TextButton")
			or NameObject:IsA("TextBox") then

			Name =
				SafeString(
					NameObject.Text
				)

		end

	end

	--==================================================
	-- ID
	--==================================================

	local IDObject =
		Card:FindFirstChild("ID")

	if IDObject then

		if IDObject:IsA("TextLabel")
			or IDObject:IsA("TextButton")
			or IDObject:IsA("TextBox") then

			ID =
				SafeString(
					IDObject.Text
				)

		end

	end

	--==================================================
	-- ATTRIBUTE FALLBACK
	--==================================================

	if Name == "" then

		pcall(function()

			Name =
				SafeString(
					Card:GetAttribute(
						"SoundName"
					)
				)

		end)

	end

	if ID == "" then

		pcall(function()

			ID =
				SafeString(
					Card:GetAttribute(
						"SoundID"
					)
				)

		end)

	end

	return Name, ID

end

--==================================================
-- GET SCROLL
--==================================================

function Search:GetScroll()

	if self.UI then

		if self.UI.Scroll
			and typeof(self.UI.Scroll) == "Instance" then

			self.Scroll = self.UI.Scroll

		end

	end

	return self.Scroll

end

--==================================================
-- SEARCH
--==================================================

function Search:Search(Query, Silent)

	Query = SafeString(Query)

	self.Query = Query
	self.LastQuery = Query

	local Normalized =
		self:Normalize(Query)

	local HasQuery =
		Normalized ~= ""

	local Found = 0
	local Total = 0

	local Scroll =
		self:GetScroll()

	if not Scroll then

		self:UpdateResults(
			0,
			0,
			HasQuery
		)

		return

	end

	--==================================================
	-- PROCESS CARDS
	--==================================================

	for _, Object in ipairs(
		Scroll:GetChildren()
	) do

		if self:IsSoundCard(Object) then

			Total += 1

			local Name, ID =
				self:GetCardData(Object)

			local Match =
				self:Matches(
					Name,
					ID,
					Query
				)

			Object.Visible = Match

			if Match then
				Found += 1
			end

		end

	end

	--==================================================
	-- STATE
	--==================================================

	self.Searching =
		HasQuery

	--==================================================
	-- OPTIONAL UI COUNTER
	--==================================================

	self:UpdateResults(
		Found,
		Total,
		HasQuery
	)

	--==================================================
	-- OPTIONAL NO RESULTS
	--==================================================

	self:UpdateNoResults(
		Found,
		Total,
		HasQuery
	)

	--==================================================
	-- CANVAS
	--==================================================

	if not Silent then

		self:UpdateCanvas()

	end

end

--==================================================
-- UPDATE RESULTS
--==================================================

function Search:UpdateResults(
	Found,
	Total,
	HasQuery
)

	--==================================================
	-- IMPORTANT
	-- Search.lua NÃO cria contador.
	--
	-- Se o UI.lua possuir um contador,
	-- podemos usar automaticamente.
	--==================================================

	local Results =
		self.Results

	if not Results then

		if self.UI then

			Results =
				self.UI.SearchResults

		end

	end

	if Results
		and Results:IsA("TextLabel") then

		Results.Text =
			tostring(Found)
			.. " / "
			.. tostring(Total)

	end

end

--==================================================
-- NO RESULTS
--==================================================

function Search:UpdateNoResults(
	Found,
	Total,
	HasQuery
)

	--==================================================
	-- NÃO CRIA ELEMENTO.
	-- Apenas usa um existente, se houver.
	--==================================================

	local Empty =
		self.NoResults

	if not Empty
		and self.UI then

		Empty =
			self.UI.SearchNoResults

	end

	if not Empty then
		return
	end

	if not Empty:IsA("GuiObject") then
		return
	end

	Empty.Visible =
		HasQuery
		and Total > 0
		and Found == 0

end

--==================================================
-- UPDATE CANVAS
--==================================================

function Search:UpdateCanvas()

	local Scroll =
		self:GetScroll()

	if not Scroll then
		return
	end

	pcall(function()

		Scroll.CanvasPosition =
			Vector2.new(
				Scroll.CanvasPosition.X,
				0
			)

	end)

end

--==================================================
-- REFRESH
--==================================================

function Search:Refresh()

	if not self.Initialized then
		return
	end

	self:Search(
		self.Query or "",
		true
	)

end

--==================================================
-- SHOW ALL
--==================================================

function Search:ShowAll()

	local Scroll =
		self:GetScroll()

	if not Scroll then
		return
	end

	for _, Object in ipairs(
		Scroll:GetChildren()
	) do

		if self:IsSoundCard(Object) then

			Object.Visible = true

		end

	end

end

--==================================================
-- GET RESULT COUNT
--==================================================

function Search:GetResultCount()

	local Scroll =
		self:GetScroll()

	if not Scroll then
		return 0
	end

	local Count = 0

	for _, Object in ipairs(
		Scroll:GetChildren()
	) do

		if self:IsSoundCard(Object)
			and Object.Visible then

			Count += 1

		end

	end

	return Count

end

--==================================================
-- DESTROY
--==================================================

function Search:Destroy()

	self.RefreshToken += 1

	self:DisconnectEvents()

	--==================================================
	-- IMPORTANT:
	-- NÃO DESTRUIR A SEARCH BAR.
	--
	-- Ela pertence ao UI.lua.
	--==================================================

	self.Input = nil
	self.SearchBar = nil
	self.Results = nil
	self.Clear = nil
	self.NoResults = nil
	self.Scroll = nil

	self.Initialized = false

end

--==================================================
-- RETURN
--==================================================

return Search
