--// 💥 RIMURU HUB
--// PREMIUM SEARCH SYSTEM
--// STABLE V2
--// SINGLE SEARCH BAR
--// TOP HEADER SEARCH
--// CASE-INSENSITIVE
--// PARTIAL MATCH
--// NAME + ID SEARCH
--// MULTI-WORD SEARCH
--// LIVE SEARCH
--// RESULT COUNTER
--// CLEAR BUTTON
--// NO RESULTS STATE
--// THEME ADAPTIVE
--// CATEGORY SAFE
--// FAVORITES SAFE
--// DUPLICATE SEARCH CLEANUP
--// LEGACY SEARCH CLEANUP
--// SAFE INITIALIZATION
--// SAFE REFRESH
--// DEBOUNCE PROTECTION
--// FUTURE FILTER COMPATIBLE

local Search = {}

--==================================================
-- CONFIG
--==================================================

local SEARCH_HEIGHT = 34

local SEARCH_TOP = 8

local SEARCH_RIGHT_PADDING = 10

local SEARCH_LEFT_PADDING = 10

local SEARCH_RADIUS = 9

local SEARCH_DEBOUNCE = 0.035

local RESULT_TEXT = " / "

local PLACEHOLDER_TEXT = "Search sounds..."

--==================================================
-- LUPA
--==================================================
-- Usamos imagem em vez de caractere Unicode.
-- Isso evita o problema de "⌕" aparecer como X
-- dependendo da fonte/dispositivo.

local SEARCH_ICON =
	"rbxassetid://6031154871"

--==================================================
-- FALLBACK COLORS
--==================================================

local FALLBACK_BACKGROUND =
	Color3.fromRGB(
		25,
		20,
		27
	)

local FALLBACK_CARD =
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

	local Success,
		Result =
		pcall(
			tostring,
			Value
		)

	if Success then
		return Result
	end

	return ""

end

--==================================================
-- GET THEME
--==================================================

