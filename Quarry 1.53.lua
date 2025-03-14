---------------------------------------
-- Quarry: system version 1.53
-- Creator: Joseph51
-- Description: A program that creates a square hole down to bedrock
-- using the given size, S, making sides of 2(s)+1
--
-- Updates: Re-indented code and reformatted direction to numbers
-- rather than strings. Also improved efficiency of the code in 
-- the Forward function.
---------------------------------------

function Empty(rx, ry, rz, dir)
    local n = 1
    Relocate(r, 0, 2 * r + 1)
    Face(0)
    while n <= 16 do
        turtle.select(n)
        turtle.drop()
        n = n + 1
    end
    Relocate(rx, ry, rz)
    Face(dir)
    turtle.select(1)
end

function Red()
    ni, responce = rednet.receive()
    ni = nil
end

function Dig()
    turtle.digDown()
    if turtle.getItemCount(16) > 0 then
        Empty(x, y, z, Direction)
    end
    local endit = 0
    local bool = turtle.detectDown()
    while bool == true do
        turtle.digDown()
        bool = turtle.detectDown()
        endit = endit + 1
        if endit == 3 then
            bool = false
        end
    end
    local file = fs.open("Recovery.txt", "w")
    file.writeLine(r)
    file.writeLine(x)
    file.writeLine(y)
    file.writeLine(z)
    file.close()
    if endit == 3 then
        if loop then
            if (y % 2 == 0) then
                if (x == 2 * r) then
                    Up()
                    Up()
                    Up()
                else
                    Up()
                    Up()
                end
            elseif (x == 2 * r) then
                Up()
                Up()
            else
                Up()
                Up()
                Up()
            end
            loop = false
        else
            Relocate(r, 0, 2 * r + 1)
            Empty(x, y, z, Direction)
            os.shutdown()
        end
    end
end

function DigUp()
    turtle.digUp()
    if turtle.getItemCount(16) > 0 then
        Empty(x, y, z, Direction)
    end
    local endit = 0
    local bool = turtle.detectUp()
    while bool == true do
        turtle.digUp()
        bool = turtle.detectUp()
    end
end

function Face(n)
    if n == 3 then
        if (Direction == 1) then
            while Direction ~= 3 do
                Left()
            end
        elseif (Direction == 2) then
            while Direction ~= 3 do
                Right()
            end
        elseif (Direction == 0) then
            while Direction ~= 3 do
                Left()
            end
        end
    elseif n == 1 then
        if (Direction == 2) then
            while Direction ~= 1 do
                Left()
            end
        elseif (Direction == 0) then
            while Direction ~= 1 do
                Right()
            end
        elseif (Direction == 3) then
            while Direction ~= 1 do
                Right()
            end
        end
    elseif n == 2 then
        if (Direction == 3) then
            while Direction ~= 2 do
                Left()
            end
        elseif (Direction == 1) then
            while Direction ~= 2 do
                Right()
            end
        elseif (Direction == 0) then
            while Direction ~= 2 do
                Right()
            end
        end
    elseif n == 0 then
        if (Direction == 3) then
            while Direction ~= 0 do
                Right()
            end
        elseif (Direction == 1) then
            while Direction ~= 0 do
                Left()
            end
        elseif (Direction == 2) then
            while Direction ~= 0 do
                Right()
            end
        end
    end
end

function Relocate(tx, ty, tz)
    local tx = tonumber(tx)
    local ty = tonumber(ty)
    local tz = tonumber(tz)
    r = tonumber(r)
    while y < 0 do
        Up()
    end
    if (x == r * 1) and (y == 0) and (z == 2 * r + 1) then
        if tz < z then
            Face(3)
        elseif tz > z then
            Face(1)
        end

        while tz ~= z do
            Forward()
        end

        if tx < x then
            Face(2)
        elseif tx > x then
            Face(0)
        end

        while tx ~= x do
            Forward()
        end
    else
        if tx < x then
            Face(2)
        elseif tx > x then
            Face(0)
        end

        while tx ~= x do
            Forward()
        end

        if tz < z then
            Face(3)
        elseif tz > z then
            Face(1)
        end

        while tz ~= z do
            Forward()
        end
    end

    if ty < y then
        while ty ~= y do
            Down()
        end
    elseif ty > y then
        while ty ~= y do
            Up()
        end
    end
