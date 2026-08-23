--// 💥 RIMURU HUB
--// PREMIUM SEARCH SYSTEM
--// CASE-INSENSITIVE SEARCH
--// PARTIAL MATCH
--// NAME + ID SEARCH
--// CATEGORY AWARE
--// FAVORITES AWARE
--// LIVE SEARCH
--// RESULT COUNTER
--// CLEAR BUTTON
--// NO RESULTS STATE
--// THEME COMPATIBLE
--// SAFE INITIALIZATION
--// SAFE REFRESH
--// DUPLICATE CONNECTION PROTECTION
--// SEARCH STATE PROTECTION
--// PERFORMANCE SAFE
--// FUTURE FILTER COMPATIBLE

local Search = {}

--==================================================
-- CONFIG
--==================================================

local SEARCH_DEBOUNCE = 0.035

local SEARCH_HEIGHT = 34

local SEARCH_TOP_OFFSET = 42

local SEARCH_BOTTOM_OFFSET = 8

local RESULT_TEXT = "Results: "

local PLACEHOLDER_TEXT =
	"Search sounds..."

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
-- SAFE THEME
--==================================================

local function GetTheme(
	Theme
)

	if not Theme then

		return {
			Background = FALLBACK_BACKGROUND,
			Card = FALLBACK_BUTTON,
			Button = FALLBACK_BUTTON,
			Text = FALLBACK_TEXT,
			SubText = FALLBACK_SUBTEXT,
			Accent = FALLBACK_ACCENT
		}

	end

	local Current

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

	if type(Current) ~= "table" then

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
					or Current.Content,
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
-- NORMALIZE TEXT
--==================================================
-- Esta é uma das partes mais importantes.
--
-- Tudo passa por aqui antes de ser comparado.
--
-- M1
-- m1
-- M1
--
-- serão tratados da mesma maneira.
--==================================================

function Search:Normalize(
	Value
)

	if Value == nil then
		return ""
	end

	local Text =
		tostring(
			Value
		)

	-- Remove espaços extras
	Text =
		Text:gsub(
			"%s+",
			" "
		)

	-- Remove espaços nas pontas
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

	-- Case insensitive
	Text =
		string.lower(
			Text
		)

	return Text

end

--==================================================
-- SPLIT SEARCH WORDS
--==================================================

