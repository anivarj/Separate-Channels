#!/bin/bash


###############
#AUTHOR: Ani Michaud (Varjabedian)

#DESCRIPTION:
# This script contains commands for parsing and separating .ome.tifs into folders based on channel.
# It's useful for large, multi-channel datasets, where sorting before stack-to-hyperstack can be useful
# The script is written in bash and is expected to be run from a terminal (faster than running through imageJ)
# To start, copy this script to the scan directory that contains all your .tif files (example: Exp163_04_04-2019_SF/cell001/)
# Open a terminal and navigate to the scan directory that contains your .tif files and this script (example: cd Exp163_04_04-2019_SF/cell001/)
# Run the script from the scan directory (example: ./separate-channels.sh)

# The organization of this code is as follows:
  # 1. Make directories for each channel
  # 2. Find .tif files and sort into appropriate channel folders
  # 3. Check for differences between the original scan directory and the sorted channel directories (just to make sure nothing is forgotten or copied incorrectly)
  # 4. Delete the original files in the scan directory (leaving the sorted directories behind)
  # 5. Follow this script by running separate-channels-2 in Fiji script editor (to import and make hyperstacks)

# PLACES THAT REQUIRE USER INPUT:
# The user will need to comment out lines of code that they do not need (example: if you have 2 channels, comment out any line that has reference to channel 3)

# The user will also need to press "Enter" to continue the script after the difference files are created. This way, if something goes wrong, you can abort the script by pressing "Ctrl+C" before the original files are removed.

# For more information and up-to-date changes, visit the GitHub repository: https://github.com/anivarj/RandoScripts/separate-channels

###############

# make directories for however many channels you have. Comment out what you don't need
mkdir ch1-tifs ch2-tifs ch3-tifs

# find files with the channel pattern and move it to the correct folder. Comment out lines that you don't need
find . -d 1 -name "*_Ch1_*" -print0 | xargs -I{} -0 cp -v {} ch1-tifs/
find . -d 1 -name "*_Ch2_*" -print0 | xargs -I{} -0 cp -v {} ch2-tifs/
find . -d 1 -name "*_Ch3_*" -print0 | xargs -I{} -0 cp -v {} ch3-tifs/

# compare the parent directory (with all files) to the copied list, just to make sure nothing went horribly wrong
echo "finding ch1 diffs..."
diff -qr . ch1-tifs/ >> diffs-ch1.txt

echo "finding ch2 diffs..."
diff -qr . ch2-tifs/ >> diffs-ch2.txt

echo "finding ch3 diffs..."
diff -qr . ch3-tifs/ >> diffs-ch3.txt

# opens the text files so you can scroll through them
open -e diffs-ch?.txt

# prompts the user to continue or abort
read -p "Ready to delete old files? Press enter to continue, or Ctrl+C to abort."

# if enter is selected, find the original .ome.tifs and delete them
find . -d 1 -name "*.ome.tif" -print0 | xargs -0 rm -v

echo "Done"
