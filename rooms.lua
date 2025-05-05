-- Directory for rooms
enemies = require "enemies"
mtEnemies = {}
setmetatable(enemies, mtEnemies)
local rooms = {}

-- Room types
FIGHT_ROOM = function()
	local randomIndex = math.random(1, #enemies)
	local randomEnemy = enemies[randomIndex]
	ACTIVE_ENEMY.name = randomEnemy.name
	ACTIVE_ENEMY.hp = randomEnemy.hp

	while(ACTIVE_ENEMY.hp > 0) do
		local activeEnemy = string.format(ENEMY_TEXT_EN, ACTIVE_ENEMY.name, ACTIVE_ENEMY.hp)
		print(activeEnemy)

		for i=1,#PLAYER.weapons do
			local weapon = PLAYER.weapons[i]
			local formattedString = string.format(WEAPON_TEXT_EN, i, weapon.name, weapon.damage, weapon.ap)
			print(formattedString)
			print(END_TURN_OPTION_EN)
		end

		while (currentAp > 0 and ACTIVE_ENEMY.hp > 0) do
			local option = io.read("*n")
			if (option == 0) then
				break
			end
			local weapon = PLAYER.weapons[option]
			if (currentAp >= weapon.ap) then
				weapon.exec()
			else
				print(WEAPON_AP_TEXT_EN)
			end
		end

		currentAp = PLAYER.ap
		ZONE_LEVEL_PROGRESS_BAR = ZONE_LEVEL_PROGRESS_BAR .. "x"
	end
		
	trigger_event(ON_ENEMY_KILLED, ACTIVE_ENEMY.name)
	print(CONTINUE_EN)
end

ENCOUNTER_ROOM = function()
	print("FOO\n")
end

-- Level 1 Rooms
ZOMBIE_ROOM = {
	name = "Zombie Room",
	flavor = "You see a Zombie in front of you!",
	exec = FIGHT_ROOM
}

TREASURE_ROOM = {
	name = "Treasure Room",
	flavor = "You encounter a room with gleaming treasure",
	exec = ENCOUNTER_ROOM
}

rooms.LEVEL_1 = { ZOMBIE_ROOM, TREASURE_ROOM, TREASURE_ROOM, TREASURE_ROOM }

return rooms
