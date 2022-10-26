local ContentProvider = game:GetService("ContentProvider")
local TweenService    = game:GetService("TweenService")
local PlayerService   = game:GetService("Players")

local LoadingScreen   = script:WaitForChild("LoadingScreen")
local AssetMessage    = LoadingScreen:WaitForChild("Frame"):WaitForChild("AssetMessage")
local Player          = PlayerService.LocalPlayer

LoadingScreen.IgnoreGuiInset = true
LoadingScreen.Enabled        = true
LoadingScreen.Parent         = Player:WaitForChild("PlayerGui", 10)
script.Parent:RemoveDefaultLoadingScreen()

local DecalAssets = {
	"rbxassetid://2260429633",
	"rbxassetid://2419731865",
	"http://www.roblox.com/asset/?id=7153771709",
	"http://www.roblox.com/asset/?id=7153793000",
	"http://www.roblox.com/asset/?id=7153792557",
	"http://www.roblox.com/asset/?id=7174482585",
	"http://www.roblox.com/asset/?id=7163731574",
	"http://www.roblox.com/asset/?id=7184379235",
	"http://www.roblox.com/asset/?id=7177528239",
	"http://www.roblox.com/asset/?id=7177363776",
	"http://www.roblox.com/asset/?id=7177337916",
	"http://www.roblox.com/asset/?id=7137507662",
	"http://www.roblox.com/asset/?id=7174302674",
	"http://www.roblox.com/asset/?id=7174207840",
	"http://www.roblox.com/asset/?id=7174204558",
	"http://www.roblox.com/asset/?id=7174205730",
	"http://www.roblox.com/asset/?id=7174203285",
	"http://www.roblox.com/asset/?id=7174204002",
	"http://www.roblox.com/asset/?id=7163969255",
	"http://www.roblox.com/asset/?id=4538051032",
	"http://www.roblox.com/asset/?id=7241561384",
	"http://www.roblox.com/asset/?id=7245368914",
	"rbxassetid://7246404528",
	"rbxassetid://7245970564",
	"rbxassetid://7246405271",
	"rbxassetid://7245976600",
	"rbxassetid://7246406769",
	"rbxassetid://7245979327",
	"rbxassetid://7245898966",
	"rbxassetid://7245900585",
	"rbxassetid://7245901789",
	"rbxassetid://3570695787",
	"http://www.roblox.com/asset/?id=7163726141",
	"http://www.roblox.com/asset/?id=7163722021",
	"http://www.roblox.com/asset/?id=7162979258",
	"http://www.roblox.com/asset/?id=7162915132",
	"http://www.roblox.com/asset/?id=7162907884",
	"http://www.roblox.com/asset/?id=7162874877",
	"http://www.roblox.com/asset/?id=7164036843",
	"http://www.roblox.com/asset/?id=7163941747",
	"http://www.roblox.com/asset/?id=7163922662",
	"http://www.roblox.com/asset/?id=7138054291",
	"http://www.roblox.com/asset/?id=7137920511",
	"http://www.roblox.com/asset/?id=7137906454",
	"http://www.roblox.com/asset/?id=7137888803",
	"http://www.roblox.com/asset/?id=7137691206",
	"http://www.roblox.com/asset/?id=7167772853",
	"http://www.roblox.com/asset/?id=7164579331",
	"http://www.roblox.com/asset/?id=7236391730",
	"rbxassetid://2424191126",
	"http://www.roblox.com/asset/?id=7194675078",
	"http://www.roblox.com/asset/?id=7200263801",
	"rbxasset://textures/ui/GuiImagePlaceholder.png",
	"rbxassetid://7255363098",
	"http://www.roblox.com/asset/?id=7167679326",
	"http://www.roblox.com/asset/?id=7194494960",
	"http://www.roblox.com/asset/?id=7194432814",
	"rbxassetid://7194432814",
	"http://www.roblox.com/asset/?id=7154416006",
	"http://www.roblox.com/asset/?id=7154414428",
	"http://www.roblox.com/asset/?id=7148874348",
	"http://www.roblox.com/asset/?id=7154286362",
	"http://www.roblox.com/asset/?id=7153949639",
	"http://www.roblox.com/asset/?id=7154494671",
	"http://www.roblox.com/asset/?id=7154393099",
	"rbxassetid://7618383243",
	"rbxassetid://7618384056",
	"http://www.roblox.com/asset/?id=7237336346",
	"http://www.roblox.com/asset/?id=7132487675",
	"http://www.roblox.com/asset/?id=7133813619",
	"http://www.roblox.com/asset/?id=7132500235",
	"http://www.roblox.com/asset/?id=7132575942",
	"rbxassetid://7142594170",
	"http://www.roblox.com/asset/?id=7142482884",
	"http://www.roblox.com/asset/?id=7148552547",
	"http://www.roblox.com/asset/?id=7142526422",
	"http://www.roblox.com/asset/?id=7142817036",
	"http://www.roblox.com/asset/?id=7225141812",
	"http://www.roblox.com/asset/?id=7256012861",
	"http://www.roblox.com/asset/?id=5128121591",
	"rbxasset://textures/ViewSelector/face_arrow.png",
	"rbxassetid://233055147",
	"rbxasset://textures/StudioUIEditor/valueBoxRoundedRectangle.png",
	"rbxasset://textures/StudioUIEditor/resizeHandleDropShadow.png",
	"rbxassetid://1877759375",
	"rbxassetid://1544599127",
	"rbxassetid://1544328047",
	"http://www.roblox.com/asset/?id=67822829",
	"rbxassetid://134531274",
	"rbxassetid://36949810",
	"rbxassetid://2137752027",
	"rbxassetid://2506521948",
	"rbxassetid://2506521954",
	"rbxassetid://2506521962",
	"http://www.roblox.com/asset/?id=319845979",
	"rbxassetid://719866611",
	"http://www.roblox.com/asset/?id=180354115",
	"http://www.roblox.com/asset/?id=171347906",
	"http://www.roblox.com/asset/?id=72808461",
	"http://www.roblox.com/asset/?id=194960409",
	"rbxassetid://1744324588",
	"rbxassetid://1725903493",
	"rbxassetid://1725899460",
	"rbxassetid://1744344042",
	"rbxassetid://1725899752",
	"rbxassetid://1725900239",
	"rbxassetid://719866584",
	"rbxassetid://719866601",
	"rbxassetid://241837157",
	"rbxassetid://97166444",
	"http://www.roblox.com/asset/?id=7236558957",
	"http://www.roblox.com/asset/?id=7236953619",
}


