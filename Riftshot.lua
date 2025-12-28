-- Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "Riftshot",
	LoadingTitle = "Riftshot",
	LoadingSubtitle = "Auto Bomb Remover",
	ConfigurationSaving = {
		Enabled = false
	}
})

local Tab = Window:CreateTab("Riftshot", 4483362458)

-- Variables
local AutoRiftshot = false
local folderName = "Sharpshooter Sam's Targets"

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
						if obj.Name == "bomb" then
							pcall(function()
								obj:Destroy()
							end)
						end
					end
				end
				task.wait(0.1) -- petite pause pour pas spammer trop
			end
		end)
	end
})

-- Petit texte
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
