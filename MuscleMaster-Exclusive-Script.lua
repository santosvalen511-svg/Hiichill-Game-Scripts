-- ==============================================
-- HIICHILL'S MUSCLE MASTER EXCLUSIVE HUB
-- OWNER: Hiichill | USER ID: 4615224144
-- NO SERVER KICKS + AUTO FEATURES
-- ==============================================
local OWNER_USERNAME = "Hiichill"
local OWNER_USER_ID = 4615224144
local IS_OWNER = game.Players.LocalPlayer.Name == OWNER_USERNAME or game.Players.LocalPlayer.UserId == OWNER_USER_ID

-- ==============================================
-- ADVANCED ANTI-SERVER-KICK SYSTEM
-- ==============================================
local function AdvancedAntiKick()
    -- BLOCK ALL KICK COMMANDS
    local PlayersService = game:GetService("Players")
    local LocalPlayer = PlayersService.LocalPlayer
    local OldKick = LocalPlayer.Kick
    hookfunction(OldKick, function(...)
        print("[ANTI-KICK] BLOCKED: Server tried to kick you!")
        return nil
    end)

    -- BLOCK TELEPORT OUT OF SERVER
    local TeleportService = game:GetService("TeleportService")
    local OldTeleport = TeleportService.Teleport
    hookfunction(OldTeleport, function(placeId, ...)
        if placeId ~= game.PlaceId then
            print("[ANTI-KICK] BLOCKED: Server tried to teleport you away!")
            return nil
        end
        return OldTeleport(placeId, ...)
    end)

    -- AUTO-RECONNECT IF DISCONNECTED
    LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
        if not LocalPlayer.Parent then
            print("[ANTI-KICK] Reconnecting to server...")
            wait(2)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)

    print("[ANTI-KICK] Advanced Anti-Kick System Activated!")
end

-- ==============================================
-- AUTO GLITCH POWER
-- ==============================================
local function AutoGlitch()
    while IS_OWNER do
        local GlitchRemote = game.ReplicatedStorage:FindFirstChild("GlitchPower", true) or game.ReplicatedStorage:FindFirstChild("BoostPower", true)
        if GlitchRemote then
            GlitchRemote:FireServer(math.huge)
            print("[AUTO-GLITCH] Activated - Max power applied!")
        else
            print("[AUTO-GLITCH] Remote not found - Retrying...")
        end
        wait(0.1)
    end
end

-- ==============================================
-- AUTO REBIRTH
-- ==============================================
local function AutoRebirth()
    while IS_OWNER do
        local Leaderstats = game.Players.LocalPlayer:FindFirstChild("leaderstats")
        local Power = Leaderstats and Leaderstats:FindFirstChild("Power") or Leaderstats:FindFirstChild("Strength")
        local RebirthBtn = game.Players.LocalPlayer.PlayerGui:FindFirstChild("RebirthButton", true)

        if Power and RebirthBtn then
            if Power.Value >= 1e12 then
                if RebirthBtn:IsA("TextButton") then
                    fireclickdetector(RebirthBtn.ClickDetector)
                else
                    RebirthBtn:FireServer()
                end
                print("[AUTO-REBIRTH] Rebirth completed successfully!")
                wait(2)
            end
        else
            print("[AUTO-REBIRTH] Power stat or button not found...")
        end
        wait(0.5)
    end
end

-- ==============================================
-- AUTO EQUIPMENT
-- ==============================================
local function AutoEquipment()
    while IS_OWNER do
        local Inv = game.Players.LocalPlayer:FindFirstChild("Inventory", true)
        local EquipRemote = game.ReplicatedStorage:FindFirstChild("EquipGear", true)
        
        if Inv and EquipRemote then
            local BestGear = {}
            for _, Gear in pairs(Inv:GetChildren()) do
                local Stat = Gear:FindFirstChild("PowerStat", true)
                if Stat then
                    table.insert(BestGear, {Name = Gear.Name, Stat = Stat.Value})
                end
            end
            table.sort(BestGear, function(a,b) return a.Stat > b.Stat end)
            
            for i=1,5 do
                -- FIXED TYPO: BestPets → BestGear
                if BestGear[i] then
                    EquipRemote:FireServer(BestGear[i].Name)
                    print("[AUTO-EQUIP] Equipped: " .. BestGear[i].Name)
                end
                wait(0.2)
            end
        else
            print("[AUTO-EQUIP] Inventory or equip remote not found...")
        end
        wait(300)
    end
end

-- ==============================================
-- AUTO PETS
-- ==============================================
local function AutoPets()
    while IS_OWNER do
        local PetsFolder = game.Players.LocalPlayer:FindFirstChild("Pets", true)
        local SummonRemote = game.ReplicatedStorage:FindFirstChild("SummonPet", true)
        local EquipRemote = game.ReplicatedStorage:FindFirstChild("EquipPet", true)
        
        if PetsFolder and SummonRemote and EquipRemote then
            local BestPets = {}
            for _, Pet in pairs(PetsFolder:GetChildren()) do
                local Multi = Pet:FindFirstChild("Multiplier", true)
                if Multi then
                    table.insert(BestPets, {Name = Pet.Name, Multi = Multi.Value})
                end
            end
            table.sort(BestPets, function(a,b) return a.Multi > b.Multi end)
            
            for i=1,3 do
                if BestPets[i] then
                    SummonRemote:FireServer(BestPets[i].Name)
                    EquipRemote:FireServer(BestPets[i].Name)
                    print("[AUTO-PET] Activated: " .. BestPets[i].Name)
                end
            end
        else
            print("[AUTO-PET] Pets folder or remotes not found...")
        end
        wait(600)
    end
end

-- ==============================================
-- AUTO FARM
-- ==============================================
local function AutoFarm()
    while IS_OWNER do
        local FarmArea = game.Workspace:FindFirstChild("FarmArea", true) or game.Workspace:FindFirstChild("BossArea", true)
        local AttackRemote = game.ReplicatedStorage:FindFirstChild("AttackObject", true)
        
        if FarmArea and AttackRemote then
            for _, Object in pairs(FarmArea:GetChildren()) do
                if Object:FindFirstChild("Health", true) then
                    while Object.Health.Value > 0 do
                        AttackRemote:FireServer(Object)
                        wait(0.05)
                    end
                    print("[AUTO-FARM] Destroyed: " .. Object.Name)
                end
            end
        else
            print("[AUTO-FARM] Farm area or attack remote not found...")
        end
        wait(1)
    end
end

-- ==============================================
-- AUTO DUPE PETS
-- ==============================================
local function AutoDupePets()
    while IS_OWNER do
        local PetToDupe = "Titan Muscle Pet"
        local PetsFolder = game.Players.LocalPlayer:FindFirstChild("Pets", true)
        local DupeRemote = game.ReplicatedStorage:FindFirstChild("DupePet", true)
        
        if PetsFolder and DupeRemote then
            local HasPet = PetsFolder:FindFirstChild(PetToDupe)
            if HasPet then
                DupeRemote:FireServer(PetToDupe, 20)
                print("[AUTO-DUPE] Duplicated " .. PetToDupe .. " x20!")
            else
                print("[AUTO-DUPE] " .. PetToDupe .. " not found...")
            end
        else
            print("[AUTO-DUPE] Pets folder or dupe remote not found...")
        end
        wait(3)
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
    AutoGlitch()
    AutoRebirth()
    AutoEquipment()
    AutoPets()
    AutoFarm()
    AutoDupePets()
else
    game.Players.LocalPlayer:Kick("ACCESS DENIED: You are not Hiichill!")
end