local LoadingImages = {
	"http://www.roblox.com/asset/?id=2590704964",
	"rbxassetid://8274413023",
	"rbxassetid://8274418005",
	"rbxassetid://8274419924",
	"rbxassetid://8274421628",
	"rbxassetid://8274423731",
	"rbxassetid://8274425230",
	"rbxassetid://8274426719",
	"rbxassetid://8274428026",
	"rbxassetid://8274429973",
	"rbxassetid://8275098024",
}

local LoadingTips   = {
	"Deku's one for all requires: level 5,000, Quirkless and 50,000 positive fame.",
	"You can acquire Deku's one for all after talking to Deku",
	"Tomuras's all for one requires: level 5,000, Decay and 50,000 negative fame.",
	"You can acquire Tomuras's all for one after talking to Dr. Ujiko",
	"Lost? You can find out where you are in the mini-map, check Menu -> Options.",
	"You can enter raids when you reach level 1,000.",
	"Boss NPCs don't have quests, so farm all you want.",
	"You can spin for quirks by talking to the doctors in the hospital.",
	"There are 38 different quirks!",
	"You can get fame specific titles, found in your Menu -> Options.",
	"You can acquire daily logins from Nezu (If you're a hero) and Kurogiri (If you're a villain).",
	"Rules can be found in-game, check the [?] tab.",
	"Don't know the quirk chances? They're located in the [?] section.",
	"Green is coolest!",
	"Talking to Cementoss will take you to the raid & pvp lobby.",
	"Codes and game related content may be found on our socials. Ex: Twitter.",
	"Make sure to check whether you have the required stats for quirk moves!",
	"Curious on what moves the quirk you're using has? Check under the [Skills] tab in your menu.",
	"AFK Farming is NOT allowed.",
	"Some heroes and villains drop loot!",
	"Quest rewards can be amplified based on your fame count! (Maximum of 3x)",
	"UwU",
	"PVP protection is automatically disabled after reaching level 500.",
	"In need of a weapon? Check out Mei Hatsume's workshop, just across the shopping district.",
	"Low level? Farm in the gym located next to spawn.",
	"Having a legendary below level 1,000 is highly unrecommended.",
	"The max level is currently 15,000.",
	"Mythical Quirks are not obtainable in spins.",
	"Max speed caps at 2,000 Agility.",
	"You can sprint with pressing [Left Shift] or on mobile the [Shift] button.",
	"Codes can be redeemed in the options page of the menu.",
	"Event weapons are unobtainable after the event has passed.",
	"In order to gain rank in the pvp lobby, you need to win a ranked match.",
	"Drop rates for loot items are: 5% for normal, 0.025% for rare.",
}

local isLoading       = false
local finishedLoading = false

