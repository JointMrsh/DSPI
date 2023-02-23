local DSPI = {}
local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("UserDataStore")

local function create_table(Player)
	local player_stats = {}
	for _, stat in pairs(Player.leaderstats:GetChildren()) do
		player_stats[stat.Name] = stat.Value
	end
	return player_stats

end



DSPI.SetAsync = function(Player, UserId) 
	local Player_Stats = create_table(Player)
	
	local success, err = pcall(function()
		DataStore:SetAsync(UserId, Player_Stats)
	end)
	
	if success then
		print("Successfully Asynced stats to "..UserId.."!")
	else
		print("Unable to Async stats for "..UserId..".")
	end
end

DSPI.GetAsync = function(UserId)
	local data = DataStore:GetAsync(UserId)
	return data
end

return DSPI
