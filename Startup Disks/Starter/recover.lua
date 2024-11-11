f=fs.open("Recovery.txt","r")
r=f.readLine()
x=f.readLine()
y=f.readLine()
z=f.readLine()
shell.run("quarry","Recover",r,x,y,z)

print(r)


