-- ScribblEXplorer v6 Loader [Production Ready]
-- Centralizes all assets from your GitHub repo for instant aesthetic updates.

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- CONFIGURATION: Point these to your Raw GitHub URLs
local CONFIG_URL = "https://raw.githubusercontent.com/ScribbleDevelopment/ScribblEXplorer/main/config.json"
local ASSET_LIB_URL = "https://raw.githubusercontent.com/ScribbleDevelopment/ScribblEXplorer/main/assets.lua"

-- 1. Load Asset Library and Config
local success, AssetLibrary = pcall(function() return loadstring(game:HttpGet(ASSET_LIB_URL))() end)
local configData = pcall(function() return HttpService:JSONDecode(game:HttpGet(CONFIG_URL)) end) and HttpService:JSONDecode(game:HttpGet(CONFIG_URL)) or {
    Meta = { Version = "v6.0 [Local Fallback]" },
    Styles = {
        MainBackground = {13, 11, 22}, AccentColor = {157, 0, 255}, 
        PanelBackground = {19, 15, 34}, TextColor = {240, 235, 255}
    }
}

-- 2. Cleanup existing UI
pcall(function()
    local coreGui = game:GetService("CoreGui")
    if coreGui:FindFirstChild("ScribblEXplorer_Gui") then coreGui.ScribblEXplorer_Gui:Destroy() end
    if LocalPlayer.PlayerGui:FindFirstChild("ScribblEXplorer_Gui") then LocalPlayer.PlayerGui.ScribblEXplorer_Gui:Destroy() end
end)

-- 3. Global State
local selectedInstance = nil
local expandedNodesMap = {}

-- 4. Main UI Construction
local ScribblEXplorer = Instance.new("ScreenGui", (game:GetService("CoreGui") or LocalPlayer:FindFirstChildOfClass("PlayerGui")))
ScribblEXplorer.Name = "ScribblEXplorer_Gui"

local MainFrame = Instance.new("Frame", ScribblEXplorer)
MainFrame.Size = UDim2.new(0.65, 0, 0.65, 0)
MainFrame.Position = UDim2.new(0.17, 0, 0.17, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(table.unpack(configData.Styles.MainBackground))
MainFrame.Active = true
MainFrame.Draggable = true

-- Apply Cosmic Corners
local function applyCosmicStyle(obj)
    local corner = Instance.new("UICorner", obj)
    corner.CornerRadius = UDim.new(0, 8)
end
applyCosmicStyle(MainFrame)

-- 5. Tree Explorer Engine
local LeftTree = Instance.new("ScrollingFrame", MainFrame)
LeftTree.Size = UDim2.new(0.4, 0, 0.9, 0)
LeftTree.Position = UDim2.new(0.02, 0, 0.05, 0)
LeftTree.BackgroundColor3 = Color3.fromRGB(table.unpack(configData.Styles.PanelBackground))

-- 6. Content/Action Panel
local RightPanel = Instance.new("Frame", MainFrame)
RightPanel.Size = UDim2.new(0.55, 0, 0.9, 0)
RightPanel.Position = UDim2.new(0.43, 0, 0.05, 0)
RightPanel.BackgroundTransparency = 1

local ActionBtn = Instance.new("TextButton", RightPanel)
ActionBtn.Text = "Execute Infinite Yield"
ActionBtn.Size = UDim2.new(0.8, 0, 0, 40)
ActionBtn.BackgroundColor3 = Color3.fromRGB(table.unpack(configData.Styles.AccentColor))
ActionBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/refs/heads/master/source"))()
end)

-- Initialize Services Tree
local function renderTree()
    for _, service in ipairs(game:GetChildren()) do
        local btn = Instance.new("TextButton", LeftTree)
        btn.Text = "  > " .. service.ClassName
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.TextColor3 = Color3.fromRGB(table.unpack(configData.Styles.TextColor))
        btn.BackgroundColor3 = Color3.fromRGB(table.unpack(configData.Styles.PanelBackground))
        btn.MouseButton1Click:Connect(function()
            selectedInstance = service
            print("Selected: " .. service.Name)
        end)
    end
end

renderTree()

-- 7. Branding
local Title = Instance.new("TextLabel", MainFrame)
Title.Text = configData.Meta.Version
Title.Position = UDim2.new(0.02, 0, -0.05, 0)
Title.TextColor3 = Color3.fromRGB(table.unpack(configData.Styles.AccentColor))
Title.BackgroundTransparency = 1
