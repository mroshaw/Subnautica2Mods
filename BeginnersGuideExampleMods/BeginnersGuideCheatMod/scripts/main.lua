local UEHelpers = require("UEHelpers")
local MOD_NAME = "BeginnersGuideCheatMod"

-- Simple helper function to log messages with the mod name as a prefix and a timestamp
local function log(msg)
    print(string.format("[%s] %s\n", MOD_NAME, msg))
end

-- Hold a reference to the player's attribute set so we can modify it each tick
local attrSet = nil

-- Function to find the player's survival attribute set in memory
local function findPlayerAttrSet()
    local all = FindAllOf("UWESurvivalAttributeSet")
    if not all then return nil end

    for _, set in ipairs(all) do
        if set:IsValid() and set:GetFullName():find("BP_Character_01_C") then
            return set
        end
    end

    return nil
end

-- When the player spawns, find and set the survival attribute
NotifyOnNewObject("/Game/Blueprints/Character/player/BP_Character_01.BP_Character_01_C", function()
    ExecuteInGameThread(function()
        attrSet = nil
        attrSet = findPlayerAttrSet()
        if attrSet then
            log("Player character created - survival attributes found! Infinite Oxygen, Food, and Water enabled!")
        end
    end)
end)

-- Loop every 500ms to check for the player's attribute set and modify it to give infinite oxygen, food, and water
LoopAsync(500, function()
    ExecuteInGameThread(function()
        if not attrSet or not attrSet:IsValid() then
            return
        end

        -- Oxygen
        local maxOxygen = attrSet.MaxOxygen.CurrentValue
        attrSet.Oxygen.BaseValue = maxOxygen
        attrSet.Oxygen.CurrentValue = maxOxygen

        -- Food
        local maxFood = attrSet.MaxFood.CurrentValue
        attrSet.Food.BaseValue = maxFood
        attrSet.Food.CurrentValue = maxFood

        -- Water
        local maxWater = attrSet.MaxWater.CurrentValue
        attrSet.Water.BaseValue = maxWater
        attrSet.Water.CurrentValue = maxWater
    end)
    return false
end)

log("Loaded!")