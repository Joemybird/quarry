local args={...}
if #args ~= 1 then
print("Usage: Down <Distance>")
error()
end
xm=tonumber(args[1])
x=0
while x<xm do
if turtle.down() then
x=x+1
else
turtle.digDown()
end
end

