--// 💥 RIMURU HUB
--// UI SYSTEM
--// PREMIUM NEON UI
--// SEARCH REMOVED FROM UI
--// SEARCH SYSTEM COMPATIBLE
--// SAFE THEME COMPATIBILITY
--// SAFE FALLBACK SYSTEM
--// STABLE BORDER SYSTEM
--// NATURAL PULSING GLOW
--// SOFT INTERFACE SHADOW
--// ROUNDED CORNERS
--// SOFT ANIMATIONS
--// DRAG SUPPORT
--// BACKGROUND SUPPORT
--// CATEGORY THEME COMPATIBILITY
--// BLACKOUT COMPATIBLE
--// UPDATED / STABLE

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

--==================================================
-- MODULE
--==================================================

local UI = {}

--==================================================
-- ANIMATION
--==================================================

local OPEN_TIME = 0.25
local CLOSE_TIME = 0.18

local OPEN_SCALE = 0.96
local CLOSE_SCALE = 0.98

local OPEN_OFFSET_Y = 8
local CLOSE_OFFSET_Y = 7

--==================================================
-- ROUNDED CORNERS
--==================================================

local CORNER_RADIUS = 14
local SMALL_CORNER_RADIUS = 10

--==================================================
-- BORDER
--==================================================

local BORDER_THICKNESS = 1.6
local BORDER_TRANSPARENCY = 0.42

--==================================================
-- PULSE
--==================================================

local PULSE_MIN_TRANSPARENCY = 0.16
local PULSE_MAX_TRANSPARENCY = 0.48

local PULSE_MIN_THICKNESS = 1.5
local PULSE_MAX_THICKNESS = 2.15

local PULSE_SPEED = 1.15

--==================================================
-- GLOW
--==================================================

local GLOW_THICKNESS = 6

local GLOW_MIN_TRANSPARENCY = 0.78
local GLOW_MAX_TRANSPARENCY = 0.94

--==================================================
-- SHADOW
--==================================================

local SHADOW_PADDING = 10

local SHADOW_TRANSPARENCY = 0.92

local SHADOW_MIN_TRANSPARENCY = 0.915
local SHADOW_MAX_TRANSPARENCY = 0.94

local SHADOW_PULSE_SPEED = 0.77

--==================================================
-- FALLBACK COLORS
--==================================================

local FALLBACK_BACKGROUND = Color3.fromRGB(
	10,
	10,
	15
)

local FALLBACK_CONTENT = Color3.fromRGB(
	15,
	15,
	20
)

local FALLBACK_CARD = Color3.fromRGB(
	25,
	25,
	32
)

local FALLBACK_ACCENT = Color3.fromRGB(
	25,
	150,
	255
)

local FALLBACK_TEXT = Color3.fromRGB(
	240,
	240,
	245
)

local FALLBACK_SUBTEXT = Color3.fromRGB(
	140,
	145,
	155
)

local FALLBACK_BLACK = Color3.fromRGB(
	8,
	8,
	8
)

local FALLBACK_WHITE = Color3.fromRGB(
	245,
	245,
	245
)

--==================================================
-- SAFE HELPERS
--==================================================

local function SafeColor(Value, Fallback)
	if typeof(Value) == "Color3" then
		return Value
	end

	return Fallback
end

local function SafeNumber(Value, Fallback)
	if type(Value) == "number" then
		return Value
	end

	return Fallback
end

--==================================================
-- FALLBACK THEME
--==================================================

local function BuildFallbackTheme()

	return {

		Name = "Rimuru Dark",

		Background = FALLBACK_BACKGROUND,

		Main = FALLBACK_BACKGROUND,

		Sidebar = FALLBACK_CONTENT,

		Content = FALLBACK_CONTENT,

		Card = FALLBACK_CARD,

		Button = FALLBACK_CARD,

		Close = FALLBACK_CARD,

		Accent = FALLBACK_ACCENT,

		Text = FALLBACK_TEXT,

		SubText = FALLBACK_SUBTEXT,

		LogoBackground = FALLBACK_BACKGROUND,

		LogoBorder = FALLBACK_ACCENT,

		BackgroundImage = nil,

		BackgroundTransparency = 0.35,

		GlowEnabled = true,

		ShadowEnabled = true,

		ShadowTransparency = SHADOW_TRANSPARENCY,

		RGB = false,

		BorderPulse = true
	}

end

--==================================================
-- GET CURRENT THEME
--==================================================

local function GetCurrentTheme(Theme)

	if not Theme then
		return BuildFallbackTheme()
	end

	local Current = nil

	if type(Theme.GetCurrent) == "function" then

		local Success, Result = pcall(function()
			return Theme:GetCurrent()
		end)

		if Success and type(Result) == "table" then
			Current = Result
		end
	end

	if not Current and type(Theme.CurrentTheme) == "table" then
		Current = Theme.CurrentTheme
	end

	if type(Current) ~= "table" then
		Current = BuildFallbackTheme()
	end

	Current.Card = SafeColor(
		Current.Card,
		FALLBACK_CARD
	)

	Current.Button = SafeColor(
		Current.Button,
		Current.Card
	)

	Current.Close = SafeColor(
		Current.Close,
		Current.Button
	)

	Current.Background = SafeColor(
		Current.Background or Current.Main,
		FALLBACK_BACKGROUND
	)

	Current.Main = Current.Background

	Current.Sidebar = SafeColor(
		Current.Sidebar,
		FALLBACK_CONTENT
	)

	Current.Content = SafeColor(
		Current.Content,
		FALLBACK_CONTENT
	)

	Current.Accent = SafeColor(
		Current.Accent,
		FALLBACK_ACCENT
	)

	Current.Text = SafeColor(
		Current.Text,
		FALLBACK_TEXT
	)

	Current.SubText = SafeColor(
		Current.SubText,
		FALLBACK_SUBTEXT
	)

	return Current
