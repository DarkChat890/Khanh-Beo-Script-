--[[
    Khanh Beo Dupe
    By Khanh Beo
--]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- Xóa UI cũ nếu đã chạy trước đó
if CoreGui:FindFirstChild("KhanhBeo_Dupe_GUI") then
    CoreGui.KhanhBeo_Dupe_GUI:Destroy()
end

-- ==========================================
-- TẠO GIAO DIỆN (MENU ĐEN, NÚT XANH LÁ)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KhanhBeo_Dupe_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 240, 0, 160)
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -80)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(0, 255, 100) -- Viền xanh lá
UIStroke.Thickness = 2
UIStroke.Transparency = 0.2
UIStroke.Parent = MainFrame

-- Thanh tiêu đề
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Active = true
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 10)
TitleFix.Position = UDim2.new(0, 0, 1, -10)
TitleFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Khanh Beo Dupe"
TitleText.TextColor3 = Color3.fromRGB(0, 255, 100) -- Chữ xanh
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.Parent = TitleBar

-- Nút chức năng Dupe
local DupeBtn = Instance.new("TextButton")
DupeBtn.Name = "InstantDupe"
DupeBtn.Size = UDim2.new(0.85, 0, 0, 55)
DupeBtn.Position = UDim2.new(0.075, 0, 0, 60)
DupeBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 45)
DupeBtn.Font = Enum.Font.GothamBold
DupeBtn.Text = "Instant Dupe"
DupeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DupeBtn.TextSize = 15
DupeBtn.AutoButtonColor = false
DupeBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = DupeBtn

local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Color3.fromRGB(138, 43, 226) -- Viền tím
BtnStroke.Thickness = 1.5
BtnStroke.Parent = DupeBtn

-- Hiệu ứng Hover cho nút
DupeBtn.MouseEnter:Connect(function()
    TweenService:Create(DupeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 65)}):Play()
end)
DupeBtn.MouseLeave:Connect(function()
    TweenService:Create(DupeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(28, 28, 45)}):Play()
end)

-- Kéo thả Menu
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ==========================================
-- LOGIC DUPE (Lõi từ code gốc)
-- ==========================================
DupeBtn.MouseButton1Click:Connect(function()
    TweenService:Create(DupeBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.8, 0, 0, 50)}):Play()
    task.wait(0.1)
    TweenService:Create(DupeBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.85, 0, 0, 55)}):Play()
    
    local char = LocalPlayer.Character
    if not char then char = LocalPlayer.CharacterAdded:Wait() end
    local hrp = char:WaitForChild("HumanoidRootPart")

    -- Dịch chuyển đến tọa độ Dupe
    hrp.CFrame = CFrame.new(2.69384432, 5.49999952, -32.8616409, 0.993587255, -0.00000000288700019, -0.113067873, 0.00000000383692011, 1, 0.00000000818371237, 0.113067873, -0.00000000856506421, 0.993587255)

    local Remotes = ReplicatedStorage:WaitForChild("Remotes")
    local Throw_Start = Remotes:WaitForChild("Throw_Start")
    local Throw_Resolve = Remotes:WaitForChild("Throw_Resolve")
    local Throw_Complete = Remotes:WaitForChild("Throw_Complete")

    -- Kích hoạt chuỗi sự kiện Dupe
    task.spawn(function() pcall(function() Throw_Start:InvokeServer() end) end)
    pcall(function() Throw_Start:InvokeServer() end)
    task.wait(0.1)

    task.spawn(function() pcall(function() Throw_Resolve:InvokeServer(1) end) end)
    pcall(function() Throw_Resolve:InvokeServer(1) end)
    task.wait(0.1)

    task.spawn(function() pcall(function() Throw_Complete:InvokeServer() end) end)
    pcall(function() Throw_Complete:InvokeServer() end)
    task.wait(0.05)

    -- Tự sát để hoàn tất
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.Health = 0
    else
        char:BreakJoints()
    end
end)