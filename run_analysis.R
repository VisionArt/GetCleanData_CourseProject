############################################################
## Course Project for Getting and Cleaning Data on Coursera
## Name: VisionArt
## Date: 22 Feb 2015
## Filename: run_analysis.R
## Data Source: UCI HAR Dataset downloaded from
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## This R script will perform the following requirements:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. Creates a second, independent tidy data set with the average of each variable
## for each activity and each subject.
############################################################

## Set work directory
setwd("~/Downloads/Coursera/Data Science Specialization/03 Getting and Cleaning Data/GetCleanData_CourseProject")

## Download and unzip source file
url = "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./getdata_projectfiles_UCI HAR Dataset.zip", mode = "wb")
unzip("getdata_projectfiles_UCI HAR Dataset.zip", exdir=".", overwrite=TRUE)

folderPath <- "./UCI HAR Dataset/"


## 1. Merges the training and the test sets to create one data set.
# Import top-level files in dataset folder
activityLabels <- read.table(paste(folderPath, "./activity_labels.txt", sep=""), header=FALSE)
features <- read.table(paste(folderPath, "./features.txt", sep=""), header=FALSE)
# Import training data files
subjectTrain <- read.table(paste(folderPath, "./train/subject_train.txt", sep=""), header=FALSE)
xTrain <- read.table(paste(folderPath, "./train/x_train.txt", sep=""), header=FALSE)
yTrain <- read.table(paste(folderPath, "./train/y_train.txt", sep=""), header=FALSE)
# Import test data files
subjectTest <- read.table(paste(folderPath, "./test/subject_test.txt", sep=""), header=FALSE)
xTest <- read.table(paste(folderPath, "./test/x_test.txt", sep=""), header=FALSE)
yTest <- read.table(paste(folderPath, "./test/y_test.txt", sep=""), header=FALSE)

# Profile the imported data with dim() command on each table
dim(activityLabels)
dim(features)
dim(subjectTrain)
dim(xTrain)
dim(yTrain)
dim(subjectTest)
dim(xTest)
dim(yTest)

# Assign meaningful headers to the respective tables
names(activityLabels) <- c("activityID", "activityType")
names(features) <- c("featureID", "featureType")
names(subjectTrain) <- "subjectID"
names(xTrain) <- features[,2]
names(yTrain) <- "activityID"
names(subjectTest) <- "subjectID"
names(xTest) <- features[,2]
names(yTest) <- "activityID"

# Merge the training and test data sets into one data set
train <- cbind(subjectTrain, yTrain, xTrain) # subject, activity, measurements
test <- cbind(subjectTest, yTest, xTest) # subject, activity, measurements
combined <- rbind(train, test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
headerNames <- names(combined)
patternIncl <- "ID|-mean|-std"
selectedCol <- grepl(patternIncl, headerNames)
combined2 <- combined[selectedCol == TRUE]


## 3. Uses descriptive activity names to name the activities in the data set.
combined3 <- merge(combined2, activityLabels, by.x="activityID", by.y="activityID", all=TRUE)
combined3$activityID = NULL
library(plyr)
combined3 <- arrange(combined3, subjectID, activityType)


## 4. Appropriately labels the data set with descriptive variable names.
headerNames <- names(combined3)
for (i in 1:length(headerNames)) {
  headerNames[i] <- ifelse(grepl("mean",headerNames[i]),paste0(sub("mean","",headerNames[i]),"_mean"),headerNames[i])
  headerNames[i] <- ifelse(grepl("std",headerNames[i]),paste0(sub("std","",headerNames[i]),"_sd"),headerNames[i])
  headerNames[i] <- gsub("^(t)", "", headerNames[i])
  headerNames[i] <- gsub("[-()]","",headerNames[i])
  headerNames[i] <- gsub("BodyBody", "Body", headerNames[i])
}
combined4 <- combined3
names(combined4) <- headerNames


## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData <- aggregate(combined4, by=list(subject=combined4$subjectID, activity=combined4$activityType), FUN=mean)
tidyData$subjectID = NULL
tidyData$activityType = NULL
names(tidyData)[1] = "subjectID"
names(tidyData)[2] = "activityType"
tidyData <- tidyData[order(tidyData$subjectID, tidyData$activityType),]
# Export the tidyData set
write.table(tidyData, './tidyData.txt', row.names=FALSE)