end

--==================================================
-- GET THEME NAME
--==================================================

local function GetThemeName(Theme)

	if not Theme then
		return "Rimuru Dark"
	end

	if type(Theme.GetName) == "function" then

		local Success, Result = pcall(function()
			return Theme:GetName()
		end)

		if Success and Result ~= nil then
			return tostring(Result)
		end
	end

	if type(Theme.GetCurrentName) == "function" then

		local Success, Result = pcall(function()
			return Theme:GetCurrentName()
		end)

		if Success and Result ~= nil then
			return tostring(Result)
		end
	end

	if Theme.CurrentThemeName then
		return tostring(
			Theme.CurrentThemeName
		)
	end

	local Current = GetCurrentTheme(Theme)

	if Current.Name then
		return tostring(Current.Name)
	end

	return "Rimuru Dark"
end

--==================================================
-- THEME COMPATIBILITY
--==================================================

function UI:EnsureThemeCompatibility()

	local Theme = self.Theme

	if not Theme then
		return
	end

	--==================================================
	-- NORMAL COLOR
	--==================================================

	if type(Theme.GetNormalColor) ~= "function" then

		Theme.GetNormalColor = function(Self)

			local Current = GetCurrentTheme(Self)

			local Name = string.lower(
				tostring(
					Current.Name
						or GetThemeName(Self)
				)
			)

			if string.find(
				Name,
				"blackout",
				1,
				true
			) then

				return Color3.fromRGB(
					8,
					8,
					8
				)
			end

			return SafeColor(
				Current.Button
					or Current.Card,
				FALLBACK_CARD
			)
		end
	end

	--==================================================
	-- NORMAL TEXT
	--==================================================

	if type(Theme.GetNormalTextColor) ~= "function" then

		Theme.GetNormalTextColor = function(Self)

			local Current = GetCurrentTheme(Self)

			local Name = string.lower(
				tostring(
					Current.Name
						or GetThemeName(Self)
				)
			)

			if string.find(
				Name,
				"blackout",
				1,
				true
			) then

				return FALLBACK_WHITE
			end

			return SafeColor(
				Current.Text,
				FALLBACK_TEXT
			)
		end
	end

	--==================================================
	-- SELECTED COLOR
	--==================================================

	if type(Theme.GetSelectedColor) ~= "function" then

		Theme.GetSelectedColor = function(Self)

			local Current = GetCurrentTheme(Self)

			local Name = string.lower(
				tostring(
					Current.Name
						or GetThemeName(Self)
				)
			)

			if string.find(
				Name,
				"blackout",
				1,
				true
			) then

				return FALLBACK_WHITE
			end

			if type(Self.GetAccent) == "function" then

				local Success, Result = pcall(function()
					return Self:GetAccent()
				end)

				if Success
					and typeof(Result) == "Color3" then

					return Result
				end
			end

			return SafeColor(
				Current.Accent,
				FALLBACK_ACCENT
			)
		end
	end

	--==================================================
	-- SELECTED TEXT
	--==================================================

	if type(Theme.GetSelectedTextColor) ~= "function" then

		Theme.GetSelectedTextColor = function(Self)

			local Current = GetCurrentTheme(Self)

			local Name = string.lower(
				tostring(
					Current.Name
						or GetThemeName(Self)
				)
			)

			if string.find(
				Name,
				"blackout",
				1,
				true
			) then

				return FALLBACK_BLACK
			end

			return SafeColor(
				Current.Text,
				FALLBACK_TEXT
			)
		end
	end

end

--==================================================
-- ACCENT
--==================================================

function UI:GetAccent()

	local Theme = self.Theme

	if Theme and type(Theme.GetAccent) == "function" then

		local Success, Result = pcall(function()
			return Theme:GetAccent()
		end)

		if Success and typeof(Result) == "Color3" then
			return Result
		end
	end

	local Current = GetCurrentTheme(Theme)

	return SafeColor(
		Current.Accent,
		FALLBACK_ACCENT
	)
end

--==================================================
-- GLOW COLOR
--==================================================

function UI:GetGlowColor()

	local Theme = self.Theme

	if Theme and type(Theme.GetGlowColor) == "function" then

		local Success, Result = pcall(function()
			return Theme:GetGlowColor()
		end)

		if Success and typeof(Result) == "Color3" then
			return Result
		end
	end

	return self:GetAccent()
end

--==================================================
-- LOGO BORDER
--==================================================

function UI:GetLogoBorderColor()

	local Theme = self.Theme

	if Theme and type(Theme.GetLogoBorder) == "function" then

		local Success, Result = pcall(function()
			return Theme:GetLogoBorder()
		end)

		if Success and typeof(Result) == "Color3" then
			return Result
		end
	end

	local Current = GetCurrentTheme(Theme)

	return SafeColor(
		Current.LogoBorder or Current.Accent,
		FALLBACK_ACCENT
	)
end

--==================================================
-- BACKGROUND TRANSPARENCY
--==================================================

