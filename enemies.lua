-- Directory for Enemies
-- Enums
ZOMBIE_NAME_EN = "Zombie"
ZOMBIE_RAT_NAME_EN = "Zombie Rat"
ZOMBIE_LORD_NAME_EN = "Zombie Lord"

ZOMBIE_ATTACK_STRING_EN = "The Zombie attacks you for %d damage...\n"

-- Attack functions
-- Zombie attack
ZOMBIE_ATTACK_FUNC = function(min, max)
	local randomDmg = math.random(min, max)
	_G.PLAYER.health = _G.PLAYER.health - randomDmg
	local formattedString = string.format(ZOMBIE_ATTACK_STRING_EN, randomDmg)
	print(formattedString)
end

local enemies = {}

local ZOMBIE = {
	name = ZOMBIE_NAME_EN,
	hp = 5,
	attack = function() return ZOMBIE_ATTACK_FUNC(1, 3) end
}

table.insert(enemies, ZOMBIE)
enemies.ZOMBIE = ZOMBIE

local ZOMBIE_RAT = {
	name = ZOMBIE_RAT_NAME_EN,
	hp = 3,
	attack = function() return ZOMBIE_ATTACK_FUNC(1, 2) end
}

table.insert(enemies, ZOMBIE_RAT)
enemies.ZOMBIE_RAT = ZOMBIE_RAT

local ZOMBIE_LORD = {
	name = ZOMBIE_LORD_NAME_EN,
	hp = 14,
	attack = function() ZOMBIE_ATTACK_FUNC(4, 10) end
}

table.insert(enemies, ZOMBIE_LORD)
enemies.ZOMBIE_LORD = ZOMBIE_LORD

return enemies
