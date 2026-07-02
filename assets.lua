local Assets = {}

function Assets.CreateFrame(parent, size, pos, color)
    local f = Instance.new("Frame", parent)
    f.Size = size
    f.Position = pos
    f.BackgroundColor3 = color
    f.BorderSizePixel = 0
    local c = Instance.new("UICorner", f)
    c.CornerRadius = UDim.new(0, 8)
    return f
end

function Assets.CreateTreeButton(parent, name, depth)
    local b = Instance.new("TextButton", parent)
    b.Text = string.rep("  ", depth) .. name
    b.Size = UDim2.new(1, 0, 0, 25)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    b.TextColor3 = Color3.fromRGB(220, 220, 220)
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Font = Enum.Font.Gotham
    return b
end

return Assets