function UI:GetBackgroundTransparency()

	local Theme = self.Theme

	if Theme
		and type(Theme.GetBackgroundTransparency) == "function" then

		local Success, Result = pcall(function()
			return Theme:GetBackgroundTransparency()
		end)

		if Success and type(Result) == "number" then

			return math.clamp(
				Result,
				0,
				1
			)
		end
	end

	local Current = GetCurrentTheme(Theme)

	return math.clamp(
		SafeNumber(
			Current.BackgroundTransparency,
			0.35
		),
		0,
		1
	)
end

--==================================================
-- GLOW
--==================================================

function UI:ShouldUseGlow()

	local Current = GetCurrentTheme(self.Theme)

	if Current.GlowEnabled ~= nil then
		return Current.GlowEnabled == true
	end

	return false
end

--==================================================
-- SHADOW
--==================================================

function UI:ShouldUseShadow()

	local Current = GetCurrentTheme(self.Theme)

	if Current.ShadowEnabled ~= nil then
		return Current.ShadowEnabled == true
	end

	return false
end

--==================================================
-- INIT
--==================================================

function UI:Init(Context)

	self.Context = Context or {}

	self.Player =
		self.Context.Player
		or Players.LocalPlayer

	if not self.Player then

		warn(
			"❌ Rimuru Hub UI: LocalPlayer não encontrado."
		)

		return false
	end

	self.PlayerGui =
		self.Context.PlayerGui
		or self.Player:WaitForChild(
			"PlayerGui"
		)

	self.Config = self.Context.Config
	self.Theme = self.Context.Theme

	self.AnimationBusy = false
	self.AnimationToken = 0

	self.NeonConnection = nil
	self.NeonTime = 0

	self:EnsureThemeCompatibility()

	local Success, Error = pcall(function()
		self:Create()
	end)

	if not Success then

		warn(
			"❌ Rimuru Hub UI: erro ao criar interface:"
		)

		warn(
			tostring(Error)
		)

		return false
	end

	return true
end

--==================================================
-- REMOVE OLD GUI
--==================================================

function UI:RemoveOld()

	if not self.PlayerGui then
		return
	end

	pcall(function()

		local Old =
			self.PlayerGui:FindFirstChild(
				"RimuruHub"
			)

		if Old then
			Old:Destroy()
		end
	end)
end

--==================================================
-- CREATE
--==================================================

