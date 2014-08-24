## run_analysis function readme

The run_analysis script takes a number of input files as specified and shared from the below site, goes through a series of steps to create a tidy data set and then finally creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

They key steps involved (as documented in the R script) are:

- Read in all dataset
- Append activity/subject variable to main test/train dataset
- Merge training and test set          
- Create more descriptive variable names using the features table. This is done by removing any "-", "()"  and "," char and apply a camel capitalisation convention
- Appropriately labels the data set with descriptive variable names 
- Use grep to extracts only the measurements on the mean and standard deviation for each measurement    
- Create new dataset with only mean and SD measurements but also keeping the subject and activity key
- Uses descriptive activity names to name the activities in the data set
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Final tidying up of variable names before writing out to a a text file
