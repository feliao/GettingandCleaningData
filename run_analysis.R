run_analysis <- function() {
      
      ## Read in all dataset
      
      X_train <- read.table("./train/X_train.txt",as.is=TRUE)
      Y_train <- read.table("./train/Y_train.txt",as.is=TRUE)
      subject_train <- read.table("./train/subject_train.txt",as.is=TRUE)
      
      X_test <- read.table("./test/X_test.txt",as.is=TRUE)
      Y_test <- read.table("./test/Y_test.txt",as.is=TRUE)
      subject_test <- read.table("./test/subject_test.txt",as.is=TRUE)
      
      features <- read.table("./features.txt",as.is=TRUE)
      activities_lable <- read.table("./activity_labels.txt",as.is=TRUE)
      
      ## append activity/subject variable to main test/train dataset
      
      train_data <- cbind(subject_train,X_train)
      train_data <- cbind(train_data,Y_train)
      
      test_data <- cbind(subject_test,X_test)
      test_data <- cbind(test_data,Y_test)
      
      ## Merge training and test set
      
      merged_data <- rbind(test_data,train_data)
            
      ## create more descriptive variable names using the features table
      ## This is done by removing any "-", "()"  and "," char
      ## and apply a camel capitalisation convention
      
      for (i in 1:nrow(features)) {
            features[i,2] <- gsub("-|\\(|\\)|,","",features[i,2])
            features[i,2] <- gsub("std","Std",features[i,2])
            features[i,2] <- gsub("mad","Mad",features[i,2])
            features[i,2] <- gsub("max","Max",features[i,2])
            features[i,2] <- gsub("min","Min",features[i,2])
            features[i,2] <- gsub("mean","Mean",features[i,2])
            features[i,2] <- gsub("energy","Energy",features[i,2])
            features[i,2] <- gsub("correlation","Correlation",features[i,2])        
      }
      
      ## Appropriately labels the data set with descriptive variable names. 

      features <- rbind(c(1,"subject"),features)
      features <- rbind(features,c(1,"activity"))
      colnames(merged_data) <- features$V2
      
      ## Use grep to extracts only the measurements on the mean and standard deviation for each measurement. 
      
      std_index <- grep("Std", features[,2])
      
      mean_index <- grep("Mean", features[,2])
      
      ## Create new dataset with only mean and SD measurements but also keeping the subject and activity key
      
      merged_data <- merged_data[,sort(c(1,std_index,mean_index,563))]
      
      ## Uses descriptive activity names to name the activities in the data set
      
      merged_data$activity[merged_data$activity ==1] <- "WALKING"
      merged_data$activity[merged_data$activity ==2] <- "WALKING UPSTAIRS"
      merged_data$activity[merged_data$activity ==3] <- "WALKING DOWNSTARIS"
      merged_data$activity[merged_data$activity ==4] <- "SITTING"
      merged_data$activity[merged_data$activity ==5] <- "STANDING"
      merged_data$activity[merged_data$activity ==6] <- "LAYING"

      
      ## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
      
      tidy_data <- aggregate(merged_data, by=list(merged_data$activity,merged_data$subject),FUN=mean, na.rm=TRUE)

      ## Final tidying up of variable names before writing out to a a text file
      
      colnames(tidy_data)[1] <- "activityGroup"
      colnames(tidy_data)[2] <- "subjectGroup"
      tidy_data <- tidy_data[,1:89]
      git
      write.table(tidy_data,file ="./tidy_data.txt",row.names=FALSE)
      
}