---@type table
local UEHelpers = require("UEHelpers")

---@type string
local MOD_NAME = "BeginnersGuideCheatMod"

---@type boolean
local debugMode = true

-- Simple helper function to log messages with the mod name as a prefix
---@param msg string
local function log(msg)
    print(string.format("[%s] %s\n", MOD_NAME, msg))
end

-- Hold a reference to the player's attribute set so we can modify it each tick
---@type UUWESurvivalAttributeSet|nil
local attrSet = nil

-- Function to find the player's survival attribute set in memory
---@return UUWESurvivalAttributeSet|nil
local function findPlayerAttrSet()
    ---@type UUWESurvivalAttributeSet[]|nil
    local all = FindAllOf("UWESurvivalAttributeSet")
    if not all then return nil end
    for _, set in ipairs(all) do
        if set:IsValid() and set:GetFullName():find("BP_Character_01_C") then
            return set
        end
    end
    return nil
end

-- When the player spawns, find and set the survival attribute set
NotifyOnNewObject("/Game/Blueprints/Character/player/BP_Character_01.BP_Character_01_C", function()
    ExecuteInGameThread(function()
        attrSet = nil
        attrSet = findPlayerAttrSet()
        if attrSet then
            log("Player character created - survival attributes found! Infinite Oxygen, Food, and Water enabled!")
        end
    end)
end)

-- Loop every 500ms to keep oxygen, food, and water at their maximum values
LoopAsync(500, function()
    ExecuteInGameThread(function()
        if not attrSet or not attrSet:IsValid() then
            -- If we're in debug mode, don't wait for the player to respawn. This allows us to hot reload the mod
            -- by setting debugMode to true
            if(debugMode) then
                log("Survival attribute set not found or invalid. Attempting to find it again...")
                attrSet = findPlayerAttrSet()
            end
            return
        end

        -- Oxygen
        ---@type number
        local maxOxygen = attrSet.MaxOxygen.CurrentValue
        attrSet.Oxygen.BaseValue = maxOxygen
        attrSet.Oxygen.CurrentValue = maxOxygen

        -- Food
        ---@type number
        local maxFood = attrSet.MaxFood.CurrentValue
        attrSet.Food.BaseValue = maxFood
        attrSet.Food.CurrentValue = maxFood

        -- Water
        ---@type number
        local maxWater = attrSet.MaxWater.CurrentValue
        attrSet.Water.BaseValue = maxWater
        attrSet.Water.CurrentValue = maxWater
    end)
    return false
end)

log("Loaded!")