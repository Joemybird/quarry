local args={...}
if #args ~= 1 then
print("Usage: Left <Turns>")
error()
end
xm=tonumber(args[1])
x=0
while x<xm do
if turtle.turnLeft() then
x=x+1
else
error()
end
end

