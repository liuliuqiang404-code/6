function SendMessage(message)
    local TextChatService = game:GetService("TextChatService")
    
    if TextChatService and TextChatService.TextChannels then
        local generalChannel = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if generalChannel then
            generalChannel:SendAsync(message)
            return true
        end
    end
    return false
end

function ChatMessage(message)
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    
    if localPlayer and localPlayer.Character then
        local head = localPlayer.Character:FindFirstChild("Head")
        if head then
            local ChatService = game:GetService("Chat")
            ChatService:Chat(head, message)
            return true
        end
    end
    return false
end

function TypeInChat(message)
    local Players = game:GetService("Players")
    local localPlayer = Players.LocalPlayer
    local PlayerGui = localPlayer:FindFirstChildOfClass("PlayerGui")
    
    if PlayerGui then
    
        virtualInput = game:GetService("VirtualInputManager")
        virtualInput:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        wait(0.1)
        
        -- 输入消息
        for i = 1, #message do
            local char = string.sub(message, i, i)
            virtualInput:SendKeyEvent(true, char, false, game)
            wait(0.01)
        end
        
        -- 再次按回车发送
        wait(0.1)
        virtualInput:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        return true
    end
    return false
end

-- 主函数 - 尝试所有方法
function Say(text)
    if not text or text == "" then return false end
    
    print("尝试发送消息: " .. text)
    
    -- 方法1: TextChatService
    if SendMessage(text) then
        print("✓ 通过TextChatService发送成功")
        return true
    end
    
    -- 方法2: 聊天服务
    if ChatMessage(text) then
        print("✓ 通过ChatService发送成功") 
        return true
    end
    
    -- 方法3: 模拟按键
    if TypeInChat(text) then
        print("✓ 通过模拟按键发送成功")
        return true
    end
    
    print("✗ 所有方法都失败了")
    return false
end

wait(2)
Say("有人使用刘某脚本")
wait(1)
Say("通通闪开😡😡")
print("聊天脚本加载完成")

-- 罗布乐思忍者注入器 - 双脚本加载器（完成后消失）
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 150)
frame.Position = UDim2.new(0.5, -110, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "忍者注入器"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = frame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0.9, 0, 0.2, 0)
status.Position = UDim2.new(0.05, 0, 0.25, 0)
status.BackgroundTransparency = 1
status.TextColor3 = Color3.fromRGB(255, 255, 255)
status.Text = "准备注入双脚本"
status.Font = Enum.Font.Gotham
status.TextSize = 14
status.Parent = frame

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.7, 0, 0.25, 0)
btn.Position = UDim2.new(0.15, 0, 0.5, 0)
btn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = "开始注入"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 14
btn.Parent = frame

local progress = Instance.new("TextLabel")
progress.Size = UDim2.new(0.9, 0, 0.2, 0)
progress.Position = UDim2.new(0.05, 0, 0.8, 0)
progress.BackgroundTransparency = 1
progress.TextColor3 = Color3.fromRGB(200, 200, 200)
progress.Text = "点击按钮开始"
progress.Font = Enum.Font.Gotham
progress.TextSize = 12
progress.Parent = frame

-- 注入函数
btn.MouseButton1Click:Connect(function()
    btn.Text = "注入中..."
    btn.BackgroundColor3 = Color3.fromRGB(120, 80, 0)
    btn.Active = false
    
    status.Text = "注入脚本1: 前置脚本"
    progress.Text = "第一阶段..."
    
    wait(1)
    --Kenny泛滥外部汉化脚本我的哔站UID:1531514159（删了这个死妈死爹死全家）
local Translations = {
    ["Close Window"] = "关闭窗口",
    ["Do you want to close this window?"]= "您要关闭此窗口吗？",
    ["You will not be able to open it again."]= "关闭后将无法再次打开。",
    ["Cancel"]= "取消",
    ["Close Window"]= "关闭窗口",
    ["Locked"] = "锁定",
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败:", err)
       
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then
                                local translatedText = translateText(text)
                                if translatedText ~= text then
                                    gui.Text = translatedText
                                    translated[gui] = true
                                end
                            end
                        end)
                    end
                end
            end
        end
        
        local function setupDescendantListener(parent)
            parent.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    task.wait(0.1)
                    pcall(function()
                        local text = descendant.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                descendant.Text = translatedText
                            end
                        end
                    end)
                end
            end)
        end
        
        pcall(setupDescendantListener, game:GetService("CoreGui"))
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerGui") then
            pcall(setupDescendantListener, player.PlayerGui)
        end
        
        while true do
            scanAndTranslate()
            task.wait(3)
        end
    end
