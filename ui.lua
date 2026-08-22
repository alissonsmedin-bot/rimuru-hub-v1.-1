--// 💥 RIMURU HUB
--// UI SYSTEM
--// PREMIUM NEON UI
--// STABLE BORDER SYSTEM
--// NATURAL PULSING GLOW
--// SOFT INTERFACE SHADOW
--// ROUNDED CORNERS
--// SOFT ANIMATIONS
--// SAFE THEME INTEGRATION
--// SAFE FALLBACKS
--// CONNECTION CLEANUP
--// TWEEN CLEANUP
--// BLACKOUT CATEGORY LOGIC REMAINS IN categories.lua

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
-- DEFAULT COLORS
--==================================================

local DEFAULT_BACKGROUND = Color3.fromRGB(10, 10, 15)
local DEFAULT_CONTENT = Color3.fromRGB(15, 15, 20)
local DEFAULT_BUTTON = Color3.fromRGB(30, 30, 30)
local DEFAULT_TEXT = Color3.fromRGB(255, 255, 255)
local DEFAULT_SUBTEXT = Color3.fromRGB(180, 180, 190)
local DEFAULT_ACCENT = Color3.fromRGB(0, 255, 170)

--==================================================
-- MENU ANIMATION
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

local SHADOW_PULSE_SPEED = 0.75

--==================================================
-- INTERNAL HELPERS
--==================================================

local function SafeCall(Function, ...)
	if type(Function) ~= "function" then
		return false, nil
	end

	local Success, Result = pcall(Function, ...)

	return Success, Result
end

local function SafeThemeMethod(Theme, MethodName, DefaultValue, ...)
	if not Theme then
		return DefaultValue
	end

	local Method = Theme[MethodName]

	if type(Method) ~= "function" then
		return DefaultValue
	end

	local Success, Result = pcall(Method, Theme, ...)

	if Success and Result ~= nil then
		return Result
	end

	return DefaultValue
end

local function ThemeColor(Theme, Key, Fallback)
	if Theme and Theme[Key] ~= nil then
		return Theme[Key]
	end

	return Fallback
end

local function SafeNumber(Value, Fallback)
	if type(Value) == "number" then
		return Value
	end

	return Fallback
end

local function SafeBoolean(Value, Fallback)
	if type(Value) == "boolean" then
		return Value
	end

	return Fallback
end

local function SafeColor(Value, Fallback)
	if typeof(Value) == "Color3" then
		return Value
	end

	return Fallback
end

--==================================================
-- GET CURRENT THEME
--==================================================

local function GetCurrentTheme(Theme)
	if not Theme then
		return nil
	end

	if type(Theme.GetCurrent) == "function" then
		local Success, Result = pcall(function()
			return Theme:GetCurrent()
		end)

		if Success and type(Result) == "table" then
			return Result
		end
	end

	if type(Theme.Current) == "table" then
		return Theme.Current
	end

	if type(Theme.CurrentThemeData) == "table" then
		return Theme.CurrentThemeData
	end

	return nil
end

--==================================================
-- GET THEME NAME
--==================================================

local function GetThemeName(Theme)
	if not Theme then
		return ""
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

	if Theme.CurrentTheme ~= nil then
		return tostring(Theme.CurrentTheme)
	end

	if Theme.CurrentThemeName ~= nil then
		return tostring(Theme.CurrentThemeName)
	end

	return ""
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
		warn("❌ Rimuru Hub UI: Player não encontrado.")
		return
	end

	self.PlayerGui =
		self.Context.PlayerGui
		or self.Player:WaitForChild("PlayerGui")

	self.Config = self.Context.Config
	self.Theme = self.Context.Theme

	self.AnimationBusy = false
	self.AnimationToken = 0

	self.NeonConnection = nil
	self.DragConnections = {}

	self.ActiveTweens = {}

	self.NeonTime = 0

	self.Gui = nil
	self.Main = nil
	self.Shadow = nil
	self.Glow = nil

	self:Create()
end

--==================================================
-- REMOVE OLD GUI
--==================================================

function UI:RemoveOld()
	if not self.PlayerGui then
		return
	end

	pcall(function()
		local Old = self.PlayerGui:FindFirstChild("RimuruHub")

		if Old then
			Old:Destroy()
		end
	end)
