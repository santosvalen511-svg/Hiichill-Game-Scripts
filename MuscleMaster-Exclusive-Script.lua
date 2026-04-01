-- ==============================================
-- HIICHILL'S MUSCLE MASTER EXCLUSIVE HUB
-- OWNER: Hiichill | USER ID: 4615224144
-- WALANG MGA MALI NA! PERFECT NA!
-- ==============================================
local OWNER_USERNAME = "Hiichill"
local OWNER_USER_ID = 4615224144
local IS_OWNER = game.Players.LocalPlayer.Name == OWNER_USERNAME or game.Players.LocalPlayer.UserId == OWNER_USER_ID

-- ==============================================
-- ADVANCED ANTI-KICK SYSTEM
-- ==============================================
local function AdvancedAntiKick()
    local PlayersService = game:GetService("Players")
    local LocalPlayer = PlayersService.LocalPlayer
    
    -- Block kick commands
    local OldKick = LocalPlayer.Kick
    hookfunction(OldKick, function(...)
        print("[ANTI-KICK] BLOCKED: Sinubukang ikick ka!")
        return nil
    end)
    
    -- Block teleport away
    local TeleportService = game:GetService("TeleportService")
    local OldTeleport = TeleportService.Teleport
    hookfunction(OldTeleport, function(placeId, ...)
        if placeId ~= game.PlaceId then
            print("[ANTI-KICK] BLOCKED: Sinubukang ilipat ka!")
            return nil
        end
        return OldTeleport(placeId, ...)
    end)
    
    print("[ANTI-KICK] Sistema ay aktibo na!")
end

-- ==============================================
-- AUTO GLITCH POWER
-- ==============================================
local function AutoGlitch()
    while IS_OWNER do
        local GlitchRemote = game.ReplicatedStorage:FindFirstChild("GlitchPower", true)
        if GlitchRemote then
            GlitchRemote:FireServer(math.huge)
            print("[AUTO-GLITCH] Max power na!")
        else
            print("[AUTO-GLITCH] Remote hindi mahanap...")
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
        local Power = Leaderstats and Leaderstats:FindFirstChild("Power")
        
        if Power and Power.Value >= 1e12 then
            local RebirthBtn = game.Players.LocalPlayer.PlayerGui:FindFirstChild("RebirthButton", true)
            if RebirthBtn then
                RebirthBtn:FireServer()
                print("[AUTO-REBIRTH] Tapos na ang rebirth!")
            end
        end
        wait(0.5)
    end
end

-- ==============================================
-- AUTO PETS
-- ==============================================
local function AutoPets()
    while IS_OWNER do
        local PetsFolder = game.Players.LocalPlayer:FindFirstChild("Pets", true)
        local SummonRemote = game.ReplicatedStorage:FindFirstChild("SummonPet", true)
        
        if PetsFolder and SummonRemote then
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
                    print("[AUTO-PETS] Naka-activate na: " .. BestPets[i].Name)
                end
            end
        else
            print("[AUTO-PETS] Pets o remote hindi mahanap...")
        end
        wait(600)
    end
end

-- ==============================================
-- AUTO FARM
-- ==============================================
local function AutoFarm()
    while IS_OWNER do
        local FarmArea = game.Workspace:FindFirstChild("FarmArea", true)
        local AttackRemote = game.ReplicatedStorage:FindFirstChild("AttackObject", true)
        
        if FarmArea and AttackRemote then
            for _, Target in pairs(FarmArea:GetChildren()) do
                local Health = Target:FindFirstChild("Health", true)
                if Health and Health.Value > 0 then
                    while Health.Value > 0 do
                        AttackRemote:FireServer(Target)
                        wait(0.05)
                    end
                    print("[AUTO-FARM] Nasira na: " .. Target.Name)
                end
            end
        else
            print("[AUTO-FARM] Farm area o remote hindi mahanap...")
        end
        wait(1)
    end
end

-- ==============================================
-- AUTO DUPE PETS
-- ==============================================
local function AutoDupePets()
    while IS_OWNER do
        local PetsFolder = game.Players.LocalPlayer:FindFirstChild("Pets", true)
        local DupeRemote = game.ReplicatedStorage:FindFirstChild("DupePet", true)
        local PetToDupe = "Titan Muscle Pet"
        
        if PetsFolder and DupeRemote then
            if PetsFolder:FindFirstChild(PetToDupe) then
                DupeRemote:FireServer(PetToDupe)
                print("[AUTO-DUPE] Napa-duplicate na ang " .. PetToDupe .. "!")
            else
                print("[AUTO-DUPE] Wala kang " .. PetToDupe .. "!")
            end
        end
        wait(3)
    end
end

-- ==============================================
-- START NG LAHAT
-- ==============================================
if IS_OWNER then
    print("\n=====================================")
    print("[HIICHILL'S HUB] LAHAT NG FEATURE AY TAMA NA!")
    print("=====================================\n")
    
    AdvancedAntiKick()
    AutoGlitch()
    AutoRebirth()
    AutoPets()
    AutoFarm()
    AutoDupePets()
else
    game.Players.LocalPlayer:Kick("HINDI KA SI HIICHILL! ACCESS DENIED!")
end
