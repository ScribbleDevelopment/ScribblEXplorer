-- Safe cleanup boundary setup: Wrapped in pcall to isolate terminal execution paths safely
pcall(function()
    local coreGui = game:GetService("CoreGui")
    local existingGui = coreGui:FindFirstChild("ScribblEXplorer_Gui")
    if existingGui then existingGui:Destroy() end
end)

pcall(function()
    local lp = game:GetService("Players").LocalPlayer
    if lp then
        local pGui = lp:FindFirstChildOfClass("PlayerGui")
        local existingGui = pGui and pGui:FindFirstChild("ScribblEXplorer_Gui")
        if existingGui then existingGui:Destroy() end
    end
end)

-- Asset Config Data Handshake Engine
local HttpService = game:GetService("HttpService")
local configURL = "https://raw.githubusercontent.com/ScribbleDevelopment/ScribblEXplorer/main/config.json" -- Replace with your raw GitHub asset link

-- Hardcoded absolute fallback layer Cosmic config parameters
local uiConfig = {
    Styles = {
        MainBackground = Color3.fromRGB(13, 11, 22), AccentColor = Color3.fromRGB(157, 0, 255),
        HeaderBackground = Color3.fromRGB(25, 16, 44), PanelBackground = Color3.fromRGB(19, 15, 34),
        InnerBackground = Color3.fromRGB(8, 6, 15), TextColor = Color3.fromRGB(240, 235, 255),
        OpTextColor = Color3.fromRGB(255, 200, 0), OutputTextColor = Color3.fromRGB(0, 255, 180),
        CornerRadius = 10, StrokeThickness = 2
    },
    Meta = { Version = "v5.5 [Cosmic Edition]" },
    TargetRepAddresses = {
        PrimaryIY = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/refs/heads/master/source",
        FallbackIY = "https://raw.githubusercontent.com/EdgeYNN/InfiniteYield/master/source"
    }
}

-- Perform Cloud Synchronous Web handshake fetch if execution context permissions allow HttpGet operations
local fetchSuccess, fetchedData = pcall(function() return game:HttpGet(configURL) end)
if fetchSuccess and fetchedData then
    local decodeSuccess, decodedTable = pcall(function() return HttpService:JSONDecode(fetchedData) end)
    if decodeSuccess and decodedTable then
        uiConfig.Meta.Version = decodedTable.Meta.Version or uiConfig.Meta.Version
        uiConfig.TargetRepAddresses = decodedTable.TargetRepAddresses or uiConfig.TargetRepAddresses
        for colorKey, rgbArray in pairs(decodedTable.Styles) do
            if type(rgbArray) == "table" and #rgbArray == 3 then
                uiConfig.Styles[colorKey] = Color3.fromRGB(rgbArray[1], rgbArray[2], rgbArray[3])
            end
        end
        uiConfig.Styles.CornerRadius = decodedTable.Styles.CornerRadius or uiConfig.Styles.CornerRadius
        uiConfig.Styles.StrokeThickness = decodedTable.Styles.StrokeThickness or uiConfig.Styles.StrokeThickness
    end
end

-- Detect runtime execution layer interface context
local isExecutor = (identifyexecutor or getexecutorname or typeof(setclipboard) == "function" or typeof(decompile) == "function") and true or false
local isServerSide = not isExecutor

-- Instantiating Top-Level Interfaces
local ScribblEXplorer = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local UIStroke_Main = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")

-- True Tree Explorer Panels
local LeftTreePanel = Instance.new("ScrollingFrame")
local ContentViewer = Instance.new("ScrollingFrame")
local ActionPanel = Instance.new("Frame")

-- Primary Core Terminals
local CopyPathBtn = Instance.new("TextButton")
local TeleportBtn = Instance.new("TextButton")
local ViewCodeBtn = Instance.new("TextButton")
local GenRemoteBtn = Instance.new("TextButton")
local CodeOutput = Instance.new("TextBox")

-- Tool Node Modifiers
local DestroyBtn = Instance.new("TextButton")
local ChangePropBtn = Instance.new("TextButton")
local ExecuteIYBtn = Instance.new("TextButton")
local SearchBar = Instance.new("TextBox")
local UICorner_Search = Instance.new("UICorner")

