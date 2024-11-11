--Direction functions
function left()
turtle.turnLeft()
end

function right()
turtle.turnRight()
end

function turn()
right()
right()
end

function down()
while not turtle.down() do turtle.digDown() end
end

function forward()
while not turtle.forward() do
if turtle.detect() then
turtle.dig()
else
turtle.attack()
end
end
end

function up()
while not turtle.up() do
if turtle.detectUp() then
turtle.digUp()
else
turtle.attackUp()
end
end
end

--World interaction functions
function Select(x)
turtle.select(x)
end
function place(slot)
local ps=s
Select(slot)
while not turtle.place() do turtle.dig() end
Select(ps)
end
function pdown(slot)--Same as place(slot), but downward
local ps=s
Select(slot)
while not turtle.placeDown() do turtle.digDown() end
Select(ps)
end
function suck(slot)
local ps=s
Select(slot)
turtle.suck()
Select(ps)
end
function drop(slot)
local ps=s
Select(slot)
turtle.drop()
Select(ps)
end
function turnOn()--Assumed side is front
local t = peripheral.wrap("front")
t.turnOn()
end
function reboot()
local t = peripheral.wrap("front")
t.shutdown()
sleep(.1)
t.turnOn()
end
function dig(slot)
print("slotted dig called")--debug
local ps=s
Select(slot)
turtle.dig()
Select(ps)
end
function ddown(slot)
local ps=s
Select(slot)
turtle.digDown()
Select(ps)
end

--Complex world interaction
function deprogram(dir)--dir is direction turtle is moving
if dir==lef then
place(ds)
drop(fds)
ddown(cs)
down()
reboot()
sleep(.1)
dig(ts)
up()
suck(fds)
dig(ds)
forward()
forward()
end
if dir==righ then
forward()
ddown(cs)
turn()
place(ds)
drop(fds)
down()
reboot()
sleep(.1)
dig(ts)
up()
suck(fds)
dig(ds)
turn()
forward()
end
end

function program(dir)--dir is direction turtle is moving
if dir==lef then
right()
pdown(cs)
left()
forward()
right()
pdown(ts)
left()
forward()
turn()
place(ds)
drop(fds)
down()
turnOn()
up()
suck(fds)
dig(ds)
turn()
end
if dir==righ then
left()
pdown(ts)
right()
forward()
turn()
place(ds)
drop(fds)
down()
turnOn()
up()
suck(fds)
dig(ds)
right()
pdown(cs)
right()
forward()
end
end



argv = {...}
argc = #argv
lef=1
righ=-1
face=1--Set direction to left to start with
ds=13--Slot where disk drive is stored
cs=14--Slot where Ender chests are stored
fds=15--Slot where floppy disk is stored
ts=16--Slot where turtles are stored
s=1--Currently selected slot
if argc<3 then
print("Usage: grid <Radius> <Width> <Length> [Boolean Remove]")
error()
else if argc>4 then
print("Usage: grid <Radius> <Width> <Length> [Boolean Remove]")
error()
end
end

r=argv[1]+0--Plus zero converts variable to int
w=argv[2]+0
l=argv[3]+0
rem=argv[4]=="true" or argv[4]=="1"
print("Radius: "..r)
print("Width: "..w)--How wide each line of turtles will be
print("Length: "..l)--How many lines of turtles
write("Removing turtles: ")
print(rem)
tl=0
tw=0
t=0


if not rem then
place(ds)
drop(fds)
if fs.exists("disk/Size.txt") then
fs.delete("disk/Size.txt")
end
local file = fs.open("disk/Size.txt", "w")
file.write(r)
file.close()
suck(fds)
dig(ds)

while t<r do-- Get to the block next to the first turtle chest position
forward()
t=t+1

end
end

while tl<l do--Loop for rows
while tw<w do--Loop for columns
t=0
tw=tw+1
if rem then
deprogram(face)
else
program(face)--Program next turtle
end
if tw>=w then
break
end
while t<2*r-1 do--Arrive to next turtle spot
forward()
t=t+1
end
end

up()
if face==lef then--Face toward next row
right()
else
left()
end

t=0
while t<2*r+1 do-- Get to the next chest spot
forward()
t=t+1
end

if face==lef then--Face down the column
right()
else
left()
end
forward()
face=face*-1
tl=tl+1
tw=0
end
