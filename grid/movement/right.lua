local args={...}
if #args ~= 1 then
print("Usage: Right <Turns>")
error()
end
xm=tonumber(args[1])
x=0
while x<xm do
if turtle.turnRight() then
x=x+1
else
error()
end
end

