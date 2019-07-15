# Separate-Channels
Two scripts for sorting and processing large datasets through import->image sequence instead of bioformats.

Separate-channels is intended to be a series of scripts for separating and processing big datasets that have many too many tifs for bioformats importer to handle.

Using import-> Image Sequence on unsorted, multi-channel tifs can cause problems when using stack-to-hyperstack, even when channels, slices and timepoints are specified correctly in the software.

Sorting the tif files into individual channels before importing can help with this, and the resulting MAX projections can later be merged together if needed.

separate-channels-1.sh is a shell script that should be run from a terminal. It will organize the tif files into individual folders based on channel, and navigates the file system much quicker than through a GUI interface.

separate-channels-2.py is a script that should be run through Fiji, and will run the commands to import the images, make the hyperstacks and create MAX projections of the data. The files will be saved in the main scan folder to avoid needlessly going into the tif folders (which are slow to load).

I hope this script can be useful to others, and if there are any questions feel free to let me know.

-Ani
