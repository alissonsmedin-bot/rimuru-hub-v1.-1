--// 💥 RIMURU HUB
--// PREMIUM SEARCH SYSTEM
--// HEADER SEARCH
--// SINGLE SEARCH BAR
--// CASE-INSENSITIVE SEARCH
--// PARTIAL MATCH
--// NAME + ID SEARCH
--// CATEGORY AWARE
--// FAVORITES COMPATIBLE
--// LIVE SEARCH
--// RESULT COUNTER
--// CLEAR BUTTON
--// NO RESULTS STATE
--// THEME AUTO ADAPTATION
--// PREMIUM MAGNIFIER ICON
--// SAFE INITIALIZATION
--// SAFE REFRESH
--// DUPLICATE CONNECTION PROTECTION
--// SEARCH STATE PROTECTION
--// PERFORMANCE SAFE
--// HEADER POSITION FIX
--// SINGLE SEARCH BAR ONLY
--// UI REFERENCE COMPATIBLE
--// NO NIL TEXT ERRORS
--// RESULT FORMAT: 0 / 0
--// THEME COLOR FIX
--// UPDATED / STABLE

local Search = {}

--==================================================
-- SERVICES
--==================================================

local RunService =
	game:GetService("RunService")

--==================================================
-- CONFIG
--==================================================

local SEARCH_HEIGHT = 34
local SEARCH_WIDTH = 255

local SEARCH_RIGHT_MARGIN = 48
local SEARCH_HEADER_Y = 12

local SEARCH_DEBOUNCE = 0.035
local THEME_CHECK_INTERVAL = 0.25

local SEARCH_CORNER = 9

local RESULT_SEPARATOR = " / "

local PLACEHOLDER_TEXT =
	"Search name or ID..."

--==================================================
-- FALLBACK COLORS
--==================================================

local FALLBACK_BACKGROUND =
	Color3.fromRGB(
		25,
		20,
		27
	)

local FALLBACK_BUTTON =
	Color3.fromRGB(
		30,
		30,
		38
	)

local FALLBACK_TEXT =
	Color3.fromRGB(
		240,
		230,
		245
	)

local FALLBACK_SUBTEXT =
	Color3.fromRGB(
		145,
		150,
		160
	)

local FALLBACK_ACCENT =
	Color3.fromRGB(
		25,
		150,
		250
	)

--==================================================
-- SAFE COLOR
--==================================================

local function SafeColor(
	Value,
	Fallback
)

	if typeof(Value) == "Color3" then
		return Value
	end

	return Fallback

end

--==================================================
-- SAFE STRING
--==================================================

local function SafeString(
	Value
)

	if Value == nil then
		return ""
	end

	return tostring(Value)

end

--==================================================
-- SAFE THEME
--==================================================

local function GetTheme(
	Theme
)

	local Default = {

		Background =
			FALLBACK_BACKGROUND,

		Content =
			FALLBACK_BACKGROUND,

		Card =
			FALLBACK_BUTTON,

		Button =
			FALLBACK_BUTTON,

		Text =
			FALLBACK_TEXT,

		SubText =
			FALLBACK_SUBTEXT,

		Accent =
			FALLBACK_ACCENT

	}

	if not Theme then
		return Default
	end

	local Current = nil

	--==================================================
	-- CURRENT THEME
	--==================================================

	if type(
		Theme.GetCurrent
	) == "function" then

		local Success,
			Result =
			pcall(function()

				return Theme:GetCurrent()

			end)

		if Success
		and type(Result) == "table" then

			Current =
				Result

		end

	end

	--==================================================
	-- FALLBACK CURRENT THEME
	--==================================================

	if type(Current) ~= "table" then

		if type(
			Theme.CurrentTheme
		) == "table" then

			Current =
				Theme.CurrentTheme

		end

	end

	if type(Current) ~= "table" then
		Current = {}
	end

	return {

		Background =
			SafeColor(
				Current.Background
					or Current.Main
					or Current.Content,

				FALLBACK_BACKGROUND
			),

		Content =
			SafeColor(
				Current.Content
					or Current.Background
					or Current.Main,

				FALLBACK_BACKGROUND
			),

		Card =
			SafeColor(
				Current.Card
					or Current.Button,

				FALLBACK_BUTTON
			),

		Button =
			SafeColor(
				Current.Button
					or Current.Card,

				FALLBACK_BUTTON
			),

		Text =
			SafeColor(
				Current.Text,

				FALLBACK_TEXT
			),

		SubText =
			SafeColor(
				Current.SubText,

				FALLBACK_SUBTEXT
			),

		Accent =
			SafeColor(
				Current.Accent,

				FALLBACK_ACCENT
			)

	}

