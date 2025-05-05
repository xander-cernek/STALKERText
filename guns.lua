-- Directory for Guns
-- Enums
RIFLE_EN = "Rifle"
PISTOL_EN = "Pistol"
SNIPER_EN = "Sniper"
SUBMACHINE_EN = "Submachine"
WONDER_EN = "Wonder"

local guns = {}

local GUN_AK = {
	name = "AK-47",
	damage = 2,
	ap = 4,
	classification = RIFLE_EN,
	exec = function()
		print("Shooting AK-47")
		ACTIVE_ENEMY.hp = ACTIVE_ENEMY.hp - 2
		currentAp = currentAp - 4
	end
}

table.insert(guns, GUN_AK)
guns.GUN_AK = GUN_AK

return guns
