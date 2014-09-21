Getting-and-Cleaning-Data_Project
=================================

The Directory with the original Samsung Data was download manualy to a new directory on the 'working environment': "ProjectData".

The Script starts with extracting the relevant files (6) into new data frames and than creates 2 additinal DF for 
the training & testing activities (it takes sometime to run).

The diffrent DF's then binds and the approperate variables name being taking from the text file which added to the directory:
(features.txt and later-on activity_labels.txt).

The final analysis (as discribed in note #5) took place at the end of the script with "dplyr" library 
(please note to activate it before runing), and than the data set with the analysis is being writen to new file: 
"totalAveragesDataSet.txt"

More details about the script can be found in the remarks within the R file which enclosed

