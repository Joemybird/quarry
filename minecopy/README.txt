Kazagistar's Computercraft Minecopy V2
==========================================
Ever get annoyed that you can't transfer your programs to a server that has HTTP disabled? Do you get annoyed when you have to type the same stuff into multiple computers? Want to code with a REAL text editor, and play SMP too? The solution is here!

Just open your minecraft and log in to a computercraft shell, then run the script with a list of files as parameters. Sit back and relax as it reads in the files, compresses them automagically, and rapidly types them into your minecraft window, saving them.

Notes: This program is buggy as hell. Make sure you call it from the same directory as the .lua files you want to transfer, because it will try to preserve relative file locations. If the text comes out with mistakes, slow down the keystrokes. If you want to be able to debug your code, disable compression. THE PROGRAM WILL RAPIDLY VOMIT KEYSTROKES INTO WHATEVER APPLICATION HAS FOCUS! IF YOU HAVE ANYTHING OTHER THEN MINECRAFT FOCUSED, IT WILL GET HAMMERED WITH LUA COMMANDS! YOU HAVE BEEN WARNED!

Enjoy, and please send me any questions you have, or patches you make to the code!


Linux requirements:
- Python 2.7
- libxdo
- lua [OPTIONAL: needed for lua file compression]

No links, this shit is trivial to install with a package manager on any distro. Once you have all the prerequesites, you should be able to just run the script.


Windows requirements:
- Python 2.7
    http://www.python.org/download/
- pywin32 [OPTIONAL: needed for automatic window switching]
    http://sourceforge.net/projects/pywin32/files/
- lua [OPTIONAL: needed for lua file compression]
    http://code.google.com/p/luaforwindows/

Windows is a little stupid when it comes to command line stuff like python. Go to My Computer>Properties>Advanced>Environment Variables, edit the PATH variable, and add to the end of it ";C:\Python27". Then you should be able to run the script doing something like: "> python scriptfolder/minecopy/minecopy.py luafolder/script1.lua luafolder/script2.lua"