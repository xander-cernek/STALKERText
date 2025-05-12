-- ROOM GEN
ROOM_X = 75
ROOM_Y = 75

MIN_WIDTH = 5
MIN_HEIGHT = 5

MAX_WIDTH = 25
MAX_HEIGHT = 25

NUM_ROOMS = 6

rooms = {}

-- math.randomseed(os.time())

grid = {}
for y=1,ROOM_Y,1 do
    grid[y] = {}
    for x=1,ROOM_X,1 do
        grid[y][x] = ". "
    end
end

graph = {}

for i=1,NUM_ROOMS,1 do
    local width = math.random(MIN_WIDTH, MAX_WIDTH)
    local height = math.random(MIN_HEIGHT, MAX_HEIGHT)

    local randomX = math.random(1 + width, ROOM_X - width)
    local randomY = math.random(1 + width, ROOM_Y - width)

    local halfWidth = math.floor(width/2)
    local halfHeight = math.floor(height/2)

    for y=randomY-halfHeight,randomY+halfHeight,1 do
        for x=randomX-halfWidth,randomX+halfWidth,1 do
            if y < ROOM_Y and x < ROOM_X and y > 0 and x > 0 then
                if y==randomY-halfHeight or y==randomY+halfHeight or x==randomX-halfWidth or x==randomX+halfWidth then
                    grid[y][x] = string.format("%s ", i)
                else
                    grid[y][x] = ". "
                end
            end
        end
    end
    rooms[i] = {width=width, height=height, x=randomX, y=randomY}
end

-- Link rooms using graph
visited = {}

-- Find closest non visited room
function findClosestNonVisitedRoom(room)
    closestRoom = -1
    shortestDistance = ROOM_X * 10 -- No way the distance can be larger than this
    for k,v in ipairs(rooms) do
        if k ~= room and not visited[k] then
            distance = math.sqrt((v[x] - rooms[room][x]) ^ 2 + (v[y] - rooms[room][x]) ^ 2)
            if distance < shortestDistance then
                shortestDistance = distance
                closestRoom = k
            end
        end
    end
    if closestRoom == -1 then error("findClosestRoom: could not find any other non-visited rooms") end
    return closestRoom
end


-- Implement a queue
queue = {}
queue.first = 0
queue.last = -1
queue.data = {}

function insert(q, val)
    q.last = q.last + 1
    q.data[q.last] = val
end
function remove(q)
    if (q.first > q.last) then
        rval = -1
    else
        local rval = q.data[q.first]
        q.data[q.first] = nil
        q.first = q.first + 1
    end
    return rval
end
--

currentRoom = 1
visited[currentRoom] = true
insert(queue, currentRoom)
numVisited = 1
while numVisited < NUM_ROOMS do
    currentRoom = remove(queue)
    print(currentRoom)
    closestRoom = findClosestNonVisitedRoom(currentRoom)
    if not visited[closestRoom] then
        visited[closestRoom] = true
        numVisited = numVisited + 1
        insert(queue, closestRoom)
    end
end

-- Display map
for y=1,ROOM_Y,1 do
    for x=1,ROOM_X,1 do
        io.write(grid[y][x])
    end
    io.write("\n")
end