end

function Return()
    local n = 1
    Relocate(r, 0, 2 * r + 1)
    Face(0)
    while n <= 9 do
        turtle.select(n)
        turtle.drop()
        n = n + 1
    end
    Face(3)
end

function Right()
    turtle.turnRight()
    Direction = (Direction + 1) % 4
end

function Left()
    turtle.turnLeft()
    Direction = (Direction + 3) % 4
end

function Down()
    local bool = false
    local try = 0
    while bool == false do
        bool = turtle.down()
        if bool == true then
            y = y - 1
            move = move + 1
        else
            turtle.digDown()
            bool2 = turtle.detectDown()
            if bool2 == true then
                try = try + 1
            else
                turtle.attackDown()
            end
        end
        if try == 10 then
            return false
        end
    end
    return true
end

function Up()
    local bool = false
    while bool == false do
        bool = turtle.up()
        if bool == true then
            y = y + 1
            move = move + 1
        else
            turtle.digUp()
            if not turtle.detectUp() then
                turtle.attackUp()
            end
        end
    end
end

function Forward()
    local try = 1
    local bool = false
    while bool == false do
        bool = turtle.forward()
        if bool == true then
            -- Define a table to map direction to coordinate changes
            local directionChanges = {
                {1, 0},  -- Direction 0: +x
                {0, 1},  -- Direction 1: +z
                {-1, 0}, -- Direction 2: -x
                {0, -1}  -- Direction 3: -z
            }

            -- Update the coordinates based on the current direction
            x = x + directionChanges[Direction + 1][1]
            z = z + directionChanges[Direction + 1][2]
            move = move + 1
        else
            if (turtle.detect() and not turtle.dig()) then
                print("time to return!!!")
                print(move)
                Relocate(r, 0, 2 * r + 1)
                Empty(x, y, z, 3)
                fs.delete("Recovery.txt")
                local file = fs.open("Recovery.txt", "w")
                file.writeLine("How many times turtle moved:")
                file.writeLine(move)
                print("Turtle Moved " .. move .. " times.")
                file.close()
                os.shutdown()
            end
        end
        if not turtle.detect() then
            turtle.attack()
        end
    end
end

function Loop() -- Main loop (Runs 3 layers at a time)
    if (x % 2 == 0) then
        if (y % 2 == 0) then
            Face(1)
        elseif y % 2 == 1 then
            Face(3)
        end
    elseif (x % 2 == 1) then
        if (y % 2 == 0) then
            Face(3)
        elseif (y % 2 == 1) then
            Face(1)
        end
    end
    if (z == 2 * r) and (x == 2 * r) and (y % 2 == 0) then
        Dig()
        DigUp()
        local n = 0
        while n < 3 do
            if not loop then
                Face(3)
                return
            else
                Down()
                n = n + 1
            end
        end
        Dig()
        DigUp()
        Face(3)
        Forward()
        Dig()
        DigUp()
    elseif (z == 2 * r) and (x == 2 * r) and (y % 2 == 1) then
        Dig()
        DigUp()
        local n = 0
        while n < 3 do
            if not loop then
                Face(1)
                return
            else
                Down()
                n = n + 1
            end
        end
        Dig()
        DigUp()
        Face(1)
        Forward()
        Dig()
        DigUp()
    elseif (z == 0) and (x == 0) and (y % 2 == 1) then
        Dig()
        DigUp()
        Down()
        Down()
        Down()
        Dig()
        DigUp()
        Face(1)
        Forward()
        Dig()
        DigUp()
    end
    if (z == 2 * r) and (x % 2 == 0) then -- Turning after facing a wall
        if (y % 2 == 0) then
            Dig()
            Left()
            Forward()
            Left()
        elseif (y % 2 == 1) then
            Dig()
            Right()
            Forward()
            Right()
        end
    elseif (z == 2 * r) and (x % 2 == 1) then
        if (y % 2 == 1) then
            Dig()
            Right()
            Forward()
            Right()
            Dig()
            DigUp()
            Forward()
        end
    elseif (z == 0) and (x % 2 == 1) then
        if (y % 2 == 0) then
            Dig()
            Right()
            Forward()
            Right()
        elseif (y % 2 == 1) then
            Dig()
            Left()
            Forward()
            Left()
        end
    elseif (z == 0) and (x % 2 == 0) then
        if (y % 2 == 1) then
            Dig()
            Left()
            Forward()
            Left()
            Dig()
        end
    end
    Dig()
    DigUp()
    Forward()