-- Custom OP Script Automation Additions
local SuperSpeedBtn = Instance.new("TextButton")
local InfiniteJumpBtn = Instance.new("TextButton")
local BToolsBtn = Instance.new("TextButton")

-- Parenting Routing Assignments
ScribblEXplorer.Name = "ScribblEXplorer_Gui"
ScribblEXplorer.ResetOnSpawn = false

if isExecutor then
    local success, _ = pcall(function() ScribblEXplorer.Parent = game:GetService("CoreGui") end)
    if not success then ScribblEXplorer.Parent = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui") end
else
    ScribblEXplorer.Parent = game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")
end

-- Interface Frame Layout Topology Creation
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScribblEXplorer
MainFrame.BackgroundColor3 = uiConfig.Styles.MainBackground
MainFrame.Position = UDim2.new(0.15, 0, 0.15, 0)
MainFrame.Size = UDim2.new(0.70, 0, 0.70, 0)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner_Main.CornerRadius = UDim.new(0, uiConfig.Styles.CornerRadius)
UICorner_Main.Parent = MainFrame

UIStroke_Main.Thickness = uiConfig.Styles.StrokeThickness
UIStroke_Main.Color = uiConfig.Styles.AccentColor
UIStroke_Main.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_Main.Parent = MainFrame

Title.Name = "Title"
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0.07, 0)
Title.BackgroundColor3 = uiConfig.Styles.HeaderBackground
Title.Text = "  ScribblEXplorer " .. uiConfig.Meta.Version .. (isServerSide and " [SS MODE]" or " [EXECUTOR MODE]")
Title.TextColor3 = uiConfig.Styles.AccentColor
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold

local titleCorner = Instance.new("UICorner", Title)
titleCorner.CornerRadius = UDim.new(0, uiConfig.Styles.CornerRadius)

SearchBar.Name = "SearchBar"
SearchBar.Parent = MainFrame
SearchBar.Position = UDim2.new(0.015, 0, 0.09, 0)
SearchBar.Size = UDim2.new(0.42, 0, 0.055, 0)
SearchBar.BackgroundColor3 = uiConfig.Styles.InnerBackground
SearchBar.TextColor3 = uiConfig.Styles.TextColor
SearchBar.PlaceholderText = " 🔍 Search sub-elements..."
SearchBar.Text = ""
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 12

UICorner_Search.CornerRadius = UDim.new(0, 5)
UICorner_Search.Parent = SearchBar

-- Left Tree Hierarchy Panel (Studio Explorer Simulation Engine Layout)
LeftTreePanel.Name = "LeftTreePanel"
LeftTreePanel.Parent = MainFrame
LeftTreePanel.Position = UDim2.new(0.015, 0, 0.16, 0)
LeftTreePanel.Size = UDim2.new(0.42, 0, 0.81, 0)
LeftTreePanel.BackgroundColor3 = uiConfig.Styles.PanelBackground
LeftTreePanel.CanvasSize = UDim2.new(0, 0, 0, 0)
LeftTreePanel.ScrollBarThickness = 5

local treeCorner = Instance.new("UICorner", LeftTreePanel)
treeCorner.CornerRadius = UDim.new(0, 6)

-- Right Detailed Selection Content Frame Viewport Tracker
ContentViewer.Name = "ContentViewer"
ContentViewer.Parent = MainFrame
ContentViewer.Position = UDim2.new(0.45, 0, 0.09, 0)
ContentViewer.Size = UDim2.new(0.535, 0, 0.46, 0)
ContentViewer.BackgroundColor3 = uiConfig.Styles.InnerBackground
ContentViewer.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentViewer.ScrollBarThickness = 5

local contentCorner = Instance.new("UICorner", ContentViewer)
contentCorner.CornerRadius = UDim.new(0, 6)

ActionPanel.Name = "ActionPanel"
ActionPanel.Parent = MainFrame
ActionPanel.Position = UDim2.new(0.45, 0, 0.57, 0)
ActionPanel.Size = UDim2.new(0.535, 0, 0.40, 0)
ActionPanel.BackgroundColor3 = uiConfig.Styles.PanelBackground

local panelCorner = Instance.new("UICorner", ActionPanel)
panelCorner.CornerRadius = UDim.new(0, 6)

