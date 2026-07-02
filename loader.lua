-- ScribblEXplorer V6: Full Explorer Edition
local HttpService = game:GetService("HttpService")
local Assets = loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/main/Assets.lua"))()

-- UI Setup
local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Assets.CreateFrame(Gui, UDim2.new(0.6, 0, 0.7, 0), UDim2.new(0.2, 0, 0.15, 0), Color3.fromRGB(20, 20, 30))

-- Explorer Panel (Left)
local ExplorerHolder = Instance.new("ScrollingFrame", Main)
ExplorerHolder.Size = UDim2.new(0.4, 0, 0.9, 0)
ExplorerHolder.Position = UDim2.new(0.02, 0, 0.05, 0)
ExplorerHolder.BackgroundTransparency = 1

-- Properties Panel (Right)
local PropHolder = Assets.CreateFrame(Main, UDim2.new(0.5, 0, 0.9, 0), UDim2.new(0.45, 0, 0.05, 0), Color3.fromRGB(25, 25, 35))

-- Recursive Tree Engine
local function PopulateExplorer(parent, depth)
    for _, child in ipairs(parent:GetChildren()) do
        local btn = Assets.CreateTreeButton(ExplorerHolder, child.Name, depth)
        
        btn.MouseButton1Click:Connect(function()
            -- Show Properties for selected instance
            PropHolder:ClearAllChildren()
            local NameLabel = Instance.new("TextLabel", PropHolder)
            NameLabel.Text = "Selected: " .. child.Name
            NameLabel.Size = UDim2.new(1, 0, 0, 30)
            
            -- Add Property Change Box
            local PropBox = Instance.new("TextBox", PropHolder)
            PropBox.PlaceholderText = "Change Property (Name=Value)"
            PropBox.Size = UDim2.new(0.9, 0, 0, 40)
            PropBox.Position = UDim2.new(0.05, 0, 0.2, 0)
            PropBox.FocusLost:Connect(function(enter)
                if enter then
                    local args = PropBox.Text:split("=")
                    if #args == 2 then child[args[1]] = args[2] end
                end
            end)
        end)
        
        if #child:GetChildren() > 0 then
            PopulateExplorer(child, depth + 1)
        end
    end
end

-- Refresh Initial Tree
PopulateExplorer(game:GetService("Workspace"), 0)
PopulateExplorer(game:GetService("Players"), 0)