LoadingScreen.Frame.Skip.MouseButton1Down:Connect(function()
	finishedLoading       = true
	LoadingScreen.Enabled = false
	script:Destroy()
end)


local MaxTime = tick() + 120
local NumberOfAssets = 0

task.spawn(function()
	while (isLoading or LoadingScreen.Enabled) and (MaxTime - tick() > 0) do
		task.wait(1)
	end

	finishedLoading = true
	if LoadingScreen then
		LoadingScreen.Enabled = false
	end
	script:Destroy()
end)

ContentProvider:PreloadAsync(LoadingScreen.Frame:GetChildren(), function(Id, Status)
	if Status == Enum.AssetFetchStatus.Failure then
		warn(Id .. "has failed to load properly." .. " [Decal Assets]")
	end
end)

task.spawn(function()
	local LastQuote = LoadingTips[math.random(1,   #LoadingTips)]
	local LastImage = LoadingScreen.Frame[LoadingImages[math.random(1, #LoadingImages)]]
	local textTip   = LoadingScreen.Frame.TipsLabel
	textTip.Text = LastQuote
	
	for _, image in ipairs(LoadingScreen.Frame:GetChildren()) do
		if not (image:IsA("ImageLabel") and image ~= LastImage) then continue end
		image.ImageTransparency = 1
	end
	
	while task.wait(3.25) and not finishedLoading do
		local newQuote
		repeat
			newQuote = LoadingTips[math.random(1, #LoadingTips)]
			task.wait()
		until LastQuote ~= newQuote or #LoadingTips <= 1

		textTip.Text = "Tip: " .. (newQuote or LastQuote)
			
		task.wait(3.25)
		isLoading = true		
		
		local newImage
		repeat
			newImage = LoadingScreen.Frame:FindFirstChild(LoadingImages[math.random(1, #LoadingImages)])
			task.wait()
		until LastImage ~= newImage or #LoadingImages <= 1
		
		local tween2 = TweenService:Create(LastImage, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {ImageTransparency = 1})
		local tween  = TweenService:Create(newImage, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {ImageTransparency = 0})
		
		tween:Play()
		tween2:Play()
		tween2.Completed:Wait()
		
		newQuote = nil
		repeat
			newQuote = LoadingTips[math.random(1, #LoadingTips)]
			task.wait()
		until LastQuote ~= newQuote or #LoadingTips <= 1
		
		LastImage = newImage

		textTip.Text = "Tip: " .. (newQuote or LastQuote)
		isLoading    = false
	end
end)

ContentProvider:PreloadAsync(DecalAssets, function(Id, Status)
	if Status == Enum.AssetFetchStatus.Failure then
		warn(Id .. " has failed to load properly." .. " [Decal Assets]")
	end
	
	NumberOfAssets+=1
	AssetMessage.Text = "Loading assets, please wait. "..NumberOfAssets.." loaded!"
end)

AssetMessage.Text = "Waiting for world to load. . ."
workspace:WaitForChild("NewOrganized")

task.spawn(function()
	local SkipButton   = LoadingScreen:WaitForChild("Frame"):WaitForChild("Skip")
	local PerfectName  = workspace:WaitForChild("S1c2R5i66p5t5s51")

	local LoadedParent = PerfectName:WaitForChild("PlayerData", 120):WaitForChild(Player.Name, 120)
	LoadedParent:WaitForChild("Loaded", 120)

	SkipButton.Visible = true
	TweenService:Create(SkipButton, TweenInfo.new(1, Enum.EasingStyle.Linear), {TextTransparency = 0}):Play()
	TweenService:Create(SkipButton.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Linear), {Transparency = 0}):Play()
end)

AssetMessage.Text = "Loading assets, please wait. "..NumberOfAssets.." loaded!"

local assets = {}
for index, child:Instance in pairs(Player.PlayerGui:GetDescendants()) do
	if child:IsA("GuiObject") then
		table.insert(assets, child)
	end
end

ContentProvider:PreloadAsync(assets, function(object, status)
	if status == Enum.AssetFetchStatus.Failure then
		warn(object .. " has failed to load properly." .. " [GUI Assets]")
	end
	
	NumberOfAssets+=1
	AssetMessage.Text = "Loading assets, please wait. "..NumberOfAssets.." loaded!"
end)

AssetMessage.Text = "Important assets have loaded!"

repeat
	task.wait(1)
	AssetMessage.Text = ("Downloading %d game assets. [Optional & not recommended to wait this long]")
until finishedLoading or ContentProvider.RequestQueueSize <= 50

finishedLoading       = true
LoadingScreen.Enabled = false
script:Destroy()