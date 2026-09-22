-- example script by https://github.com/mstudio45/LinoriaLib/blob/main/Example.lua and modified by deivid
-- You can suggest changes with a pull request or something

local repo = "https://raw.githubusercontent.com/NightForRoblox/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles
local Sliders = Library.Sliders

Library.ForceCheckbox = false -- Forces AddToggle to AddCheckbox
Library.ShowToggleFrameInKeybinds = true -- Make toggle keybinds work inside the keybinds UI (aka adds a toggle to the UI). Good for mobile users (Default value = true)

local Window = Library:CreateWindow({
	-- Set Center to true if you want the menu to appear in the center
	-- Set AutoShow to true if you want the menu to appear when it is created
	-- Set Resizable to true if you want to have in-game resizable Window
	-- Set MobileButtonsSide to "Left" or "Right" if you want the ui toggle & lock buttons to be on the left or right side of the window
	-- Set ShowCustomCursor to false if you don't want to use the Linoria cursor
	-- NotifySide = Changes the side of the notifications (Left, Right) (Default value = Left)
	-- Position and Size are also valid options here
	-- but you do not need to define them unless you are changing them :)

	Title = "",
	Footer = "badnoli v1.0 [alpha] for Build A Boat For Treasure by @thedarli [CLOSE ON P]",
	Icon = 97249090324248,
  IconSize = UDim2.fromOffset(120, 61),
	NotifySide = "Right",
	ShowCustomCursor = true,
})

-- CALLBACK NOTE:
-- Passing in callback functions via the initial element parameters (i.e. Callback = function(Value)...) works
-- HOWEVER, using Toggles/Options.INDEX:OnChanged(function(Value) ... ) is the RECOMMENDED way to do this.
-- I strongly recommend decoupling UI code from logic code. i.e. Create your UI elements FIRST, and THEN setup :OnChanged functions later.

-- You do not have to set your tabs & groups up this way, just a prefrence.
-- You can find more icons in https://lucide.dev/
local Tabs = {
	-- Creates a new tab titled Main
	Main = Window:AddTab("Main", "home"),
	["UI Settings"] = Window:AddTab("UI Settings", "settings"),
}
local MovementGroupBox = Tabs.Main:AddLeftGroupbox("Movement / Lighting", "boxes")

local SpeedhackSpeed = nil
local SpeedhackActive = nil

MovementGroupBox:AddToggle("SpeedhackToggle", {
	Text = "Enable Speedhack",
	Tooltip = "speed like sonic bruh", -- Information shown when you hover over the toggle

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
			if Value == true then
				SpeedhackActive = true
				while task.wait(0.1) and SpeedhackActive do
					local hum = game.Players.LocalPlayer.Character.Humanoid
					hum.WalkSpeed = SpeedhackSpeed
				end
			else
				SpeedhackActive = false
			end
	end,
})

MovementGroupBox:AddSlider("SpeedhackSlider", {
    Text = "WalkSpeed:",
    Default = 16,
    Min = 16,
    Max = 500,
    Rounding = 1,
    Compact = false,
		Callback = function(Value)
				SpeedhackSpeed = Value
		end,
})

local JumpboostSpeed = nil
local JumpboostActive = nil

MovementGroupBox:AddToggle("SpeedhackToggle", {
	Text = "Enable Jumpboost",
	Tooltip = "jumping i love jumping", -- Information shown when you hover over the toggle

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
			if Value == true then
				JumpboostActive = true
				while task.wait(0.1) and JumpboostActive do
					local hum = game.Players.LocalPlayer.Character.Humanoid
					hum.JumpPower = JumpboostSpeed
				end
			else
				JumpboostActive = false
			end
	end,
})

MovementGroupBox:AddSlider("SpeedhackSlider", {
    Text = "JumpPower:",
    Default = 50,
    Min = 50,
    Max = 700,
    Rounding = 1,
    Compact = false,
		Callback = function(Value)
				JumpboostSpeed = Value
		end,
})

local FullbrightActive = nil

