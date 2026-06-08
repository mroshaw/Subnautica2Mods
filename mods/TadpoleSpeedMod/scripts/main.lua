-- Allow players to amend the speed multiplier and debug mode without modifying the main code
---@type table
local config = require("config")

---@type table
local UEHelpers = require("UEHelpers")

---@type string
local MOD_NAME = "TadpoleSpeedMod"

-- Simple helper function to log messages with the mod name as a prefix
--- Debug messages will only be logged if DebugMode is enabled in the config
---@param msg string
---@param debug boolean
local function log(msg, debug)
    if debug and not config.DebugMode then
        return
    end
    print(string.format("[%s] %s\n", MOD_NAME, msg))
end

-- Listen for when a tadpole is spawned in the game and apply the speed multiplier
NotifyOnNewObject("/Game/Blueprints/Vehicle/BP_Tadpole.BP_Tadpole_C", function(ConstructedTadpole)
    ExecuteInGameThread(function()
        -- Cast the spawned object so VS can provide automcompletion for its properties and methods
        ---@cast ConstructedTadpole ABP_Tadpole_C

        log("Tadpole spawned. Applying speed multiplier...", true)

        ---@type UUWEMovementSetComponent
        local movementSet = ConstructedTadpole.MovementSetComponent
        if movementSet and movementSet:IsValid() then
            log("Found MovementSetComponent...", true)
            
            local baseSpeed = movementSet:GetBaseSwimSpeed()
            local maxSpeed = movementSet:GetMaxSwimSpeed()
        
            log("Base speed: " .. baseSpeed, true)
            log("Max speed: " .. maxSpeed, true)

            -- Apply the multiplier to the base speed
            movementSet:SetBaseSwimSpeed(baseSpeed * config.SpeedMultiplier)

            log("New base speed: " .. movementSet:GetBaseSwimSpeed(), true)
            log("New max speed: " .. movementSet:GetMaxSwimSpeed(), true)
        else
            log("Error: Could not find MovementSetComponent on the tadpole!", false)
        end
    end)
end)
