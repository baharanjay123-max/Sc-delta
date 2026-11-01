y-- ============================================================
-- SCRIPT FINAL: MUSIK + FLY FLOATING (TANPA ICON LOGO)
-- Logo ID: 81021292421948
-- by BRUHH
-- ============================================================

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")

-- ===================== DATA PLAYLIST =====================
local Playlists = {
    {
        Name = "BKB / BREAKBEAT",
        Tracks = {
            { SongName = "BLACK HOLE BREAKBEAT", SoundId = "rbxassetid://118362297271903" },
            { SongName = "NU BREAKBEAT", SoundId = "rbxassetid://76497788855136" },
            { SongName = "BREAKBEAT BEAUTIFUL", SoundId = "rbxassetid://124564676675935" },
            { SongName = "BREAKBEAT PURE LOVE", SoundId = "rbxassetid://128392830206161" },
            { SongName = "BREAKBEAT ALWAYS LOVING YOU", SoundId = "rbxassetid://128071048140468" },
            { SongName = "BREAKBEAT RIVER FLOWS IN YOU", SoundId = "rbxassetid://125026658817868" },
            { SongName = "I NEED TO DACTOR", SoundId = "rbxassetid://89433429094554" },
            { SongName = "ROULATE RUSSIAN BKB", SoundId = "rbxassetid://112975242747165" },
            { SongName = "NOBARE YOU BKB", SoundId = "rbxassetid://108695200115706" },
            { SongName = "TAK BISA LAGI MENCINTAIMU BKB", SoundId = "rbxassetid://137798111576173" },
            { SongName = "CHICA LOCA BKB", SoundId = "rbxassetid://82808551264264" },
            { SongName = "AKU SUDAH HAMIL SAYANG BKB", SoundId = "rbxassetid://92817454990794" },
            { SongName = "GEN-Z BKB", SoundId = "rbxassetid://107968763369784" },
            { SongName = "IRAMA BKB", SoundId = "rbxassetid://74394269263180" },
            { SongName = "FOREVER BKB", SoundId = "rbxassetid://116187656749144" },
            { SongName = "JADIKAN LAH DIRIKU YG KE 2 BKB", SoundId = "rbxassetid://96287468808586" },
            { SongName = "AHOYxMATOTO BKB", SoundId = "rbxassetid://125071929480860" },
            { SongName = "KAMU MALU-MALU BKB", SoundId = "rbxassetid://104538666715482" }
        }
    }
}

-- ===================== STATE =====================
local flying = false
local bodyVelocity, bodyGyro
local isPlaying = false
local currentPlaylistIndex = 1
local currentTrackIndex = 1
local menuOpen = true

-- ===================== TEMA UNGU =====================
local UNGU = Color3.fromRGB(138, 43, 226)
local UNGU_MUDA = Color3.fromRGB(186, 85, 211)
local UNGU_GELAP = Color3.fromRGB(75, 0, 130)
local BG_GELAP = Color3.fromRGB(20, 20, 25)

-- ===================== FUNGSI DRAG =====================
local function buatBisaDigeser(obj)
    local dragging = false
    local dragStart, startPos
    
    obj.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = obj.Position
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ===================== GUI UTAMA =====================
local gui = Instance.new("ScreenGui")
gui.Name = "ScriptGuaFull"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

-- ===================== FRAME MENU =====================
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 480)
frame.Position = UDim2.new(0.5, -150, 0.5, -240)
frame.BackgroundColor3 = BG_GELAP
frame.BorderSizePixel = 0
frame.Visible = true
frame.Parent = gui
buatBisaDigeser(frame) -- Seluruh menu bisa digeser

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Color = UNGU
stroke.Thickness = 2
stroke.Transparency = 0.3
stroke.Parent = frame

-- Logo (Nempel di dalam frame, otomatis ikut geser)
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 80, 0, 80)
logo.Position = UDim2.new(0.5, -40, 0, 10)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://81021292421948"
logo.Parent = frame

-- Judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 95)
title.BackgroundTransparency = 1
title.Text = "MUSIC SYSTEM"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.Parent = frame

-- Scroll Frame Musik
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.9, 0, 0, 300)
scroll.Position = UDim2.new(0.05, 0, 0, 130)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = UNGU_MUDA
scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

