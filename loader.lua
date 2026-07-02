-- ScribblEXplorer V6: ty for using btw
local HttpService = game:GetService("HttpService")
local BaseUrl = "https://raw.githubusercontent.com/ScribbleDevelopment/ScribblEXplorer/main/"

-- Load Assets & Config
local Assets = loadstring(game:HttpGet(BaseUrl .. "assets.lua"))()
local Config = HttpService:JSONDecode(game:HttpGet(BaseUrl .. "config.json"))

-- UI Setup
local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Assets.CosmicStyle(Instance.new("Frame", Gui))
Main.Size = UDim2.new(0.6, 0, 0.7, 0)
Main.Position = UDim2.new(0.2, 0, 0.15, 0)
Main.Active = true
Main.Draggable = true

local ExplorerHolder = Instance.new("ScrollingFrame", Main)
ExplorerHolder.Size = UDim2.new(0.4, 0, 0.9, 0)
ExplorerHolder.Position = UDim2.new(0.02, 0, 0.05, 0)
ExplorerHolder.BackgroundTransparency = 1

local PropHolder = Assets.CosmicStyle(Instance.new("Frame", Main))
PropHolder.Size = UDim2.new(0.5, 0, 0.9, 0)
PropHolder.Position = UDim2.new(0.45, 0, 0.05, 0)

-- Recursive Tree Engine
local function Populate(parent, depth)
    for _, child in ipairs(parent:GetChildren()) do
        local btn = Assets.CreateTreeButton(ExplorerHolder, child.Name, depth)
        
        btn.MouseButton1Click:Connect(function()
            PropHolder:ClearAllChildren()
            local NameLabel = Instance.new("TextLabel", PropHolder)
            NameLabel.Text = "Instance: " .. child.Name
            NameLabel.Size = UDim2.new(1, 0, 0, 30)
            NameLabel.BackgroundTransparency = 1
            NameLabel.TextColor3 = Color3.new(1,1,1)
            
            local PropBox = Instance.new("TextBox", PropHolder)
            PropBox.PlaceholderText = "Property=Value"
            PropBox.Size = UDim2.new(0.9, 0, 0, 40)
            PropBox.Position = UDim2.new(0.05, 0, 0.2, 0)
            PropBox.FocusLost:Connect(function(enter)
                if enter then
                    local args = PropBox.Text:split("=")
                    if #args == 2 then child[args[1]] = args[2] end
                end
            end)
        end)
        
        if #child:GetChildren() > 0 and depth < 3 then
            Populate(child, depth + 1)
        end
    end
end

-- Refresh Initial Tree
Populate(game:GetService("Workspace"), 0)
Populate(game:GetService("Players"), 0)
