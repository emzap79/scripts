#!/usr/bin/env python

import os, subprocess, Tkinter, tkFileDialog, tkSimpleDialog

from Tkinter import *

root = Tk()
root.title(“PDF Compressor”)

def compressPdf():
    volumeDirectory = str(tkFileDialog.askdirectory(title=”Select Volume”))
pathName, directoryName = os.path.split(volumeDirectory)
directoryNameNew = directoryName + ‘_compressed’
directoryPathNew = os.path.join(pathName, directoryNameNew)
psDirectoryName = directoryName + ‘_ps’
psDirectoryPath = os.path.join(pathName, psDirectoryName)
if os.path.exists(directoryPathNew):
    pass
else:
    os.makedirs(directoryPathNew)
if os.path.exists(psDirectoryPath):
    pass
else:
    os.makedirs(psDirectoryPath)
pdfFiles = os.listdir(volumeDirectory)
for pdfFile in pdfFiles:
    pdfFileName, extension = pdfFile.split(“.”)
psFileName = pdfFileName + ‘.ps’
pdfOldPath = os.path.join(pathName, directoryName, pdfFile)
psPath = os.path.join(psDirectoryPath, psFileName)
pdfNewPath = os.path.join(directoryPathNew, pdfFile)
subprocess.call(["pdf2ps", pdfOldPath, psPath])
subprocess.call(["ps2pdf", psPath, pdfNewPath])
print pdfNewPath
print ‘+++++++++++++++++++’
print ‘Done!’

def close():
    root.destroy()

menu = Menu(root)
root.config(menu=menu)
## File Menu
filemenu = Menu(menu)
menu.add_cascade(label=”File”, menu=filemenu)
filemenu.add_command(label=”Exit”, command=close)
## Process Menu
processmenu = Menu(menu)
menu.add_cascade(label=”Process Data”, menu=processmenu)
processmenu.add_command(label=”Compress PDFs”, command=compressPdf)

mainloop()