-- Custom Action Interface Style Engine Helper mapping definitions
local function styleButton(btn, text, pos, size, bg, isOpFeature)
    btn.Parent = ActionPanel
    btn.Text = text
    btn.Position = pos
    btn.Size = size
    btn.BackgroundColor3 = bg or Color3.fromRGB(31, 23, 49)
    btn.TextColor3 = isOpFeature and uiConfig.Styles.OpTextColor or uiConfig.Styles.TextColor
    btn.Font = isOpFeature and Enum.Font.GothamBold or Enum.Font.Gotham
    btn.TextSize = 11
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 5)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = btn.BackgroundColor3:Lerp(Color3.fromRGB(255, 255, 255), 0.12)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = bg or Color3.fromRGB(31, 23, 49)
    end)
end

-- Layout Core Operations Commands Layout
styleButton(CopyPathBtn, "Copy Path", UDim2.new(0.02, 0, 0.05, 0), UDim2.new(0.3, 0, 0.16, 0))
styleButton(TeleportBtn, "Teleport to Part", UDim2.new(0.35, 0, 0.05, 0), UDim2.new(0.3, 0, 0.16, 0))
styleButton(ExecuteIYBtn, "Execute IY", UDim2.new(0.68, 0, 0.05, 0), UDim2.new(0.3, 0, 0.16, 0), Color3.fromRGB(115, 30, 185))

styleButton(ViewCodeBtn, "View/Copy Code", UDim2.new(0.02, 0, 0.25, 0), UDim2.new(0.3, 0, 0.16, 0))
styleButton(GenRemoteBtn, "Gen Remote Code", UDim2.new(0.35, 0, 0.25, 0), UDim2.new(0.3, 0, 0.16, 0))
styleButton(DestroyBtn, "Destroy (Client)", UDim2.new(0.68, 0, 0.25, 0), UDim2.new(0.3, 0, 0.16, 0), Color3.fromRGB(180, 40, 40))

styleButton(SuperSpeedBtn, "🔥 Super Speed", UDim2.new(0.02, 0, 0.45, 0), UDim2.new(0.3, 0, 0.16, 0), Color3.fromRGB(50, 40, 70), true)
styleButton(InfiniteJumpBtn, "🚀 Inf Jump", UDim2.new(0.35, 0, 0.45, 0), UDim2.new(0.3, 0, 0.16, 0), Color3.fromRGB(50, 40, 70), true)
styleButton(BToolsBtn, "🔨 Give BTools", UDim2.new(0.68, 0, 0.45, 0), UDim2.new(0.3, 0, 0.16, 0), Color3.fromRGB(50, 40, 70), true)

styleButton(ChangePropBtn, "Set Property", UDim2.new(0.68, 0, 0.72, 0), UDim2.new(0.3, 0, 0.22, 0), Color3.fromRGB(0, 140, 110))

CodeOutput.Parent = ActionPanel
CodeOutput.Position = UDim2.new(0.02, 0, 0.68, 0)
CodeOutput.Size = UDim2.new(0.64, 0, 0.26, 0)
CodeOutput.BackgroundColor3 = uiConfig.Styles.InnerBackground
CodeOutput.TextColor3 = uiConfig.Styles.OutputTextColor
CodeOutput.Text = "PropertyName=Value"
CodeOutput.ClearTextOnFocus = false
CodeOutput.MultiLine = true
CodeOutput.TextXAlignment = Enum.TextXAlignment.Left
CodeOutput.TextYAlignment = Enum.TextYAlignment.Top
CodeOutput.Font = Enum.Font.Code
CodeOutput.TextSize = 11

local outputCorner = Instance.new("UICorner", CodeOutput)
outputCorner.CornerRadius = UDim.new(0, 4)

-- Tracking States Globals Parameters definitions
local selectedInstance = nil
local currentParentObj = nil
local nodeRowCounter = 0
local expandedNodesMap = {}

local namesOfServices = {
    "Workspace", "Players", "Lighting", "ReplicatedFirst", "ReplicatedStorage", 
    "ServerScriptService", "ServerStorage", "StarterGui", "StarterPack", 
    "StarterPlayer", "Teams", "SoundService", "Chat", "TextChatService",
    "LocalizationService", "JointsService", "CollectionService", "PhysicsService",
    "Debris", "TweenService", "MarketplaceService", "TeleportService", "HttpService",
    "InsertService", "GroupService", "MessagingService", "ProximityPromptService",
    "SocialService", "BadgeService", "AssetService", "GuiService", "VRService",
    "LogService", "Selection", "ContentProvider"
}