function Search:GetWords(
	Query
)

	local Words = {}

	Query =
		self:Normalize(
			Query
		)

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
-- WORD MATCH
--==================================================
-- Todos os termos precisam existir.
--
-- Exemplo:
--
-- "m1 hit"
--
-- encontra:
--
-- "M1 Hit 1"
-- "M1 Hit 2"
--
-- mas não:
--
-- "M1 Down"
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

	local Words =
		self:GetWords(
			Query
		)

	for _, Word in
		ipairs(
			Words
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

	self.CurrentCategory =
		"Outros"

	self.LastQuery =
		""

	self.Searching =
		false

	self.RefreshToken =
		0

	self.Connections =
		self.Connections
		or {}

	self.Initialized =
		false

	--==================================================
	-- FIND CONTENT
	--==================================================

	if not self.UI then

		warn(
			"⚠️ Rimuru Hub Search: UI não encontrado."
		)

		return false

	end

	self.Content =
		self.UI.Content

	self.Scroll =
		self.UI.Scroll

	if not self.Content
	or not self.Scroll then

		warn(
			"⚠️ Rimuru Hub Search: Content/Scroll não encontrado."
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
			"❌ Rimuru Hub Search: erro ao criar:",
			tostring(Error)
		)

		return false

	end

	self.Initialized =
		true

	return true

end

--==================================================
-- CREATE SEARCH BAR
--==================================================

function Search:Create()

	-- Evita duplicação
	local Existing =
		self.Content:FindFirstChild(
			"PremiumSearch"
		)

	if Existing then

		Existing:Destroy()

	end

	--==================================================
	-- CONTAINER
	--==================================================

	local Container =
		Instance.new(
			"Frame"
		)

	Container.Name =
		"PremiumSearch"

	Container.Position =
		UDim2.new(
			0,
			10,
			0,
			8
		)

	Container.Size =
		UDim2.new(
			1,
			-20,
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
		self.Content

	self.Container =
		Container

	--==================================================
	-- SEARCH BACKGROUND
	--==================================================

	local Background =
		Instance.new(
			"Frame"
		)

	Background.Name =
		"Background"

	Background.Size =
		UDim2.new(
			1,
			-72,
			1,
			0
		)

	Background.BackgroundColor3 =
		FALLBACK_BACKGROUND

	Background.BackgroundTransparency =
		0

	Background.BorderSizePixel =
		0

	Background.ZIndex =
		510

	Background.Parent =
		Container

	local Corner =
		Instance.new(
			"UICorner"
		)

	Corner.CornerRadius =
		UDim.new(
			0,
			9
		)

	Corner.Parent =
		Background

	local Stroke =
		Instance.new(
			"UIStroke"
		)

	Stroke.Name =
		"SearchStroke"

	Stroke.Thickness =
		1

	Stroke.Transparency =
		0.45

	Stroke.Color =
		FALLBACK_ACCENT

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
		Instance.new(
			"TextLabel"
		)

	Icon.Name =
		"SearchIcon"

	Icon.Position =
		UDim2.new(
			0,
			10,
			0,
			0
		)

	Icon.Size =
		UDim2.new(
			0,
			22,
			1,
			0
		)

	Icon.BackgroundTransparency =
		1

	Icon.Text =
		"⌕"

	Icon.TextSize =
		21

	Icon.Font =
		Enum.Font.GothamBold

	Icon.TextColor3 =
		FALLBACK_ACCENT

	Icon.ZIndex =
		511

	Icon.Parent =
		Background

	self.Icon =
		Icon

	--==================================================
	-- TEXT BOX
	--==================================================

	local TextBox =
		Instance.new(
			"TextBox"
		)

	TextBox.Name =
		"Input"

	TextBox.Position =
		UDim2.new(
			0,
			36,
			0,
			0
		)

	TextBox.Size =
		UDim2.new(
			1,
			-70,
			1,
			0
		)

	TextBox.BackgroundTransparency =
		1

	TextBox.ClearTextOnFocus =
		false

	TextBox.PlaceholderText =
		PLACEHOLDER_TEXT

	TextBox.Text =
		""

	TextBox.TextColor3 =
		FALLBACK_TEXT

	TextBox.PlaceholderColor3 =
		FALLBACK_SUBTEXT

	TextBox.TextSize =
		11

	TextBox.Font =
		Enum.Font.Gotham

	TextBox.TextXAlignment =
		Enum.TextXAlignment.Left

	TextBox.ZIndex =
		511

	TextBox.Parent =
		Background

	self.Input =
		TextBox

	--==================================================
	-- CLEAR BUTTON
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
			28,
			0,
			28
		)

	Clear.Position =
		UDim2.new(
			1,
			-34,
			0.5,
			-14
		)

	Clear.BackgroundTransparency =
		1

	Clear.Text =
		"×"

	Clear.TextSize =
		18

	Clear.Font =
		Enum.Font.GothamBold

	Clear.TextColor3 =
		FALLBACK_SUBTEXT

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
	-- RESULT COUNTER
	--==================================================

	local Results =
		Instance.new(
			"TextLabel"
		)

	Results.Name =
		"Results"

	Results.Position =
		UDim2.new(
			1,
			-65,
			0,
			0
		)

	Results.Size =
		UDim2.new(
			0,
			65,
			1,
			0
		)

	Results.BackgroundTransparency =
		1

	Results.Text =
		""

	Results.TextColor3 =
		FALLBACK_SUBTEXT

	Results.TextSize =
		9

	Results.Font =
		Enum.Font.GothamMedium

	Results.TextXAlignment =
		Enum.TextXAlignment.Right

	Results.ZIndex =
		511

	Results.Parent =
		Container

	self.Results =
		Results

	--==================================================
	-- NO RESULTS
	--==================================================

	local Empty =
		Instance.new(
			"TextLabel"
		)

	Empty.Name =
		"NoResults"

	Empty.Position =
		UDim2.new(
			0,
			0,
			0,
			55
		)

	Empty.Size =
		UDim2.new(
			1,
			0,
			0,
			40
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

	Empty.Visible =
		false

	Empty.ZIndex =
		510

	Empty.Parent =
		self.Content

	self.NoResults =
		Empty

	--==================================================
	-- EVENTS
	--==================================================

	self:DisconnectEvents()

	table.insert(
		self.Connections,

		TextBox:GetPropertyChangedSignal(
			"Text"
		):Connect(function()

			self:ScheduleSearch(
				TextBox.Text
			)

		end)

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

		TextBox.Focused:Connect(
			function()

				self:OnFocus()

			end
		)

	)

	table.insert(
		self.Connections,

		TextBox.FocusLost:Connect(
			function()

				self:OnFocusLost()

			end
		)

	)

	self:ApplyTheme()

end

--==================================================
-- DISCONNECT EVENTS
--==================================================

function Search:DisconnectEvents()

	if not self.Connections then
		self.Connections = {}
		return
	end

	for _, Connection in
		ipairs(
			self.Connections
		) do

		if Connection
		and type(Connection.Disconnect) == "function" then

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
			0.15

	end

end

function Search:OnFocusLost()

	if self.Stroke then

		self.Stroke.Transparency =
			0.45

	end

end

--==================================================
-- SET CATEGORY
--==================================================
-- Chamado pelo Categories.lua.
--
-- Importante:
-- trocar categoria limpa a pesquisa.
-- Isso evita a categoria nova herdar uma query
-- antiga sem querer.
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
		Category = "Outros"
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

	self.Query =
		""

	self.LastQuery =
		""

	if self.Input then

		self.Input.Text =
			""

	end

	if not Silent then

		self:Search(
			""
		)

	else

		self:Search(
			"",
			true
		)

	end

end

--==================================================
-- SCHEDULE SEARCH
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
-- CHECK CARD
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

	local Name =
		Object.Name

	if type(Name) ~= "string" then
		return false
	end

	return string.sub(
		Name,
		1,
		6
	) == "Sound_"

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

	local NameLabel =
		Card:FindFirstChild(
			"Name"
		)

	local IDLabel =
		Card:FindFirstChild(
			"ID"
		)

	local Name =
		NameLabel
		and NameLabel:IsA("TextLabel")
		and NameLabel.Text
		or ""

	local ID =
		IDLabel
		and IDLabel:IsA("TextLabel")
		and IDLabel.Text
		or ""

	return (
		tostring(Name)
	),
	(
		tostring(ID)
	)

end

--==================================================
-- SEARCH
--==================================================

function Search:Search(
	Query,
	Silent
)

	Query =
		tostring(
			Query
			or ""
		)

	self.Query =
		Query

	self.LastQuery =
		Query

	local NormalizedQuery =
		self:Normalize(
			Query
		)

	local HasQuery =
		NormalizedQuery ~= ""

	local Found =
		0

	local Total =
		0

	if not self.Scroll then
		return
	end

	--==================================================
	-- PROCESS CARDS
	--==================================================

	for _, Object in
		ipairs(
			self.Scroll:GetChildren()
		) do

		if self:IsSoundCard(Object) then

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
	-- UPDATE RESULT
	--==================================================

	self:UpdateResults(
		Found,
		Total,
		HasQuery
	)

	--==================================================
	-- NO RESULTS
	--==================================================

	self:UpdateNoResults(
		Found,
		Total,
		HasQuery
	)

	self.Searching =
		HasQuery

	self:UpdateClearButton(
		HasQuery
	)

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
			RESULT_TEXT
			.. tostring(Found)

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

	if HasQuery
	and Total > 0
	and Found == 0 then

		self.NoResults.Visible =
			true

	else

		self.NoResults.Visible =
			false

	end

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

	-- AutomaticCanvasSize já é usado pelo UI.
	-- Esta chamada apenas força uma atualização
	-- quando necessário.

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
-- Útil quando:
--
-- Favorites mudou
-- Cards foram recriados
-- Categoria mudou
-- Theme foi alterado
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

		if self:IsSoundCard(Object) then

			Object.Visible =
				true

		end

	end

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

		if self:IsSoundCard(Object)
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

	if not self.Content then
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
	-- STROKE
	--==================================================

	if self.Stroke then

		self.Stroke.Color =
			Theme.Accent

	end

	--==================================================
	-- ICON
	--==================================================

	if self.Icon then

		self.Icon.TextColor3 =
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

	self.Initialized =
		false

end

--==================================================
-- RETURN
--==================================================

return Search
