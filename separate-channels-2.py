#@File(label = "Select scan directory", style = "directory") scanFolder
#@ String (label="channels (c)") channels
#@ String (label="z-steps (z)") zsteps
#@ String (label="timepoints (t)") timepoints

"""
##AUTHOR: Ani Michaud (Varjabedian)

## DESCRIPTION: This script is the second script in the separate-channels series for importing and preparing big datasets. Data should have previously been run through separate-channels-1 to sort and create appropriate directory structure.

The organization of this code is as follows:
1. Script parameters (at the top, preceded by a "#@") that gather information for the dialogue box
2. Import statements for all the modules needed
3. Definitions of functions for carrying out processing steps
4. The _main_() function, which calls all of the other pre-defined functions

For more information and up-to-date changes, visit the GitHub repository:
https://github.com/anivarj/RandoScripts/separate-channels
"""
# import image sequence from folder
import os, sys, traceback, shutil, glob
from ij import IJ, WindowManager, ImagePlus
from ij.gui import GenericDialog
import datetime

# converts the input directory you chose to a path string that can be used later on
scanFolder = str(scanFolder)
print "The scanFolder is: " + scanFolder


# get the name of the scan
scanName = os.path.basename(scanFolder)
print "The scanName is: " + scanName


def import_sequence(channelFolder):
    # importing the sequence
    importFolder = os.path.join(scanFolder, channelFolder)
    print "The importFolder is: " + importFolder
    print "Importing image sequence"
    IJ.run("Image Sequence...", "open=[" + importFolder + "] sort use");

def make_hyperstack(cString):
    # making a stack
    print "Making hyperstack..."
    IJ.run("Stack to Hyperstack...", "order=xyczt(default) channels=1  slices=" + zsteps + " frames=" + timepoints + " display=Color");

def make_MAX(cString):
    # max projection
    print "Running MAX projection..."
    IJ.run("Z Project...", "projection=[Max Intensity] all");

    # renaming
    imp = IJ.getImage() # gets the resulting image
    imp.setTitle("MAX_C" + cString + "-" + scanName + "_raw")
    imp = IJ.getImage() # gets the resulting image
    windowName = imp.getTitle() # gets title

    print "Saving MAX..."
    IJ.saveAsTiff(imp, os.path.join(scanFolder, windowName));

def _main_ ():
    channelInt = int(channels)
    for c in range(1, channelInt+1):
    	cString = str(c)
        channelFolder = "ch" + cString + "-tifs"
        print "The channelFolder is: " + channelFolder
        import_sequence(channelFolder)
        make_hyperstack(cString)
        make_MAX(cString)

        IJ.run("Close All")


_main_()
print "End of script"
