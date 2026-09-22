local players = game:GetService("Players")
local player = players.LocalPlayer
if not player then print("Character not found! Cannot load script") return end
local character = player.Character

local instance = game:GetObjects("rbxassetid://136794807969533")[1]
if not instance then print("Model not found! Cannot load script") return end

instance.Parent = player.PlayerGui
instance.main.Position = UDim2.new(0, 0, 0, 0)

task.wait(0.3)

instance.main.text.Text = "Identifying the game..."

-- accepted places

if player.PlayerGui then
	if game.PlaceId == 110258689672367 then
		task.wait(0.2)
		instance.main.text.Text = "The game is determined! Its: DOORS [HOTEL -]"
		task.wait(1)
		instance.main.text.Text = "Loading BADNOLI loadstring..."
		instance.main.ImageLabel.Image = "rbxassetid://97249090324248"

		loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/softnoli/refs/heads/main/badnoli/olddoors.lua"))()

		task.wait(0.3)
		instance.main.text.Text = "loadstring Loaded! Good luck with the game!"
		task.wait(1.3)
		instance:Destroy()
	end
	if game.PlaceId == 537413528 then
		task.wait(0.2)
		instance.main.text.Text = "The game is determined! Its: BABFT"
		task.wait(1)
		instance.main.text.Text = "Loading BADNOLI loadstring..."
		instance.main.ImageLabel.Image = "rbxassetid://97249090324248"

		loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/softnoli/refs/heads/main/badnoli/babft.lua"))()

		task.wait(0.3)
		instance.main.text.Text = "loadstring Loaded! Good luck with the game!"
		task.wait(1.3)
		instance:Destroy()
	end
	if game.PlaceId == 1930863474 then
		task.wait(0.2)
		instance.main.text.Text = "The game is determined! Its: BABFT [EASTER EVENT 2021]"
		task.wait(1)
		instance.main.text.Text = "Loading BADNOLI loadstring..."
		instance.main.ImageLabel.Image = "rbxassetid://97249090324248"

		loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/softnoli/refs/heads/main/badnoli/babfteasterevent.lua"))()

		task.wait(0.3)
		instance.main.text.Text = "loadstring Loaded! Good luck with the game!"
		task.wait(1.3)
		instance:Destroy()
	end
	if game.PlaceId == 1930866268 then
		task.wait(0.2)
		instance.main.text.Text = "The game is determined! Its: BABFT [2024 BUILD]"
		task.wait(1)
		instance.main.text.Text = "Loading BADNOLI loadstring..."
		instance.main.ImageLabel.Image = "rbxassetid://97249090324248"

		loadstring(game:HttpGet("https://raw.githubusercontent.com/Darli17/softnoli/refs/heads/main/badnoli/babft.lua"))()

		task.wait(0.3)
		instance.main.text.Text = "loadstring Loaded! Good luck with the game!"
		task.wait(1.3)
		instance:Destroy()
	end
	else
		task.wait(0.2)
		instance.main.text.Text = "Use softnoli in Supported Games."

		task.wait(3)
		instance:Destroy()
end
