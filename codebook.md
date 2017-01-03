#OBJECTIVE
The run_analysis.R script does the following -
1. Merges the training and the test sets to create one data set.
2 Extracts only the measurements on the mean and standard deviation for each measurement.
3 Uses descriptive activity names to name the activities in the data set
4 Appropriately labels the data set with descriptive variable names.
5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#TRANSFORMATIONS STEPS
1 Data was from the download data and put into respective variables.
2 The test and train data was combined for X,y and subject into one using row binding
3 Descriptive column names were used for activity_labels,y_combined,subject_combined,X_combined and features
4 X_combined table was filtered using grep() to find the locations of the the columns with "mean" or "std" in their name and the result was stored in X_combined_filtered.
5 Now subject_combined,y_combined and X_combined_filtered were column binded into one table called mergedTable 
6 A tempTable was created from mergedTable by dropping the activity_name column.
7 From tempTable ,groupedTempTable was created by using group_by() command and grouping data on the basis of subject_number and activity_number.
8 Now summarise_all() was used to call the mean function on various columns of the groupedTempTable
9 The final result was stored in processedTable and the result was also written to the data set directory with the name "processedTable.csv".
10 The processedTable was returned.


#ABOUT THE SCRIPT 
The script has a function called loadDataSet() which takes one argument destFolder i.e location
where the data set is located.

#VARIABLES 
activity_labels-has the activity descriptions 
features - names of all the features/variables 
subject_train - training data set for subjects that took part
X_train - training data set for Variable data that has been recorded 
y_train - training data set for the corresponding activity for which the data has been recorded      in X_train
subject_test - test data set for subjects that took part
X_test - test data set for Variable data that has been recorded
y_test - test data set for the corresponding activity for which the data has been recorded in        X_test
subject_combined - combined train and test data for subjects
X_combined - combined train and test data for X
y_combined - combined traing and test data for activites i.e y
indexOfMeanAndStd - indexes where mean and std occur in the variable names 
X_combined_filtered - filtered table based on variables that have mean or std in their columns
combinedTable - column binded table for y_combined,subject_combined and X_combined 
mergedTable - made by combining activity labels and combinedTable based on activity_number
tempTable - dropping activity names column 
groupedTempTable - grouped table based on subject_number and activity_number 
processedTable - final clean data that contains average of each variable based on subject and        activity
      
      
      