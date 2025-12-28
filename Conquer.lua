-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "Conquer Glove",
	LoadingTitle = "Conquer Glove",
	LoadingSubtitle = "Auto Actions",
	ConfigurationSaving = {
		Enabled = false
	}
})

local Tab = Window:CreateTab("Conquer Glove", 4483362458)

-- Variables
local AutoConquer = false
local gameRef = game
local player = gameRef.Players.LocalPlayer

-- Toggle Auto Conquer
Tab:CreateToggle({
	Name = "Auto Conquer",
	CurrentValue = false,
	Flag = "AutoConquerToggle",
	Callback = function(Value)
		AutoConquer = Value

		if not AutoConquer then return end

		task.spawn(function()
			local character = player.Character or player.CharacterAdded:Wait()
			local humanoidr = character:WaitForChild("HumanoidRootPart")
			local ReplicatedStorage = gameRef:GetService("ReplicatedStorage")
			local Workspace = gameRef:GetService("Workspace")

			-- Finish NPC dialogue
			pcall(function()
				ReplicatedStorage.Remotes.Dialogue.FinishedNPCDialogue:FireServer()
			end)

			-- Click basket
			task.wait(2.5)
			pcall(function()
				fireclickdetector(
					Workspace.Map.Props.BasketCollection.Basket.ClickDetector
				)
			end)

			-- Auto slap (sans déplacement)
			gameRef:GetService("RunService").PostSimulation:Connect(function()
				if AutoConquer then
					pcall(function()
						ReplicatedStorage.Remotes.tool.use:FireServer("slap")
					end)
				end
			end)

			-- Auto slap squirrels
			Workspace.NPCs.DescendantAdded:Connect(function(squir)
				if not AutoConquer then return end
				if squir.Name == "squirrel" then
					local squirhr = squir:WaitForChild("HumanoidRootPart", 5)
					if not squirhr then return end
					while AutoConquer and squirhr.Parent do
						task.wait()
						pcall(function()
							ReplicatedStorage.Remotes.tool.hit:FireServer(
								"slap",
								{ Instance = squirhr }
							)
						end)
					end
				end
			end)

			-- Auto Conker
			Workspace.DescendantAdded:Connect(function(conk)
				if not AutoConquer then return end
				if conk.Name == "Conker" then
					local trans = conk:FindFirstChildOfClass("TouchTransmitter")
					if trans then
						pcall(function()
							firetouchinterest(conk, humanoidr, 0)
							firetouchinterest(conk, humanoidr, 1)
						end)
						task.delay(0.1, function()
							pcall(function()
								fireproximityprompt(
									Workspace.Map.CoreAssets.Bowl.ProximityPrompt
								)
							end)
						end)
					end
				end
			end)
		end)
	end
})