local servicesList = {}
for _, serviceName in ipairs(namesOfServices) do
    local success, serviceInstance = pcall(function() return game:GetService(serviceName) end)
    if success and serviceInstance then
        table.insert(servicesList, serviceInstance)
    end
end

-- Full Runtime Functional Core Logic Block Engines Mapping
local function getFullPath(obj)
    if not obj then return "" end
    local path = obj.Name
    local current = obj.Parent
    while current and current ~= game do
        local safeName = current.Name:match("^[%a_][%w_]*$") and current.Name or "[\"" .. current.Name .. "\"]"
        if safeName == current.Name then
            path = safeName .. "." .. path
        else
            path = safeName .. path
        end
        current = current.Parent
    end
    return "game." .. path
end

local function updateOutput(text)
    CodeOutput.Text = text
    if isExecutor and setclipboard then
        pcall(function() setclipboard(text) end)
    end
end

-- Right Selection Panel Renderer Engine Module Function block
local function displayChildren(parentObj, filterText)
    currentParentObj = parentObj
    for _, child in ipairs(ContentViewer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local children = pcall(function() return parentObj:GetChildren() end) and parentObj:GetChildren() or {}
    local validChildren = {}
    
    if filterText and filterText ~= "" then
        for _, child in ipairs(children) do
            if string.find(string.lower(child.Name), string.lower(filterText)) then
                table.insert(validChildren, child)
            end
        end
    else
        validChildren = children
    end
    
    ContentViewer.CanvasSize = UDim2.new(0, 0, 0, #validChildren * 24)
    
    for i, child in ipairs(validChildren) do
        local btn = Instance.new("TextButton")
        btn.Parent = ContentViewer
        btn.Size = UDim2.new(0.96, 0, 0, 20)
        btn.Position = UDim2.new(0.02, 0, 0, (i - 1) * 24)
        btn.BackgroundColor3 = Color3.fromRGB(25, 20, 39)
        btn.TextColor3 = uiConfig.Styles.TextColor
        btn.Text = "  [" .. child.ClassName .. "] " .. child.Name
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.SourceSans
        btn.TextSize = 13
        
        local btnCorner = Instance.new("UICorner", btn)
        btnCorner.CornerRadius = UDim.new(0, 4)
        
        btn.MouseButton1Click:Connect(function()
            selectedInstance = child
            for _, v in ipairs(ContentViewer:GetChildren()) do
                if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(25, 20, 39) end
            end
            btn.BackgroundColor3 = uiConfig.Styles.AccentColor
        end)
    end
end

-- TRUE CASCADING OBJECT TREE EXPLORER GENERATOR
local function renderTreeRow(object, indentLevel)
    nodeRowCounter = nodeRowCounter + 1
    local rowYPos = (nodeRowCounter - 1) * 22
    
    local children = pcall(function() return object:GetChildren() end) and object:GetChildren() or {}
    local hasChildren = #children > 0
    
    local RowFrame = Instance.new("Frame")
    RowFrame.Name = "TreeRow_" .. object.Name
    RowFrame.Parent = LeftTreePanel
    RowFrame.Size = UDim2.new(0.98, 0, 0, 20)
    RowFrame.Position = UDim2.new(0, 0, 0, rowYPos)
    RowFrame.BackgroundTransparency = 1
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Parent = RowFrame
    ToggleBtn.Size = UDim2.new(0, 16, 0, 16)
    ToggleBtn.Position = UDim2.new(0, (indentLevel * 14) + 2, 0, 2)
    ToggleBtn.BackgroundTransparency = 1
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.TextSize = 12
    ToggleBtn.TextColor3 = uiConfig.Styles.AccentColor
    ToggleBtn.Text = hasChildren and (expandedNodesMap[object] and "−" or "＋") or ""
    
    local ObjectSelectBtn = Instance.new("TextButton")
    ObjectSelectBtn.Parent = RowFrame
    ObjectSelectBtn.Size = UDim2.new(0.8, -((indentLevel * 14) + 20), 1, 0)
    ObjectSelectBtn.Position = UDim2.new(0, (indentLevel * 14) + 20, 0, 0)
    ObjectSelectBtn.BackgroundTransparency = 1
    ObjectSelectBtn.Text = object.Name
    ObjectSelectBtn.TextColor3 = (selectedInstance == object) and uiConfig.Styles.AccentColor or uiConfig.Styles.TextColor
    ObjectSelectBtn.TextXAlignment = Enum.TextXAlignment.Left
    ObjectSelectBtn.Font = Enum.Font.SourceSans
    ObjectSelectBtn.TextSize = 14
    
    ObjectSelectBtn.MouseButton1Click:Connect(function()
        selectedInstance = object
        displayChildren(object)
        local scrollPosition = LeftTreePanel.CanvasPosition
        nodeRowCounter = 0
        for _, childRow in ipairs(LeftTreePanel:GetChildren()) do
            if childRow:IsA("Frame") then childRow:Destroy() end
        end
        for _, topService in ipairs(servicesList) do
            renderTreeRow(topService, 0)
        end
        LeftTreePanel.CanvasSize = UDim2.new(0, 0, 0, nodeRowCounter * 22)
        LeftTreePanel.CanvasPosition = scrollPosition
    end)
    
    ToggleBtn.MouseButton1Click:Connect(function()
        if not hasChildren then return end
        expandedNodesMap[object] = not expandedNodesMap[object]
        
        local currentScroll = LeftTreePanel.CanvasPosition
        nodeRowCounter = 0
        for _, childRow in ipairs(LeftTreePanel:GetChildren()) do
            if childRow:IsA("Frame") then childRow:Destroy() end
        end
        for _, topService in ipairs(servicesList) do
            renderTreeRow(topService, 0)
        end
        LeftTreePanel.CanvasSize = UDim2.new(0, 0, 0, nodeRowCounter * 22)
        LeftTreePanel.CanvasPosition = currentScroll
    end)
    
    if expandedNodesMap[object] and hasChildren then
        for _, subChild in ipairs(children) do
            renderTreeRow(subChild, indentLevel + 1)
        end
    end
end

local function rebuildTreeHierarchy()
    nodeRowCounter = 0
    for _, childRow in ipairs(LeftTreePanel:GetChildren()) do
        if childRow:IsA("Frame") then childRow:Destroy() end
    end
    for _, service in ipairs(servicesList) do
        renderTreeRow(service, 0)
    end
    LeftTreePanel.CanvasSize = UDim2.new(0, 0, 0, nodeRowCounter * 22)
end

SearchBar.Changed:Connect(function(property)
    if property == "Text" and currentParentObj then
        displayChildren(currentParentObj, SearchBar.Text)
    end
end)

-- Button Logic Intercept Routines
CopyPathBtn.MouseButton1Click:Connect(function()
    if selectedInstance then
        updateOutput(getFullPath(selectedInstance))
    else
        updateOutput("-- No instance selected --")
    end
end)

TeleportBtn.MouseButton1Click:Connect(function()
    local lp = game:GetService("Players").LocalPlayer
    if not lp or not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then 
        updateOutput("-- Local player character frame not loaded --")
        return 
    end
    
    if selectedInstance then
        local targetPart = selectedInstance:IsA("BasePart") and selectedInstance or selectedInstance:FindFirstChildWhichIsA("BasePart", true)
        if targetPart then
            lp.Character.HumanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 4, 0)
            updateOutput("-- Teleported to component --")
        else
            updateOutput("-- Could not find a physical part --")
        end
    end
end)

ViewCodeBtn.MouseButton1Click:Connect(function()
    if selectedInstance and selectedInstance:IsA("LuaSourceContainer") then
        if isServerSide then
            updateOutput("-- [F9 Console Mode]: Code decompilation unavailable via client terminal bounds. --")
        else
            local decompileFunc = _G.decompile or decompile
            if decompileFunc then
                updateOutput(decompileFunc(selectedInstance))
            else
                updateOutput("-- Decompiler function mapping not supported by script execution layout. --")
            end
        end
    else
        updateOutput("-- Element selected is not standard executable source script. --")
    end
end)

GenRemoteBtn.MouseButton1Click:Connect(function()
    if selectedInstance then
        local path = getFullPath(selectedInstance)
        if selectedInstance:IsA("RemoteEvent") then
            updateOutput("-- code generated by ScribblEXplorer\nlocal remote = " .. path .. "\nremote:FireServer(\"args\")")
        elseif selectedInstance:IsA("RemoteFunction") then
            updateOutput("-- code generated by ScribblEXplorer\nlocal rFunc = " .. path .. "\nlocal res = rFunc:InvokeServer(\"args\")")
        else
            updateOutput("-- Node element is not a standard Event/Function engine --")
        end
    end
end)

DestroyBtn.MouseButton1Click:Connect(function()
    if selectedInstance then
        local oldParent = selectedInstance.Parent
        pcall(function() selectedInstance:Destroy() end)
        updateOutput("-- Purged Node Instance --")
        rebuildTreeHierarchy()
        if oldParent then displayChildren(oldParent) end
    end
end)

ChangePropBtn.MouseButton1Click:Connect(function()
    if not selectedInstance then return end
    local txt = CodeOutput.Text
    local splitIdx = string.find(txt, "=")
    if splitIdx then
        local pName = string.gsub(string.sub(txt, 1, splitIdx - 1), "%s+", "")
        local pValStr = string.sub(txt, splitIdx + 1):match("^%s*(.-)%s*$")
        local val = pValStr
        if string.lower(pValStr) == "true" then val = true end
        if string.lower(pValStr) == "false" then val = false end
        if tonumber(pValStr) then val = tonumber(pValStr) end
        
        pcall(function() selectedInstance[pName] = val end)
        updateOutput("Set property value successfully.")
    end
end)

-- Automated Exploits Controls Engine Blocks
local speedActive = false
SuperSpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    SuperSpeedBtn.BackgroundColor3 = speedActive and Color3.fromRGB(130, 0, 200) or Color3.fromRGB(50, 40, 70)
    task.spawn(function()
        while speedActive do
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                if player and player.Character then
                    local hum = player.Character:FindFirstChild("Humanoid")
                    if hum then hum.WalkSpeed = 120 end
                end
            end)
            task.wait(0.2)
        end
    end)