end

--==================================================
-- MARK SEARCH OBJECT
--==================================================

local function MarkSearchObject(
	Object
)

	pcall(function()

		Object:SetAttribute(
			"RimuruSearchElement",
			true
		)

	end)

end

--==================================================
-- NORMALIZE
--==================================================

function Search:Normalize(
	Value
)

	local Text =
		SafeString(
			Value
		)

	Text =
		Text:gsub(
			"%s+",
			" "
		)

	Text =
		Text:gsub(
			"^%s+",
			""
		)

	Text =
		Text:gsub(
			"%s+$",
			""
		)

	return string.lower(
		Text
	)

end

--==================================================
-- GET WORDS
--==================================================

function Search:GetWords(
	Query
)

	local Words = {}

	Query =
		self:Normalize(
			Query
		)

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

function Search:Matches(
	Name,
	ID,
	Query
)

	Query =
		self:Normalize(
			Query
		)

	if Query == "" then
		return true
	end

	local NameText =
		self:Normalize(
			Name
		)

	local IDText =
		self:Normalize(
			ID
		)

	local Combined =
		NameText
		.. " "
		.. IDText

	for _, Word in
		ipairs(
			self:GetWords(
				Query
			)
		) do

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
-- INIT
--==================================================

function Search:Init(
	Context
)

	Context =
		Context
		or {}

	--==================================================
	-- CLEAN PREVIOUS
	--==================================================

	if self.Initialized then

		pcall(function()

			self:Destroy()

		end)

	end

	self.Context =
		Context

	self.Config =
		Context.Config

	self.Theme =
		Context.Theme

	self.UI =
		Context.UI

	self.Cards =
		Context.Cards

	self.Categories =
		Context.Categories

	self.Favorites =
		Context.Favorites

	self.Query =
		""

	self.LastQuery =
		""

	self.CurrentCategory =
		"Outros"

	self.Searching =
		false

	self.RefreshToken =
		0

	self.ThemeTimer =
		0

	self.LastThemeSignature =
		""

	self.Connections =
		{}

	self.ThemeConnection =
		nil

	self.Initialized =
		false

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
	-- HEADER
	--==================================================

	self.Header =
		self.UI.Header

	if not self.Header then

		warn(
			"⚠️ Rimuru Hub Search: Header não encontrado."
		)

		return false

	end

	--==================================================
	-- CREATE
	--==================================================

	local Success,
		Error =
		pcall(function()

			self:RemoveOldSearchBars()

			self:Create()

			self:StartThemeWatcher()

		end)

	if not Success then

		warn(
			"❌ Rimuru Hub Search: erro ao inicializar:"
		)

		warn(
			tostring(Error)
		)

		return false

	end

	self.Initialized =
		true

	return true

end

--==================================================
-- REMOVE OLD SEARCH BARS
--==================================================

function Search:RemoveOldSearchBars()

	if not self.UI then
		return
	end

	local Root =
		self.UI.Gui

	if not Root then
		return
	end

	--==================================================
	-- IMPORTANT
	--
	-- NÃO destruir:
	--
	-- UI.SearchBar
	-- UI.SearchBox
	-- UI.SearchIcon
	--
	-- porque outros módulos podem possuir
	-- referências a eles.
	--
	-- Aqui só removemos pesquisas ANTIGAS
	-- criadas pelo Search.lua.
	--==================================================

	local Names = {

		"PremiumSearch",
		"SearchFrame",
		"SearchContainer",
		"SoundSearch",
		"SearchBackground",
		"SearchNoResults",
		"NoResults"

	}

	local NameMap = {}

	for _, Name in
		ipairs(
			Names
		) do

		NameMap[Name] =
			true

	end

	--==================================================
	-- REMOVE SOMENTE ELEMENTOS MARCADOS
	--==================================================

	for _, Object in
		ipairs(
			Root:GetDescendants()
		) do

		local IsSearch =
			false

		pcall(function()

			IsSearch =
				Object:GetAttribute(
					"RimuruSearchElement"
				) == true

		end)

		if IsSearch
		and Object.Name ~= "SearchBar"
		and Object.Name ~= "SearchBox"
		and Object.Name ~= "SearchIcon" then

			pcall(function()

				Object:Destroy()

			end)

		end

	end

	--==================================================
	-- REMOVE CONTAINER ANTIGO
	--==================================================

	for _, Object in
		ipairs(
			Root:GetDescendants()
		) do

		if NameMap[
			Object.Name
		] then

			pcall(function()

				Object:Destroy()

			end)

		end

	end

