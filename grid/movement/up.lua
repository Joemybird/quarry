local args={...}
if #args ~= 1 then
print("Usage: Up <Distance>")
error()
end
xm=tonumber(args[1])
x=0
while x<xm do
if turtle.up() then
x=x+1
else
turtle.digUp()
end
end