end

function Loop2() -- Secondary loop (Runs 1 layer at a time)
    if (x % 2 == 0) then
        if (y % 2 == 0) then
            Face(1)
        elseif y % 2 == 1 then
            Face(3)
        end
    elseif (x % 2 == 1) then
        if (y % 2 == 0) then
            Face(3)
        elseif (y % 2 == 1) then
            Face(1)
        end
    end
    if (z == 2 * r) and (x == 2 * r) and (y % 2 == 0) then
        Dig()
        Down()
        Dig()
        Face(3)
        Forward()
        Dig()
    elseif (z == 2 * r) and (x == 2 * r) and (y % 2 == 1) then
        Dig()
        Down()
        Dig()
        Face(1)
        Forward()
        Dig()
    elseif (z == 0) and (x == 0) and (y % 2 == 1) then
        Dig()
        Down()
        Dig()
        Face(1)
        Forward()
        Dig()
    end
    if (z == 2 * r) and (x % 2 == 0) then -- Turning after facing a wall
        if (y % 2 == 0) then
            Dig()
            Left()
            Forward()
            Left()
        elseif (y % 2 == 1) then
            Dig()
            Right()
            Forward()
            Right()
        end
    elseif (z == 2 * r) and (x % 2 == 1) then
        if (y % 2 == 1) then
            Dig()
            Right()
            Forward()
            Right()
            Dig()
            Forward()
        end
    elseif (z == 0) and (x % 2 == 1) then
        if (y % 2 == 0) then
            Dig()
            Right()
            Forward()
            Right()
        elseif (y % 2 == 1) then
            Dig()
            Left()
            Forward()
            Left()
        end
    elseif (z == 0) and (x % 2 == 0) then
        if (y % 2 == 1) then
            Dig()
            Left()
            Forward()
            Left()
            Dig()
        end
    end
    Dig()
    Forward()
end

function End()
    print("time to return!!!")
    print(move)
    Relocate(r, 0, 2 * r + 1)
    Empty(x, y, z, 3)
    fs.delete("Recovery.txt")
    local file = fs.open("Recovery.txt", "w")
    file.writeLine("How many times turtle moved:")
    file.writeLine(move)
    print("Turtle Moved " .. move .. " times.")
    file.close()
    os.shutdown()
end