function UI:Create()

	self:RemoveOld()

	local CurrentTheme =
		GetCurrentTheme(self.Theme)

	--==================================================
	-- SCREEN GUI
	--==================================================

	local Gui = Instance.new("ScreenGui")

	Gui.Name = "RimuruHub"

	Gui.ResetOnSpawn = false

	Gui.IgnoreGuiInset = true

	Gui.ZIndexBehavior =
		Enum.ZIndexBehavior.Global

	Gui.DisplayOrder = 999999

	Gui.Parent = self.PlayerGui

	self.Gui = Gui

	--==================================================
	-- SHADOW
	--==================================================

	local Shadow = Instance.new("Frame")

	Shadow.Name = "InterfaceShadow"

	Shadow.Size = UDim2.new(
		0,
		600 + SHADOW_PADDING * 2,
		0,
		400 + SHADOW_PADDING * 2
	)

	Shadow.Position = UDim2.new(
		0.5,
		-300 - SHADOW_PADDING,
		0.5,
		-200 - SHADOW_PADDING
	)

	Shadow.BackgroundColor3 =
		Color3.fromRGB(0, 0, 0)

	Shadow.BackgroundTransparency =
		SafeNumber(
			CurrentTheme.ShadowTransparency,
			SHADOW_TRANSPARENCY
		)

	Shadow.BorderSizePixel = 0

	Shadow.Visible = false

	Shadow.ZIndex = 498

	Shadow.Parent = Gui

	local ShadowCorner =
		Instance.new("UICorner")

	ShadowCorner.CornerRadius =
		UDim.new(
			0,
			CORNER_RADIUS + 5
		)

	ShadowCorner.Parent = Shadow

	self.Shadow = Shadow

	--==================================================
	-- MAIN
	--==================================================

	local Main = Instance.new("Frame")

	Main.Name = "Main"

	Main.Size = UDim2.new(
		0,
		600,
		0,
		400
	)

	Main.Position = UDim2.new(
		0.5,
		-300,
		0.5,
		-200
	)

	Main.BackgroundColor3 =
		SafeColor(
			CurrentTheme.Background,
			FALLBACK_BACKGROUND
		)

	Main.BackgroundTransparency = 0.10

	Main.BorderSizePixel = 0

	Main.Visible = false

	Main.ZIndex = 500

	Main.ClipsDescendants = true

	Main.Parent = Gui

	self.Main = Main

	self.OriginalPosition =
		Main.Position

	self.OriginalSize =
		Main.Size

	--==================================================
	-- SCALE
	--==================================================

	local MainScale =
		Instance.new("UIScale")

	MainScale.Name = "MenuScale"

	MainScale.Scale = 1

	MainScale.Parent = Main

	self.MainScale = MainScale

	--==================================================
	-- CORNER
	--==================================================

	local MainCorner =
		Instance.new("UICorner")

	MainCorner.CornerRadius =
		UDim.new(
			0,
			CORNER_RADIUS
		)

	MainCorner.Parent = Main

	self.MainCorner = MainCorner

	--==================================================
	-- BORDER
	--==================================================

	local MainStroke =
		Instance.new("UIStroke")

	MainStroke.Name =
		"NormalBorder"

	MainStroke.Color =
		self:GetAccent()

	MainStroke.Thickness =
		BORDER_THICKNESS

	MainStroke.Transparency =
		BORDER_TRANSPARENCY

	MainStroke.ApplyStrokeMode =
		Enum.ApplyStrokeMode.Border

	MainStroke.Parent = Main

	self.MainStroke = MainStroke

	--==================================================
	-- GLOW
	--==================================================

	local Glow =
		Instance.new("Frame")

	Glow.Name = "NeonGlow"

	Glow.Size =
		UDim2.new(1, 0, 1, 0)

	Glow.BackgroundTransparency = 1

	Glow.BorderSizePixel = 0

	Glow.ZIndex = 499

	Glow.ClipsDescendants = true

	Glow.Parent = Main

	local GlowCorner =
		Instance.new("UICorner")

	GlowCorner.CornerRadius =
		UDim.new(
			0,
			CORNER_RADIUS
		)

	GlowCorner.Parent = Glow

	local GlowStroke =
		Instance.new("UIStroke")

	GlowStroke.Name =
		"GlowStroke"

	GlowStroke.Color =
		self:GetGlowColor()

	GlowStroke.Thickness =
		GLOW_THICKNESS

	GlowStroke.Transparency = 1

	GlowStroke.ApplyStrokeMode =
		Enum.ApplyStrokeMode.Border

	GlowStroke.Parent = Glow

	self.Glow = Glow
	self.GlowStroke = GlowStroke

	--==================================================
	-- BACKGROUND IMAGE
	--==================================================

	local Background =
		Instance.new("ImageLabel")

	Background.Name =
		"ThemeBackground"

	Background.Size =
		UDim2.new(1, 0, 1, 0)

	Background.BackgroundTransparency = 1

	Background.BorderSizePixel = 0

	Background.ScaleType =
		Enum.ScaleType.Crop

	Background.ImageTransparency =
		self:GetBackgroundTransparency()

	Background.ZIndex = 501

	Background.Visible = false

	Background.Parent = Main

	local BackgroundCorner =
		Instance.new("UICorner")

	BackgroundCorner.CornerRadius =
		UDim.new(
			0,
			CORNER_RADIUS
		)

	BackgroundCorner.Parent =
		Background

	self.Background = Background

	--==================================================
	-- HEADER
	--==================================================

	local Header =
		Instance.new("Frame")

	Header.Name = "Header"

	Header.Size =
		UDim2.new(
			1,
			0,
			0,
			58
		)

	Header.BackgroundTransparency = 1

	Header.ZIndex = 502

	Header.Parent = Main

	self.Header = Header

	--==================================================
	-- LOGO
	--==================================================

	local HeaderLogo =
		Instance.new("ImageLabel")

	HeaderLogo.Name =
		"HeaderLogo"

	HeaderLogo.Size =
		UDim2.new(
			0,
			40,
			0,
			40
		)

	HeaderLogo.Position =
		UDim2.new(
			0,
			10,
			0,
			8
		)

	HeaderLogo.BackgroundTransparency = 1

	HeaderLogo.Image =
		"rbxassetid://6691708227"

	HeaderLogo.ScaleType =
		Enum.ScaleType.Fit

	HeaderLogo.ZIndex = 502

	HeaderLogo.Parent = Header

	self.HeaderLogo = HeaderLogo

	local LogoStroke =
		Instance.new("UIStroke")

	LogoStroke.Name =
		"LogoBorder"

	LogoStroke.Color =
		self:GetLogoBorderColor()

	LogoStroke.Thickness = 1.5

	LogoStroke.Transparency = 0.20

	LogoStroke.Parent = HeaderLogo

	self.LogoStroke = LogoStroke

	--==================================================
	-- TITLE
	--==================================================

	local Title =
		Instance.new("TextLabel")

	Title.Name = "Title"

	Title.Position =
		UDim2.new(
			0,
			60,
			0,
			7
		)

	Title.Size =
		UDim2.new(
			1,
			-105,
			0,
			25
		)

	Title.BackgroundTransparency = 1

	Title.Text = "Rimuru Hub"

	Title.TextColor3 =
		SafeColor(
			CurrentTheme.Text,
			FALLBACK_TEXT
		)

	Title.TextSize = 19

	Title.Font =
		Enum.Font.GothamBold

	Title.TextXAlignment =
		Enum.TextXAlignment.Left

	Title.ZIndex = 502

	Title.Parent = Header

	self.Title = Title

	--==================================================
	-- SUBTITLE
	--==================================================

	local Subtitle =
		Instance.new("TextLabel")

	Subtitle.Name = "Subtitle"

	Subtitle.Position =
		UDim2.new(
			0,
			61,
			0,
			31
		)

	Subtitle.Size =
		UDim2.new(
			1,
			-75,
			0,
			18
		)

	Subtitle.BackgroundTransparency = 1

	Subtitle.Text = "Sound Library"

	Subtitle.TextColor3 =
		SafeColor(
			CurrentTheme.SubText,
			FALLBACK_SUBTEXT
		)

	Subtitle.TextSize = 11

	Subtitle.Font =
		Enum.Font.Gotham

	Subtitle.TextXAlignment =
		Enum.TextXAlignment.Left

	Subtitle.ZIndex = 502

	Subtitle.Parent = Header

	self.Subtitle = Subtitle

	--==================================================
	-- CLOSE
	--==================================================

	local Close =
		Instance.new("TextButton")

	Close.Name = "Close"

	Close.Size =
		UDim2.new(
			0,
			30,
			0,
			30
		)

	Close.Position =
		UDim2.new(
			1,
			-38,
			0,
			14
		)

	Close.BackgroundColor3 =
		SafeColor(
			CurrentTheme.Close,
			FALLBACK_CARD
		)

	Close.BorderSizePixel = 0

	Close.Text = "X"

	Close.TextColor3 =
		SafeColor(
			CurrentTheme.Text,
			FALLBACK_TEXT
		)

	Close.TextSize = 12

	Close.Font =
		Enum.Font.GothamBold

	Close.AutoButtonColor = false

	Close.ZIndex = 503

	Close.Parent = Header

	local CloseCorner =
		Instance.new("UICorner")

	CloseCorner.CornerRadius =
		UDim.new(
			0,
			SMALL_CORNER_RADIUS
		)

	CloseCorner.Parent = Close

	local CloseStroke =
		Instance.new("UIStroke")

	CloseStroke.Color =
		self:GetAccent()

	CloseStroke.Thickness = 1

	CloseStroke.Transparency = 0.35

	CloseStroke.Parent = Close

	self.Close = Close
	self.CloseStroke = CloseStroke

	--==================================================
	-- SIDEBAR
	--==================================================

	local Sidebar =
		Instance.new("Frame")

	Sidebar.Name = "Sidebar"

	Sidebar.Position =
		UDim2.new(
			0,
			10,
			0,
			65
		)

	Sidebar.Size =
		UDim2.new(
			0,
			165,
			1,
			-75
		)

	Sidebar.BackgroundColor3 =
		SafeColor(
			CurrentTheme.Sidebar,
			FALLBACK_CONTENT
		)

	Sidebar.BackgroundTransparency = 0.10

	Sidebar.BorderSizePixel = 0

	Sidebar.ZIndex = 502

	Sidebar.Parent = Main

	local SidebarCorner =
		Instance.new("UICorner")

	SidebarCorner.CornerRadius =
		UDim.new(
			0,
			11
		)

	SidebarCorner.Parent = Sidebar

	local SidebarStroke =
		Instance.new("UIStroke")

	SidebarStroke.Color =
		self:GetAccent()

	SidebarStroke.Thickness = 1

	SidebarStroke.Transparency = 0.65

	SidebarStroke.Parent = Sidebar

	local SidebarPadding =
		Instance.new("UIPadding")

	SidebarPadding.PaddingTop =
		UDim.new(0, 8)

	SidebarPadding.PaddingLeft =
		UDim.new(0, 7)

	SidebarPadding.PaddingRight =
		UDim.new(0, 7)

	SidebarPadding.Parent = Sidebar

	local SidebarLayout =
		Instance.new("UIListLayout")

	SidebarLayout.Padding =
		UDim.new(0, 5)

	SidebarLayout.SortOrder =
		Enum.SortOrder.LayoutOrder

	SidebarLayout.Parent = Sidebar

	self.Sidebar = Sidebar
	self.SidebarStroke = SidebarStroke

	--==================================================
	-- CONTENT
	--==================================================

	local Content =
		Instance.new("Frame")

	Content.Name = "Content"

	Content.Position =
		UDim2.new(
			0,
			185,
			0,
			65
		)

	Content.Size =
		UDim2.new(
			1,
			-195,
			1,
			-75
		)

	Content.BackgroundColor3 =
		SafeColor(
			CurrentTheme.Content,
			FALLBACK_CONTENT
		)

	Content.BackgroundTransparency = 0.10

	Content.BorderSizePixel = 0

	Content.ZIndex = 502

	Content.Parent = Main

	local ContentCorner =
		Instance.new("UICorner")

	ContentCorner.CornerRadius =
		UDim.new(
			0,
			11
		)

	ContentCorner.Parent = Content

	local ContentStroke =
		Instance.new("UIStroke")

	ContentStroke.Color =
		self:GetAccent()

	ContentStroke.Thickness = 1

	ContentStroke.Transparency = 0.65

	ContentStroke.Parent = Content

	self.Content = Content
	self.ContentStroke = ContentStroke

	--==================================================
	-- CONTENT TITLE
	--==================================================

	local ContentTitle =
		Instance.new("TextLabel")

	ContentTitle.Name =
		"ContentTitle"

	ContentTitle.Position =
		UDim2.new(
			0,
			14,
			0,
			10
		)

	ContentTitle.Size =
		UDim2.new(
			1,
			-28,
			0,
			25
		)

	ContentTitle.BackgroundTransparency = 1

	ContentTitle.Text = "Principal"

	ContentTitle.TextColor3 =
		SafeColor(
			CurrentTheme.Text,
			FALLBACK_TEXT
		)

	ContentTitle.TextSize = 15

	ContentTitle.Font =
		Enum.Font.GothamBold

	ContentTitle.TextXAlignment =
		Enum.TextXAlignment.Left

	ContentTitle.ZIndex = 503

	ContentTitle.Parent = Content

	self.ContentTitle = ContentTitle

	--==================================================
	-- CONTENT SCROLL
	--==================================================
	-- NÃO existe SearchBar aqui.
	-- A barra de pesquisa pertence ao Search.lua.
	-- O Scroll começa diretamente abaixo do título.

	local Scroll =
		Instance.new("ScrollingFrame")

	Scroll.Name =
		"ContentScroll"

	Scroll.Position =
		UDim2.new(
			0,
			10,
			0,
			42
		)

	Scroll.Size =
		UDim2.new(
			1,
			-20,
			1,
			-52
		)

	Scroll.BackgroundTransparency = 1

	Scroll.BorderSizePixel = 0

	Scroll.ScrollBarThickness = 5

	Scroll.ScrollBarImageColor3 =
		self:GetAccent()

	Scroll.AutomaticCanvasSize =
		Enum.AutomaticSize.Y

	Scroll.ScrollingDirection =
		Enum.ScrollingDirection.Y

	Scroll.ZIndex = 503

	Scroll.Parent = Content

	local ScrollPadding =
		Instance.new("UIPadding")

	ScrollPadding.PaddingBottom =
		UDim.new(
			0,
			6
		)

	ScrollPadding.Parent = Scroll

	local ScrollLayout =
		Instance.new("UIListLayout")

	ScrollLayout.Padding =
		UDim.new(
			0,
			5
		)

	ScrollLayout.SortOrder =
		Enum.SortOrder.LayoutOrder

	ScrollLayout.Parent = Scroll

	self.Scroll = Scroll

	--==================================================
	-- CLOSE EVENT
	--==================================================

	Close.MouseButton1Click:Connect(
		function()

			self:SetVisibleAnimated(
				false
			)

		end
	)

	--==================================================
	-- DRAG
	--==================================================

	self:SetupDrag()

	--==================================================
	-- NEON
	--==================================================

	self:StartNeonAnimation()

