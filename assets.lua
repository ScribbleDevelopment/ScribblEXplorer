local Assets = {}

function Assets.CosmicStyle(obj)
    obj.BackgroundColor3 = Color3.fromRGB(19, 15, 34)
    obj.BorderSizePixel = 0
    local corner = Instance.new("UICorner", obj)
    corner.CornerRadius = UDim.new(0, 6)
    return obj
end

function Assets.CreateTreeButton(parent, name, depth)
    local b = Instance.new("TextButton", parent)
    b.Text = string.rep("  ", depth) .. "• " .. name
    b.Size = UDim2.new(1, -10, 0, 25)
    b.BackgroundColor3 = Color3.fromRGB(30, 25, 45)
    b.TextColor3 = Color3.fromRGB(200, 200, 255)
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Font = Enum.Font.Gotham
    Assets.CosmicStyle(b)
    return b
end

return Assets
