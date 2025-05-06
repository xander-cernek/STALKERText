-- Directory for rooms
local enemies = require "enemies"

local rooms = {}

-- Room types
FIGHT_ROOM = function()
	local randomIndex = math.random(1, #enemies)
	local randomEnemy = enemies[randomIndex]
	ACTIVE_ENEMY.name = randomEnemy.name
	ACTIVE_ENEMY.hp = randomEnemy.hp
	ACTIVE_ENEMY.attack = randomEnemy.attack

	while(ACTIVE_ENEMY.hp > 0) do
		local activeEnemy = string.format(ENEMY_TEXT_EN, ACTIVE_ENEMY.name, ACTIVE_ENEMY.hp)
		print(activeEnemy)

		for i=1,#_G.PLAYER.weapons do
			local weapon = _G.PLAYER.weapons[i]
			local formattedString = string.format(WEAPON_TEXT_EN, i, weapon.name, weapon.damage, weapon.ap)
			print(formattedString)
			print(END_TURN_OPTION_EN)
		end

		-- Player attack as long as they have action points (ap)
		while (currentAp > 0 and ACTIVE_ENEMY.hp > 0) do
			local option = io.read("*n")
			if (option == 0) then
				break
			end
			local weapon = _G.PLAYER.weapons[option]
			if (currentAp >= weapon.ap) then
				weapon.exec()
			else
				print(WEAPON_AP_TEXT_EN)
			end
		end

		-- Enemy attack
		randomEnemy.attack()

		currentAp = _G.PLAYER.ap
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
	flavor = "The stench of rotting flesh cursed by Radiation burns your nose.",
	exec = FIGHT_ROOM
}

TREASURE_ROOM = {
	name = "Treasure Room",
	flavor = "You encounter a room with gleaming treasure",
	exec = ENCOUNTER_ROOM
}

rooms.LEVEL_1 = { ZOMBIE_ROOM, TREASURE_ROOM, TREASURE_ROOM, TREASURE_ROOM }

return rooms