end

--==================================================
-- CREATE
--==================================================

function Search:Create()

	--==================================================
	-- CREATE HEADER SEARCH
	--==================================================

	local Container =
		Instance.new(
			"Frame"
		)

	Container.Name =
		"PremiumSearch"

	Container.AnchorPoint =
		Vector2.new(
			1,
			0
		)

	Container.Position =
		UDim2.new(
			1,
			-SEARCH_RIGHT_MARGIN,
			0,
			SEARCH_HEADER_Y
		)

	Container.Size =
		UDim2.new(
			0,
			SEARCH_WIDTH,
			0,
			SEARCH_HEIGHT
		)

	Container.BackgroundTransparency =
		1

	Container.BorderSizePixel =
		0

	Container.ZIndex =
		505

	MarkSearchObject(
		Container
	)

	Container.Parent =
		self.Header

	self.Container =
		Container

	--==================================================
	-- THEME
	--==================================================

	local CurrentTheme =
		GetTheme(
			self.Theme
		)

	--==================================================
	-- BACKGROUND
	--==================================================

	local Background =
		Instance.new(
			"Frame"
		)

	Background.Name =
		"SearchBackground"

	Background.Size =
		UDim2.new(
			1,
			0,
			1,
			0
		)

	Background.BackgroundColor3 =
		CurrentTheme.Card

	Background.BackgroundTransparency =
		0.08

	Background.BorderSizePixel =
		0

	Background.ZIndex =
		505

	MarkSearchObject(
		Background
	)

	Background.Parent =
		Container

	local Corner =
		Instance.new(
			"UICorner"
		)

	Corner.CornerRadius =
		UDim.new(
			0,
			SEARCH_CORNER
		)

	MarkSearchObject(
		Corner
	)

	Corner.Parent =
		Background

	local Stroke =
		Instance.new(
			"UIStroke"
		)

	Stroke.Name =
		"SearchStroke"

	Stroke.Color =
		CurrentTheme.Accent

	Stroke.Thickness =
		1

	Stroke.Transparency =
		0.40

	Stroke.ApplyStrokeMode =
		Enum.ApplyStrokeMode.Border

	MarkSearchObject(
		Stroke
	)

	Stroke.Parent =
		Background

	self.Background =
		Background

	self.Stroke =
		Stroke

	--==================================================
	-- ICON
	--==================================================

	local IconFrame =
		Instance.new(
			"Frame"
		)

	IconFrame.Name =
		"SearchIcon"

	IconFrame.Size =
		UDim2.new(
			0,
			24,
			0,
			24
		)

	IconFrame.Position =
		UDim2.new(
			0,
			8,
			0.5,
			-12
		)

	IconFrame.BackgroundTransparency =
		1

	IconFrame.BorderSizePixel =
		0

	IconFrame.ZIndex =
		506

	MarkSearchObject(
		IconFrame
	)

	IconFrame.Parent =
		Background

	local Lens =
		Instance.new(
			"Frame"
		)

	Lens.Name =
		"Lens"

	Lens.Size =
		UDim2.new(
			0,
			11,
			0,
			11
		)

	Lens.Position =
		UDim2.new(
			0,
			3,
			0,
			3
		)

	Lens.BackgroundTransparency =
		1

	Lens.BorderSizePixel =
		0

	Lens.ZIndex =
		507

	MarkSearchObject(
		Lens
	)

	Lens.Parent =
		IconFrame

	local LensCorner =
		Instance.new(
			"UICorner"
		)

	LensCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	MarkSearchObject(
		LensCorner
	)

	LensCorner.Parent =
		Lens

	local LensStroke =
		Instance.new(
			"UIStroke"
		)

	LensStroke.Name =
		"LensStroke"

	LensStroke.Color =
		CurrentTheme.Accent

	LensStroke.Thickness =
		2

	LensStroke.Transparency =
		0

	MarkSearchObject(
		LensStroke
	)

	LensStroke.Parent =
		Lens

	local Handle =
		Instance.new(
			"Frame"
		)

	Handle.Name =
		"Handle"

	Handle.Size =
		UDim2.new(
			0,
			8,
			0,
			2
		)

	Handle.Position =
		UDim2.new(
			0,
			12,
			0,
			15
		)

	Handle.Rotation =
		45

	Handle.BackgroundColor3 =
		CurrentTheme.Accent

	Handle.BorderSizePixel =
		0

	Handle.ZIndex =
		507

	MarkSearchObject(
		Handle
	)

	Handle.Parent =
		IconFrame

	local HandleCorner =
		Instance.new(
			"UICorner"
		)

	HandleCorner.CornerRadius =
		UDim.new(
			1,
			0
		)

	MarkSearchObject(
		HandleCorner
	)

	HandleCorner.Parent =
		Handle

	self.Icon =
		IconFrame

	self.LensStroke =
		LensStroke

	self.Handle =
		Handle

	--==================================================
	-- INPUT
	--==================================================

	local Input =
		Instance.new(
			"TextBox"
		)

	Input.Name =
		"Input"

	Input.Position =
		UDim2.new(
			0,
			36,
			0,
			0
		)

	Input.Size =
		UDim2.new(
			1,
			-96,
			1,
			0
		)

	Input.BackgroundTransparency =
		1

	Input.BorderSizePixel =
		0

	Input.ClearTextOnFocus =
		false

	Input.Text =
		""

	Input.PlaceholderText =
		PLACEHOLDER_TEXT

	Input.TextColor3 =
		CurrentTheme.Text

	Input.PlaceholderColor3 =
		CurrentTheme.SubText

	Input.TextSize =
		11

	Input.Font =
		Enum.Font.Gotham

	Input.TextXAlignment =
		Enum.TextXAlignment.Left

	Input.ZIndex =
		506

	MarkSearchObject(
		Input
	)

	Input.Parent =
		Background

	self.Input =
		Input

	--==================================================
	-- RESULT COUNTER
	--==================================================

	local Results =
		Instance.new(
			"TextLabel"
		)

	Results.Name =
		"Results"

	Results.AnchorPoint =
		Vector2.new(
			1,
			0
		)

	Results.Position =
		UDim2.new(
			1,
			-7,
			0,
			0
		)

	Results.Size =
		UDim2.new(
			0,
			48,
			1,
			0
		)

	Results.BackgroundTransparency =
		1

	Results.Text =
		"0 / 0"

	Results.TextColor3 =
		CurrentTheme.SubText

	Results.TextSize =
		9

	Results.Font =
		Enum.Font.GothamMedium

	Results.TextXAlignment =
		Enum.TextXAlignment.Right

	Results.ZIndex =
		506

	MarkSearchObject(
		Results
	)

	Results.Parent =
		Background

	self.Results =
		Results

	--==================================================
	-- CLEAR
	--==================================================

	local Clear =
		Instance.new(
			"TextButton"
		)

	Clear.Name =
		"Clear"

	Clear.Size =
		UDim2.new(
			0,
			22,
			0,
			22
		)

	Clear.Position =
		UDim2.new(
			1,
			-57,
			0.5,
			-11
		)

	Clear.BackgroundTransparency =
		1

	Clear.BorderSizePixel =
		0

	Clear.Text =
		"×"

	Clear.TextColor3 =
		CurrentTheme.SubText

	Clear.TextSize =
		16

	Clear.Font =
		Enum.Font.GothamBold

	Clear.AutoButtonColor =
		false

	Clear.Visible =
		false

	Clear.ZIndex =
		507

	MarkSearchObject(
		Clear
	)

	Clear.Parent =
		Background

	self.Clear =
		Clear

	--==================================================
	-- NO RESULTS
	--==================================================

	local Empty =
		Instance.new(
			"TextLabel"
		)

	Empty.Name =
		"SearchNoResults"

	Empty.AnchorPoint =
		Vector2.new(
			0.5,
			0
		)

	Empty.Position =
		UDim2.new(
			0.5,
			0,
			0,
			75
		)

	Empty.Size =
		UDim2.new(
			1,
			-30,
			0,
			40
		)

	Empty.BackgroundTransparency =
		1

	Empty.Text =
		"No sounds found"

	Empty.TextColor3 =
		CurrentTheme.SubText

	Empty.TextSize =
		12

	Empty.Font =
		Enum.Font.GothamMedium

	Empty.Visible =
		false

	Empty.ZIndex =
		504

	MarkSearchObject(
		Empty
	)

	Empty.Parent =
		self.Header

	self.NoResults =
		Empty

	--==================================================
	-- IMPORTANT UI ALIASES
	--
	-- Isso resolve os nil.Text dos outros módulos.
	--==================================================

	self.UI.SearchBar =
		Container

	self.UI.SearchBox =
		Input

	self.UI.SearchInput =
		Input

	self.UI.SearchClear =
		Clear

	self.UI.SearchIcon =
		IconFrame

	self.UI.SearchStroke =
		Stroke

	self.UI.SearchResults =
		Results

	--==================================================
	-- EVENTS
	--==================================================

	self:DisconnectEvents()

	table.insert(
		self.Connections,

		Input:GetPropertyChangedSignal(
			"Text"
		):Connect(
			function()

				self:ScheduleSearch(
					Input.Text
				)

			end
		)
	)

	table.insert(
		self.Connections,

		Clear.MouseButton1Click:Connect(
			function()

				self:ClearSearch()

			end
		)
	)

	table.insert(
		self.Connections,

		Input.Focused:Connect(
			function()

				self:OnFocus()

			end
		)
	)

	table.insert(
		self.Connections,

		Input.FocusLost:Connect(
			function()

				self:OnFocusLost()

			end
		)
	)

	--==================================================
	-- THEME
	--==================================================

	self:ApplyTheme()

	--==================================================
	-- INITIAL SEARCH
	--==================================================

	self:Search(
		"",
		true
	)

