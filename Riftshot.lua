-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "Barzil hub",
	LoadingTitle = "Riftshot",
	LoadingSubtitle = "Auto Bomb Remover",
	ConfigurationSaving = {
		Enabled = false
	}
})

local Tab = Window:CreateTab("Barzil", 4483362458)

Tab:CreateButton({
	Name = "TP Barzil",
	Callback = function()
		game:GetService("TeleportService"):Teleport(
			7234087065,
			game.Players.LocalPlayer
		)
	end
})


-- Variables
local AutoRiftshot = false
local folderName = "Sharpshooter Sam's Targets"
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- Bouton Riftshot TP
Tab:CreateButton({
	Name = "Riftshot TP",
	Callback = function()
		local target = workspace:FindFirstChild("Buildings") 
			and workspace.Buildings:FindFirstChild("Sharpshooter Sam's Island") 
			and workspace.Buildings["Sharpshooter Sam's Island"]:FindFirstChild("StartTargetPractice")
		if target then
			hrp.CFrame = target.CFrame
		end
	end
})

-- Toggle Auto Riftshot
Tab:CreateToggle({
	Name = "Auto Riftshot",
	CurrentValue = false,
	Flag = "AutoRiftshotToggle",
	Callback = function(Value)
		AutoRiftshot = Value

		task.spawn(function()
			while AutoRiftshot do
				local folder = workspace:FindFirstChild(folderName)
				if folder then
					for _, obj in ipairs(folder:GetChildren()) do
						if obj.Name == "Bomb" then
							pcall(function()
								obj:Destroy()
							end)
						end
					end
				end
				task.wait(0.1)
			end
		end)
	end
})

-- Petit texte Discord
Tab:CreateParagraph({
	Title = "Discord",
	Content = "find op scripts"
})

-- Bouton Join Discord
Tab:CreateButton({
	Name = "Join The Discord",
	Callback = function()
		setclipboard("https://discord.gg/YTAUARbbuj")

		Rayfield:Notify({
			Title = "Discord",
			Content = "Link copied to clipboard",
			Duration = 3
		})
	end
})
