local args={...}
if #args ~= 1 then
print("Usage: Select <Slot>")
error()
end
x=tonumber(args[1])
if not turtle.select(x) then
error()
end