end

--==================================================
-- UPDATE SHADOW
--==================================================

function UI:UpdateShadow()

	if not self.Shadow or not self.Main then
		return
	end

	local Enabled =
		self:ShouldUseShadow()

	self.Shadow.Visible =
		self.Main.Visible
		and Enabled

	if not Enabled then
		return
	end

	self.Shadow.Position =
		UDim2.new(
			self.Main.Position.X.Scale,
			self.Main.Position.X.Offset
				- SHADOW_PADDING,

			self.Main.Position.Y.Scale,
			self.Main.Position.Y.Offset
				- SHADOW_PADDING
		)

	self.Shadow.Size =
		UDim2.new(
			self.Main.Size.X.Scale,
			self.Main.Size.X.Offset
				+ SHADOW_PADDING * 2,

			self.Main.Size.Y.Scale,
			self.Main.Size.Y.Offset
				+ SHADOW_PADDING * 2
		)

	local Pulse =
		(
			math.sin(
				self.NeonTime
					* SHADOW_PULSE_SPEED
			)
			+ 1
		)
		* 0.5

	Pulse =
		Pulse
			* Pulse
			* (3 - 2 * Pulse)

	self.Shadow.BackgroundTransparency =
		SHADOW_MAX_TRANSPARENCY
		-
		(
			Pulse
			*
			(
				SHADOW_MAX_TRANSPARENCY
				-
				SHADOW_MIN_TRANSPARENCY
			)
		)

