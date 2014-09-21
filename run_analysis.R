
#the downloaded Dir' was extracted to new Dir': "ProjectData" 
#- manually, outside to this script using 7-Zip..  
  
run_analysis <- function () {
 
# Extract the relevant files (6) into new data frames:
  
  
 subject_trainers <- read.table ("~/ProjectData/train/subject_train.txt", header = FALSE)  
  trainers_activities <- read.table ("~/ProjectData/train/y_train.txt", header = FALSE)
  trainers_features <- read.table ("~/ProjectData/train/x_train.txt", header = FALSE)
  
  subject_testing <- read.table ("~/ProjectData/test/subject_test.txt", header = FALSE)
  testing_activities <- read.table ("~/ProjectData/test/y_test.txt", header = FALSE)
  testing_features <- read.table ("~/ProjectData/test/x_test.txt", header = FALSE)

# create two data frames - for each group (testers & trainers)

  trainersData <- data.frame (trainers_features,subject_trainers,trainers_activities)
  testingData <- data.frame (testing_features,subject_testing,testing_activities)

#and now bind them.. 
  bindData <- rbind (trainersData,testingData)

#checking what are the variables numbers (in "features.txt" file) 
#which compute the "mean" and "std" of the diffrent features     
# applying the chosen variables to create data set with means and Std's

  featuresName <- read.table ("~/ProjectData/features.txt", header = FALSE)
  VariablesList <- grep(".mean\\()|.std\\()", featuresName$V2)
  Data_features <- bindData [, VariablesList]

# add 2 variables: subjects and activities

  Data_features <- cbind (Data_features, bindData$V1.1, bindData$V1.2)

# now naming the 'subjects' varaibel (column # 67 or V1.1) 
  names (Data_features)[67] <- "Subjects"

# naming the activities (under V1.2 or colunm number 68) 
  names (Data_features)[68] <- "activity"
  activityName <- read.table ("~/ProjectData/activity_labels.txt", as.is = TRUE)  

# loops for applying the right names in the right spot 

  for (i in 1:nrow(Data_features)) {
  
   for (n in 1:6)  {
        
      if (Data_features[i,68] == n) {
          Data_features[i,68] <- activityName[n,2]
       } 
     }
     
  }
 
#naming the features (columns 1-66 in Data_features)
  
VariablesNames <- grep(".mean\\()|.std\\()", featuresName$V2, value = TRUE)

  for (y in 1:66) {
    names (Data_features)[y] <- VariablesNames [y]
    
  }


# creating new Data Set for analysis with 66 columns (extracting the 'activity' & 'subjects')
variableToUse <- Data_features [ ,1:66]

# using library ("dplyr") for the grouping and means calculating

  Data_features$Subjects <- as.character(Data_features$Subjects) 

  meansTable <- ddply(variableToUse, .(Data_features$activity, Data_features$Subjects), colMeans)

# writing the new Data Set for a .txt file as was asked in step 5:  
  write.table(meansTable, "totalAveragesDataSet.txt", row.names = FALSE)

}
  