end

task.wait(2)

setupTranslationEngine()

local success, err = pcall(function()
--这下面填加载外部脚本



end)

if not success then
    warn("加载失败:", err)
end
    -- 这里替换为实际脚本1
    -- loadstring(game:HttpGet("https://example.com/esp.lua"))()
    
    status.Text = "✓ 前置已加载"
    progress.Text = "第一阶段完成"
    
    wait(0.5)
    
    status.Text = "注入脚本2: 主脚本"
    progress.Text = "第二阶段..."
    
    wait(1)
    local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

WindUI:Localization({
    Enabled = true,
    Prefix = "loc:",
    DefaultLanguage = "zh",
    Translations = {
        ["zh"] = {
            ["WINDUI_EXAMPLE"] = "刘某脚本",
            ["WELCOME"] = "欢迎使用刘某脚本！",
            ["LIB_DESC"] = "十分好用的刘某脚本",
            ["SETTINGS"] = "设置",
            ["APPEARANCE"] = "外观",
            ["FEATURES"] = "功能",
            ["UTILITIES"] = "工具",
            ["UI_ELEMENTS"] = "UI 元素",
            ["CONFIGURATION"] = "配置",
            ["SAVE_CONFIG"] = "保存配置",
            ["LOAD_CONFIG"] = "加载配置",
            ["THEME_SELECT"] = "选择主题",
            ["TRANSPARENCY"] = "窗口透明度",
            ["CLOES WINDOW"] = "关闭窗口",
            ["DO YOU WAND TO CLOSE THIS WINDOW?"]= "您要关闭此窗口吗？",
            ["You will not be able to open it again."]= "关闭后将无法再次打开。",
            ["Cancel"]= "取消",
            ["Close Window"]= "关闭窗口",
            ["DEADRAIL"] = "死铁轨",
            ["DH"] = "死铁轨",
        }
    }
})

-- 创建金色主题
WindUI:AddTheme({
    Name = "GoldenTheme",
    Accent = Color3.fromHex("#FFD700"),      -- 金色主色调
    Dialog = Color3.fromHex("#2a2a2a"),
    Outline = Color3.fromHex("#FFA500"),     -- 橙色边框
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#888888"),
    Background = Color3.fromHex("#1a1a1a"),
    Button = Color3.fromHex("#4a3a1a"),      -- 金色系按钮
    Icon = Color3.fromHex("#FFD700")         -- 金色图标
})

WindUI.TransparencyValue = 0.2
WindUI:SetTheme("GoldenTheme")  -- 应用金色主题