-- ===================== FUNGSI TOMBOL MUSIK =====================
local function buatTombol(teks, warna, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.BackgroundColor3 = warna
    btn.Text = teks
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Parent = scroll
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ===================== SISTEM MUSIK =====================
local musicSound = Instance.new("Sound")
musicSound.Volume = 0.5
musicSound.Looped = false
musicSound.Parent = SoundService

local songLabel = Instance.new("TextLabel")
songLabel.Size = UDim2.new(0.9, 0, 0, 25)
songLabel.Position = UDim2.new(0.05, 0, 0, 435)
songLabel.BackgroundTransparency = 1
songLabel.Text = "Pilih Lagu..."
songLabel.TextColor3 = UNGU_MUDA
songLabel.Font = Enum.Font.GothamBold
songLabel.TextScaled = true
songLabel.Parent = frame

local function playTrack(index)
    local playlist = Playlists[currentPlaylistIndex]
    local track = playlist.Tracks[index]
    if track then
        currentTrackIndex = index
        musicSound.SoundId = track.SoundId
        musicSound:Play()
        isPlaying = true
        songLabel.Text = "Playing: " .. track.SongName
    end
end

local function loadPlaylist(index)
    for _, child in ipairs(scroll:GetChildren()) do
        if child:IsA("TextButton") and child:GetAttribute("MusicBtn") then
            child:Destroy()
        end
    end
    
    local playlist = Playlists[index]
    if not playlist then return end
    
    for i, track in ipairs(playlist.Tracks) do
        local btn = buatTombol(track.SongName, UNGU_GELAP, function()
            playTrack(i)
        end)
        btn:SetAttribute("MusicBtn", true)
    end
end

-- Tombol Play/Pause
local playBtn = Instance.new("TextButton")
playBtn.Size = UDim2.new(0.28, 0, 0, 30)
playBtn.Position = UDim2.new(0.05, 0, 0, 465)
playBtn.BackgroundColor3 = UNGU
playBtn.Text = "Play/Pause"
playBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
playBtn.Font = Enum.Font.GothamBold
playBtn.TextScaled = true
playBtn.Parent = frame

local playCorner = Instance.new("UICorner")
playCorner.CornerRadius = UDim.new(0, 8)
playCorner.Parent = playBtn

playBtn.MouseButton1Click:Connect(function()
    if isPlaying then
        musicSound:Pause()
        isPlaying = false
        songLabel.Text = "Paused"
    else
        if musicSound.SoundId ~= "" then
            musicSound:Resume()
            isPlaying = true
            songLabel.Text = "Playing: " .. Playlists[currentPlaylistIndex].Tracks[currentTrackIndex].SongName
        end
    end
end)

-- Tombol Next
local nextBtn = Instance.new("TextButton")
nextBtn.Size = UDim2.new(0.28, 0, 0, 30)
nextBtn.Position = UDim2.new(0.36, 0, 0, 465)
nextBtn.BackgroundColor3 = UNGU
nextBtn.Text = "Next"
nextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
nextBtn.Font = Enum.Font.GothamBold
nextBtn.TextScaled = true
nextBtn.Parent = frame

local nextCorner = Instance.new("UICorner")
nextCorner.CornerRadius = UDim.new(0, 8)
nextCorner.Parent = nextBtn

nextBtn.MouseButton1Click:Connect(function()
    currentTrackIndex = currentTrackIndex % #Playlists[currentPlaylistIndex].Tracks + 1
    playTrack(currentTrackIndex)
end)

-- Tombol Prev
local prevBtn = Instance.new("TextButton")
prevBtn.Size = UDim2.new(0.28, 0, 0, 30)
prevBtn.Position = UDim2.new(0.67, 0, 0, 465)
prevBtn.BackgroundColor3 = UNGU
prevBtn.Text = "Prev"
prevBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
prevBtn.Font = Enum.Font.GothamBold
prevBtn.TextScaled = true
prevBtn.Parent = frame

local prevCorner = Instance.new("UICorner")
prevCorner.CornerRadius = UDim.new(0, 8)
prevCorner.Parent = prevBtn

prevBtn.MouseButton1Click:Connect(function()
    currentTrackIndex = currentTrackIndex - 1
    if currentTrackIndex < 1 then
        currentTrackIndex = #Playlists[currentPlaylistIndex].Tracks
    end
    playTrack(currentTrackIndex)
end)

-- Tombol Tutup Menu (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 10)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextScaled = true
closeBtn.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
end)

-- ===================== FITUR FLY (FLOATING) =====================
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(0, 120, 0, 50)
flyBtn.Position = UDim2.new(0.5, -60, 1, -100) -- Bawah tengah
flyBtn.BackgroundColor3 = UNGU_GELAP
flyBtn.Text = "FLY: OFF"
flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
flyBtn.Font = Enum.Font.GothamBlack
flyBtn.TextScaled = true
flyBtn.Parent = gui
buatBisaDigeser(flyBtn) -- Tombol fly bisa digeser

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 10)
flyCorner.Parent = flyBtn

flyBtn.MouseButton1Click:Connect(function()
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    
    flying = not flying
    if flying then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Parent = hrp
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bodyGyro.P = 1000
        bodyGyro.D = 50
        bodyGyro.Parent = hrp
        
        flyBtn.Text = "FLY: ON"
        flyBtn.BackgroundColor3 = UNGU_MUDA
    else
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        flyBtn.Text = "FLY: OFF"
        flyBtn.BackgroundColor3 = UNGU_GELAP
    end
end)

-- ===================== LOOP FLY =====================
RunService.RenderStepped:Connect(function()
    if flying and bodyVelocity and bodyGyro then
        local cam = workspace.CurrentCamera
        local char = player.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        local moveDir = hum and hum.MoveDirection or Vector3.zero
        local worldDir = cam.CFrame:VectorToWorldSpace(moveDir)
        
        if worldDir.Magnitude > 0 then
            bodyVelocity.Velocity = worldDir.Unit * 50
        else
            bodyVelocity.Velocity = Vector3.zero
        end
        
        bodyGyro.CFrame = cam.CFrame
    end
end)

-- ===================== MULAI =====================
loadPlaylist(currentPlaylistIndex)
songLabel.Text = "Playlist: " .. Playlists[currentPlaylistIndex].Name
print("[BRUHH] Script Final: Menu Musik + Fly Floating (Tanpa Icon Logo) berhasil di-load!")