end

--==================================================
-- DISCONNECT EVENTS
--==================================================

function Search:DisconnectEvents()

	if not self.Connections then

		self.Connections =
			{}

		return

	end

	for _, Connection in
		ipairs(
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
-- FOCUS
--==================================================

function Search:OnFocus()

	if not self.Stroke then
		return
	end

	self.Stroke.Transparency =
		0.12

	self.Stroke.Thickness =
		1.35

end

--==================================================
-- FOCUS LOST
--==================================================

function Search:OnFocusLost()

	if not self.Stroke then
		return
	end

	self.Stroke.Transparency =
		0.40

	self.Stroke.Thickness =
		1

end

--==================================================
-- SET CATEGORY
--==================================================

function Search:SetCategory(
	Category
)

	Category =
		SafeString(
			Category
		)

	if Category == "" then

		Category =
			"Outros"

	end

	self.CurrentCategory =
		Category

	self:ClearSearch(
		true
	)

end

--==================================================
-- GET QUERY
--==================================================

function Search:GetQuery()

	return self.Query
		or ""

end

--==================================================
-- SET QUERY
--==================================================

function Search:SetQuery(
	Query
)

	Query =
		SafeString(
			Query
		)

	if self.Input
	and self.Input.Text ~= Query then

		self.Input.Text =
			Query

		return

	end

	self:Search(
		Query
	)

end

--==================================================
-- CLEAR
--==================================================

function Search:ClearSearch(
	Silent
)

	self.RefreshToken +=
		1

	self.Query =
		""

	self.LastQuery =
		""

	if self.Input then

		self.Input.Text =
			""

	end

	self:Search(
		"",
		Silent == true
	)

end

--==================================================
-- SCHEDULE
--==================================================

function Search:ScheduleSearch(
	Query
)

	Query =
		SafeString(
			Query
		)

	self.RefreshToken +=
		1

	local Token =
		self.RefreshToken

	task.delay(
		SEARCH_DEBOUNCE,
		function()

			if Token ~= self.RefreshToken then
				return
			end

			self:Search(
				Query
			)

		end
	)

end

--==================================================
-- SOUND CARD
--==================================================

function Search:IsSoundCard(
	Object
)

	if not Object then
		return false
	end

	if not Object:IsA(
		"Frame"
	) then

		return false

	end

	local Name =
		Object.Name

	if type(Name) ~= "string" then
		return false
	end

	if string.sub(
		Name,
		1,
		6
	) == "Sound_" then

		return true

	end

	local Attribute

	pcall(function()

		Attribute =
			Object:GetAttribute(
				"SoundCard"
			)

	end)

	return Attribute == true

end

--==================================================
-- CARD DATA
--==================================================

function Search:GetCardData(
	Card
)

	if not Card then
		return "", ""
	end

	local Name =
		""

	local ID =
		""

	local NameObject =
		Card:FindFirstChild(
			"Name"
		)

	if NameObject
	and (
		NameObject:IsA("TextLabel")
		or NameObject:IsA("TextButton")
		or NameObject:IsA("TextBox")
	) then

		Name =
			SafeString(
				NameObject.Text
			)

	end

	local IDObject =
		Card:FindFirstChild(
			"ID"
		)

	if IDObject
	and (
		IDObject:IsA("TextLabel")
		or IDObject:IsA("TextButton")
		or IDObject:IsA("TextBox")
	) then

		ID =
			SafeString(
				IDObject.Text
			)

	end

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
-- SEARCH
--==================================================

function Search:Search(
	Query,
	Silent
)

	Query =
		SafeString(
			Query
		)

	self.Query =
		Query

	self.LastQuery =
		Query

	local Normalized =
		self:Normalize(
			Query
		)

	local HasQuery =
		Normalized ~= ""

	local Found =
		0

	local Total =
		0

	if not self.Scroll
	and self.UI then

		self.Scroll =
			self.UI.Scroll

	end

	if not self.Scroll then

		self:UpdateResults(
			0,
			0,
			HasQuery
		)

		return

	end

	for _, Object in
		ipairs(
			self.Scroll:GetChildren()
		) do

		if self:IsSoundCard(
			Object
		) then

			Total +=
				1

			local Name,
				ID =
				self:GetCardData(
					Object
				)

			local Match =
				self:Matches(
					Name,
					ID,
					Query
				)

			Object.Visible =
				Match

			if Match then

				Found +=
					1

			end

		end

	end

	self:UpdateResults(
		Found,
		Total,
		HasQuery
	)

	self:UpdateNoResults(
		Found,
		Total,
		HasQuery
	)

	self:UpdateClearButton(
		HasQuery
	)

	self.Searching =
		HasQuery

	if not Silent then

		self:UpdateCanvas()

	end

end

--==================================================
-- RESULTS
--==================================================

function Search:UpdateResults(
	Found,
	Total,
	HasQuery
)

	if not self.Results then
		return
	end

	self.Results.Text =
		tostring(
			Found
		)
		..
		RESULT_SEPARATOR
		..
		tostring(
			Total
		)

end

--==================================================
-- NO RESULTS
--==================================================

function Search:UpdateNoResults(
	Found,
	Total,
	HasQuery
)

	if not self.NoResults then
		return
	end

	self.NoResults.Visible =
		HasQuery
		and Total > 0
		and Found == 0

end

--==================================================
-- CLEAR BUTTON
--==================================================

function Search:UpdateClearButton(
	Visible
)

	if not self.Clear then
		return
	end

	self.Clear.Visible =
		Visible

end

--==================================================
-- CANVAS
--==================================================

function Search:UpdateCanvas()

	if not self.Scroll then
		return
	end

	pcall(function()

		self.Scroll.CanvasPosition =
			Vector2.new(
				self.Scroll.CanvasPosition.X,
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
		self.Query
			or "",
		true
	)

end

--==================================================
-- SHOW ALL
--==================================================

function Search:ShowAll()

	if not self.Scroll then
		return
	end

	for _, Object in
		ipairs(
			self.Scroll:GetChildren()
		) do

		if self:IsSoundCard(
			Object
		) then

			Object.Visible =
				true

		end

	end

end

--==================================================
-- RESULT COUNT
--==================================================

function Search:GetResultCount()

	if not self.Scroll then
		return 0
	end

	local Count =
		0

	for _, Object in
		ipairs(
			self.Scroll:GetChildren()
		) do

		if self:IsSoundCard(
			Object
		)
		and Object.Visible then

			Count +=
				1

		end

	end

	return Count

end

--==================================================
-- THEME SIGNATURE
--==================================================

function Search:GetThemeSignature()

	local Theme =
		GetTheme(
			self.Theme
		)

	local function ColorSignature(
		Color
	)

		if typeof(Color) ~= "Color3" then
			return "nil"
		end

		return string.format(
			"%d_%d_%d",

			math.floor(
				Color.R * 255
			),

			math.floor(
				Color.G * 255
			),

			math.floor(
				Color.B * 255
			)
		)

	end

	return table.concat({

		ColorSignature(
			Theme.Card
		),

		ColorSignature(
			Theme.Button
		),

		ColorSignature(
			Theme.Text
		),

		ColorSignature(
			Theme.SubText
		),

		ColorSignature(
			Theme.Accent
		)

	}, "|")

end

--==================================================
-- THEME WATCHER
--==================================================

function Search:StartThemeWatcher()

	if self.ThemeConnection then

		self.ThemeConnection:Disconnect()

		self.ThemeConnection =
			nil

	end

	self.ThemeTimer =
		0

	self.LastThemeSignature =
		self:GetThemeSignature()

	self.ThemeConnection =
		RunService.RenderStepped:Connect(
			function(
				Delta
			)

				if not self.Container
				or not self.Container.Parent then

					return

				end

				self.ThemeTimer +=
					Delta

				if self.ThemeTimer
					< THEME_CHECK_INTERVAL then

					return

				end

				self.ThemeTimer =
					0

				local Signature =
					self:GetThemeSignature()

				if Signature
					~=
					self.LastThemeSignature then

					self.LastThemeSignature =
						Signature

					self:ApplyTheme()

				end

			end
		)

end

--==================================================
-- APPLY THEME
--==================================================

function Search:ApplyTheme()

	if not self.Container then
		return
	end

	local Theme =
		GetTheme(
			self.Theme
		)

	if self.Background then

		self.Background.BackgroundColor3 =
			Theme.Card

		self.Background.BackgroundTransparency =
			0.08

	end

	if self.Stroke then

		self.Stroke.Color =
			Theme.Accent

	end

	if self.LensStroke then

		self.LensStroke.Color =
			Theme.Accent

	end

	if self.Handle then

		self.Handle.BackgroundColor3 =
			Theme.Accent

	end

	if self.Input then

		self.Input.TextColor3 =
			Theme.Text

		self.Input.PlaceholderColor3 =
			Theme.SubText

	end

	if self.Results then

		self.Results.TextColor3 =
			Theme.SubText

	end

	if self.Clear then

		self.Clear.TextColor3 =
			Theme.SubText

	end

	if self.NoResults then

		self.NoResults.TextColor3 =
			Theme.SubText

	end

	--==================================================
	-- KEEP UI REFERENCES SYNCHRONIZED
	--==================================================

	if self.UI then

		self.UI.SearchBar =
			self.Container

		self.UI.SearchBox =
			self.Input

		self.UI.SearchInput =
			self.Input

		self.UI.SearchClear =
			self.Clear

		self.UI.SearchIcon =
			self.Icon

		self.UI.SearchStroke =
			self.Stroke

		self.UI.SearchResults =
			self.Results

	end

end

--==================================================
-- DESTROY
--==================================================

function Search:Destroy()

	self.RefreshToken +=
		1

	self:DisconnectEvents()

	if self.ThemeConnection then

		self.ThemeConnection:Disconnect()

		self.ThemeConnection =
			nil

	end

	if self.Container then

		self.Container:Destroy()

	end

	if self.NoResults then

		pcall(function()

			self.NoResults:Destroy()

		end)

	end

	--==================================================
	-- CLEAR SEARCH REFERENCES FROM UI
	--==================================================

	if self.UI then

		self.UI.SearchBar =
			nil

		self.UI.SearchBox =
			nil

		self.UI.SearchInput =
			nil

		self.UI.SearchClear =
			nil

		self.UI.SearchIcon =
			nil

		self.UI.SearchStroke =
			nil

		self.UI.SearchResults =
			nil

	end

	self.Container =
		nil

	self.Background =
		nil

	self.Stroke =
		nil

	self.Icon =
		nil

	self.LensStroke =
		nil

	self.Handle =
		nil

	self.Input =
		nil

	self.Clear =
		nil

	self.Results =
		nil

	self.NoResults =
		nil

	self.ThemeConnection =
		nil

	self.Initialized =
		false

end

--==================================================
-- RETURN
--==================================================

return Search
