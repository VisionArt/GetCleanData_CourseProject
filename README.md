# Getting and Cleaning Data
Repo for Course Project for Getting and Cleaning Data on Coursera

## Overview
The purpose of this project is to demonstrate the ability to collect, work with and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

## Included in this Repo
- README.md - explains how the scripts work and how they are connected
- CodeBook.md - describes the variables, the data and any transformations or work performed to clean up the data
- run_analysis.R - R script to import and cleanse the data to prepare the tidy dataset
- tidyData.txt - output file containing the tidy data of mean of each mean and standard deviation value in the test and train data sets that is generated upon executing run_analysis.R

## About run_analysis.R Script
The run_analysis.R script processes the provided UCI HAR Dataset and creates a tidy data as per the following requirements:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names. 
5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Information about the source data required to run the script, data dictionary and transformation work to fulfil the project requirements can be found in the CodeBook.md.

**Notes:**
After downloading and unzipping the source data files, please take notice to set the path of the working directory and the dataset folder (a sub directory named /UCI HAR Dataset/)
