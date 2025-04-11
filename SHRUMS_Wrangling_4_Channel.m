%Dec 1, 2020, All Purpose Data Wrangling
%Sept 9, 2020, Original scripting
%Todd Fallesen, CALM Facility, Francis Crick Institute

%%Make a function that finds all the files with of a certain type, so we
%%can implement it in sophie's data.  I.e. i want to scan all the folders,
%%and then we look in each folder and get the file we want

%%The input path is just the directory where all the subdirectories are
%%Filename is the filename that will be scanned in each subdirectory
%%all_data_output_file is the name of the output file you want


%%%%%%%%%%%%%%%%%
%%
% Modified July 21 2021 For Sophie Brumm.
% 
%
% 
%
% 
%%
%%%%%%%%%%%%%%%%%

clear all

tic

%%CHANGE THESE
%Path to directory
input_path = '/path/to/default/Output_Folder/'; %the directory where all the output subdirectories are
filename='Stardist_Labels_Enhanced_ImagesObjects_edge_size_filtered.csv';  %the file we will be looking for in each subdirectory
save_file_name  = 'Date_Meaningful_Filename_All_Channels_Output.xlsx';
%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%RUNNING CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
all_data_output_file = strcat(input_path, save_file_name);
save_path = input_path;

all_files = dir(input_path);                                        %get a list of all the files and subdirectories in the main folder
subFolders = all_files([all_files.isdir]);                          %get a list of all the subdirectories only
subFolders(ismember( {subFolders.name}, {'.', '..'})) = [];         %remove . and .. directories.

%%loop over 

%%need to insert a try-catch for the times when a file isn't actually read.
%%
for n=1:length(subFolders) %loop over the subdirectories
    disp("run number")
    n
    
    id = subFolders(n).name;            %gets the subfolder name
    
      if length(id) > 31
         id_short = id(1:31);
      else
          id_short = id;
      end
    
 
    csv_input_file = strcat(input_path, id, filesep,filename);

    excel_out_file = strcat(id,'.xlsx');%makes the excel file name per embyro
    SaveFileName = strcat(save_path, excel_out_file);
    
    clear Filename_table Small_Table Tracked_objects All_tracked_objects table_for_tracked_object output_table
    try
    	Filename_table = readtable(csv_input_file, 'Delimiter', ','); %read in the data for the filenames
    catch
        pause(1);
        Filename_table = readtable(csv_input_file, 'Delimiter', ',');
    end
    
    if height(Filename_table)==0 %%try again if the file doesn't read
        pause(1);
        disp("Stuck on File");
        disp(csv_input_file);
        Filename_table = readtable(csv_input_file, 'Delimiter', ','); %read in the data for the filenames
    
    else
    
%%        
    %small table reads the big table for the necessary variables for data analysis.  If we need more variables, add them here, and rebuild the array underneath to export)    
    

    Small_Table = Filename_table(:,{'ImageNumber',...
                                    'ObjectNumber',...
                                    'Intensity_IntegratedIntensity_C1',...
                                    'Intensity_IntegratedIntensity_C1_Corr',...
                                    'Intensity_IntegratedIntensity_C1_Enhanced',...
                                    'Intensity_IntegratedIntensity_C1_Enhanced_Corr',...
                                    'Intensity_IntegratedIntensity_C2',...
                                    'Intensity_IntegratedIntensity_C2_Corr',...
                                    'Intensity_IntegratedIntensity_C2_Enhanced_Corr',...
                                    'Intensity_IntegratedIntensity_C2_enhanced',...
                                    'Intensity_IntegratedIntensity_C3',...
                                    'Intensity_IntegratedIntensity_C3_Corr',...
                                    'Intensity_IntegratedIntensity_C3_Enhanced',...
                                    'Intensity_IntegratedIntensity_C3_Enhanced_Corr',...
                                    'Intensity_IntegratedIntensity_C4',...
                                    'Intensity_IntegratedIntensity_C4_Corr',...
                                    'Intensity_IntegratedIntensity_C4_Enhanced',...
                                    'Intensity_IntegratedIntensity_C4_Enhanced_Corr',...
                                    'AreaShape_Eccentricity',...
                                    'AreaShape_Area', ...
                                    'TrackObjects_Label_2',...
                                    'TrackObjects_Lifetime_2'}); %make a new table with just the columns that we need
    
    
    Tracked_objects = Small_Table(:,{'TrackObjects_Label_2'});
    All_tracked_objects = table2array(unique(Tracked_objects));  %make a table that has all the unique tracked objects, then make an array from that table
    All_tracked_objects = All_tracked_objects(~isnan(All_tracked_objects));  %remove NaN's
    %there should be tracked objects in order, that shouldn't change, but in
    %the off chance that they do, set up the loop for the length of the array,
    %then call each value of the array, as opposed to just a value

    total_intensity = [];
