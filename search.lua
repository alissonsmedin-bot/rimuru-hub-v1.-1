--// 💥 RIMURU HUB
--// PREMIUM SEARCH SYSTEM
--// HEADER SEARCH
--// CASE-INSENSITIVE
--// PARTIAL MATCH
--// NAME + ID SEARCH
--// LIVE SEARCH
--// RESULT COUNTER
--// CLEAR BUTTON
--// NO RESULTS STATE
--// THEME COMPATIBLE
--// CATEGORY SAFE
--// FAVORITES COMPATIBLE
--// PERFORMANCE SAFE
--// DUPLICATE SAFE
--// REFRESH SAFE
--// FUTURE FILTER COMPATIBLE
--// HEADER INTEGRATED
--// SINGLE SEARCH BAR
--// STABLE VERSION

local Search = {}

--==================================================
-- CONFIG
--==================================================

local SEARCH_HEIGHT = 32

local SEARCH_WIDTH = 265

local SEARCH_RIGHT_OFFSET = 48

local SEARCH_DEBOUNCE = 0.045

local SEARCH_CORNER_RADIUS = 9

local SEARCH_STROKE_TRANSPARENCY = 0.42

local SEARCH_FOCUS_TRANSPARENCY = 0.12

local SEARCH_ICON_SIZE = 17

local SEARCH_TEXT_SIZE = 11

local SEARCH_RESULT_TEXT_SIZE = 8

local PLACEHOLDER_TEXT = "Search name or ID..."

--==================================================
-- FALLBACK COLORS
--==================================================