function Main()
    terminalMode = 0
    IsOn = true
    Slot = {}
    Direction = 3
    move = 0
    x, y, z = 0
    loop = true
    command = args[1]
    if IsOn == true then
        print("how big? ")
        if args[1] == nil then
            r = read()
            x = r + 0
            z = 2 * r + 1
            y = 0
        end
        if command == "Recover" then
            if (args[2] == "Mid") then
                r = tonumber(args[3])
                local ty = tonumber(args[4])
                if (ty % 2 == 1) then
                    Relocate(0, ty, 0)
                elseif (ty % 2 == 0) then
                    Relocate(2 * r, ty, 2 * r)
                else
                    print("Error occured in Recover Mode.")
                    IsOn = false
                    error()
                end
            end
            r = tonumber(args[2])
            x = r + 0
            z = 2 * r + 1
            y = 0
            print(y + 1)
            print("Recover")
            local tx = tonumber(args[3])
            local ty = tonumber(args[4])
            local tz = tonumber(args[5])
            print(tx, ty, tz)
            Relocate(tx, ty, tz)
            if (z == 2 * r) and (x == 2 * r) and (y % 2 == 1) then
                Dig()
                Face(3)
                Forward()
            elseif (z == 0) and (x == 0) and (y % 2 == 0) then
                Dig()
                Face(1)
                Forward()
            end
        elseif command == "Remote" then
            rednet.open("right")
            ni, r = rednet.receive()
            r = tonumber(r)
            print("r is: " .. r)
            x = r + 0
            z = 2 * r + 1
            y = 0
            Relocate(0, 0, 0)
            ni = nil
        else
            Relocate(0, 0, 0)
            Face(1)
            Dig()
            Forward()
        end
        print("ready")
        while IsOn == true do
            if red then
                local rez = parallel.waitForAny(Loop, Red)
                if rez == 2 then
                    num = 0
                    for i in string.gmatch(responce, "%S+") do
                        if num == 0 then
                            command = i
                        elseif num == 1 then
                            rez = i
                        end
                    end
                    num = num + 1
                end
                if command == "Sleep" then
                    print("Sleep: " .. rez .. " " .. tonumber(rez))
                    sleep(tonumber(rez))
                elseif command == "Return" then
                    Return()
                    IsOn = false
                end
            else
                while IsOn == true do
                    if loop then
                        Loop()
                    else
                        Loop2()
                    end
                end
            end
        end
    end
end

function Termin()
    while true do
        local event = os.pullEventRaw("terminate")
        local f = parallel.waitForAny(slep, Termed)
        if (f == 2) then
            break
        end
    end
end

function slep()
    sleep(30)
end

function Termed()
    local event = os.pullEventRaw("terminate")
end

function pass()
    t = read("*")
    if t == "Incorrect" then
        print("Access Granted.")
        sleep(2)
        term.clear()
        term.setCursorPos(1, 1)
        if fs.exists("safety.txt") then
            fs.delete("safety.txt")
        end
    else
        if (attempt > 2) then
            num = 1
        end
        attempt = attempt + 1
        print("Incorrect Login Details.")
        sleep(1)
        term.clear()
        term.setCursorPos(1, 1)
        print("Joe's Computer Security 1.1")
        print("UserName: Joe")
        write("Password: ")
        if (num < 1) then
            pass()
        else
        end
    end
end

function counter()
    print("You now have 30 seconds to input the correct password")
    local file = fs.open("safety.txt", "w")
    file.writeLine("OFF")
    file.close()
    local tem = parallel.waitForAny(slep, Termin, pass)
    if tem == 1 then
        Delete()
    elseif tem == 2 then
        print("Really? tried again???")
        sleep(2)
        Delete()
    elseif (num > 0) then
        term.clear()
        term.setCursorPos(1, 1)
        print("Too many attempts")
        sleep(1)
        Delete()
    else
        term.clear()
        term.setCursorPos(1, 1)
        print("Access Granted.")
        sleep(2)
    end
end

function Delete()
    term.clear()
    term.setCursorPos(1, 1)
    files = fs.list(".")
    for i = 1, #files do
        if files[i] ~= "rom" then
            fs.delete(files[i])
        end
    end
    print("All files have been deleted")
    error()
end

IsOn = true
red = false
double = true
term.clear()
term.setCursorPos(1, 1)
terminalMode = 0
Slot = {}
x, y, z = 0
move = 0
args = {...}
attempt = 1
num = 0
Main()
num = 0
responce = ""
if (tem == false) then
    term.clear()
    term.setCursorPos(1, 1)
    write("You tried to terminate")
    sleep(.5)
    write(".")
    sleep(.5)
    write(".")
    sleep(.5)
    write(".\n")
    sleep(1)
    counter()
end
os.shutdown()