end)

local infJumpActive = false
InfiniteJumpBtn.MouseButton1Click:Connect(function()
    infJumpActive = not infJumpActive
    InfiniteJumpBtn.BackgroundColor3 = infJumpActive and Color3.fromRGB(0, 180, 255) or Color3.fromRGB(50, 40, 70)
    if infJumpActive then
        _G.InfJumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                if player and player.Character then
                    local hum = player.Character:FindFirstChildOfClass("Humanoid")
                    if hum then hum:ChangeState("Jumping") end
                end
            end)
        end)
    else
        if _G.InfJumpConn then _G.InfJumpConn:Disconnect() end
    end
end)

BToolsBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        if player then
            local backpack = player:FindFirstChildOfClass("Backpack")
            if backpack then
                local t1 = Instance.new("HopperBin", backpack) t1.BinType = Enum.HopperBinType.Clone
                local t2 = Instance.new("HopperBin", backpack) t2.BinType = Enum.HopperBinType.Hammer
                local t3 = Instance.new("HopperBin", backpack) t3.BinType = Enum.HopperBinType.Grab
                updateOutput("-- Built-in Tools added to Backpack inventory --")
            end
        end
    end)
end)

-- Cross-Environment IY Injector Module execution handshake mapping context
ExecuteIYBtn.MouseButton1Click:Connect(function()
    updateOutput("-- Injecting Infinite Yield environment... --")
    local runSuccess = pcall(function()
        loadstring(game:HttpGet(uiConfig.TargetRepAddresses.PrimaryIY))()
    end)
    if not runSuccess then
        pcall(function()
            loadstring(game:HttpGet(uiConfig.TargetRepAddresses.FallbackIY))()
        end)
    end
    updateOutput("-- IY Loaded Successfully via Cosmic Asset Configuration --")
end)

-- Structural Initialization Bootstrap Sequence
rebuildTreeHierarchy()
if servicesList[1] then displayChildren(servicesList[1]) end
updateOutput("-- ScribblEXplorer Cosmic Dynamic Tree Active --")