local FALLBACK_BACKGROUND =
	Color3.fromRGB(
		25,
		25,
		32
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
		240,
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
-- SEARCH ICON
--==================================================
-- Roblox built-in magnifying glass icon.
-- ImageLabel evita o antigo símbolo "⌕"
-- que podia aparecer como um retângulo
-- dependendo da fonte/dispositivo.
--==================================================

local SEARCH_ICON =
	"rbxassetid://6031094678"

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
-- SAFE NUMBER
--==================================================

local function SafeNumber(
	Value,
	Fallback
)

	if type(Value) == "number" then
		return Value
	end

	return Fallback

end

--==================================================
-- SAFE THEME
--==================================================

local function GetTheme(
	Theme
)

	if not Theme then

		return {

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

	end

	local Current = nil

	--==================================================
	-- MODERN THEME API
	--==================================================

	if type(Theme.GetCurrent) == "function" then

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
	-- COMPATIBILITY
	--==================================================

	if type(Current) ~= "table"
	and type(Theme.CurrentTheme) == "table" then

		Current =
			Theme.CurrentTheme

	end

	if type(Current) ~= "table" then
		Current = {}
	end

	return {

		Background =
			SafeColor(
				Current.Background
				or Current.Main,
				FALLBACK_BACKGROUND
			),

		Content =
			SafeColor(
				Current.Content
				or Current.Background,
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
-- NORMALIZE
--==================================================
-- Tudo passa por esta função.
--
-- M1
-- m1
-- M1
--
-- são considerados iguais.
--==================================================

function Search:Normalize(
	Value
)

	if Value == nil then
		return ""
	end

	local Text =
		tostring(Value)

	-- Normaliza espaços
	Text =
		Text:gsub(
			"%s+",
			" "
		)

	-- Remove espaços do início
	Text =
		Text:gsub(
			"^%s+",
			""
		)

	-- Remove espaços do final
	Text =
		Text:gsub(
			"%s+$",
			""
		)

	-- Case insensitive
	Text =
		string.lower(Text)

	return Text

end

--==================================================
-- GET SEARCH WORDS
--==================================================

function Search:GetWords(
	Query
)

	local Words = {}

	Query =
		self:Normalize(Query)

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
-- Todos os termos digitados precisam aparecer
-- no nome ou no ID.
--
-- Exemplo:
--
-- "m1"
--
-- encontra:
--
-- M1
-- m1
-- M1 Hit
-- Ultimate M1
--
-- "m1 123"
--
-- procura ambos os termos.
--==================================================

function Search:Matches(
	Name,
	ID,
	Query
)

	Query =
		self:Normalize(Query)

	if Query == "" then
		return true
	end

	local NameText =
		self:Normalize(Name)

	local IDText =
		self:Normalize(ID)

	local Combined =
		NameText
		.. " "
		.. IDText

	local Words =
		self:GetWords(Query)

	if #Words == 0 then
		return true
	end

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
-- INIT
--==================================================

function Search:Init(
	Context
)

	Context =
		Context
		or {}

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

	self.Initialized =
		false

	self.Destroyed =
		false

	self.Connections =
		self.Connections
		or {}

	--==================================================
	-- VALIDATE UI
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
	-- CONTENT
	--==================================================

	self.Content =
		self.UI.Content

	if not self.Content then

		warn(
			"⚠️ Rimuru Hub Search: Content não encontrado."
		)

		return false

	end

	--==================================================
	-- SCROLL
	--==================================================

	self.Scroll =
		self.UI.Scroll

	if not self.Scroll then

		warn(
			"⚠️ Rimuru Hub Search: Scroll não encontrado."
		)

		return false

	end

	--==================================================
	-- CREATE
	--==================================================

	local Success,
		Error =
		pcall(function()

			self:Create()

		end)

	if not Success then

		warn(
			"❌ Rimuru Hub Search: erro ao criar:"
		)

		warn(
			tostring(Error)
		)

		return false

	end

	self.Initialized =
		true

	self.Destroyed =
		false

	return true

end

--==================================================
-- CREATE
--==================================================

function Search:Create()

	--==================================================
	-- CLEAN OLD SEARCH
	--==================================================

	local Old =
		self.Header:FindFirstChild(
			"PremiumSearch"
		)

	if Old then
		Old:Destroy()
	end

	--==================================================
	-- CONTAINER
	--==================================================

	local Container =
		Instance.new("Frame")

	Container.Name =
		"PremiumSearch"

	Container.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	Container.Position =
		UDim2.new(
			1,
			-SEARCH_RIGHT_OFFSET,
			0.5,
			0
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
		510

	Container.Parent =
		self.Header

	self.Container =
		Container

	--==================================================
	-- BACKGROUND
	--==================================================

	local Background =
		Instance.new("Frame")

	Background.Name =
		"Background"

	Background.Size =
		UDim2.new(
			1,
			0,
			1,
			0
		)

	Background.BackgroundColor3 =
		FALLBACK_BUTTON

	Background.BackgroundTransparency =
		0

	Background.BorderSizePixel =
		0

	Background.ZIndex =
		510

	Background.Parent =
		Container

	local Corner =
		Instance.new("UICorner")

	Corner.CornerRadius =
		UDim.new(
			0,
			SEARCH_CORNER_RADIUS
		)

	Corner.Parent =
		Background

	local Stroke =
		Instance.new("UIStroke")

	Stroke.Name =
		"SearchStroke"

	Stroke.Color =
		FALLBACK_ACCENT

	Stroke.Thickness =
		1

	Stroke.Transparency =
		SEARCH_STROKE_TRANSPARENCY

	Stroke.Parent =
		Background

	self.Background =
		Background

	self.Stroke =
		Stroke

	--==================================================
	-- SEARCH ICON
	--==================================================

	local Icon =
		Instance.new("ImageLabel")

	Icon.Name =
		"SearchIcon"

	Icon.AnchorPoint =
		Vector2.new(
			0,
			0.5
		)

	Icon.Position =
		UDim2.new(
			0,
			10,
			0.5,
			0
		)

	Icon.Size =
		UDim2.new(
			0,
			SEARCH_ICON_SIZE,
			0,
			SEARCH_ICON_SIZE
		)

	Icon.BackgroundTransparency =
		1

	Icon.BorderSizePixel =
		0

	Icon.Image =
		SEARCH_ICON

	Icon.ImageColor3 =
		FALLBACK_ACCENT

	Icon.ScaleType =
		Enum.ScaleType.Fit

	Icon.ZIndex =
		511

	Icon.Parent =
		Background

	self.Icon =
		Icon

	--==================================================
	-- INPUT
	--==================================================

	local Input =
		Instance.new("TextBox")

	Input.Name =
		"Input"

	Input.Position =
		UDim2.new(
			0,
			34,
			0,
			0
		)

	Input.Size =
		UDim2.new(
			1,
			-105,
			1,
			0
		)

	Input.BackgroundTransparency =
		1

	Input.BorderSizePixel =
		0

	Input.ClearTextOnFocus =
		false

	Input.MultiLine =
		false

	Input.Text =
		""

	Input.PlaceholderText =
		PLACEHOLDER_TEXT

	Input.TextColor3 =
		FALLBACK_TEXT

	Input.PlaceholderColor3 =
		FALLBACK_SUBTEXT

	Input.TextSize =
		SEARCH_TEXT_SIZE

	Input.Font =
		Enum.Font.Gotham

	Input.TextXAlignment =
		Enum.TextXAlignment.Left

	Input.TextYAlignment =
		Enum.TextYAlignment.Center

	Input.ZIndex =
		511

	Input.Parent =
		Background

	self.Input =
		Input

	--==================================================
	-- RESULT COUNTER
	--==================================================

	local Results =
		Instance.new("TextLabel")

	Results.Name =
		"Results"

	Results.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	Results.Position =
		UDim2.new(
			1,
			-35,
			0.5,
			0
		)

	Results.Size =
		UDim2.new(
			0,
			48,
			0,
			18
		)

	Results.BackgroundTransparency =
		1

	Results.Text =
		""

	Results.TextColor3 =
		FALLBACK_SUBTEXT

	Results.TextSize =
		SEARCH_RESULT_TEXT_SIZE

	Results.Font =
		Enum.Font.GothamMedium

	Results.TextXAlignment =
		Enum.TextXAlignment.Right

	Results.TextYAlignment =
		Enum.TextYAlignment.Center

	Results.ZIndex =
		511

	Results.Parent =
		Background

	self.Results =
		Results

	--==================================================
	-- CLEAR BUTTON
	--==================================================

	local Clear =
		Instance.new("TextButton")

	Clear.Name =
		"Clear"

	Clear.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	Clear.Position =
		UDim2.new(
			1,
			-7,
			0.5,
			0
		)

	Clear.Size =
		UDim2.new(
			0,
			22,
			0,
			22
		)

	Clear.BackgroundTransparency =
		1

	Clear.BorderSizePixel =
		0

	Clear.Text =
		"×"

	Clear.TextColor3 =
		FALLBACK_SUBTEXT

	Clear.TextSize =
		17

	Clear.Font =
		Enum.Font.GothamBold

	Clear.AutoButtonColor =
		false

	Clear.Visible =
		false

	Clear.ZIndex =
		512

	Clear.Parent =
		Background

	self.Clear =
		Clear

	--==================================================
	-- NO RESULTS
	--==================================================
	-- Fica no Content, NÃO dentro da barra.
	--==================================================

	local Empty =
		self.Content:FindFirstChild(
			"SearchNoResults"
		)

	if Empty then
		Empty:Destroy()
	end

	Empty =
		Instance.new("TextLabel")

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
			115
		)

	Empty.Size =
		UDim2.new(
			1,
			-30,
			0,
			45
		)

	Empty.BackgroundTransparency =
		1

	Empty.Text =
		"No sounds found"

	Empty.TextColor3 =
		FALLBACK_SUBTEXT

	Empty.TextSize =
		12

	Empty.Font =
		Enum.Font.GothamMedium

	Empty.TextXAlignment =
		Enum.TextXAlignment.Center

	Empty.TextYAlignment =
		Enum.TextYAlignment.Center

	Empty.Visible =
		false

	Empty.ZIndex =
		505

	Empty.Parent =
		self.Content

	self.NoResults =
		Empty

	--==================================================
	-- EVENTS
	--==================================================

	self:DisconnectEvents()

	-- INPUT
	table.insert(
		self.Connections,

		Input:GetPropertyChangedSignal(
			"Text"
		):Connect(function()

			if self.Destroyed then
				return
			end

			self:ScheduleSearch(
				Input.Text
			)

		end)
	)

	-- CLEAR
	table.insert(
		self.Connections,

		Clear.MouseButton1Click:Connect(
			function()

				if self.Destroyed then
					return
				end

				self:ClearSearch()

			end
		)
	)

	-- FOCUS
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
	-- APPLY THEME
	--==================================================

	self:ApplyTheme()

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

	if self.Stroke then

		self.Stroke.Transparency =
			SEARCH_FOCUS_TRANSPARENCY

	end

end

--==================================================
-- FOCUS LOST
--==================================================

function Search:OnFocusLost()

	if self.Stroke then

		self.Stroke.Transparency =
			SEARCH_STROKE_TRANSPARENCY

	end

end

--==================================================
-- SET CATEGORY
--==================================================

function Search:SetCategory(
	Category
)

	Category =
		tostring(
			Category
			or ""
		)

	if Category == "" then

		Category =
			"Outros"

	end

	self.CurrentCategory =
		Category

	--==================================================
	-- IMPORTANTE
	--==================================================
	-- Categoria nova NÃO herda pesquisa antiga.
	--==================================================

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
		tostring(
			Query
			or ""
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
-- CLEAR SEARCH
--==================================================

function Search:ClearSearch(
	Silent
)

	self.RefreshToken += 1

	self.Query =
		""

	self.LastQuery =
		""

	self.Searching =
		false

	if self.Input
	and self.Input.Text ~= "" then

		self.Input.Text =
			""

	else

		self:Search(
			"",
			Silent == true
		)

	end

end

--==================================================
-- SCHEDULE
--==================================================

function Search:ScheduleSearch(
	Query
)

	Query =
		tostring(
			Query
			or ""
		)

	self.RefreshToken += 1

	local Token =
		self.RefreshToken

	task.delay(
		SEARCH_DEBOUNCE,
		function()

			if self.Destroyed
			or Token ~= self.RefreshToken then

				return

			end

			self:Search(
				Query
			)

		end
	)

end

--==================================================
-- IS SOUND CARD
--==================================================

function Search:IsSoundCard(
	Object
)

	if not Object then
		return false
	end

	if not Object:IsA("Frame") then
		return false
	end

	--==================================================
	-- PRIMEIRA FORMA
	--==================================================

	local Name =
		Object.Name

	if type(Name) == "string"
	and string.sub(
		Name,
		1,
		6
	) == "Sound_" then

		return true

	end

	--==================================================
	-- SEGUNDA FORMA
	--==================================================
	-- Compatibilidade futura:
	-- cards que não usam Sound_ no nome.
	--==================================================

	if Object:GetAttribute(
		"SoundCard"
	) == true then

		return true

	end

	return false

end

--==================================================
-- GET CARD DATA
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

	--==================================================
	-- NAME LABEL
	--==================================================

	local NameLabel =
		Card:FindFirstChild(
			"Name",
			true
		)

	if NameLabel
	and NameLabel:IsA(
		"TextLabel"
	) then

		Name =
			NameLabel.Text

	elseif NameLabel
	and NameLabel:IsA(
		"TextButton"
	) then

		Name =
			NameLabel.Text

	end

	--==================================================
	-- ID LABEL
	--==================================================

	local IDLabel =
		Card:FindFirstChild(
			"ID",
			true
		)

	if IDLabel
	and IDLabel:IsA(
		"TextLabel"
	) then

		ID =
			IDLabel.Text

	elseif IDLabel
	and IDLabel:IsA(
		"TextButton"
	) then

		ID =
			IDLabel.Text

	end

	--==================================================
	-- ATTRIBUTE FALLBACK
	--==================================================

	if Name == "" then

		local AttributeName =
			Card:GetAttribute(
				"SoundName"
			)

		if AttributeName ~= nil then

			Name =
				tostring(
					AttributeName
				)

		end

	end

	if ID == "" then

		local AttributeID =
			Card:GetAttribute(
				"SoundID"
			)

		if AttributeID ~= nil then

			ID =
				tostring(
					AttributeID
				)

		end

	end

	return
		tostring(Name),
		tostring(ID)

end

--==================================================
-- SEARCH
--==================================================

function Search:Search(
	Query,
	Silent
)

	if self.Destroyed then
		return
	end

	Query =
		tostring(
			Query
			or ""
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

	if not self.Scroll then
		return
	end

	--==================================================
	-- PROCESS
	--==================================================

	for _, Object in
		ipairs(
			self.Scroll:GetChildren()
		) do

		if self:IsSoundCard(
			Object
		) then

			Total += 1

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

				Found += 1

			end

		end

	end

	--==================================================
	-- RESULTS
	--==================================================

	self:UpdateResults(
		Found,
		Total,
		HasQuery
	)

	--==================================================
	-- EMPTY
	--==================================================

	self:UpdateNoResults(
		Found,
		Total,
		HasQuery
	)

	--==================================================
	-- CLEAR
	--==================================================

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
-- UPDATE RESULTS
--==================================================

function Search:UpdateResults(
	Found,
	Total,
	HasQuery
)

	if not self.Results then
		return
	end

	if HasQuery then

		self.Results.Text =
			tostring(Found)
			.. "/"
			.. tostring(Total)

	else

		self.Results.Text =
			""

	end

end

--==================================================
-- UPDATE NO RESULTS
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
-- UPDATE CLEAR
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
-- UPDATE CANVAS
--==================================================

function Search:UpdateCanvas()

	if not self.Scroll then
		return
	end

	pcall(function()

		self.Scroll.CanvasPosition =
			Vector2.new(
				0,
				0
			)

	end)

end

--==================================================
-- REFRESH
--==================================================

function Search:Refresh()

	if not self.Initialized
	or self.Destroyed then

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

	self:UpdateNoResults(
		0,
		0,
		false
	)

end

--==================================================
-- GET RESULT COUNT
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

			Count += 1

		end

	end

	return Count

end

--==================================================
-- APPLY THEME
--==================================================

function Search:ApplyTheme()

	if self.Destroyed then
		return
	end

	local Theme =
		GetTheme(
			self.Theme
		)

	--==================================================
	-- BACKGROUND
	--==================================================

	if self.Background then

		self.Background.BackgroundColor3 =
			Theme.Card

	end

	--==================================================
	-- BORDER
	--==================================================

	if self.Stroke then

		self.Stroke.Color =
			Theme.Accent

	end

	--==================================================
	-- ICON
	--==================================================

	if self.Icon then

		self.Icon.ImageColor3 =
			Theme.Accent

	end

	--==================================================
	-- INPUT
	--==================================================

	if self.Input then

		self.Input.TextColor3 =
			Theme.Text

		self.Input.PlaceholderColor3 =
			Theme.SubText

	end

	--==================================================
	-- CLEAR
	--==================================================

	if self.Clear then

		self.Clear.TextColor3 =
			Theme.SubText

	end

	--==================================================
	-- RESULTS
	--==================================================

	if self.Results then

		self.Results.TextColor3 =
			Theme.SubText

	end

	--==================================================
	-- NO RESULTS
	--==================================================

	if self.NoResults then

		self.NoResults.TextColor3 =
			Theme.SubText

	end

end

--==================================================
-- DESTROY
--==================================================

function Search:Destroy()

	self.Destroyed =
		true

	self.RefreshToken += 1

	self:DisconnectEvents()

	if self.Container then

		self.Container:Destroy()

	end

	if self.NoResults then

		self.NoResults:Destroy()

	end

	self.Container =
		nil

	self.Background =
		nil

	self.Stroke =
		nil

	self.Icon =
		nil

	self.Input =
		nil

	self.Clear =
		nil

	self.Results =
		nil

	self.NoResults =
		nil

	self.Header =
		nil

	self.Content =
		nil

	self.Scroll =
		nil

	self.Initialized =
		false

end

--==================================================
-- RETURN
--==================================================

return Search
