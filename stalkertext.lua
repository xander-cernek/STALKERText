--- STALKER v0.1 ---
--- REQUIRES ---
local guns = require "guns"
local rooms = require "rooms"

HUD_TEXT_EN = "===== %s's HUD =====\n=> Health: %d\n=> Pack weight: %d\n=> Pack value: %d\n"
LAB_TEXT_EN = "LABORATORY\n----------\nThe zone is a treacherous place, are you sure you want to continue?\n1. New Run\n2. Armory\n3. Logs\n"
ZONE_TEXT_EN_1 = "%s\n1. %s\n"

ZONE_LEVEL_PROGRESS_BAR = "."

ROOM_HEADER_EN = "-----== %s ==-----\n> %s\n"
ENEMY_TEXT_EN = "%s, Health: %d\n"
WEAPON_TEXT_EN = "%d: %s, Damage: %d, AP: %d\n"
WEAPON_AP_TEXT_EN = "You don't have enough AP for that action...\n"
END_TURN_OPTION_EN = "0: End turn\n"

ENEMY_KILLED_EN = "You killed %s!\n"
CONTINUE_EN = "Press 1 to continue\n"

events = {}

function register_event(event_name, handler)
	if not events[event_name] then
		events[event_name] = {}
	end
	table.insert(events[event_name], handler)
end

function trigger_event(event_name, ...)
	if events[event_name] then
		for _, handler in ipairs(events[event_name]) do
			handler(...)
		end
	end
end

-- Event keys
ON_ENEMY_KILLED = "enemy_killed_event"

-- Event functions
function OnEnemyKilled(enemyName)
	local enemyKilled = string.format(ENEMY_KILLED_EN, enemyName)
	print(enemyKilled)
end

-- Register events
register_event(ON_ENEMY_KILLED, OnEnemyKilled)

PLAYER = {
	name = "IRON HANDS",
	health = 10,
	weight = 0,
	value = 0,
	ap = 10,
	weapons = {}
}
currentAp = PLAYER.ap

ACTIVE_ENEMY = {
	name = "",
	hp = 0
}

-- LAB = 1
-- Zone = 2
-- Armory = 3
CURRENT_STATE = 1

while(true) do
	if (CURRENT_STATE == 1) then
		print(LAB_TEXT_EN)
		table.insert(PLAYER.weapons, guns.GUN_AK)
	end

	if (CURRENT_STATE == 2) then
		os.execute("clear")
		print(ZONE_LEVEL_PROGRESS_BAR)
		local hudText = string.format(HUD_TEXT_EN, PLAYER.name, PLAYER.health, PLAYER.weight, PLAYER.value)
		print(hudText)

		local randomIndex = math.random(1, #rooms.LEVEL_1)
		local room = rooms.LEVEL_1[randomIndex]
		local roomHeader = string.format(ROOM_HEADER_EN, room.name, room.flavor)
		print(roomHeader)
		rooms.LEVEL_1[randomIndex].exec()

		ZONE_LEVEL_PROGRESS_BAR = ZONE_LEVEL_PROGRESS_BAR .. "."
	end

	local option = io.read("*n")

	if (option == 1 and CURRENT_STATE == 1) then
		CURRENT_STATE = 2
	end
	if (option == 2 and CURRENT_STATE == 1) then
		CURRENT_STATE = 3
	end
end