end

--==================================================
-- START NEON
--==================================================

function UI:StartNeonAnimation()

	if self.NeonConnection then

		self.NeonConnection:Disconnect()

		self.NeonConnection = nil

	end

	self.NeonTime = 0

	self.NeonConnection =
		RunService.RenderStepped:Connect(
			function(DeltaTime)

				if not self.Main
					or not self.Main.Parent then

					return
				end

				self.NeonTime +=
					DeltaTime

				self:UpdateShadow()

				local Accent =
					self:GetAccent()

				local GlowColor =
					self:GetGlowColor()

				local GlowEnabled =
					self:ShouldUseGlow()

				local Wave =
					(
						math.sin(
							self.NeonTime
								* PULSE_SPEED
						)
						+ 1
					)
					* 0.5

				local Pulse =
					Wave
					* Wave
					* (3 - 2 * Wave)

				if self.Theme
					and type(
						self.Theme.GetBorderPulse
					) == "function" then

					local Success, Result =
						pcall(function()

							return self.Theme:
								GetBorderPulse()

						end)

					if Success
						and type(Result) == "number" then

						Pulse =
							math.clamp(
								Result,
								0,
								1
							)
					end
				end

				--==================================================
				-- MAIN BORDER
				--==================================================

				if self.MainStroke then

					self.MainStroke.Color =
						Accent

					if GlowEnabled then

						self.MainStroke.Transparency =
							PULSE_MAX_TRANSPARENCY
							-
							(
								Pulse
								*
								(
									PULSE_MAX_TRANSPARENCY
									-
									PULSE_MIN_TRANSPARENCY
								)
							)

						self.MainStroke.Thickness =
							PULSE_MIN_THICKNESS
							+
							(
								Pulse
								*
								(
									PULSE_MAX_THICKNESS
									-
									PULSE_MIN_THICKNESS
								)
							)

					else

						self.MainStroke.Transparency =
							BORDER_TRANSPARENCY

						self.MainStroke.Thickness =
							BORDER_THICKNESS

					end
				end

				--==================================================
				-- GLOW
				--==================================================

				if self.GlowStroke then

					self.GlowStroke.Color =
						GlowColor

					if GlowEnabled then

						self.GlowStroke.Transparency =
							GLOW_MAX_TRANSPARENCY
							-
							(
								Pulse
								*
								(
									GLOW_MAX_TRANSPARENCY
									-
									GLOW_MIN_TRANSPARENCY
								)
							)

						self.GlowStroke.Thickness =
							GLOW_THICKNESS
							+
							(
								Pulse * 1.5
							)

					else

						self.GlowStroke.Transparency = 1

					end
				end

				--==================================================
				-- CLOSE
				--==================================================

				if self.CloseStroke then

					self.CloseStroke.Color =
						Accent

					self.CloseStroke.Transparency =
						0.30
						+
						(
							(1 - Pulse)
							* 0.10
						)

				end

				--==================================================
				-- SIDEBAR
				--==================================================

				if self.SidebarStroke then

					self.SidebarStroke.Color =
						Accent

					self.SidebarStroke.Transparency =
						GlowEnabled
						and
						(
							0.58
							+
							(
								(1 - Pulse)
								* 0.12
							)
						)
						or 0.70

				end

				--==================================================
				-- CONTENT
				--==================================================

				if self.ContentStroke then

					self.ContentStroke.Color =
						Accent

					self.ContentStroke.Transparency =
						GlowEnabled
						and
						(
							0.58
							+
							(
								(1 - Pulse)
								* 0.12
							)
						)
						or 0.70

				end

				--==================================================
				-- LOGO
				--==================================================

				if self.LogoStroke then

					self.LogoStroke.Color =
						self:GetLogoBorderColor()

				end

				--==================================================
				-- SCROLLBAR
				--==================================================

				if self.Scroll then

					self.Scroll.ScrollBarImageColor3 =
						Accent

				end

			end
		)

