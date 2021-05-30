local mt = getrawmetatable(game)
local old = mt.__index
setreadonly(mt, false)
mt.__index =
    newcclosure(
    function(k, v)
        if not checkcaller() and v == "WalkSpeed" then
            return 18
        end
        if not checkcaller() and v == "JumpPower" then
            return 40
        end
        
        return old(k, v)
    end
)
game:GetService("Players").LocalPlayer.Idled:connect(
    function()
        vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        print("Afk 15m")
    end
)

function GetListItem()
    local outt = {}
    local lis = game:GetService("Players").LocalPlayer.Backpack
    for k, v in pairs(lis:GetChildren()) do
        if v:IsA("Tool") then
            table.insert(outt, v.Name)
        end
    end
    return outt
end
function GetSlot()
    local Slot
    for k, v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Name == "Slot" then
            if v.Owner.Value == game.Players.LocalPlayer then
                Slot = v
            end
        end
    end
    return Slot
end
function ClaimSlot()
    local Slot
    for k, v in pairs(game.Workspace:GetChildren()) do
        if v:FindFirstChild("Owner") and v.Name == "Slot" then
            if v.Owner.Value == nil then
                firetouchinterest(v.Buttons.Claim.Nut, game.Players.LocalPlayer.Character.LeftFoot, 0)
            end
        end
    end
    return Slot
end
pcall(
    function()
        ClaimSlot()
    end
)
local speed = 18
local Jump = 40
local Zones = {"Cay", "Cay2"}
local Zone = "Cay"
local tool = ""
local Farm = false
local FarmMob = false
local toolmob = ""
local Slot

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kiet1308/DarkCyber/main/TurtleLib.lua"))()

local window = library:Window("Wood Farm")
local dropdown =
    window:Dropdown(
    "Sellect Zones",
    Zones,
    function(name)
        Zone = name
    end
)
local dropdown2 =
    window:Dropdown(
    "Sellect Weapeons",
    GetListItem(),
    function(name)
        tool = name
    end
)
window:Button(
    "Refress dropdown",
    function()
        dropdown2:NewList(GetListItem())
    end
)
window:Toggle(
    "Auto Farm",
    false,
    function(bool)
        Farm = bool
        --print(_G.AutoFarm)
    end
)

local window = library:Window("Mob Farm")
local dropdown2 =
    window:Dropdown(
    "Sellect Weapeons",
    GetListItem(),
    function(name)
        toolmob = name
    end
)
window:Button(
    "Refress dropdown",
    function()
        dropdown2:NewList(GetListItem())
    end
)
window:Toggle(
    "Mob Farm",
    false,
    function(bool)
        FarmMob = bool
        --print(_G.AutoFarm)
    end
)

local window = library:Window("Local Player")
window:Slider("Walk Speed",1,500,18, function(value)
    speed = value
end)
window:Slider("Jump Power",1,500,40, function(value)
    Jump = value
end)
spawn(function()
    while wait() do 
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then 
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed=speed
            game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower=Jump

        end
    end
end)


local noclip = false
game:GetService("RunService").Stepped:connect(
    function()
        if noclip then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(11)
        end
    end
)
--_G.AutoFarm = true
function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
end

spawn(
    function()
        while wait() do
            if Farm then
                wait()
                --print(tool)
                if
                    game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(tool) and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                 then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(tool)
                    )
                end
            end
        end
    end
)
spawn(
    function()
        while wait() do
            if FarmMob then
                wait()
                --print(tool)
                if
                    game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolmob) and
                        game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                 then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(
                        game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(toolmob)
                    )
                end
            end
        end
    end
)
spawn(
    function()
        repeat
            Slot = GetSlot()
            wait()
        until Slot ~= nil
    end
)
spawn(
    function()
        while wait() do
            if Farm and Slot ~= nil then
                wait()
                for dc, co in pairs(game:GetService("Workspace")[Zone]:GetChildren()) do
                    if Farm then
                        if co:IsA("MeshPart") then
                            local r = math.random()
                            co.Name = tostring(r)
                            local t = tick()
                            repeat
                                wait()
                                if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                        co.CFrame * CFrame.new(0, 0, 3)
                                end
                                Click()
                                noclip = true
                            until game:GetService("Workspace")[Zone]:FindFirstChild(tostring(r)) == nil or
                                tick() - t > 10 or
                                not Farm
                            noclip = false
                            for k, v in pairs(Slot.Tree:GetChildren()) do
                                if Farm then
                                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                                    end
                                    fireproximityprompt(v.ProximityPrompt, 3)

                                    local t = tick()
                                    repeat
                                        wait()
                                        fireproximityprompt(v.ProximityPrompt, 3)
                                    until game.Players.LocalPlayer.Character:FindFirstChild("Wood") or tick() - t > 2 or
                                        not Farm
                                    if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                            game:GetService("Workspace")["Hòn đảo đầu"]["Sell Path"].CFrame
                                    end
                                    --fireproximityprompt(game:GetService("Workspace")["Hòn đảo đầu"]["Sell Path"].ProximityPrompt,4)
                                    local t = tick()
                                    repeat
                                        wait()
                                        fireproximityprompt(
                                            game:GetService("Workspace")["Hòn đảo đầu"]["Sell Path"].ProximityPrompt,
                                            4
                                        )
                                    until game.Players.LocalPlayer.Character:FindFirstChild("Wood") == nil or
                                        tick() - t > 2 or
                                        not Farm
                                end
                            end
                        end
                    end
                end
            end
        end
    end
)
spawn(
    function()
        while wait() do
            if FarmMob then
                for k, v in pairs(game.Workspace.Golem:GetChildren()) do
                    if
                        v.Name == "Golem" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and
                            v.Humanoid.Health > 0
                     then
                        noclip = true

                        repeat
                            wait()
                            Click()
                            if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                                    v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            end
                        until v.Humanoid.Health == 0 or not FarmMob
                        noclip = false
                    end
                end
            end
        end
    end
)
