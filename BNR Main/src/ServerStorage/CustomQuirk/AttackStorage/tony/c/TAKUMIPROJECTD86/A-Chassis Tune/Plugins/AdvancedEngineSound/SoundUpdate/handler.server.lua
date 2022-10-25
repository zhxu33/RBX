local a = script.Parent.Parent.LowOn:Clone()
a.Parent = script.Parent.Parent.Parent.Parent.Parent.DriveSeat
a.SetRev:Destroy()
a.VolumeInfluence:Destroy()
a.Name = "LowOnServer"
local b = script.Parent.Parent.HighOn:Clone()
b.Parent = script.Parent.Parent.Parent.Parent.Parent.DriveSeat
b.SetRev:Destroy()
b.VolumeInfluence:Destroy()
b.Name = "HighOnServer"
local c = script.Parent.Parent.LowOn:Clone()
c.Parent = script.Parent.Parent.Parent.Parent.Parent.DriveSeat
c.Name = "LowOnClient"
local d = script.Parent.Parent.HighOn:Clone()
d.Parent = script.Parent.Parent.Parent.Parent.Parent.DriveSeat
d.Name = "HighOnClient"

local e = script.Parent.Parent.LowOff:Clone()
e.Parent = script.Parent.Parent.Parent.Parent.Parent.DriveSeat
e.SetRev:Destroy()
e.VolumeInfluence:Destroy()
e.Name = "LowOffServer"
local f = script.Parent.Parent.HighOff:Clone()
f.Parent = script.Parent.Parent.Parent.Parent.Parent.DriveSeat
f.SetRev:Destroy()
f.VolumeInfluence:Destroy()
f.Name = "HighOffServer"
local g = script.Parent.Parent.LowOff:Clone()
g.Parent = script.Parent.Parent.Parent.Parent.Parent.DriveSeat
g.Name = "LowOffClient"
local h = script.Parent.Parent.HighOff:Clone()
h.Parent = script.Parent.Parent.Parent.Parent.Parent.DriveSeat
h.Name = "HighOffClient"

game.SoundService.RespectFilteringEnabled = true

script.Parent.Parent = script.Parent.Parent.Parent.Parent.Parent



script.Parent.OnServerEvent:Connect(function(player,hnv,hnd,hnp,lnv,lnd,lnp, hfv,hfd,hfp,lfv,lfd,lfp)
if b.IsPlaying == false then
b:Play()
end
b.Volume = hnv
b.flange.Depth = hnd
b.Pitch = hnp
if a.IsPlaying == false then
a:Play()
end
a.Volume = lnv
a.flange.Depth = lnd
a.Pitch = lnp

if f.IsPlaying == false then
f:Play()
end
f.Volume = hfv
f.flange.Depth = hfd
f.Pitch = hfp
if e.IsPlaying == false then
e:Play()
end
e.Volume = lfv
e.flange.Depth = lfd
e.Pitch = lfp
end)

script.Parent.Parent.DriveSeat.ChildRemoved:Connect(function(ok)
a:Stop()
b:Stop()
c:Stop()
d:Stop()
e:Stop()
f:Stop()
g:Stop()
h:Stop()
end)