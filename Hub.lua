--[[
    PROJECT: AVATARHUNTER_HUB_ULTIMATE
    DEVELOPER: IHaveAvatarHunterSB
    STATUS: 2026 AI WORLD CUP WINNER
    THEME ENGINE: ACTIVATED
]]

-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window with Initial Theme
local Window = Rayfield:CreateWindow({
   Name = "🏆 AVATARHUNTER HUB | WORLD CUP EDITION",
   LoadingTitle = "Loading World Champion Suite...",
   LoadingSubtitle = "by IHaveAvatarHunterSB",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "AvatarHunterHub",
      FileName = "MainConfig"
   },
   KeySystem = false,
   Theme = "Default" -- Starting theme
})

-- Global Variables
local TargetPartName = ""
local PropertyValue = ""

-- [TAB 1: PART EDITOR]
local MainTab = Window:CreateTab("Part Editor", 4483362458)

MainTab:CreateInput({
   Name = "Target Part Name",
   PlaceholderText = "e.g. Part1",
   Callback = function(Text) TargetPartName = Text end,
})

MainTab:CreateInput({
   Name = "Property Value",
   PlaceholderText = "e.g. -100 or Neon",
   Callback = function(Text) PropertyValue = Text end,
})

-- Saving Logic Function
local function ApplyProperty(PropName, isNumber)
    if TargetPartName == "" or PropertyValue == "" then
        Rayfield:Notify({Title = "Error", Content = "Inputs cannot be empty!", Duration = 3})
        return
    end

    -- 3 Second Saving Animation with Notifications
    local SaveNotif = Rayfield:Notify({
        Title = "SYSTEM",
        Content = "Saving " .. PropName .. " .",
        Duration = 1,
    })
    task.wait(1)
    Rayfield:Notify({Title = "SYSTEM", Content = "Saving " .. PropName .. " ..", Duration = 1})
    task.wait(1)
    Rayfield:Notify({Title = "SYSTEM", Content = "Saving " .. PropName .. " ...", Duration = 1})
    task.wait(1)

    -- Remote Call
    local finalValue = isNumber and tonumber(PropertyValue) or PropertyValue
    local myObby = workspace.Obbies:FindFirstChild("IHaveAvatarHunterSB")
    local target = myObby and myObby.Items.Parts:FindFirstChild(TargetPartName)

    if target then
        game:GetService("ReplicatedStorage").Events.PaintObject:InvokeServer({[1] = target}, PropName, finalValue)
        Rayfield:Notify({Title = "SUCCESS", Content = "Set " .. PropName .. " Successfully!", Duration = 3})
    else
        Rayfield:Notify({Title = "FAIL", Content = "Part '"..TargetPartName.."' not found!", Duration = 3})
    end
end

MainTab:CreateSection("Apply Changes")
MainTab:CreateButton({Name = "SET REFLECTANCE", Callback = function() ApplyProperty("Reflectance", true) end})
MainTab:CreateButton({Name = "SET TRANSPARENCY", Callback = function() ApplyProperty("Transparency", true) end})
MainTab:CreateButton({Name = "SET MATERIAL", Callback = function() ApplyProperty("Material", false) end})

-- [TAB 2: THEME SETTINGS]
local ThemeTab = Window:CreateTab("Themes", 4483362458)

ThemeTab:CreateDropdown({
   Name = "Select Theme",
   Options = {"Default", "AmberGlow", "Amethyst", "Bloom", "Green", "Light", "Ocean", "Serenity"},
   CurrentOption = "Default",
   Callback = function(Option)
      Window:SetTheme(Option)
      Rayfield:Notify({Title = "Theme Updated", Content = "Switched to " .. Option, Duration = 2})
   end,
})

ThemeTab:CreateSection("Special Effects")

local RainbowEnabled = false
ThemeTab:CreateToggle({
   Name = "Rainbow Mode (RGB)",
   CurrentValue = false,
   Callback = function(Value)
      RainbowEnabled = Value
      task.spawn(function()
         while RainbowEnabled do
            local color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            -- Note: Rayfield doesn't natively rainbow the whole UI, 
            -- but we can notify the user of the vibe!
            task.wait(0.1)
         end
      end)
   end,
})

-- [TAB 3: CREDITS]
local CreditsTab = Window:CreateTab("Credits", 4483362458)
CreditsTab:CreateLabel("Avatar Hub")
CreditsTab:CreateLabel("Lead Developer: IHaveAvatarHunterSB")
CreditsTab:CreateLabel("UI Style: Rayfield Prestige")

Rayfield:LoadConfiguration()
