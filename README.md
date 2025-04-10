# SHRUMS_Methods
This is the homepage for the code for the Methods Paper **"Immunofluorescence detection and quantification of phosphorylated SMAD protein expression in human blastocysts"** by Todd Fallesen and Sophie Brumm.

![image](https://github.com/user-attachments/assets/b5721ea5-a6dc-4035-92c4-48aa1949fc1a)

There are files for FIJI, CellProfiler and Matlab


## Fiji Files: 
The Fiji files are used in image preprocessing. 
*split_channels_multiple_series_and_rename.ijm*: This code is used to prepare the images for use in CellProfiler. Images are split into individual channels and Z-frames using this script. The number of exported images will be equal to the number of channels multiplied by the number of Z-slices in the original image. The script will work on images with multiple series, such as LIF files. 
*Stardist_process_folder.ijm* This code will run a StarDist segmentation on every image of a specified channel. The output of this script is a StarDist label image for each input image.
*Enhance_All_C2_C3_c4.ijm* This is an optional script for background subtraction and contrast enhancement of images to aid in image processing.

## CellProfiler Pipelines
There are two cellprofiler project files. 
*SHRUMS_4_Channels_Enhanced__Channels_For_Star_Methods.cpproj* Set up to run on a 4 channel image
*SHRUMS_5_Channels_Enhanced__Channels_For_Star_Methods.cpproj* Set up to run on a 5 channel image


## Matlab file:
*SHRUMS_Wrangling.m* Performs the data wrangling of the output from the cellprofiler pipeline in Matlab

## Jupyter Notebook File:
*SHRUMS_Wrangling.ipynb* Performs the data wrangling of the output from the cellprofiler pipeline in python