end

--==================================================
-- GET ACCENT
--==================================================

function UI:GetAccent()
	return SafeColor(
		SafeThemeMethod(
			self.Theme,
			"GetAccent",
			DEFAULT_ACCENT
		),
		DEFAULT_ACCENT
	)
end

--==================================================
-- GET GLOW COLOR
--==================================================

function UI:GetGlowColor()
	local Accent = self:GetAccent()

	return SafeColor(
		SafeThemeMethod(
			self.Theme,
			"GetGlowColor",
			Accent
		),
		Accent
	)
end

--==================================================
-- GET LOGO BORDER
--==================================================

function UI:GetLogoBorder()
	local Accent = self:GetAccent()

	return SafeColor(
		SafeThemeMethod(
			self.Theme,
			"GetLogoBorder",
			Accent
		),
		Accent
	)
end

--==================================================
-- GET BACKGROUND TRANSPARENCY
--==================================================

function UI:GetBackgroundTransparency(CurrentTheme)
	if CurrentTheme and CurrentTheme.BackgroundTransparency ~= nil then
		return SafeNumber(
			CurrentTheme.BackgroundTransparency,
			0.35
		)
	end

	return SafeNumber(
		SafeThemeMethod(
			self.Theme,
			"GetBackgroundTransparency",
			0.35
		),
		0.35
	)
end

--==================================================
-- CREATE
--==================================================