MovementGroupBox:AddToggle("Fullbright", {
	Text = "Enable Fullbright",
	Tooltip = "my eyes!", -- Information shown when you hover over the toggle

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
		if Value == true then
				FullbrightActive = true
				while task.wait(0.1) and FullbrightActive do
						local lighting = game:GetService("Lighting");
						lighting.Ambient = Color3.fromRGB(255, 255, 255);
						lighting.Brightness = 1;
						lighting.FogEnd = 1e10;
				end
			else
					FullbrightActive = false
					local lighting = game:GetService("Lighting");
					lighting.Ambient = Color3.fromRGB(80, 102, 175);
					lighting.Brightness = 1.5;
					lighting.FogEnd = 100000;
		end
	end,
})

local PlayerGroupBox = Tabs.Main:AddRightGroupbox("Player")

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local flying = false
local flySpeed = 15

local function startFlying()
    flying = true
    
 
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1000000, 1000000, 1000000)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart

 
    local userInputService = game:GetService("UserInputService")
    

    while flying do
        local moveDirection = Vector3.new(0, 0, 0)
        
        if userInputService:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
        end
        if userInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if userInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        bodyVelocity.Velocity = moveDirection * flySpeed
        wait(0.1)
    end
end


local function stopFlying()
    flying = false
    rootPart:FindFirstChild("BodyVelocity"):Destroy()
end

PlayerGroupBox:AddToggle("Fly", {
	Text = "Enable Fly",
	Tooltip = " 'wings' ", -- Information shown when you hover over the toggle

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
			if Value == true then
				startFlying()
			else
				stopFlying()
			end
	end,
})
	:AddKeyPicker("FlyKeybind", {
    Default = "F",
    Text = "Fly",
    Mode = "Toggle", -- Options: "Toggle", "Hold", "Always"

    -- Sets the toggle's value according to the keybind state if Mode is Toggle
    SyncToggleState = true,
		})
PlayerGroupBox:AddSlider("FlySlider", {
    Text = "FlySpeed:",
    Default = 15,
    Min = 5,
    Max = 200,
    Rounding = 1,
    Compact = false,
		
		Callback = function(Value)
			flySpeed = Value
		end,
})

local NoclipActive = nil

PlayerGroupBox:AddToggle("Noclip", {
	Text = "Noclip",
	Tooltip = "just noclip :)", -- Information shown when you hover over the toggle

	Default = false, -- Default value (true / false)
	Disabled = false, -- Will disable the toggle (true / false)
	Visible = true, -- Will make the toggle invisible (true / false)
	Risky = false, -- Makes the text red (the color can be changed using Library.Scheme.Red) (Default value = false)

	Callback = function(Value)
			if Value == true then
				NoclipActive = true 
				while task.wait(0.1) and NoclipActive == true do
					game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = false
					game.Players.LocalPlayer.Character.UpperTorso.CanCollide = false
					game.Players.LocalPlayer.Character.LowerTorso.CanCollide = false
				end
			else
				NoclipActive = false
					game.Players.LocalPlayer.Character.HumanoidRootPart.CanCollide = true
					game.Players.LocalPlayer.Character.UpperTorso.CanCollide = true
					game.Players.LocalPlayer.Character.LowerTorso.CanCollide = true
			end
	end,
})
	:AddKeyPicker("NoclipKeybind", {
    Default = "N",
    Text = "Noclip",
    Mode = "Toggle", -- Options: "Toggle", "Hold", "Always"

    -- Sets the toggle's value according to the keybind state if Mode is Toggle
    SyncToggleState = true,
		})

PlayerGroupBox:AddButton({
    Text = "ANTI-AFK Script",
		Tooltip = "by LUKELION2019",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZEXT512/AntiAfkXs/refs/heads/main/Anti"))()
    end
})

local ClientGroupBox = Tabs.Main:AddLeftGroupbox("Client", "boxes")

local value = 1
local name = "Bread"

local WarningClient = ClientGroupBox:AddLabel("CLIENT SIDE ONLY", false)
local WarningClient2 = ClientGroupBox:AddLabel("IGNORE 'USED' VALUES AND ", false)
local WarningClient3 = ClientGroupBox:AddLabel("XYZ BLOCKS", false)

