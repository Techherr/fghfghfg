local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "RIGO HUB",
    LoadingTitle = "RIGO HUB THE BEST",
    LoadingSubtitle = "by Rigo",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Rigohubexample"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = true, -- Set this to true to use our key system
    KeySettings = {
       Title = "KEY SYSTEM",
       Subtitle = "Input key ",
       Note = "Go to https://pastebin.com/raw/gqWhLwZ0 for key",
       FileName = "RigoHubKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"https://pastebin.com/raw/gqWhLwZ0"%7D -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
    }
 })
