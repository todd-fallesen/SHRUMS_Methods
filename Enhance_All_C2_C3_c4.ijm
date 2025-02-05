//May 26, 2021,Todd Fallesen, CALM Facility,Crick
// Do all enhancements at once.
// July 21 2021, removed extra code, commented out a lot to make life easier.
//So let's script that.
//September 23 2021, running this on Image_Quant_SMAD2.3 folder



#@ File (label = "Input directory", style = "directory") input

print("\\Clear");

suffix = ".tif";
prefix = "C2"; //psmad images
prefix_1 = "C3"; //Oct4 images
prefix_2 = "C4"; //NanoG images
prefix_3 = "C1"; //
prefix_4 = "C5"; //  


//comment out any of the proccesses you don't want to run
processFolder(input);  //does C2
processFolder_2(input);  //does C3 and C4
processFolder_3(input); //does channel C1
processFolder_4(input); //does channel C5



// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		if(startsWith(list[i], prefix) && endsWith(list[i], suffix))
			processFile(input,list[i]);
	}
}

function processFile(input, file) {
//This function takes the original image, thresholds it and uses the threshold as a mask over the 
//original image. The masked image is then median filtered
	print("Processing: " + input + File.separator + file);
	open(input+File.separator + file);
	filename_short = File.nameWithoutExtension;
	save_file = "Contrast_enhanced_" + filename_short + ".tif";
	save_path = input + File.separator + save_file;


	run("Auto Threshold", "method=Moments white");
	run("Divide...", "value=255");
	rename("mask");
	open(input+File.separator + file);
	rename("original");
	imageCalculator("Multiply create", "mask","original");
	selectWindow("Result of mask");
	run("Median...", "radius=1");
	print("Saving to in reality: " + save_path);
	save(save_path);
	print("Saving to: " + save_path);
	run("Close All");
}

function processFolder_2(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder_2(input + File.separator + list[i]);
		if((startsWith(list[i], prefix_1) && endsWith(list[i], suffix)) || (startsWith(list[i], prefix_2) && endsWith(list[i], suffix)) )
			processFile_2(input, list[i]);
	}
}

function processFile_2(input, file) {
//The image has outlying spots removed, and a median filter of 2
	print("Processing: " + input + File.separator + file);
	open(input+File.separator + file);
	filename_short = File.nameWithoutExtension;
	save_file = "Enhanced_" + filename_short + ".tif";
	save_path = input + File.separator + save_file;



	rename("original");
	run("Remove Outliers...", "radius=6 threshold=120 which=Bright");
	run("Median...", "radius=2");
	print("Saving to in reality: " + save_path);
	save(save_path);
	print("Saving to: " + save_path);
	run("Close All");
}

function processFolder_3(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder_3(input + File.separator + list[i]);
		if(startsWith(list[i], prefix_3) && endsWith(list[i], suffix))
			processFile_3(input, list[i]);
	}
}

function processFile_3(input, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	print("Processing: " + input + File.separator + file);
	open(input+File.separator + file);
	filename_short = File.nameWithoutExtension;
	save_file = "Enhanced_" + filename_short + ".tif";
	save_path = input + File.separator + save_file;



	rename("original");
	run("Remove Outliers...", "radius=6 threshold=120 which=Bright");
	run("Median...", "radius=2");
	print("Saving to in reality: " + save_path);
	save(save_path);
	print("Saving to: " + save_path);
	run("Close All");
}


//prcessFolder_4 is exactly the same as processFolder_3, I just didn't want to write another if and else statement
function processFolder_4(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder_4(input + File.separator + list[i]);
		if(startsWith(list[i], prefix_3) && endsWith(list[i], suffix))
			processFile_4(input, list[i]);
	}
}

function processFile_4(input, file) {
	// Do the processing here by adding your own code.
	// Leave the print statements until things work, then remove them.
	print("Processing: " + input + File.separator + file);
	open(input+File.separator + file);
	filename_short = File.nameWithoutExtension;
	save_file = "Enhanced_" + filename_short + ".tif";
	save_path = input + File.separator + save_file;



	rename("original");
	run("Remove Outliers...", "radius=6 threshold=120 which=Bright");
	run("Median...", "radius=2");
	print("Saving to in reality: " + save_path);
	save(save_path);
	print("Saving to: " + save_path);
	run("Close All");
}