end

--==================================================
-- ANIMATION ENABLED
--==================================================

function UI:IsAnimationEnabled()

	if not self.Config
		or not self.Config.UI then

		return true
	end

	return self.Config.UI.Animation ~= false
end

--==================================================
-- CANCEL
--==================================================

function UI:CancelAnimation()

	self.AnimationToken += 1

	self.AnimationBusy = false

end

--==================================================
-- SET VISIBLE
--==================================================

function UI:SetVisible(Value)

	if not self.Main then
		return
	end

	self:CancelAnimation()

	self.Main.Visible = Value

	if self.Shadow then

		self.Shadow.Visible =
			Value
			and self:ShouldUseShadow()

	end

	if Value then

		self.MainScale.Scale = 1

		self.Main.Position =
			self.OriginalPosition

		self:UpdateShadow()

	end

end

--==================================================
-- SET VISIBLE ANIMATED
--==================================================

function UI:SetVisibleAnimated(Value)

	local Main = self.Main

	local Scale = self.MainScale

	if not Main or not Scale then
		return
	end

	if not self:IsAnimationEnabled() then

		self:SetVisible(Value)

		return
	end

	self:CancelAnimation()

	local Token =
		self.AnimationToken

	--==================================================
	-- OPEN
	--==================================================

	if Value then

		Main.Visible = true

		if self.Shadow then

			self.Shadow.Visible =
				self:ShouldUseShadow()

		end

		Scale.Scale =
			OPEN_SCALE

		Main.Position =
			UDim2.new(
				self.OriginalPosition.X.Scale,
				self.OriginalPosition.X.Offset,

				self.OriginalPosition.Y.Scale,
				self.OriginalPosition.Y.Offset
					+ OPEN_OFFSET_Y
			)

		self:UpdateShadow()

		local Info =
			TweenInfo.new(
				OPEN_TIME,
				Enum.EasingStyle.Quint,
				Enum.EasingDirection.Out
			)

		local ScaleTween =
			TweenService:Create(
				Scale,
				Info,
				{
					Scale = 1
				}
			)

		local PositionTween =
			TweenService:Create(
				Main,
				Info,
				{
					Position =
						self.OriginalPosition
				}
			)

		self.AnimationBusy = true

		ScaleTween:Play()
		PositionTween:Play()

		task.spawn(function()

			PositionTween.Completed:Wait()

			if self.AnimationToken
				== Token then

				self.AnimationBusy =
					false

				self:UpdateShadow()

			end

		end)

		return
	end

	--==================================================
	-- CLOSE
	--==================================================

	if not Main.Visible then
		return
	end

	local Info =
		TweenInfo.new(
			CLOSE_TIME,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.In
		)

	local ScaleTween =
		TweenService:Create(
			Scale,
			Info,
			{
				Scale = CLOSE_SCALE
			}
		)

	local PositionTween =
		TweenService:Create(
			Main,
			Info,
			{
				Position =
					UDim2.new(
						self.OriginalPosition.X.Scale,
						self.OriginalPosition.X.Offset,

						self.OriginalPosition.Y.Scale,
						self.OriginalPosition.Y.Offset
							+ CLOSE_OFFSET_Y
					)
			}
		)

	self.AnimationBusy = true

	ScaleTween:Play()
	PositionTween:Play()

	task.spawn(function()

		PositionTween.Completed:Wait()

		if self.AnimationToken
			~= Token then

			return
		end

		Main.Visible = false

		if self.Shadow then
			self.Shadow.Visible = false
		end

		Scale.Scale = 1

		Main.Position =
			self.OriginalPosition

		self.AnimationBusy = false

	end)

end

--==================================================
-- TOGGLE
--==================================================

function UI:ToggleAnimated()

	if not self.Main then
		return
	end

	self:SetVisibleAnimated(
		not self.Main.Visible
	)

end

--==================================================
-- DRAG
--==================================================

function UI:SetupDrag()

	local Main = self.Main

	if not Main then
		return
	end

	local Dragging = false

	local DragStart
	local StartPosition

	Main.InputBegan:Connect(
		function(Input)

			if self.Config
				and self.Config.UI
				and self.Config.UI.MainMenuDraggable
				== false then

				return
			end

			if Input.UserInputType
				== Enum.UserInputType.MouseButton1

				or Input.UserInputType
				== Enum.UserInputType.Touch then

				Dragging = true

				DragStart =
					Input.Position

				StartPosition =
					Main.Position

			end

		end
	)

	UIS.InputChanged:Connect(
		function(Input)

			if not Dragging then
				return
			end

			if Input.UserInputType
				== Enum.UserInputType.MouseMovement

				or Input.UserInputType
				== Enum.UserInputType.Touch then

				local Delta =
					Input.Position
					- DragStart

				Main.Position =
					UDim2.new(
						StartPosition.X.Scale,
						StartPosition.X.Offset
							+ Delta.X,

						StartPosition.Y.Scale,
						StartPosition.Y.Offset
							+ Delta.Y
					)

				self:UpdateShadow()

			end

		end
	)

	UIS.InputEnded:Connect(
		function(Input)

			if Input.UserInputType
				== Enum.UserInputType.MouseButton1

				or Input.UserInputType
				== Enum.UserInputType.Touch then

				Dragging = false

			end

		end
	)

