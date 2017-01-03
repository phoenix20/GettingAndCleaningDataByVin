startAnalysis <- function(){
      
      
  
      #### READ ALL THE FILES INTO R ###############################################################################    
      activity_labels <- read.table("./activity_labels.txt") 
      features <- read.table("./features.txt")
      subject_train <-read.table("./train/subject_train.txt")
      X_train <-read.table("./train/X_train.txt")
      y_train <-read.table("./train/y_train.txt")
      subject_test <-read.table("./test/subject_test.txt")
      X_test <-read.table("./test/X_test.txt")
      y_test <-read.table("./test/y_test.txt")
      #### JOINING TEST AND TRAING DATA FOR SUBJECT, X AND y #########################################
      
      X_combined <- rbind(X_train,X_test)
      y_combined <- rbind(y_train,y_test)
      subject_combined <- rbind (subject_train,subject_test)
      
      ####  RENAMING THE COLUMN NAMES FOR activity_labels,features,subject,X and y ###################
      
      activity_labels <- rename(activity_labels,activity_name=V2,activity_number=V1)
      features <- rename(features,feature_number=V1,feature_name=V2)
      subject_combined <- rename(subject_combined,subject_number = V1)
      y_combined <- rename(y_combined,activity_number = V1)
      names(X_combined) <- features$feature_name
      
      #### FILTERING THE x TABLE BASED ON COLUMNS CONTAINING MEAN AND STD ###########################
      
      indexOfMeanAndStd <-  grep("mean|std",features$feature_name)
      X_combined_filtered <- X_combined[,indexOfMeanAndStd]
      
      #### COLUMN BINDING THE DATA TOGETHER I.E. SUBJECT , y AND X DATA TABLES ############################
      
      
      combinedTable <- cbind(subject_combined,y_combined,X_combined_filtered)
      
      #### MERGING ACTIVITY LABELS AND COMBINED TABLE TOGETHER (ALSO ARRANGING) ######################
      mergedTable <- merge(activity_labels,combinedTable,by="activity_number")
      
      mergedTable <- arrange(mergedTable,subject_number,activity_number)
      
      #### PROCESSING TO FIND AVERAGE OF VARIABLES FOR EACH ACTIVITY AND SUBJECT 
      tempTable <- select(mergedTable,-activity_name)
      groupedTempTable <- group_by(tempTable,subject_number,activity_number)
      
      processedTable <- summarise_all(groupedTempTable,.funs = funs("mean"))
      
      #### WRITING THE DATA FRAME TO A CSV FILE IN THE WORKING DIRECTORY ############################
      dir.create("PROCESSED DATA")
      write.table(processedTable,file = "./PROCESSED DATA/processedTable.csv",sep=",",row.names = FALSE)
      
      
      
      #### RETURNING THE TABLE AFTER THE ANALYSIS ###################################################
      return(processedTable)
}



