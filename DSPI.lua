local Database = {}

local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local DATABASE_NAME = "UserData"

local function getPlayerStats(player)
    local stats = {}
    for _, stat in pairs(player.leaderstats:GetChildren()) do
        stats[stat.Name] = stat.Value
    end
    return stats
end

function Database:save(player)
    local success, result = pcall(function()
        local dataStore = DataStoreService:GetDataStore(DATABASE_NAME)
        local key = "Player_" .. player.UserId
        local stats = getPlayerStats(player)
        dataStore:SetAsync(key, stats)
    end)
    if success then
        print("Successfully saved data for player " .. player.Name)
    else
        print("Error saving data for player " .. player.Name .. ": " .. result)
    end
end

function Database:load(player)
    local success, result = pcall(function()
        local dataStore = DataStoreService:GetDataStore(DATABASE_NAME)
        local key = "Player_" .. player.UserId
        local stats = dataStore:GetAsync(key)
        if stats then
            for statName, statValue in pairs(stats) do
                if player.leaderstats:FindFirstChild(statName) then
                    player.leaderstats[statName].Value = statValue
                end
            end
        end
    end)
    if success then
        print("Successfully loaded data for player " .. player.Name)
    else
        print("Error loading data for player " .. player.Name .. ": " .. result)
    end
end

function Database:loadAllPlayers()
    local success, result = pcall(function()
        local dataStore = DataStoreService:GetDataStore(DATABASE_NAME)
        for _, player in pairs(Players:GetPlayers()) do
            local key = "Player_" .. player.UserId
            local stats = dataStore:GetAsync(key)
            if stats then
                for statName, statValue in pairs(stats) do
                    if player.leaderstats:FindFirstChild(statName) then
                        player.leaderstats[statName].Value = statValue
                    end
                end
            end
        end
    end)
    if success then
        print("Successfully loaded data for all players")
    else
        print("Error loading data for all players: " .. result)
    end
end

function Database:clear(player)
    local success, result = pcall(function()
        local dataStore = DataStoreService:GetDataStore(DATABASE_NAME)
        local key = "Player_" .. player.UserId
        dataStore:RemoveAsync(key)
    end)
    if success then
        print("Successfully cleared data for player " .. player.Name)
    else
        print("Error clearing data for player " .. player.Name .. ": " .. result)
    end
end

return Database
