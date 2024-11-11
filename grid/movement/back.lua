local args={...}
if #args ~= 1 then
print("Usage: Back <Distance>")
error()
end
xm=tonumber(args[1])
x=0
while x<xm do
if turtle.back() then
x=x+1
else
turtle.dig()
end
end

