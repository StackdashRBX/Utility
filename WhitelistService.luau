local WhitelistService = {ID = "bvT3BN7KFz"}

--// Services
local MarketplaceService = game:GetService("MarketplaceService")
local GroupService       = game:GetService("GroupService")
local HttpService        = game:GetService("HttpService")
local RunService         = game:GetService("RunService")

--// Methods
function WhitelistService:Init(Initializer: Script)
	local PlaceInfo = MarketplaceService:GetProductInfo(game.PlaceId)
	local PlayerId: number
	
	--//
	
	if (PlaceInfo.Creator.CreatorType == "Group") then
		PlayerId = GroupService:GetGroupInfoAsync(PlaceInfo.Creator.CreatorTargetId).Owner.Id
	else
		PlayerId = PlaceInfo.Creator.Id
	end
	
	--//
	
	if (RunService:IsStudio()) then
		warn("Stackdash products do not work in studio for security purposes. Publish the game instead.")
		Initializer:Destroy()
	end
	
	--//
	
	local Response = HttpService:RequestAsync({
		Url = 'http://api.onpointrblx.com/vendr/v2/licences/getlicence/roblox/'..PlayerId..'/'..self.ID..'/'..Initializer.Name,
		Method = "GET"
	})
	
	--//
	
	if not (Response.Success) then
		warn("API Response: ", Response)
	end
	
	--//
	
	return (Response.Status == 200) or Initializer:Destroy()
end

--//

return WhitelistService
