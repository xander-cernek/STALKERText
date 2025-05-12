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
        os.execute("clear")
        local hudText = string.format(HUD_TEXT_EN, PLAYER.name, PLAYER.health, PLAYER.weight, PLAYER.value)
		print(hudText)
        if _G.PLAYER.health <= 0 then
            print("GAME OVER ... ")
            print("Press ENTER to exit")
            io.read()
            break
        end

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
	
    if (ACTIVE_ENEMY.hp <= 0) then
	    trigger_event(ON_ENEMY_KILLED, ACTIVE_ENEMY.name)
    end
	print(CONTINUE_EN)
end

ENCOUNTER_ROOM = function()
	print("Press 1 to grab the object.")
end

FOO = function()
end

NEXT_LEVEL = function()
    print("Not implemented")
end

-- Enter and Exit rooms
ENTER_ROOM = {
    name = "Entrance",
    flavor = "You stand at the entrance to the Zone. The heavy weight of sadness hangs in the air.\nThere is no turning back now, you must proceed...\n",
    exec = FOO
}

EXIT_ROOM = {
    name = "Stairs",
    flavor = "You find stairs leading downward, further into the Zone",
    exec = NEXT_LEVEL
}

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

rooms.LEVEL_1 = {
    ["START"] = {
        roomType = ENTER_ROOM,
        doors = {1}
    },
    [1] = {
        roomType = ZOMBIE_ROOM,
        doors = {2, 3}
    },
    [2] = {
        roomType = TREASURE_ROOM,
        doors = {1, 3, 4}
    },
    [3] = {
        roomType = ZOMBIE_ROOM,
        nextRooms = {1, 2, 4}
    },
    [4] = {
        roomType = TREASURE_ROOM,
        doors = {2, 3, 5} 
    },
    [5] = {
        roomType = EXIT_ROOM,
        doors = {EXIT_ROOM}
    }
}

return rooms
