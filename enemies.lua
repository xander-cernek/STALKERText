-- Directory for Enemies
-- Enums
ZOMBIE_NAME_EN = "Zombie"

local enemies = {}

local ZOMBIE = {
	name = ZOMBIE_NAME_EN,
	hp = 5
}

table.insert(enemies, ZOMBIE)
enemies.ZOMBIE = ZOMBIE

return enemies