function UI:Create()
	self:RemoveOld()

	if not self.Theme then
		warn("❌ Rimuru Hub UI: Theme não encontrado.")
		return
	end

	local CurrentTheme = GetCurrentTheme(self.Theme)

	if not CurrentTheme then
		warn("❌ Rimuru Hub UI: tema inválido.")
		return
	end

	--==================================================
	-- SCREEN GUI
	--==================================================

	local Gui = Instance.new("ScreenGui")

	Gui.Name = "RimuruHub"
	Gui.ResetOnSpawn = false
	Gui.IgnoreGuiInset = true
	Gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
	Gui.DisplayOrder = 999999

	Gui.Parent = self.PlayerGui

	self.Gui = Gui

	--==================================================
	-- INTERFACE SHADOW
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

	Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

	Shadow.BackgroundTransparency =
		SafeNumber(
			CurrentTheme.ShadowTransparency,
			SHADOW_TRANSPARENCY
		)

	Shadow.BorderSizePixel = 0

	Shadow.Visible = false

	Shadow.ZIndex = 498

	Shadow.Parent = Gui

	local ShadowCorner = Instance.new("UICorner")

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
			DEFAULT_BACKGROUND
		)

	Main.BackgroundTransparency = 0.10

	Main.BorderSizePixel = 0

	Main.Visible = false

	Main.ZIndex = 500

	Main.ClipsDescendants = true

	Main.Parent = Gui

	self.Main = Main

	self.OriginalPosition = Main.Position
	self.OriginalSize = Main.Size

	--==================================================
	-- SCALE
	--==================================================

	local MainScale = Instance.new("UIScale")

	MainScale.Name = "MenuScale"
	MainScale.Scale = 1

	MainScale.Parent = Main

	self.MainScale = MainScale

	--==================================================
	-- MAIN CORNER
	--==================================================

	local MainCorner = Instance.new("UICorner")

	MainCorner.CornerRadius =
		UDim.new(
			0,
			CORNER_RADIUS
		)

	MainCorner.Parent = Main

	self.MainCorner = MainCorner

	--==================================================
	-- MAIN BORDER
	--==================================================

	local MainStroke = Instance.new("UIStroke")

	MainStroke.Name = "NormalBorder"

	MainStroke.Color = self:GetAccent()

	MainStroke.Thickness = BORDER_THICKNESS
	MainStroke.Transparency = BORDER_TRANSPARENCY

	MainStroke.ApplyStrokeMode =
		Enum.ApplyStrokeMode.Border

	MainStroke.Parent = Main

	self.MainStroke = MainStroke

	--==================================================
	-- EXTERNAL GLOW
	--==================================================

	-- O glow agora fica FORA do Main.
	-- Isso evita que ClipsDescendants corte a borda externa.

	local Glow = Instance.new("Frame")

	Glow.Name = "NeonGlow"

	Glow.Size = UDim2.new(
		1,
		0,
		1,
		0
	)

	Glow.Position = UDim2.new(
		0,
		0,
		0,
		0
	)

	Glow.BackgroundTransparency = 1
	Glow.BorderSizePixel = 0

	Glow.Visible = true

	Glow.ZIndex = 499

	Glow.Parent = Gui

	local GlowCorner = Instance.new("UICorner")

	GlowCorner.CornerRadius =
		UDim.new(
			0,
			CORNER_RADIUS
		)

	GlowCorner.Parent = Glow

	local GlowStroke = Instance.new("UIStroke")

	GlowStroke.Name = "GlowStroke"

	GlowStroke.Color = self:GetGlowColor()

	GlowStroke.Thickness = GLOW_THICKNESS

	GlowStroke.Transparency = 1

	GlowStroke.ApplyStrokeMode =
		Enum.ApplyStrokeMode.Border

	GlowStroke.Parent = Glow

	self.Glow = Glow
	self.GlowStroke = GlowStroke

	--==================================================
	-- BACKGROUND IMAGE
	--==================================================

	local Background = Instance.new("ImageLabel")

	Background.Name = "ThemeBackground"

	Background.Size = UDim2.new(
		1,
		0,
		1,
		0
	)

	Background.Position = UDim2.new(
		0,
		0,
		0,
		0
	)

	Background.BackgroundTransparency = 1
	Background.BorderSizePixel = 0

	Background.ScaleType =
		Enum.ScaleType.Crop

	Background.ImageTransparency =
		self:GetBackgroundTransparency(
			CurrentTheme
		)

	Background.ZIndex = 501

	Background.Visible = false

	Background.Parent = Main

	local BackgroundCorner = Instance.new("UICorner")

	BackgroundCorner.CornerRadius =
		UDim.new(
			0,
			CORNER_RADIUS
		)

	BackgroundCorner.Parent = Background

	self.Background = Background

	--==================================================
	-- HEADER
	--==================================================

	local Header = Instance.new("Frame")

	Header.Name = "Header"

	Header.Size = UDim2.new(
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

	local HeaderLogo = Instance.new("ImageLabel")

	HeaderLogo.Name = "HeaderLogo"

	HeaderLogo.Size = UDim2.new(
		0,
		40,
		0,
		40
	)

	HeaderLogo.Position = UDim2.new(
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

	--==================================================
	-- LOGO BORDER
	--==================================================

	local LogoStroke = Instance.new("UIStroke")

	LogoStroke.Name = "LogoBorder"

	LogoStroke.Color =
		self:GetLogoBorder()

	LogoStroke.Thickness = 1.5
	LogoStroke.Transparency = 0.20

	LogoStroke.Parent = HeaderLogo

	self.LogoStroke = LogoStroke

	--==================================================
	-- TITLE
	--==================================================

	local Title = Instance.new("TextLabel")

	Title.Name = "Title"

	Title.Position = UDim2.new(
		0,
		60,
		0,
		7
	)

	Title.Size = UDim2.new(
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
			DEFAULT_TEXT
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

	local Subtitle = Instance.new("TextLabel")

	Subtitle.Name = "Subtitle"

	Subtitle.Position = UDim2.new(
		0,
		61,
		0,
		31
	)

	Subtitle.Size = UDim2.new(
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
			DEFAULT_SUBTEXT
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

	local Close = Instance.new("TextButton")

	Close.Name = "Close"

	Close.Size = UDim2.new(
		0,
		30,
		0,
		30
	)

	Close.Position = UDim2.new(
		1,
		-38,
		0,
		14
	)

	Close.BackgroundColor3 =
		SafeColor(
			CurrentTheme.Button
				or CurrentTheme.Card,
			DEFAULT_BUTTON
		)

	Close.BorderSizePixel = 0

	Close.Text = "X"

	Close.TextColor3 =
		SafeColor(
			CurrentTheme.Text,
			DEFAULT_TEXT
		)

	Close.TextSize = 12

	Close.Font =
		Enum.Font.GothamBold

	Close.AutoButtonColor = false

	Close.ZIndex = 503

	Close.Parent = Header

	local CloseCorner = Instance.new("UICorner")

	CloseCorner.CornerRadius =
		UDim.new(
			0,
			SMALL_CORNER_RADIUS
		)

	CloseCorner.Parent = Close

	local CloseStroke = Instance.new("UIStroke")

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

	local Sidebar = Instance.new("Frame")

	Sidebar.Name = "Sidebar"

	Sidebar.Position = UDim2.new(
		0,
		10,
		0,
		65
	)

	Sidebar.Size = UDim2.new(
		0,
		165,
		1,
		-75
	)

	Sidebar.BackgroundColor3 =
		SafeColor(
			CurrentTheme.Content
				or CurrentTheme.Background,
			DEFAULT_CONTENT
		)

	Sidebar.BackgroundTransparency = 0.10

	Sidebar.BorderSizePixel = 0
	Sidebar.ZIndex = 502

	Sidebar.Parent = Main

	local SidebarCorner = Instance.new("UICorner")

	SidebarCorner.CornerRadius =
		UDim.new(
			0,
			11
		)

	SidebarCorner.Parent = Sidebar

	local SidebarStroke = Instance.new("UIStroke")

	SidebarStroke.Color =
		self:GetAccent()

	SidebarStroke.Thickness = 1
	SidebarStroke.Transparency = 0.65

	SidebarStroke.Parent = Sidebar

	local SidebarPadding = Instance.new("UIPadding")

	SidebarPadding.PaddingTop =
		UDim.new(0, 8)

	SidebarPadding.PaddingLeft =
		UDim.new(0, 7)

	SidebarPadding.PaddingRight =
		UDim.new(0, 7)

	SidebarPadding.Parent = Sidebar

	local SidebarLayout = Instance.new("UIListLayout")

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

	local Content = Instance.new("Frame")

	Content.Name = "Content"

	Content.Position = UDim2.new(
		0,
		185,
		0,
		65
	)

	Content.Size = UDim2.new(
		1,
		-195,
		1,
		-75
	)

	Content.BackgroundColor3 =
		SafeColor(
			CurrentTheme.Content
				or CurrentTheme.Background,
			DEFAULT_CONTENT
		)

	Content.BackgroundTransparency = 0.10

	Content.BorderSizePixel = 0
	Content.ZIndex = 502

	Content.Parent = Main

	local ContentCorner = Instance.new("UICorner")

	ContentCorner.CornerRadius =
		UDim.new(
			0,
			11
		)

	ContentCorner.Parent = Content

	local ContentStroke = Instance.new("UIStroke")

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

	local ContentTitle = Instance.new("TextLabel")

	ContentTitle.Name = "ContentTitle"

	ContentTitle.Position = UDim2.new(
		0,
		14,
		0,
		10
	)

	ContentTitle.Size = UDim2.new(
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
			DEFAULT_TEXT
		)

	ContentTitle.TextSize = 17

	ContentTitle.Font =
		Enum.Font.GothamBold

	ContentTitle.TextXAlignment =
		Enum.TextXAlignment.Left

	ContentTitle.ZIndex = 503

	ContentTitle.Parent = Content

	self.ContentTitle = ContentTitle

	--==================================================
	-- SCROLL
	--==================================================

	local Scroll = Instance.new("ScrollingFrame")

	Scroll.Name = "ContentScroll"

	Scroll.Position = UDim2.new(
		0,
		10,
		0,
		42
	)

	Scroll.Size = UDim2.new(
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

	local ScrollPadding = Instance.new("UIPadding")

	ScrollPadding.PaddingBottom =
		UDim.new(0, 6)

	ScrollPadding.Parent = Scroll

	local ScrollLayout = Instance.new("UIListLayout")

	ScrollLayout.Padding =
		UDim.new(0, 5)

	ScrollLayout.SortOrder =
		Enum.SortOrder.LayoutOrder

	ScrollLayout.Parent = Scroll

	self.Scroll = Scroll

	--==================================================
	-- CLOSE EVENT
	--==================================================

	Close.MouseButton1Click:Connect(function()
		self:SetVisibleAnimated(false)
	end)

	--==================================================
	-- DRAG
	--==================================================

	self:SetupDrag()

	--==================================================
	-- INITIAL POSITIONS
	--==================================================

	self:SyncGlow()
	self:UpdateShadow()

	--==================================================
	-- NEON / PULSE
	--==================================================

	self:StartNeonAnimation()

	--==================================================
	-- APPLY CURRENT THEME
	--==================================================

	self:ApplyTheme()
end

--==================================================
-- SHOULD USE GLOW
--==================================================

function UI:ShouldUseGlow()
	local CurrentTheme = GetCurrentTheme(self.Theme)

	if not CurrentTheme then
		return false
	end

	if CurrentTheme.GlowEnabled ~= nil then
		return CurrentTheme.GlowEnabled == true
	end

	local Name = string.lower(
		GetThemeName(self.Theme)
	)

	if string.find(Name, "rimuru dark", 1, true)
		or string.find(Name, "blackout", 1, true)
		or string.find(Name, "void", 1, true)
	then
		return true
	end

	return false
end

--==================================================
-- SHOULD USE SHADOW
--==================================================

function UI:ShouldUseShadow()
	local CurrentTheme = GetCurrentTheme(self.Theme)

	if not CurrentTheme then
		return false
	end

	if CurrentTheme.ShadowEnabled ~= nil then
		return CurrentTheme.ShadowEnabled == true
	end

	local Name = string.lower(
		GetThemeName(self.Theme)
	)

	return string.find(
		Name,
		"rimuru dark",
		1,
		true
	) ~= nil
end

--==================================================
-- SYNC GLOW
--==================================================

function UI:SyncGlow()
	if not self.Glow or not self.Main then
		return
	end

	self.Glow.Position = self.Main.Position
	self.Glow.Size = self.Main.Size

	self.Glow.Visible =
		self.Main.Visible
		and self:ShouldUseGlow()
		or false
end

--==================================================
-- UPDATE SHADOW
--==================================================

function UI:UpdateShadow()
	if not self.Shadow or not self.Main then
		return
	end

	local Enabled = self:ShouldUseShadow()

	self.Shadow.Visible =
		self.Main.Visible
		and Enabled
		or false

	if not Enabled then
		return
	end

	self.Shadow.Position = UDim2.new(
		self.Main.Position.X.Scale,
		self.Main.Position.X.Offset
			- SHADOW_PADDING,

		self.Main.Position.Y.Scale,
		self.Main.Position.Y.Offset
			- SHADOW_PADDING
	)

	self.Shadow.Size = UDim2.new(
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
		* (
			3
			- 2 * Pulse
		)

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
-- START NEON / PULSE
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

				if not self.Gui
					or not self.Gui.Parent
				then
					return
				end

				if not self.Main
					or not self.Main.Parent
				then
					return
				end

				if not self.Theme then
					return
				end

				local Current =
					GetCurrentTheme(
						self.Theme
					)

				if not Current then
					return
				end

				self.NeonTime += DeltaTime

				--==================================================
				-- FOLLOW MAIN
				--==================================================

				self:SyncGlow()
				self:UpdateShadow()

				--==================================================
				-- COLORS
				--==================================================

				local Accent =
					self:GetAccent()

				local GlowColor =
					self:GetGlowColor()

				--==================================================
				-- GLOW ENABLED
				--==================================================

				local GlowEnabled =
					self:ShouldUseGlow()

				--==================================================
				-- NATURAL PULSE
				--==================================================

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
					* (
						3
						- 2 * Wave
					)

				--==================================================
				-- THEME PULSE
				--==================================================

				if type(self.Theme.GetBorderPulse)
					== "function"
				then
					local Success, Result =
						pcall(function()
							return self.Theme:GetBorderPulse()
						end)

					if Success
						and type(Result) == "number"
					then
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

						self.Glow.Visible =
							self.Main.Visible

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
								Pulse
								* 1.5
							)

					else

						self.GlowStroke.Transparency = 1
						self.Glow.Visible = false
					end
				end

				--==================================================
				-- CLOSE BORDER
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
				-- SIDEBAR BORDER
				--==================================================

				if self.SidebarStroke then

					self.SidebarStroke.Color =
						Accent

					if GlowEnabled then

						self.SidebarStroke.Transparency =
							0.58
							+
							(
								(1 - Pulse)
								* 0.12
							)

					else

						self.SidebarStroke.Transparency =
							0.70
					end
				end

				--==================================================
				-- CONTENT BORDER
				--==================================================

				if self.ContentStroke then

					self.ContentStroke.Color =
						Accent

					if GlowEnabled then

						self.ContentStroke.Transparency =
							0.58
							+
							(
								(1 - Pulse)
								* 0.12
							)

					else

						self.ContentStroke.Transparency =
							0.70
					end
				end

				--==================================================
				-- LOGO
				--==================================================

				if self.LogoStroke then
					self.LogoStroke.Color =
						self:GetLogoBorder()
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
		or not self.Config.UI
	then
		return true
	end

	return self.Config.UI.Animation ~= false
end

--==================================================
-- CANCEL TWEENS
--==================================================

function UI:CancelTweens()
	for _, Tween in pairs(self.ActiveTweens) do
		if Tween then
			pcall(function()
				Tween:Cancel()
			end)
		end
	end

	table.clear(self.ActiveTweens)
end

--==================================================
-- REGISTER TWEEN
--==================================================

function UI:RegisterTween(Tween)
	if not Tween then
		return
	end

	table.insert(
		self.ActiveTweens,
		Tween
	)
end

--==================================================
-- CANCEL ANIMATION
--==================================================

function UI:CancelAnimation()
	self.AnimationToken += 1
	self.AnimationBusy = false

	self:CancelTweens()
end

--==================================================
-- SET VISIBLE
--==================================================

function UI:SetVisible(Value)
	if not self.Main then
		return
	end

	self:CancelAnimation()

	Value = Value == true

	self.Main.Visible = Value

	if self.Shadow then
		self.Shadow.Visible =
			Value
			and self:ShouldUseShadow()
			or false
	end

	if self.Glow then
		self.Glow.Visible =
			Value
			and self:ShouldUseGlow()
			or false
	end

	if Value then

		if self.MainScale then
			self.MainScale.Scale = 1
		end

		self.Main.Position =
			self.OriginalPosition

		self:SyncGlow()
		self:UpdateShadow()

	else

		self:SyncGlow()
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

	Value = Value == true

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

		if self.Glow then
			self.Glow.Visible =
				self:ShouldUseGlow()
		end

		Scale.Scale = OPEN_SCALE

		Main.Position =
			UDim2.new(
				self.OriginalPosition.X.Scale,
				self.OriginalPosition.X.Offset,

				self.OriginalPosition.Y.Scale,
				self.OriginalPosition.Y.Offset
					+ OPEN_OFFSET_Y
			)

		self:SyncGlow()
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

		self:RegisterTween(ScaleTween)
		self:RegisterTween(PositionTween)

		self.AnimationBusy = true

		ScaleTween:Play()
		PositionTween:Play()

		task.spawn(function()

			local Success =
				pcall(function()
					PositionTween.Completed:Wait()
				end)

			if not Success then
				return
			end

			if self.AnimationToken ~= Token then
				return
			end

			self.AnimationBusy = false

			self:SyncGlow()
			self:UpdateShadow()
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

	self:RegisterTween(ScaleTween)
	self:RegisterTween(PositionTween)

	self.AnimationBusy = true

	ScaleTween:Play()
	PositionTween:Play()

	task.spawn(function()

		local Success =
			pcall(function()
				PositionTween.Completed:Wait()
			end)

		if not Success then
			return
		end

		if self.AnimationToken ~= Token then
			return
		end

		Main.Visible = false

		if self.Shadow then
			self.Shadow.Visible = false
		end

		if self.Glow then
			self.Glow.Visible = false
		end

		Scale.Scale = 1
		Main.Position = self.OriginalPosition

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

	self:DisconnectDrag()

	local Dragging = false
	local DragStart = nil
	local StartPosition = nil

	--==================================================
	-- INPUT BEGAN
	--==================================================

	local InputBeganConnection =
		Main.InputBegan:Connect(
			function(Input)

				if not self.Config
					or not self.Config.UI
				then
					return
				end

				if self.Config.UI.MainMenuDraggable
					~= true
				then
					return
				end

				if Input.UserInputType
					== Enum.UserInputType.MouseButton1
					or Input.UserInputType
					== Enum.UserInputType.Touch
				then

					Dragging = true

					DragStart =
						Input.Position

					StartPosition =
						Main.Position
				end
			end
		)

	--==================================================
	-- INPUT CHANGED
	--==================================================

	local InputChangedConnection =
		UIS.InputChanged:Connect(
			function(Input)

				if not Dragging then
					return
				end

				if not DragStart
					or not StartPosition
				then
					return
				end

				if Input.UserInputType
					== Enum.UserInputType.MouseMovement
					or Input.UserInputType
					== Enum.UserInputType.Touch
				then

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

					self:SyncGlow()
					self:UpdateShadow()
				end
			end
		)

	--==================================================
	-- INPUT ENDED
	--==================================================

	local InputEndedConnection =
		UIS.InputEnded:Connect(
			function(Input)

				if Input.UserInputType
					== Enum.UserInputType.MouseButton1
					or Input.UserInputType
					== Enum.UserInputType.Touch
				then

					Dragging = false
					DragStart = nil
					StartPosition = nil
				end
			end
		)

	table.insert(
		self.DragConnections,
		InputBeganConnection
	)

	table.insert(
		self.DragConnections,
		InputChangedConnection
	)

	table.insert(
		self.DragConnections,
		InputEndedConnection
	)
end

--==================================================
-- DISCONNECT DRAG
--==================================================

function UI:DisconnectDrag()
	if not self.DragConnections then
		self.DragConnections = {}
		return
	end

	for _, Connection in ipairs(
		self.DragConnections
	) do

		if Connection then
			pcall(function()
				Connection:Disconnect()
			end)
		end
	end

	table.clear(self.DragConnections)
end

--==================================================
-- APPLY BACKGROUND
--==================================================

function UI:ApplyBackground()
	if not self.Background then
		return
	end

	local CurrentTheme =
		GetCurrentTheme(
			self.Theme
		)

	if not CurrentTheme then
		return
	end

	local Image =
		CurrentTheme.BackgroundImage

	self.Background.Visible = false
	self.Background.Image = ""

	if not Image
		or Image == ""
	then
		return
	end

	self.Background.Image =
		tostring(Image)

	self.Background.ImageTransparency =
		self:GetBackgroundTransparency(
			CurrentTheme
		)

	self.Background.Visible =
		self.Main
		and self.Main.Visible
		or false
end

--==================================================
-- APPLY SHADOW
--==================================================

function UI:ApplyShadow()
	if not self.Shadow then
		return
	end

	local CurrentTheme =
		GetCurrentTheme(
			self.Theme
		)

	if not CurrentTheme then
		return
	end

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

	local Transparency =
		CurrentTheme.ShadowTransparency

	if type(Transparency) ~= "number" then
		Transparency =
			SHADOW_TRANSPARENCY
	end

	self.Shadow.BackgroundTransparency =
		math.clamp(
			Transparency,
			0,
			1
		)

	self:UpdateShadow()
end

--==================================================
-- APPLY THEME
--==================================================

function UI:ApplyTheme()
	if not self.Theme then
		return
	end

	local CurrentTheme =
		GetCurrentTheme(
			self.Theme
		)

	if not CurrentTheme then
		return
	end

	local Accent =
		self:GetAccent()

	local BackgroundColor =
		SafeColor(
			CurrentTheme.Background,
			DEFAULT_BACKGROUND
		)

	local ContentColor =
		SafeColor(
			CurrentTheme.Content
				or CurrentTheme.Background,
			DEFAULT_CONTENT
		)

	local TextColor =
		SafeColor(
			CurrentTheme.Text,
			DEFAULT_TEXT
		)

	local SubTextColor =
		SafeColor(
			CurrentTheme.SubText,
			DEFAULT_SUBTEXT
		)

	local ButtonColor =
		SafeColor(
			CurrentTheme.Button
				or CurrentTheme.Card,
			DEFAULT_BUTTON
		)

	--==================================================
	-- MAIN
	--==================================================

	if self.Main then
		self.Main.BackgroundColor3 =
			BackgroundColor
	end

	--==================================================
	-- MAIN CORNER
	--==================================================

	if self.MainCorner then
		self.MainCorner.CornerRadius =
			UDim.new(
				0,
				CORNER_RADIUS
			)
	end

	--==================================================
	-- GLOW CORNER
	--==================================================

	if self.Glow then

		local Corner =
			self.Glow:FindFirstChildOfClass(
				"UICorner"
			)

		if Corner then
			Corner.CornerRadius =
				UDim.new(
					0,
					CORNER_RADIUS
				)
		end
	end

	--==================================================
	-- SHADOW
	--==================================================

	self:ApplyShadow()

	--==================================================
	-- BACKGROUND
	--==================================================

	self:ApplyBackground()

	--==================================================
	-- MAIN BORDER
	--==================================================

	if self.MainStroke then
		self.MainStroke.Color =
			Accent
	end

	--==================================================
	-- GLOW
	--==================================================

	if self.GlowStroke then
		self.GlowStroke.Color =
			self:GetGlowColor()

		if not self:ShouldUseGlow() then
			self.GlowStroke.Transparency = 1
		end
	end

	--==================================================
	-- TITLE
	--==================================================

	if self.Title then
		self.Title.TextColor3 =
			TextColor
	end

	--==================================================
	-- SUBTITLE
	--==================================================

	if self.Subtitle then
		self.Subtitle.TextColor3 =
			SubTextColor
	end

	--==================================================
	-- CLOSE
	--==================================================

	if self.Close then

		self.Close.BackgroundColor3 =
			ButtonColor

		self.Close.TextColor3 =
			TextColor
	end

	if self.CloseStroke then
		self.CloseStroke.Color =
			Accent
	end

	--==================================================
	-- SIDEBAR
	--==================================================

	if self.Sidebar then
		self.Sidebar.BackgroundColor3 =
			ContentColor
	end

	if self.SidebarStroke then
		self.SidebarStroke.Color =
			Accent
	end

	--==================================================
	-- CONTENT
	--==================================================

	if self.Content then
		self.Content.BackgroundColor3 =
			ContentColor
	end

	if self.ContentStroke then
		self.ContentStroke.Color =
			Accent
	end

	--==================================================
	-- CONTENT TITLE
	--==================================================

	if self.ContentTitle then
		self.ContentTitle.TextColor3 =
			TextColor
	end

	--==================================================
	-- SCROLL
	--==================================================

	if self.Scroll then
		self.Scroll.ScrollBarImageColor3 =
			Accent
	end

	--==================================================
	-- LOGO BORDER
	--==================================================

	if self.LogoStroke then
		self.LogoStroke.Color =
			self:GetLogoBorder()
	end

	--==================================================
	-- SYNC
	--==================================================

	self:SyncGlow()
	self:UpdateShadow()
end

--==================================================
-- DESTROY
--==================================================

function UI:Destroy()
	--==================================================
	-- STOP NEON
	--==================================================

	if self.NeonConnection then

		pcall(function()
			self.NeonConnection:Disconnect()
		end)

		self.NeonConnection = nil
	end

	--==================================================
	-- STOP DRAG
	--==================================================

	self:DisconnectDrag()

	--==================================================
	-- STOP TWEENS
	--==================================================

	self:CancelTweens()

	self.AnimationToken += 1
	self.AnimationBusy = false

	--==================================================
	-- DESTROY GUI
	--==================================================

	if self.Gui then

		pcall(function()
			self.Gui:Destroy()
		end)

		self.Gui = nil
	end

	--==================================================
	-- CLEAR REFERENCES
	--==================================================

	self.Main = nil
	self.Shadow = nil
	self.Glow = nil
	self.GlowStroke = nil

	self.MainStroke = nil
	self.MainCorner = nil

	self.Background = nil

	self.Header = nil
	self.HeaderLogo = nil
	self.LogoStroke = nil

	self.Title = nil
	self.Subtitle = nil

	self.Close = nil
	self.CloseStroke = nil

	self.Sidebar = nil
	self.SidebarStroke = nil

	self.Content = nil
	self.ContentStroke = nil
	self.ContentTitle = nil
	self.Scroll = nil

	self.MainScale = nil

	self.OriginalPosition = nil
	self.OriginalSize = nil
end

--==================================================
-- RETURN
--==================================================

return UI