%%
%Build the array of the new short table for data-analysis, if variables are
% %added above, be sure to add them here auch.

                         
    for k = 1:length(All_tracked_objects)
        table_for_tracked_object = Small_Table(Small_Table.TrackObjects_Label_2 == All_tracked_objects(k),:);
                                    total_intensity(k,1) = All_tracked_objects(k);
                                    total_intensity(k,2) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C1);
                                    total_intensity(k,3) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C1_Corr);
                                    total_intensity(k,4) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C1_Enhanced);
                                    total_intensity(k,5) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C1_Enhanced_Corr);
                                    total_intensity(k,6) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C2);
                                    total_intensity(k,7) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C2_enhanced);
                                    total_intensity(k,8) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C2_Enhanced_Corr);
                                    total_intensity(k,9) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C2_Corr);
                                    total_intensity(k,10) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C3);
                                    total_intensity(k,11) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C3_Enhanced);
                                    total_intensity(k,12) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C3_Enhanced_Corr);
                                    total_intensity(k,13) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C3_Corr);
                                    total_intensity(k,14) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C4);
                                    total_intensity(k,15) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C4_Enhanced);
                                    total_intensity(k,16) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C4_Corr);
                                    total_intensity(k,17) = sum(table_for_tracked_object.Intensity_IntegratedIntensity_C4_Enhanced_Corr);
                                    total_intensity(k,18) = max(table_for_tracked_object.AreaShape_Eccentricity);
                                    total_intensity(k,19) = sum(table_for_tracked_object.AreaShape_Area);
                                    total_intensity(k,20) = max(table_for_tracked_object.TrackObjects_Lifetime_2'); %make a new table with just the columns that we need
    end

    %column headers for the new excel spreadsheet
    column_headers = {              'Tracked_Object_Number',...
                                    'Intensity_IntegratedIntensity_C1',...
                                    'Intensity_IntegratedIntensity_C1_Corr',...
                                    'Intensity_IntegratedIntensity_C1_Enhanced',...
                                    'Intensity_IntegratedIntensity_C1_Enhanced_Corr',...
                                    'Intensity_IntegratedIntensity_C2',...
                                    'Intensity_IntegratedIntensity_C2_Enhanced',...
                                    'Intensity_IntegratedIntensity_C2_Enhanced_Corr',...
                                    'Intensity_IntegratedIntensity_C2_Corr',...
                                    'Intensity_IntegratedIntensity_C3',...
                                    'Intensity_IntegratedIntensity_C3_Enhanced',...
                                    'Intensity_IntegratedIntensity_C3_Enhanced_Corr',...
                                    'Intensity_IntegratedIntensity_C3_Corr',...
                                    'Intensity_IntegratedIntensity_C4',...
                                    'Intensity_IntegratedIntensity_C4_Enhanced',...
                                    'Intensity_IntegratedIntensity_C4_Corr',...
                                    'Intensity_IntegratedIntensity_C4_Enhanced_Corr',... 
                                    'Max_Eccentricity',...
                                    'Total_Area',...
                                    'Lifetime'};  %generate headers for the columns for the output spreadsheet


    %build the excel spreadsheet
    output_table = array2table(total_intensity, 'VariableNames', column_headers);
    pause(2); %race condition for saving to the tables
    writetable(output_table, SaveFileName); %save the excel file
    pause(5); %try to beat the race conditions
    writetable(output_table, all_data_output_file, 'Sheet', id_short);
    end
  
end
elapsed_time = toc
disp(elapsed_time)