local function GetTheme(
	Theme
)

	local Default = {

		Background =
			FALLBACK_BACKGROUND,

		Card =
			FALLBACK_CARD,

		Button =
			FALLBACK_CARD,

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
	-- NEW THEME SYSTEM
	--==================================================

	if type(Theme.GetCurrent) == "function" then

		local Success,
			Result =
			pcall(
				function()

					return Theme:GetCurrent()

				end
			)

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
				or Current.Content
				or Current.Main,

				FALLBACK_BACKGROUND
			),

		Card =
			SafeColor(
				Current.Card
				or Current.Button,

				FALLBACK_CARD
			),

		Button =
			SafeColor(
				Current.Button
				or Current.Card,

				FALLBACK_CARD
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

function Search:Normalize(
	Value
)

	local Text =
		SafeString(
			Value
		)

	-- Remove quebra de linha
	Text =
		Text:gsub(
			"[\r\n\t]+",
			" "
		)

	-- Junta espaços duplicados
	Text =
		Text:gsub(
			"%s+",
			" "
		)

	-- Remove espaços das pontas
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
-- REMOVE OLD SEARCH BARS
--==================================================
-- Essa parte é propositalmente agressiva.
--
-- Se alguma versão antiga do sistema criou:
--
-- Search
-- SearchBar
-- SearchBox
-- PremiumSearch
-- OldSearch
-- etc.
--
-- ela será removida antes de criar a nova.
--
-- Isso evita duas barras aparecendo.

function Search:RemoveLegacySearchBars()

	if not self.Content then
		return
	end

	local LegacyNames = {

		["PremiumSearch"] = true,

		["SearchBar"] = true,

		["SearchBox"] = true,

		["SearchContainer"] = true,

		["OldSearch"] = true,

		["LegacySearch"] = true,

		["SearchUI"] = true,

		["SoundSearch"] = true

	}

	for _, Object in
		ipairs(
			self.Content:GetChildren()
		) do

		if Object:IsA("GuiObject") then

			local Name =
				SafeString(
					Object.Name
				)

			if LegacyNames[Name] then

				-- Não destrói a nova barra
				if Object ~= self.Container then

					pcall(
						function()

							Object:Destroy()

						end
					)

				end

			end

		end

	end

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

	self.RefreshToken =
		0

	self.Searching =
		false

	self.Initialized =
		false

	self.Connections =
		self.Connections
		or {}

	--==================================================
	-- UI CHECK
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

	if not self.Content then

		warn(
			"⚠️ Rimuru Hub Search: Content não encontrado."
		)

		return false

	end

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
		pcall(
			function()

				self:Create()

			end
		)

	if not Success then

		warn(
			"❌ Rimuru Hub Search: erro ao criar."
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
-- CREATE
--==================================================

function Search:Create()

	--==================================================
	-- REMOVE EXISTING
	--==================================================

	self:DisconnectEvents()

	local Existing =
		self.Content:FindFirstChild(
			"RimuruPremiumSearch"
		)

	if Existing then

		Existing:Destroy()

	end

	-- Remove possíveis barras antigas
	self:RemoveLegacySearchBars()

	--==================================================
	-- CONTAINER
	--==================================================

	local Container =
		Instance.new(
			"Frame"
		)

	Container.Name =
		"RimuruPremiumSearch"

	Container.Position =
		UDim2.new(
			0,
			SEARCH_LEFT_PADDING,
			0,
			SEARCH_TOP
		)

	Container.Size =
		UDim2.new(
			1,
			-(
				SEARCH_LEFT_PADDING
				+
				SEARCH_RIGHT_PADDING
			),
			0,
			SEARCH_HEIGHT
		)

	Container.BackgroundTransparency =
		1

	Container.BorderSizePixel =
		0

	Container.ZIndex =
		520

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
		"SearchBackground"

	Background.Size =
		UDim2.new(
			1,
			0,
			1,
			0
		)

	Background.BackgroundColor3 =
		FALLBACK_CARD

	Background.BackgroundTransparency =
		0

	Background.BorderSizePixel =
		0

	Background.ZIndex =
		520

	Background.Parent =
		Container

	local Corner =
		Instance.new(
			"UICorner"
		)

	Corner.CornerRadius =
		UDim.new(
			0,
			SEARCH_RADIUS
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
		FALLBACK_ACCENT

	Stroke.Thickness =
		1

	Stroke.Transparency =
		0.45

	Stroke.ApplyStrokeMode =
		Enum.ApplyStrokeMode.Border

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
			"ImageLabel"
		)

	Icon.Name =
		"SearchIcon"

	Icon.Size =
		UDim2.new(
			0,
			18,
			0,
			18
		)

	Icon.Position =
		UDim2.new(
			0,
			10,
			0.5,
			-9
		)

	Icon.BackgroundTransparency =
		1

	Icon.BorderSizePixel =
		0

	Icon.Image =
		SEARCH_ICON

	Icon.ImageColor3 =
		FALLBACK_ACCENT

	Icon.ImageTransparency =
		0

	Icon.ScaleType =
		Enum.ScaleType.Fit

	Icon.ZIndex =
		521

	Icon.Parent =
		Background

	self.Icon =
		Icon

	--==================================================
	-- INPUT
	--==================================================

	local Input =
		Instance.new(
			"TextBox"
		)

	Input.Name =
		"SearchInput"

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
			-110,
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

	Input.TextEditable =
		true

	Input.Text =
		""

	Input.PlaceholderText =
		PLACEHOLDER_TEXT

	Input.TextColor3 =
		FALLBACK_TEXT

	Input.PlaceholderColor3 =
		FALLBACK_SUBTEXT

	Input.TextSize =
		11

	Input.Font =
		Enum.Font.Gotham

	Input.TextXAlignment =
		Enum.TextXAlignment.Left

	Input.TextYAlignment =
		Enum.TextYAlignment.Center

	Input.ZIndex =
		521

	Input.Parent =
		Background

	self.Input =
		Input

	--==================================================
	-- RESULTS
	--==================================================

	local Results =
		Instance.new(
			"TextLabel"
		)

	Results.Name =
		"SearchResults"

	Results.AnchorPoint =
		Vector2.new(
			1,
			0
		)

	Results.Position =
		UDim2.new(
			1,
			-40,
			0,
			0
		)

	Results.Size =
		UDim2.new(
			0,
			55,
			1,
			0
		)

	Results.BackgroundTransparency =
		1

	Results.Text =
		"0 / 0"

	Results.TextColor3 =
		FALLBACK_SUBTEXT

	Results.TextSize =
		9

	Results.Font =
		Enum.Font.GothamMedium

	Results.TextXAlignment =
		Enum.TextXAlignment.Right

	Results.TextYAlignment =
		Enum.TextYAlignment.Center

	Results.ZIndex =
		521

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
		"ClearSearch"

	Clear.AnchorPoint =
		Vector2.new(
			1,
			0.5
		)

	Clear.Position =
		UDim2.new(
			1,
			-8,
			0.5,
			0
		)

	Clear.Size =
		UDim2.new(
			0,
			25,
			0,
			25
		)

	Clear.BackgroundTransparency =
		1

	Clear.BorderSizePixel =
		0

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
		522

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
		"NoSearchResults"

	Empty.Position =
		UDim2.new(
			0,
			0,
			0,
			48
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

	Empty.TextXAlignment =
		Enum.TextXAlignment.Center

	Empty.Visible =
		false

	Empty.ZIndex =
		520

	Empty.Parent =
		self.Content

	self.NoResults =
		Empty

	--==================================================
	-- EVENTS
	--==================================================

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

				if self.Stroke then

					self.Stroke.Transparency =
						0.12

					self.Stroke.Thickness =
						1.4

				end

			end
		)
	)

	table.insert(
		self.Connections,

		Input.FocusLost:Connect(
			function()

				if self.Stroke then

					self.Stroke.Transparency =
						0.45

					self.Stroke.Thickness =
						1

				end

			end
		)
	)

	self:ApplyTheme()

end

--==================================================
-- DISCONNECT
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

	-- Categoria nova começa limpa.
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

	if self.Input then

		if self.Input.Text ~= Query then

			self.Input.Text =
				Query

			return

		end

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

	self.RefreshToken += 1

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

	self.RefreshToken += 1

	local Token =
		self.RefreshToken

	task.delay(
		SEARCH_DEBOUNCE,
		function()

			if Token ~= self.RefreshToken then
				return
			end

			if not self.Initialized then
				return
			end

			self:Search(
				Query
			)

		end
	)

end

--==================================================
-- CARD CHECK
--==================================================

function Search:IsSoundCard(
	Object
)

	if not Object then
		return false
	end

	if not Object:IsA("GuiObject") then
		return false
	end

	local Name =
		SafeString(
			Object.Name
		)

	-- Sistema atual
	if string.sub(
		Name,
		1,
		6
	) == "Sound_" then

		return true

	end

	-- Compatibilidade futura:
	-- cards podem possuir atributo.
	local IsSound =
		Object:GetAttribute(
			"IsSoundCard"
		)

	if IsSound == true then
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

	--==================================================
	-- ATTRIBUTE FIRST
	--==================================================

	local AttributeName =
		Card:GetAttribute(
			"SoundName"
		)

	local AttributeID =
		Card:GetAttribute(
			"SoundID"
		)

	--==================================================
	-- NAME
	--==================================================

	local Name =
		SafeString(
			AttributeName
		)

	if Name == "" then

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
				SafeString(
					NameLabel.Text
				)

		end

	end

	--==================================================
	-- ID
	--==================================================

	local ID =
		SafeString(
			AttributeID
		)

	if ID == "" then

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
				SafeString(
					IDLabel.Text
				)

		end

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

	if not self.Scroll then
		return
	end

	local Found =
		0

	local Total =
		0

	local HasQuery =
		self:Normalize(
			Query
		) ~= ""

	--==================================================
	-- CARDS
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

	if self.Results then

		-- SEMPRE:
		--
		-- 0 / 0
		-- 4 / 28
		-- 1 / 10

		self.Results.Text =
			tostring(Found)
			.. RESULT_TEXT
			.. tostring(Total)

	end

	--==================================================
	-- NO RESULTS
	--==================================================

	if self.NoResults then

		self.NoResults.Visible =
			HasQuery
			and Total > 0
			and Found == 0

	end

	--==================================================
	-- CLEAR
	--==================================================

	if self.Clear then

		self.Clear.Visible =
			HasQuery

	end

	self.Searching =
		HasQuery

	--==================================================
	-- CANVAS
	--==================================================

	if not Silent then

		self:UpdateCanvas()

	end

end

--==================================================
-- UPDATE CANVAS
--==================================================

function Search:UpdateCanvas()

	if not self.Scroll then
		return
	end

	pcall(
		function()

			self.Scroll.CanvasPosition =
				Vector2.new(
					self.Scroll.CanvasPosition.X,
					0
				)

		end
	)

end

--==================================================
-- REFRESH
--==================================================

function Search:Refresh()

	if not self.Initialized then
		return
	end

	-- Reobtém referências caso UI tenha
	-- recriado o Content/Scroll.

	if self.UI then

		self.Content =
			self.UI.Content
			or self.Content

		self.Scroll =
			self.UI.Scroll
			or self.Scroll

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

	self:Search(
		self.Query
		or "",
		true
	)

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

			Count += 1

		end

	end

	return Count

end

--==================================================
-- TOTAL COUNT
--==================================================

function Search:GetTotalCount()

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
		) then

			Count += 1

		end

	end

	return Count

end

--==================================================
-- APPLY THEME
--==================================================

function Search:ApplyTheme()

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
	-- RESULTS
	--==================================================

	if self.Results then

		self.Results.TextColor3 =
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

		pcall(
			function()

				self.Container:Destroy()

			end
		)

	end

	if self.NoResults then

		pcall(
			function()

				self.NoResults:Destroy()

			end
		)

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
