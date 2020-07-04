#You should create one R script called run_analysis.R that does the following.

#Read in data
library(data.table)

features <- fread("features.txt")
activity_labels <- fread("activity_labels.txt")

subject_train <- fread("subject_train.txt")
X_train <- fread("X_train.txt")
y_train <- fread("y_train.txt")

subject_test <- fread("subject_test.txt")
X_test <- fread("X_test.txt")
y_test <- fread("y_test.txt")

#Appropriately labels the data set with descriptive variable names.
colnames(X_train) <- features$V2
colnames(X_test) <- features$V2

#Add subject and response columns to train and test datasets
X_train$subject <- subject_train
X_train$response <- y_train
X_test$subject <- subject_test
X_test$response <- y_test

#Merges the training and the test sets to create one data set.
merged <- rbind(X_train,X_test)

#Extracts only the measurements on the mean and standard deviation 
#for each measurement.
colstokeep <- colnames(merged)[grep('(mean|std|subject|response)',colnames(merged))]

#Creates a second, independent tidy data set with the average of 
#each variable for each activity and each subject.
library(dplyr)

finaldataset <- merged[,..colstokeep] %>%
  left_join(activity_labels,by=c("response"="V1")) %>% #descriptive activity names
  rename(activity=V2) %>%
  select(-response) %>%
  group_by(subject,activity) %>%
  summarise_all(mean)

#write table
write.table(finaldataset,"cleanAccelerometerData.txt",row.names=FALSE)
