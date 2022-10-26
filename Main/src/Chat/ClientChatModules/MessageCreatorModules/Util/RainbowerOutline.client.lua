local pd = false
local colors = {
Color3.new(255/255,255/255,0/255),
Color3.new(0/255,255/255,0/255),
Color3.new(0/255,0/255,255/255),
Color3.new(144/255,0/255,255/255),
Color3.new(255/255,0/255,255/255),
Color3.new(255/255,0/255,0/255),
Color3.new(255/255,125/255,0/255),
}

local AllowedTags = {
	['Owner'] = true,
	['Developer'] = true,
	['Head Developer'] = true,
	['Exec Admin'] = true,
	['Head Admin'] = true,
	['Admin'] = true,
	['Moderator'] = true,
	['Trial Moderator']  = true
}

local color_num = 1

while wait() do
	if AllowedTags[script.Parent.Text] then
		script.Parent.TextStrokeColor3 = Color3.new(1,0,0)
		for i=1,15 do
			game:GetService("RunService").RenderStepped:wait()
			script.Parent.TextStrokeColor3 = Color3.new(script.Parent.TextStrokeColor3.r,script.Parent.TextStrokeColor3.g+(17/255),script.Parent.TextStrokeColor3.b)
		end
		for i=1,15 do
			game:GetService("RunService").RenderStepped:wait()
			script.Parent.TextStrokeColor3 = Color3.new(script.Parent.TextStrokeColor3.r-(17/255),script.Parent.TextStrokeColor3.g,script.Parent.TextStrokeColor3.b)
		end
		for i=1,15 do
			game:GetService("RunService").RenderStepped:wait()
			script.Parent.TextStrokeColor3 = Color3.new(script.Parent.TextStrokeColor3.r,script.Parent.TextStrokeColor3.g,script.Parent.TextStrokeColor3.b+(17/255))
		end
		for i=1,15 do
			game:GetService("RunService").RenderStepped:wait()
			script.Parent.TextStrokeColor3 = Color3.new(script.Parent.TextStrokeColor3.r,script.Parent.TextStrokeColor3.g-(17/255),script.Parent.TextStrokeColor3.b)
		end
		for i=1,15 do
			game:GetService("RunService").RenderStepped:wait()
			script.Parent.TextStrokeColor3 = Color3.new(script.Parent.TextStrokeColor3.r+(17/255),script.Parent.TextStrokeColor3.g,script.Parent.TextStrokeColor3.b)
		end
		for i=1,15 do
			game:GetService("RunService").RenderStepped:wait()
			script.Parent.TextStrokeColor3 = Color3.new(script.Parent.TextStrokeColor3.r,script.Parent.TextStrokeColor3.g,script.Parent.TextStrokeColor3.b-(17/255))
		end
	end
end