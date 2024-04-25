if turtle~=nil then
shell.run("cd","disk")
local f=fs.open("disk/Size.txt","r")
local r=f.readLine()
r = r+0
f.close()
files = fs.list("./disk")
for i = 1, #files do
if files[i]~="startup" then
shell.run("copy",files[i],"../"..files[i])
end
end
shell.run("cd","..")
shell.run("label","set","Quarry")
shell.run("Quarry","Recover",r,"0","0","0")
else
print("Non-turtle type detected")
end
