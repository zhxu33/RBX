local Rarity = {}

local MI = require(game.ReplicatedStorage.WeaponShop.ItemData)

RareItems = {
	["RFarmer_Midnight"] = 7214289854,
	["RCapsules"] = 7214289854,
	["RPurse"] = 7214295846,
	["RSemi_Respirator"] = 7214291679,
	["RFlashwear"] = 7214291071,
	["RMicrophone"] = 7214293763,
	["RDamascus_Steel"] = 7214293183,
	["RECM_Jammer"] = 7214292400,
	["RBackpack"] = 7214280332,
	["RBodyArmor"] = 7214287724,
	["RNomubrain"] = 7214294595,
	["RMNomubrain"] = 7214295218,
	["RBelt"] = 7214286965
}

function Rarity:GetRarity()
	
	if MI[self] and MI[self][1].Cost then
		return nil
	end
	
	if MI[self] and MI[self][1].Cost == nil then
		return "Event"
	end
	
	if self["Rare"] or self["Image"] == RareItems[self["Name"]] then
		return "RareLoot"
	end
	
	if self["Event"] then
		return "Event"
	end
	
	return nil
	
end

return Rarity