local ItemDropdown = ClientGroupBox:AddDropdown("ItemDropdown", {
    Text = "Item Value",
    Values = game.Players.LocalPlayer.Data:GetDescendants(),
    Default = 1,
    Multi = false,
		Callback = function(Value)
			name = Value
		end
})

ClientGroupBox:AddInput("ValueInput", {
	Default = "1",
	Numeric = true, -- true / false, only allows numbers
	Finished = false, -- true / false, only calls callback when you press enter
	ClearTextOnFocus = false, -- true / false, if false the text will not clear when textbox focused

	Text = "Item Count",
	Tooltip = "", -- Information shown when you hover over the textbox

	Callback = function(Value)
			value = Value
	end,
})

ClientGroupBox:AddButton({
    Text = "Get Item",
    Func = function()

name.Value += value
    end
})

local AutoGroupBox = Tabs.Main:AddRightGroupbox("Automation", "boxes")

local WarningAuto = AutoGroupBox:AddLabel("IF NOT WORKING TRY TO", false)
local WarningAuto2 = AutoGroupBox:AddLabel("LOAD ALL LOCATIONS", false)
local WarningAuto2 = AutoGroupBox:AddLabel("ON MAP", false)

AutoGroupBox:AddButton({
    Text = "Auto Farm Script",
		Tooltip = "by cell0ph1ne",
    Func = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cell0ph1ne/Other_Scripts/refs/heads/main/Gold_Farming"))()
    end
})

local SecretsGroupBox = Tabs.Main:AddRightGroupbox("Secrets", "boxes")

SecretsGroupBox:AddButton({
    Text = "2021 Easter Event Place",
		Tooltip = "TP to 2021 Easter Event Place. Item can be getted: yes",
    Func = function()
	local TeleportService = game:GetService("TeleportService")
	local placeId = 1930863474
	local player = game.Players.LocalPlayer

	TeleportService:Teleport(placeId, player)
		end
})

SecretsGroupBox:AddButton({
    Text = "Unlock Event Items in Shop",
		Tooltip = "Only robux items can be getted.",
    Func = function()
        local eventsframe = game.Players.LocalPlayer.PlayerGui.ShopGui.MainFrame.TabFrame.ShopFrame.ScrollingFrameChests
				eventsframe.FrameEvent.Visible = true
				eventsframe.FrameEvent["+3 Egg Cannons"].Visible = true
				eventsframe.FrameEvent["+4 Cookie Wheels"].Visible = true
				eventsframe.FrameEvent["+5 Dragon Harpoons"].Visible = true
				eventsframe.FrameEvent["+5 Duel Harpoons"].Visible = true

				eventsframe.FrameEvent["+3 Egg Cannons"].Position = UDim2.new(0.190000027, 0, 0, 0)
    end
})

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "Open Keybind Menu",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
	end,
})
MenuGroup:AddToggle("ShowCustomCursor", {
	Text = "Custom Cursor",
	Default = true,
	Callback = function(Value)
		Library.ShowCustomCursor = Value
	end,
})
MenuGroup:AddDropdown("NotificationSide", {
	Values = { "Left", "Right" },
	Default = "Right",

	Text = "Notification Side",

	Callback = function(Value)
		Library:SetNotifySide(Value)
	end,
})
MenuGroup:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",

	Text = "DPI Scale",

	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)

		Library:SetDPIScale(DPI)
	end,
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
	:AddKeyPicker("MenuKeybind", { Default = "P", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- ThemeManager (Allows you to have a menu theme system)

-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- Adds our MenuKeybind to the ignore list
-- (do you want each config to have a different menu key? probably not.)
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
ThemeManager:SetFolder("MyScriptHub")
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:SetSubFolder("specific-place") -- if the game has multiple places inside of it (for example: DOORS)
-- you can use this to save configs for those places separately
-- The path in this script would be: MyScriptHub/specific-game/settings/specific-place
-- [ This is optional ]

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs["UI Settings"])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs["UI Settings"])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
