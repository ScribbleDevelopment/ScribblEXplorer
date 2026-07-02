local Assets = {}

-- This allows you to apply your "Cosmic" theme instantly to any new UI element
function Assets.ApplyCosmicTheme(element)
    if element:IsA("Frame") then
        element.BackgroundColor3 = Color3.fromRGB(19, 15, 34)
    elseif element:IsA("TextButton") then
        element.BackgroundColor3 = Color3.fromRGB(31, 23, 49)
        element.Font = Enum.Font.Gotham
    end
    -- Add a corner automatically
    local corner = Instance.new("UICorner", element)
    corner.CornerRadius = UDim.new(0, 8)
    return element
end

-- Define UI templates here (e.g., a custom SearchBar template)
function Assets.CreateSearchBar(parent)
    local search = Instance.new("TextBox", parent)
    search.PlaceholderText = "Search the void..."
    search.Size = UDim2.new(0.9, 0, 0, 30)
    -- Apply your theme
    Assets.ApplyCosmicTheme(search)
    return search
end

return Assets
