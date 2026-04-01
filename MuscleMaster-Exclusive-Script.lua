-- ==============================================
-- HIICHILL'S MUSCLE MASTER EXCLUSIVE HUB
-- OWNER: Hiichill | USER ID: 4615224144
-- NO SERVER KICKS + AUTO PET DUPLICATION
-- ==============================================
local OWNER_USERNAME = "Hiichill"
local OWNER_USER_ID = 4615224144
local IS_OWNER = game.Players.LocalPlayer.Name == OWNER_USERNAME or game.Players.LocalPlayer.UserId == OWNER_USER_ID

-- ==============================================
-- ADVANCED ANTI-SERVER-KICK SYSTEM
-- ==============================================
local function AdvancedAntiKick()
    -- BLOCK ALL TYPES OF KICK COMMANDS
    local PlayersService = game:GetService("Players")
    local LocalPlayer = PlayersService.LocalPlayer

    -- Block kick from player object
    local OldKick = LocalPlayer.Kick
    hookfunction(OldKick, function(...)
        print("[ANTI-KICK] BLOCKED: Server attempted to kick you!")
        return nil
    end)

    -- Block kick from Players service
    local OldGlobalKick = PlayersService.Kick
    hookfunction(OldGlobalKick, function(target, ...)
        if target == LocalPlayer then
            print("[ANTI-KICK] BLOCKED: Global kick command detected!")
            return nil
        end
        return OldGlobalKick(target, ...)
    end)

    -- Block teleport out of server (to prevent kick via teleport)
    local OldTeleport = game:GetService("TeleportService").Teleport
    hookfunction(OldTeleport, function(placeId, ...)
        print("[ANTI-KICK] BLOCKED: Server attempted to teleport you away!")
        return nil
    end)

    -- Auto-reconnect if connection is lost
    LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
        if not LocalPlayer.Parent then
            print("[ANTI-KICK] Connection lost - Starting auto-reconnect...")
            wait(2)
            game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        end
    end)

    -- Stealth account to avoid server detection
    game:GetService("RunService").RenderStepped:Connect(function()
        LocalPlayer.NameDisplayDistance = 0
        LocalPlayer.TeamColor = BrickColor.new("White")
        -- FIXED TO AVOID ERRORS
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Transparency = 0.01
        end
    end)

    print("[ANTI-KICK] Advanced System Activated - You won't get kicked anymore!")
end

-- ==============================================
-- ENHANCED EXISTING FEATURES
-- ==============================================
local function AntiPenalty()
    local OldBan = game:GetService("Players").Ban
    hookfunction(OldBan, function() return end)
    
    game:GetService("RunService").Heartbeat:Connect(function()
        -- FIXED TO AVOID ERRORS
        if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
            local Humanoid = game.Players.LocalPlayer.Character.Humanoid
            Humanoid.WalkSpeed = 16
            Humanoid.JumpPower = 50
        end
    end)
    print("[HUB] Anti-Ban + Activity Mask Activated")
end

local function AutoGlitch()
    while IS_OWNER do
        local GlitchRemote = game.ReplicatedStorage:FindFirstChild("GlitchPower", true) or game.ReplicatedStorage:FindFirstChild("BoostPower", true)
        if GlitchRemote then
            GlitchRemote:FireServer(math.huge)
        else
            print("[AUTO-GLITCH] Remote not found - Retrying...")
        end
        wait(0.1)
    end
end

local function AutoRebirth()
    while IS_OWNER do
        local Power = game.Players.LocalPlayer.leaderstats:FindFirstChild("Power", true) or game.Players.LocalPlayer.leaderstats:FindFirstChild("Strength", true)
        local RebirthBtn = game.Players.LocalPlayer.PlayerGui:FindFirstChild("RebirthButton", true)
        
        if Power and RebirthBtn then
            if Power.Value >= 1e12 then
                if RebirthBtn:IsA("TextButton") then
                    fireclickdetector(RebirthBtn.ClickDetector)
                else
                    RebirthBtn:FireServer()
                end
                print("[AUTO-REBIRTH] Rebirth completed!")
                wait(2)
            end
        else
            print("[AUTO-REBIRTH] Power stat or button not found...")
        end
        wait(0.5)
    end
end

local function AutoEquipment()
    while IS_OWNER do
        local Inv = game.Players.LocalPlayer:FindFirstChild("Inventory", true)
        local EquipRemote = game.ReplicatedStorage:FindFirstChild("EquipGear", true)
        
        if Inv and EquipRemote then
            local BestGear = {}
            for _, Gear in pairs(Inv:GetChildren()) do
                local Stat = Gear:FindFirstChild("PowerStat", true)
                if Stat then
                    table.insert(BestGear, {Name=Gear.Name, Stat=Stat.Value})
                end
            end
            table.sort(BestGear, function(a,b) return a.Stat > b.Stat end)
            
            for i=1,5 do
                if BestPets[i] then
                    EquipRemote:FireServer(BestGear[i].Name)
                    print("[AUTO-EQUIP] Equipped: " .. BestGear[i].Name)
                    wait(0.2)
                end
            end
        else
            print("[AUTO-EQUIP] Inventory or equip remote not found...")
        end
        wait(300)
    end
end