end

--==================================================
-- APPLY BACKGROUND
--==================================================

function UI:ApplyBackground()

	if not self.Background then
		return
	end

	local CurrentTheme =
		GetCurrentTheme(self.Theme)

	local Image =
		CurrentTheme.BackgroundImage

	self.Background.Visible = false

	self.Background.Image = ""

	if not Image or Image == "" then
		return
	end

	self.Background.Image =
		tostring(Image)

	self.Background.ImageTransparency =
		math.clamp(
			SafeNumber(
				CurrentTheme.BackgroundTransparency,
				0.35
			),
			0,
			1
		)

	self.Background.Visible = true

end

--==================================================
-- APPLY SHADOW
--==================================================

function UI:ApplyShadow()

	if not self.Shadow then
		return
	end

	local CurrentTheme =
		GetCurrentTheme(self.Theme)

	local Enabled =
		self:ShouldUseShadow()

	self.Shadow.Visible =
		self.Main
		and self.Main.Visible
		and Enabled
		or false

	self.Shadow.BackgroundColor3 =
		Color3.fromRGB(
			0,
			0,
			0
		)

	self.Shadow.BackgroundTransparency =
		math.clamp(
			SafeNumber(
				CurrentTheme.ShadowTransparency,
				SHADOW_TRANSPARENCY
			),
			0,
			1
		)

	self:UpdateShadow()

end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()

	local CurrentTheme =
		GetCurrentTheme(self.Theme)

	--==================================================
	-- MAIN
	--==================================================

	if self.Main then

		self.Main.BackgroundColor3 =
			SafeColor(
				CurrentTheme.Background,
				FALLBACK_BACKGROUND
			)

	end

	self:ApplyShadow()
	self:ApplyBackground()

	--==================================================
	-- BORDER
	--==================================================

	if self.MainStroke then

		self.MainStroke.Color =
			self:GetAccent()

	end

	--==================================================
	-- GLOW
	--==================================================

	if self.GlowStroke then

		self.GlowStroke.Color =
			self:GetGlowColor()

	end

	--==================================================
	-- TITLE
	--==================================================

	if self.Title then

		self.Title.TextColor3 =
			SafeColor(
				CurrentTheme.Text,
				FALLBACK_TEXT
			)

	end

	--==================================================
	-- SUBTITLE
	--==================================================

	if self.Subtitle then

		self.Subtitle.TextColor3 =
			SafeColor(
				CurrentTheme.SubText,
				FALLBACK_SUBTEXT
			)

	end

	--==================================================
	-- CLOSE
	--==================================================

	if self.Close then

		self.Close.BackgroundColor3 =
			SafeColor(
				CurrentTheme.Close,
				FALLBACK_CARD
			)

		self.Close.TextColor3 =
			SafeColor(
				CurrentTheme.Text,
				FALLBACK_TEXT
			)

	end

	if self.CloseStroke then

		self.CloseStroke.Color =
			self:GetAccent()

	end

	--==================================================
	-- SIDEBAR
	--==================================================

	if self.Sidebar then

		self.Sidebar.BackgroundColor3 =
			SafeColor(
				CurrentTheme.Sidebar,
				FALLBACK_CONTENT
			)

	end

	if self.SidebarStroke then

		self.SidebarStroke.Color =
			self:GetAccent()

	end

	--==================================================
	-- CONTENT
	--==================================================

	if self.Content then

		self.Content.BackgroundColor3 =
			SafeColor(
				CurrentTheme.Content,
				FALLBACK_CONTENT
			)

	end

	if self.ContentStroke then

		self.ContentStroke.Color =
			self:GetAccent()

	end

	--==================================================
	-- CONTENT TITLE
	--==================================================

	if self.ContentTitle then

		self.ContentTitle.TextColor3 =
			SafeColor(
				CurrentTheme.Text,
				FALLBACK_TEXT
			)

	end

	--==================================================
	-- SCROLL
	--==================================================

	if self.Scroll then

		self.Scroll.ScrollBarImageColor3 =
			self:GetAccent()

	end

	--==================================================
	-- LOGO
	--==================================================

	if self.LogoStroke then

		self.LogoStroke.Color =
			self:GetLogoBorderColor()

	end

	--==================================================
	-- FINAL
	--==================================================

	self:UpdateShadow()

end

--==================================================
-- DESTROY
--==================================================

function UI:Destroy()

	self:CancelAnimation()

	if self.NeonConnection then

		self.NeonConnection:Disconnect()

		self.NeonConnection = nil

	end

	if self.Gui then

		self.Gui:Destroy()

		self.Gui = nil

	end

	self.Main = nil

	self.Shadow = nil

	self.Background = nil

	self.Sidebar = nil

	self.Content = nil

	self.ContentTitle = nil

	self.Scroll = nil

end

--==================================================
-- RETURN MODULE
--==================================================

return UI