local function gradient(text, startColor, endColor)
    local result = ""
    for i = 1, #text do
        local t = (i - 1) / (#text - 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        result = result .. string.format('<font color="rgb(%d,%d,%d)">%s</font>', r, g, b, text:sub(i, i))
    end
    return result
end

WindUI:Popup({
    Title = gradient("bu neng xie zhong wen zhi neng zhe yang", Color3.fromHex("#FFD700"), Color3.fromHex("#FFA500")),  -- 金色到橙色渐变
    Icon = "crown",
    Content = "loc:LIB_DESC",
    Buttons = {
        {
            Title = "开始使用",
            Icon = "arrow-right",
            Variant = "Primary",
            Callback = function() end
        }
    }
})

local Window = WindUI:CreateWindow({
    Title = "loc:WINDUI_EXAMPLE",
    Icon = "crown",
    Author = "loc:WELCOME",
    Folder = "WindUI_Example",
    Size = UDim2.fromOffset(700, 500),
    Theme = "Dark",  -- 使用金色主题
    User = {
        Enabled = true,
        Anonymous = false,
        Callback = function()
            WindUI:Notify({
                Title = "点这干啥",
                Content = "点了没有用",
                Duration = 3
            })
        end
    },
    SideBarWidth = 220,
    ScrollBarEnabled = true
})

-- 设置打开按钮为金色到橙色渐变
Window:EditOpenButton({
    Title = "打开刘某脚本",
    Icon = "crown",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("#FFD700"),  -- 金色
        Color3.fromHex("#FFA500")   -- 橙色
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({
    Title = "v1.0",
    Color = Color3.fromHex("#30ff6a")
})

Window:Tag({
    Title = "测试",
    Color = Color3.fromHex("#FFD700")  -- 金色标签
})

Window:CreateTopbarButton("theme-switcher", "moon", function()
    WindUI:SetTheme(WindUI:GetCurrentTheme() == "Dark" and "GoldenTheme" or "Dark")
    WindUI:Notify({
        Title = "主题已更改",
        Content = "当前主题: "..WindUI:GetCurrentTheme(),
        Duration = 2
    })
end, 990)

local Tabs = {
    Main = Window:Section({ Title = "loc:FEATURES", Opened = false }),
    Settings = Window:Section({ Title = "loc:SETTINGS", Opened = false }),
    Utilities = Window:Section({ Title = "loc:UTILITIES", Opened = false }),
}

local TabHandles = {
    Elements = Tabs.Main:Tab({ Title = "loc:UI_ELEMENTS", Icon = "layout-grid" }),
    Appearance = Tabs.Settings:Tab({ Title = "loc:APPEARANCE", Icon = "brush" }),
    Config = Tabs.Utilities:Tab({ Title = "loc:CONFIGURATION", Icon = "settings" }),
}

TabHandles.Elements:Paragraph({
    Title = "交互式组件",
    Desc = "探索 WindUI 的强大元素",
    Image = "component",
    ImageSize = 20,
    Color = "White",
})

TabHandles.Elements:Divider()

local toggleState = false
local featureToggle = TabHandles.Elements:Toggle({
    Title = "启用高级功能",
    Desc = "解锁额外功能",
    Value = false,
    Callback = function(state) 
        toggleState = state
        WindUI:Notify({
            Title = "功能状态",
            Content = state and "功能已启用" or "功能已禁用",
            Icon = state and "check" or "x",
            Duration = 2
        })
    end
})

local intensitySlider = TabHandles.Elements:Slider({
    Title = "效果强度",
    Desc = "调整效果强度",
    Value = { Min = -78, Max = 91, Default = 91 },
    Callback = function(value)
        print("强度设置为:", value)
    end
})

local modeDropdown = TabHandles.Elements:Dropdown({
    Title = "选择模式",
    Values = { "地鸡", "搞鸡", "砖加" },
    Value = "搞鸡",
    Callback = function(option)
        WindUI:Notify({
            Title = "模式已更改",
            Content = "已选择: "..option,
            Duration = 2
        })
    end
})

TabHandles.Elements:Divider()

TabHandles.Elements:Button({
    Title = "显示通知",
    Icon = "bell",
    Callback = function()
        WindUI:Notify({
            Title = "你好",
            Content = "这是一个通知",
            Icon = "bell",
            Duration = 3
        })
    end
})

TabHandles.Elements:Colorpicker({
    Title = "主题色",
    Desc = "更改 UI 主题色",
    Default = Color3.fromHex("#FFD700"),  -- 默认金色
    Callback = function(color)
        WindUI:Notify({
            Title = "颜色已更改",
            Content = "新主题色: "..color:ToHex(),
            Duration = 2
        })
    end
})

TabHandles.Appearance:Paragraph({
    Title = "自定义界面",
    Desc = "个性化您的体验",
    Image = "palette",
    ImageSize = 20,
    Color = "White"
})

local themes = {}
for themeName, _ in pairs(WindUI:GetThemes()) do
    table.insert(themes, themeName)
end
table.sort(themes)

local themeDropdown = TabHandles.Appearance:Dropdown({
    Title = "loc:THEME_SELECT",
    Values = themes,
    Value = "Dark",
    Callback = function(theme)
        WindUI:SetTheme(theme)
        WindUI:Notify({
            Title = "主题已应用",
            Content = theme,
            Icon = "crown",
            Duration = 2
        })
    end
})

local transparencySlider = TabHandles.Appearance:Slider({
    Title = "loc:TRANSPARENCY",
    Value = { 
        Min = 0,
        Max = 1,
        Default = 0.2,
    },
    Step = 0.1,
    Callback = function(value)
        Window:ToggleTransparency(tonumber(value) > 0)
        WindUI.TransparencyValue = tonumber(value)
    end
})

TabHandles.Appearance:Toggle({
    Title = "启用深色模式",
    Desc = "使用深色配色方案",
    Value = true,
    Callback = function(state)
        WindUI:SetTheme(state and "GoldenTheme" or "Light")
        themeDropdown:Select(state and "GoldenTheme" or "Light")
    end
})

TabHandles.Appearance:Button({
    Title = "创建新主题",
    Icon = "plus",
    Callback = function()
        Window:Dialog({
            Title = "创建主题",
            Content = "此功能即将推出！",
            Buttons = {
                {
                    Title = "确定",
                    Variant = "Primary"
                }
            }
        })
    end
})

TabHandles.Config:Paragraph({
    Title = "配置管理器",
    Desc = "保存和加载您的设置",
    Image = "save",
    ImageSize = 20,
    Color = "White"
})

local configName = "默认"
local configFile = nil
local MyPlayerData = {
    name = "玩家91",
    level = 1,
    inventory = { "78", "91", "大鸡吧" }
}

TabHandles.Config:Input({
    Title = "配置名称",
    Value = configName,
    Callback = function(value)
        configName = value
    end
})

local ConfigManager = Window.ConfigManager
if ConfigManager then
    ConfigManager:Init(Window)
    
    TabHandles.Config:Button({
        Title = "loc:SAVE_CONFIG",
        Icon = "save",
        Variant = "Primary",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            
            configFile:Register("featureToggle", featureToggle)
            configFile:Register("intensitySlider", intensitySlider)
            configFile:Register("modeDropdown", modeDropdown)
            configFile:Register("themeDropdown", themeDropdown)
            configFile:Register("transparencySlider", transparencySlider)
            
            configFile:Set("playerData", MyPlayerData)
            configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
            
            if configFile:Save() then
                WindUI:Notify({ 
                    Title = "loc:SAVE_CONFIG", 
                    Content = "已保存为: "..configName,
                    Icon = "check",
                    Duration = 3
                })
            else
                WindUI:Notify({ 
                    Title = "错误", 
                    Content = "保存配置失败",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })

    TabHandles.Config:Button({
        Title = "loc:LOAD_CONFIG",
        Icon = "folder",
        Callback = function()
            configFile = ConfigManager:CreateConfig(configName)
            local loadedData = configFile:Load()
            
            if loadedData then
                if loadedData.playerData then
                    MyPlayerData = loadedData.playerData
                end
                
                local lastSave = loadedData.lastSave or "未知"
                WindUI:Notify({ 
                    Title = "loc:LOAD_CONFIG", 
                    Content = "已加载: "..configName.."\n最后保存: "..lastSave,
                    Icon = "refresh-cw",
                    Duration = 5
                })
                
                TabHandles.Config:Paragraph({
                    Title = "玩家数据",
                    Desc = string.format("名称: %s\n等级: %d\n背包: %s", 
                        MyPlayerData.name, 
                        MyPlayerData.level, 
                        table.concat(MyPlayerData.inventory, ", "))
                })
            else
                WindUI:Notify({ 
                    Title = "错误", 
                    Content = "加载配置失败",
                    Icon = "x",
                    Duration = 3
                })
            end
        end
    })
else
    TabHandles.Config:Paragraph({
        Title = "配置管理器不可用",
        Desc = "此功能需要 ConfigManager",
        Image = "alert-triangle",
        ImageSize = 20,
        Color = "White"
    })
end

local footerSection = Window:Section({ Title = "WindUI " .. WindUI.Version })
TabHandles.Config:Paragraph({
    Title = "用心创造 ❤️",
    Desc = "刘某脚本牛逼",
    Image = "",
    ImageSize = 20,
    Color = "Grey",
    Buttons = {
        {
            Title = "复制链接",
            Icon = "copy",
            Variant = "Tertiary",
            Callback = function()
                setclipboard("刘某nb")
                WindUI:Notify({
                    Title = "已复制！",
                    Content = "已复制到剪贴板",
                    Duration = 2
                })
            end
        }
    }
})

local Tab = Window:Tab({
    Title = "简介",
    Icon = "crown",
    Locked = false,
    Opened = true,
})

local Button = Tab:Button({
    Title = "制作者",
    Desc = "刘某",
    Icon = "crown"
})

local Button = Tab:Button({
    Title = "合作者",
    Desc = "一眼鸡",
    Icon = "crown"
})

local Button = Tab:Button({
    Title = "QQ群",
    Desc = "1062180757",
    Icon = "crown"
})

local Paragraph = Tab:Paragraph({
    Title = "QQ群",
    Desc = "点击复制按钮获取QQ群",
    Color = "Red",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "crown",
            Title = "复制",
            Callback = function()
                local cardKey = "1062180757" 
                if setclipboard then
                    setclipboard(cardKey)
                    WindUI:Notify({
                        Title = "复制",
                        Content = "已复制到剪贴板: " .. cardKey,
                        Icon = "crown",
                        Duration = 5
                    })
                    print("已复制: " .. cardKey)
                else
                    WindUI:Notify({
                        Title = "错误",
                        Content = "复制功能不可用",
                        Icon = "crown",
                        Duration = 3
                    })
                end
            end,
        }
    }
})

local Tab = Window:Tab({
    Title = "通用",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "通用飞",
    Desc = "好用",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E9%A3%9E%E8%A1%8C%E8%84%9A%E6%9C%ACV3(%E5%85%A8%E6%B8%B8%E6%88%8F%E9%80%9A%E7%94%A8)%20(1).txt"))()
        WindUI:Notify({
            Title = "飞",
            Content = "飞行",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Slider = Tab:Slider({
    Title = "速度",
    Desc = "修改移速",
    Step = 1,
    Value = {
        Min = 0,
        Max = 100,
        Default = 16,
    },
    Callback = function(value)
        -- 修改移动速度
        local player = game.Players.LocalPlayer
        local character = player.Character
                WindUI:Notify({
            Title = "移动速度",
            Content = "已设置为: " .. value,
            Icon = "crown",
            Duration = 3
        })
        if character and character:FindFirstChildOfClass("Humanoid") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            humanoid.WalkSpeed = value
        end
        
        print(value)

-- 角色重生时自动重新应用速度设置
game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    wait(1) -- 等待角色完全加载
    if character:FindFirstChildOfClass("Humanoid") then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local currentValue = Slider:GetValue()
        humanoid.WalkSpeed = currentValue
    end
end)

-- 初始应用（如果已有角色）
if game.Players.LocalPlayer.Character then
    spawn(function()
        wait(1)
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local currentValue = Slider:GetValue()
            humanoid.WalkSpeed = currentValue
         end
     end)
  end
end
})

local Slider = Tab:Slider({
    Title = "跳跃高度",
    Desc = "修改跳跃高度",
    Step = 1,
    Value = {
        Min = 0,
        Max = 100,
        Default = 50,
    },
    Callback = function(value)
        -- 存储跳跃强度值
        _G.JumpIntensity = value
        
        -- 显示修改通知
        WindUI:Notify({
            Title = "跳跃高度",
            Content = "已设置为: " .. value,
            Icon = "crown",
            Duration = 3
        })
        
        print(value)
-- 监听跳跃事件
game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.JumpIntensity and _G.JumpIntensity > 50 then
        local player = game.Players.LocalPlayer
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local hrp = character.HumanoidRootPart
            local jumpForce = (_G.JumpIntensity - 50) * 2
            hrp.Velocity = Vector3.new(hrp.Velocity.X, jumpForce, hrp.Velocity.Z)
          end
       end
   end)
end
})

Slider:Lock()

local Toggle = Tab:Toggle({
    Title = "夜视",
    Desc = "夜视功能",
    Icon = "crown",
    Type = "Checkbox",
    Value = false, -- default value
    Callback = function(state) 
                 
    end
})

Toggle:Lock()

local Tab = Window:Tab({
    Title = "死铁轨",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "红叶汉化",
    Desc = "点完后点下面一个",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/stghongye.lua"))()
        WindUI:Notify({
            Title = "红叶子汉化",
            Content = "副包",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "红叶汉化",
    Desc = "点完这个就可以用了",
    Locked = false,
    Callback = function()
        script_key="这里填你的卡密";
(loadstring or load)(game:HttpGet("https://getnative.cc/script/loader"))()
        WindUI:Notify({
            Title = "红叶子汉化",
            Content = "主包",
            Icon = "crown",
            Duration = 3
        })
    end
})

Tab:Divider()

local Button = Tab:Button({
    Title = "v5刷债券",
    Desc = "点完后点下面一个",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader'))()
        WindUI:Notify({
            Title = "刷债券",
            Content = "要解卡",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "99夜",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "虚空",
    Desc = "汉化版",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/atnew2025/Chinese-scripts/refs/heads/main/voidware-cn.txt"))()
        WindUI:Notify({
            Title = "虚空汉化",
            Content = "好用",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "99夜无敌脚本",
    Desc = "汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/森林中的99夜.lua"))()
        WindUI:Notify({
            Title = "好用",
            Content = "汉化版",
            Icon = "crown",
            Duration = 3
        })
    end
})

Tab:Divider()

local Button = Tab:Button({
    Title = "老外脚本",
    Desc = "分界线里面的脚本卡密通用",
    Icon = "crown"
})

local Button = Tab:Button({
    Title = "99夜最无敌",
    Desc = "汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/99%E5%A4%9C%E6%B1%89%E5%8C%96.txt"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某汉化",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "99夜刷糖果",
    Desc = "要解卡",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://api.luarmor.net/files/v3/loaders/c87b3621b22ecc2c8b474f95c47ecb40.lua'))()
        WindUI:Notify({
            Title = "好用",
            Content = "要解卡",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "99夜刷砖石",
    Desc = "老外脚本",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet('https://api.luarmor.net/files/v3/loaders/8ee53a2a2e39163362c725415e1307ab.lua'))()
        WindUI:Notify({
            Title = "好用",
            Content = "要解卡",
            Icon = "crown",
            Duration = 3
        })
    end
})



Tab:Divider()

local Tab = Window:Tab({
    Title = "doors",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "doors",
    Desc = "汉化1",
    Locked = false,
    Callback = function()
          loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/VelocityX.lua"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某寻找",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Paragraph = Tab:Paragraph({
    Title = "上面的卡密",
    Desc = "点击复制按钮获取卡密",
    Color = "Red",
    Image = "",
    ImageSize = 30,
    Thumbnail = "",
    ThumbnailSize = 80,
    Locked = false,
    Buttons = {
        {
            Icon = "crown",
            Title = "复制",
            Callback = function()
                local cardKey = "VelocityXFreeDoorsKey" 
                if setclipboard then
                    setclipboard(cardKey)
                    WindUI:Notify({
                        Title = "卡密复制",
                        Content = "卡密已复制到剪贴板: " .. cardKey,
                        Icon = "crown",
                        Duration = 5
                    })
                    print("卡密已复制: " .. cardKey)
                else
                    WindUI:Notify({
                        Title = "错误",
                        Content = "复制功能不可用",
                        Icon = "crown",
                        Duration = 3
                    })
                end
            end,
        }
    }
})

local Button = Tab:Button({
    Title = "doors",
    Desc = "汉化2",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/atnew2025/Chinese-scripts/refs/heads/main/mshax(prohax).txt"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "doors",
    Desc = "汉化3",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://www.msdoors.xyz/script"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "doors",
    Desc = "汉化4",
    Locked = false,
    Callback = function()
          --[[Doors Blackking And BobHub脚本汉化]]loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
        WindUI:Notify({
            Title = "好用",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "内脏与黑火药",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "内脏与黑火药",
    Desc = "皮脚本",
    Locked = false,
    Callback = function()
        getgenv().XiaoPi="皮脚本-内脏与黑火药" loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\120\105\97\111\112\105\55\55\47\120\105\97\111\112\105\55\55\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\82\111\98\108\111\120\45\80\105\45\71\66\45\83\99\114\105\112\116\46\108\117\97"))()
        WindUI:Notify({
            Title = "中文",
            Content = "好用",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "脚本中心",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "皮脚本",
    Desc = "中文",
    Locked = false,
    Callback = function()
      getgenv().XiaoPi="皮脚本QQ群1002100032" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()  
        WindUI:Notify({
            Title = "无敌皮脚本",
            Content = "好用",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "战争大亨",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "战争大亨",
    Desc = "汉化",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E6%88%98%E4%BA%89%E5%A4%A7%E4%BA%A8%E6%B1%89%E5%8C%96"))()
        WindUI:Notify({
            Title = "刘某汉化",
            Content = "无敌",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "大78",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "黄某",
    Desc = "大78",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\46\99\111\109\47\67\78\72\77\47\67\104\105\110\101\115\101\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\233\187\132\230\159\144\232\135\170\229\138\168\230\177\137\229\140\150"))()
        WindUI:Notify({
            Title = "可以",
            Content = "78",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "偷走脑红",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "目前没有做",
    Desc = "若实在想玩，请向刘某反馈",
    Locked = false,
    Callback = function()
        WindUI:Notify({
            Title = "你点啥",
            Content = "说了没做",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "自然灾害",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "自然灾害",
    Desc = "无敌少侠飞",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
        WindUI:Notify({
            Title = "好玩",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "防坠落",
    Desc = "刘某",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E9%98%B2%E5%9D%A0%E8%90%BD2"))()
        WindUI:Notify({
            Title = "好用",
            Content = "可以",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Tab = Window:Tab({
    Title = "被打压怎么办",
    Icon = "crown",
    Locked = false,
})

local Button = Tab:Button({
    Title = "反击",
    Desc = "踢出所有人",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E8%B8%A2%E4%BA%BA"))()
        WindUI:Notify({
            Title = "猛攻",
            Content = "刘某",
            Icon = "crown",
            Duration = 3
        })
    end
})

local Button = Tab:Button({
    Title = "机甲变身",
    Desc = "机甲变身",
    Locked = false,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/liuliuqiang404-code/-/refs/heads/main/%E8%87%AA%E6%9D%80"))()
        WindUI:Notify({
            Title = "机甲变身",
            Content = "横扫千军",
            Icon = "crown",
            Duration = 3
        })
    end
})

Window:OnClose(function()
    print("窗口已关闭")
    
    if ConfigManager and configFile then
        configFile:Set("playerData", MyPlayerData)
        configFile:Set("lastSave", os.date("%Y-%m-%d %H:%M:%S"))
        configFile:Save()
        print("配置已在关闭时自动保存")
    end
end)

Window:OnDestroy(function()
    print("窗口已销毁")
end)
    status.Text = "✓ 主脚本已加载"
    progress.Text = "双脚本注入完成"
    btn.Text = "注入完成"
    btn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    
    -- 3秒后UI消失
    wait(2)
    screenGui:Destroy()
end)