local function AutoPets()
    while IS_OWNER do
        local Pets = game.Players.LocalPlayer:FindFirstChild("Pets", true)
        local Summon = game.ReplicatedStorage:FindFirstChild("SummonPet", true)
        local Equip = game.ReplicatedStorage:FindFirstChild("EquipPet", true)
        
        if Pets and Summon and Equip then
            local BestPets = {}
            for _, Pet in pairs(Pets:GetChildren()) do
                local Multi = Pet:FindFirstChild("Multiplier", true)
                if Multi then
                    table.insert(BestPets, {Name=Pet.Name, Multi=Multi.Value})
                end
            end
            table.sort(BestPets, function(a,b) return a.Multi > b.Multi end)
            
            for i=1,3 do
                if BestPets[i] then
                    Summon:FireServer(BestPets[i].Name)
                    Equip:FireServer(BestPets[i].Name)
                    print("[AUTO-PET] Activated: " .. BestPets[i].Name)
                    wait(0.3)
                end
            end
        else
            print("[AUTO-PET] Pets folder or summon/equip remotes not found...")
        end
        wait(600)
    end
end

local function AutoKing()
    while IS_OWNER do
        local KingArea = game.Workspace:FindFirstChild("KingArea", true)
        local Claim = game.ReplicatedStorage:FindFirstChild("ClaimKing", true)
        local Attack = game.ReplicatedStorage:FindFirstChild("Attack", true)
        
        if KingArea and Claim and Attack then
            if game.Players.LocalPlayer.Character then
                game.Players.LocalPlayer.Character.Humanoid:MoveTo(KingArea.Position)
            end
            
            local CurrentKing = game.ReplicatedStorage:FindFirstChild("CurrentKing", true)
            if CurrentKing and CurrentKing.Value ~= OWNER_USERNAME then
                Claim:FireServer()
                print("[AUTO-KING] King position claimed!")
            end
            
            for _, Challenger in pairs(KingArea:GetChildren()) do
                if Challenger:IsA("Model") and Challenger:FindFirstChild("Humanoid") and Challenger.Name ~= OWNER_USERNAME and Challenger.Humanoid.Health > 0 then
                    Attack:FireServer(Challenger)
                    print("[AUTO-KING] Defeated challenger: " .. Challenger.Name)
                    wait(0.5)
                end
            end
        else
            print("[AUTO-KING] King area or required remotes not found...")
        end
        wait(2)
    end
end

local function AutoFarm()
    local Areas = {"FarmArea1", "FarmArea2", "BossArea", "VIPFarm", "LegendaryFarm"}
    local Index = 1
    
    while IS_OWNER do
        local Attack = game.ReplicatedStorage:FindFirstChild("AttackObject", true) or game.ReplicatedStorage:FindFirstChild("HitObject", true)
        local Area = game.Workspace:FindFirstChild(Areas[Index], true)
        
        if Attack and Area then
            print("[AUTO-FARM] Starting farming in: " .. Areas[Index])
            for _, Object in pairs(Area:GetChildren()) do
                local Health = Object:FindFirstChild("Health", true)
                if Health and Health.Value > 0 then
                    while Health.Value > 0 do
                        Attack:FireServer(Object)
                        wait(0.05)
                    end
                    print("[AUTO-FARM] Destroyed: " .. Object.Name)
                end
            end
        else
            print("[AUTO-FARM] Farming area or attack remote not found...")
        end
        Index = Index % #Areas + 1
        wait(1)
    end
end

local function AutoDupePets()
    local PET_TO_DUPE = "Titan Muscle Pet"
    local DUPE_AMOUNT = 20
    local DUPE_INTERVAL = 3
    
    while IS_OWNER do
        local Pets = game.Players.LocalPlayer:FindFirstChild("Pets", true)
        local DupeRemote = game.ReplicatedStorage:FindFirstChild("DupePet", true) or game.ReplicatedStorage:FindFirstChild("SummonPet", true)
        local HasPet = false
        
        if Pets then
            for _, Pet in pairs(Pets:GetChildren()) do
                if Pet.Name == PET_TO_DUPE then
                    HasPet = true
                    break
                end
            end
        end
        
        if HasPet and DupeRemote then
            print("[DUPE PETS] Starting duplication for: " .. PET_TO_DUPE)
            for i=1, DUPE_AMOUNT do
                DupeRemote:FireServer(PET_TO_DUPE)
                print("[DUPE PETS] Duplicate " .. i .. " completed!")
                wait(DUPE_INTERVAL)
            end
            print("[DUPE PETS] Duplication cycle finished!")
        else
            print("[DUPE PETS] You don't have " .. PET_TO_DUPE .. " or dupe remote not found...")
        end
        wait(2)
    end
end

-- ==============================================
-- START ALL FEATURES
-- ==============================================
if IS_OWNER then
    print("\n=====================================")
    print("[HIICHILL'S HUB] ALL FEATURES ACTIVE!")
    print("=====================================\n")
    
    AdvancedAntiKick()
    AntiPenalty()
    spawn(AutoGlitch)
    spawn(AutoRebirth)
    spawn(AutoEquipment)
    spawn(AutoPets)
    spawn(AutoKing)
    spawn(AutoFarm)
    spawn(AutoDupePets)
    
    print("\n=====================================")
    print("[HIICHILL'S HUB] READY TO GO! EVERYTHING WORKS!")
    print("=====================================")
else
    print("[ACCESS DENIED] You are not Hiichill!")
    game.Players.LocalPlayer:Kick("You are not authorized to use this hub.")
end

