--// 💥🎵 RIMURU HUB
--// Sound ID Library

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

-- SOUNDS
local Sounds = {
    {Name = "Coin Parry", ID = "81202220081219"},
    {Name = "Coin", ID = "136124980150792"},
    {Name = "Naginata Hit", ID = "94107281648467"},
    {Name = "Gun Fire", ID = "5735280081"},
    {Name = "Gun Hit", ID = "3932141920"},
    {Name = "Dash", ID = "92870369637296"},
    {Name = "M1 Hit", ID = "92660735965001"},
    {Name = "M1 Down", ID = "73223862105514"},
}

-- SETTINGS
local Colors = {
    Green = Color3.fromRGB(60,220,120),
    Red = Color3.fromRGB(235,65,65),
    White = Color3.fromRGB(235,235,235),
    Blue = Color3.fromRGB(65,130,255),
    Cyan = Color3.fromRGB(40,220,220),
    Neon = Color3.fromRGB(170,60,255),
}

local CurrentColor = Colors.Cyan
local BG = 0.08
local RGB = false

-- GUI
local Gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
Gui.Name = "RimuruHub"

local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.new(0,720,0,450)
Main.Position = UDim2.new(0.5,-360,0.5,-225)
Main.BackgroundColor3 = Color3.fromRGB(18,18,23)
Main.BackgroundTransparency = BG
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,14)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = CurrentColor
Stroke.Thickness = 1.5

-- DRAG
local drag, start, pos
Main.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = true
        start = i.Position
        pos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - start
        Main.Position = UDim2.new(pos.X.Scale,pos.X.Offset+d.X,pos.Y.Scale,pos.Y.Offset+d.Y)
    end
end)

UserInputService.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag = false
    end
end)

-- HEADER
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1,0,0,60)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Text = "Rimuru Hub"
Title.Size = UDim2.new(0,300,0,25)
Title.Position = UDim2.new(0,80,0,8)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(245,245,245)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- SIDEBAR
local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0,160,1,-70)
Side.Position = UDim2.new(0,10,0,65)
Side.BackgroundColor3 = Color3.fromRGB(14,14,19)
Instance.new("UICorner", Side).CornerRadius = UDim.new(0,10)

local function Btn(t)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1,0,0,40)
    b.Text = t
    b.BackgroundColor3 = Color3.fromRGB(25,25,31)
    b.TextColor3 = Color3.fromRGB(180,180,190)
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    return b
end

local SoundsBtn = Btn("🔊 Sounds")
local ConfigBtn = Btn("⚙️ Config")

-- CONTENT
local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1,-180,1,-70)
Content.Position = UDim2.new(0,175,0,65)
Content.BackgroundTransparency = 1

local Scroll = Instance.new("ScrollingFrame", Content)
Scroll.Size = UDim2.new(1,0,1,0)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 5
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0,6)

-- SOUND CARDS
local function Card(s)
    local f = Instance.new("Frame", Scroll)
    f.Size = UDim2.new(1,0,0,50)
    f.BackgroundColor3 = Color3.fromRGB(25,25,31)

    local t = Instance.new("TextLabel", f)
    t.Text = s.Name.." - "..s.ID
    t.Size = UDim2.new(1,-80,1,0)
    t.BackgroundTransparency = 1
    t.TextColor3 = Color3.fromRGB(230,230,235)
    t.Font = Enum.Font.Gotham
    t.TextSize = 12
    t.TextXAlignment = Enum.TextXAlignment.Left

    local c = Instance.new("TextButton", f)
    c.Text = "Copy"
    c.Size = UDim2.new(0,70,0,30)
    c.Position = UDim2.new(1,-75,0.5,-15)
    c.BackgroundColor3 = CurrentColor
    c.TextColor3 = Color3.new(1,1,1)
    c.Font = Enum.Font.GothamBold
    c.TextSize = 12

    c.MouseButton1Click:Connect(function()
        if setclipboard then setclipboard(s.ID) end
        c.Text = "Copied"
        task.wait(0.7)
        c.Text = "Copy"
    end)
end

for _,v in ipairs(Sounds) do Card(v) end

-- PAGE SWITCH
local function Show()
    Scroll.Visible = true
end

SoundsBtn.MouseButton1Click:Connect(Show)
ConfigBtn.MouseButton1Click:Connect(Show)

Show()
