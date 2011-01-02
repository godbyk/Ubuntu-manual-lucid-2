# -*- encoding: utf-8 -*-
#!/usr/bin/python
import re

def change():
    f = open("po_ubuntu-manual-lt.po", "rb")
    m = False
    newfile = ""
    for line in f:
        if line.count("msgstr"):
            m = True
        elif line.count("msgid"):
            m = False
        if m:
            nline = re.sub("``", "„", line)
            nline = re.sub("''", "“", nline)
            newfile += nline
        else:
            newfile += line
    f.close()
    
    fw = open("lt.po", "w")
    fw.write(newfile)
    fw.close()
    
    return 1
    
if __name__ == "__main__":
    a = change()
    
