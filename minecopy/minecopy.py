#!/usr/bin/python
import time,sys,os,platform,subprocess

###############################################
#           Configurable options              #
###############################################
#time between keystrokes
key_press_delay = 0.01
#time for editor commands
editor_wait_delay = 0.1
#name of window to autoswap to if able
window_name = "Minecraft"
# removes .lua from filenames
crop_endings = True 
# how long to delay start if autoswap fails
switch_delay = 10
# compress if lua is installed
try_compress = True
# remove directory structure when copying files
crop_directories = True
###############################################

# location of lua compression script
lua_path = os.path.join(os.path.dirname(__file__),"app_maximum.lua")
#location of temporary compressed file
temp_path = os.path.join(os.path.dirname(__file__),"TEMPORARY_LUA_FILE")

if platform.system() == "Linux":
    # Import libxdo, for key output
    from ctypes import *
    xdo=cdll.LoadLibrary("libxdo.so.2")
    xdo_context=xdo.xdo_new(None)
     
    def typeout(string):
        xdo.xdo_type(xdo_context, 0, string, key_press_delay*1000000) # microseconds

    def savefile():
        typekeys(["ctrl","Return","ctrl","Left","Return"])

    def typekeys(keysyms): # separation might be useful eventually?
        for key in keysyms:
            xdo.xdo_keysequence(xdo_context, 0, key, key_press_delay*1000000) # microseconds
            time.sleep(editor_wait_delay)
        
if platform.system() == "Windows":
    def windowswitch():
        # Load the stuff for writing strings using com
        from win32com import client
        shell = client.Dispatch("WScript.Shell")
        shell.AppActivate('Minecraft') 
        
    import SendKeysCtypes as key
    
    def typeout(string):
        newstring = ""
        for char in string:
            if char in ["{","}","[","]","+","^","%","~","(",")"]:
                char = "{%s}"%char
            newstring += char
        key.SendKeys(newstring, key_press_delay, True, True, True)
    
    def savefile():
        sequence = ("{VK_CONTROL}{ENTER}{VK_CONTROL}{RIGHT}{ENTER}")
        key.SendKeys(sequence, editor_wait_delay)

def loadfile(filename):
    global try_compress
    if try_compress:
        try:
            subprocess.call(["lua", lua_path, "-o", temp_path, "--quiet", "--maximum", os.path.join(os.getcwd(),filename)])
            filename = temp_path
        except:  
            try_compress = False
    f = open(filename)
    data = f.read()
    f.close()
    if try_compress:
        os.remove(temp_path)
    return data
        
def copyfile(filename):
    data = loadfile(filename)
    if crop_directories:
        filename = os.path.basename(filename)
    if crop_endings:
        filename = filename.replace(".lua","")
    typeout("rm "+filename+"\nedit "+filename+"\n")
    time.sleep(editor_wait_delay) # make sure it has time to finish
    typeout(data)
    savefile()
    
if __name__ == "__main__":
    try:
        windowswitch()
    except:
        print("Select minecraft window manually and make sure a computercraft terminal is open!")
        print("You have %d seconds or bad things will happen!!!" % switch_delay)
        time.sleep(switch_delay)
    for filename in sys.argv[1:]:
        copyfile(filename)