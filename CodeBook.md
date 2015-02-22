# CodeBook

## Purpose of this File
To describe the variables, the data and any transformations or work performed to clean up the data.

## Data Source
The topic we are looking at for this course project is about Wearable Computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### From the Source Data's project authors
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' in the dataset folder for more details.

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Transformation
The run_analysis.R script processes the above UCI HAR Dataset and creates a tidy data as per the following requirements:

### 1) Merges the training and the test sets to create one data set.
  i) Upon setting the appropriate working directory, the script would import into tables the data from all the relevant files:
- top-level files in dataset folder 
        - activity_labels.txt
        - features.txt
- files in the train folder
        - subject_train.txt
        - x_train.txt
        - y_train.txt
- files in the test folder
        - subject_test.txt
        - x_test.txt
        - y_test.txt
<BR>
<BR>ii) Profile the imported data with dim() command on each table:
* activity_labels - 6 observations and 2 variables. This is a dictionary for activity numbers, for example: activity 1 = WALKING.
* features – has 561 observations and 2 variables. 2nd variable contains the names of 561 variables from x_test and y_test files.
* subject_train - 7352 observations and 1 variable
* x_train - 7352 observations and 561 variables
* y_train - 7352 observations and 1 variable (activity number)
* subject_test - 2947 observations and 1 variable
* x_test - 2947 observations and 561 variables
* y_test - 2947 observations and 1 variable (activity number)
<BR>
<BR>iii) Assign of meaningful headers to the respective tables:
- activityID
- activityType
- featureID
- featureType
- subjectID
<BR>
<BR>iv) Merge the training and test data sets into one consolidated data set using cbind and rbind functions (by row number).

### 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
- Use the grep function to scan for specific patterns to include/exclude in the table headers.

### 3) Uses descriptive activity names to name the activities in the data set
- Use the merge function to label descriptive activity names, with activityID translated to activityType.

### 4) Appropriately labels the data set with descriptive variable names. 
- Use the gsub function to label descriptive variable names.
  * Keep the names as short as possible.
  * All mean/sd measures are moved to the end of variables' names.
  * Remove "t" from beginning of the variables' names while keeping "f" for variables transformed with FFT.
  * Remove all "-" and "()" from labels.
  * De-duplicate vocabs like "BodyBody".

### 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- Use the aggregate, order, merge and mean functions.
- Export the tidy data set to filename "tidyData.txt".

## Data Dictionary
This describes the variables (of interest) and transformed. For each variable it comes with name of variable, its data type, description, range of values (if any).<BR>
Please note that for all numeric variables the range of values is [-1, 1] unless provided separately for given variable.

* subjectID: int; Number of the subject tested, ranged 1-30.
* activityID: factor w/ 6 levels; Activity performed by subject. The values are:
  1 WALKING
  2 WALKING_UPSTAIRS
  3 WALKING_DOWNSTAIRS
  4 SITTING
  5 STANDING
  6 LAYING
* BodyAccX_mean: num; Mean of Time Body Accelerometer X-axis raw signal
* BodyAccY_mean: num; Mean of Time Body Accelerometer Y-axis raw signal
* BodyAccZ_mean: num; Mean of Time Body Accelerometer Z-axis raw signal
* BodyAccX_sd: num; Standard Deviation of Time Body Accelerometer X-axis raw signal
* BodyAccY_sd: num; Standard Deviation of Time Body Accelerometer Y-axis raw signal
* BodyAccZ_sd: num; Standard Deviation of Time Body Accelerometer Z-axis raw signal
* GravityAccX_mean: num; Mean of Time Gravity Accelerometer X-axis raw signal
* GravityAccY_mean: num; Mean of Time Gravity Accelerometer Y-axis raw signal
* GravityAccZ_mean: num; Mean of Time Gravity Accelerometer Z-axis raw signal
* GravityAccX_sd: num; Standard Deviation of Time Gravity Accelerometer X-axis raw signal
* GravityAccY_sd: num; Standard Deviation of Time Gravity Accelerometer Y-axis raw signal
* GravityAccZ_sd: num; Standard Deviation of Time Gravity Accelerometer Z-axis raw signal
* BodyAccJerkX_mean: num; Mean of Time Body Accelerometer Jerk X-axis signal
* BodyAccJerkY_mean: num; Mean of Time Body Accelerometer Jerk Y-axis signal
* BodyAccJerkZ_mean: num; Mean of Time Body Accelerometer Jerk Z-axis signal
* BodyAccJerkX_sd: num; Standard Deviation of Time Body Accelerometer Jerk X-axis signal
* BodyAccJerkY_sd: num; Standard Deviation of Time Body Accelerometer Jerk Y-axis signal
* BodyAccJerkZ_sd: num; Standard Deviation of Time Body Accelerometer Jerk Z-axis signal
* BodyGyroX_mean: num; Mean of Time Body Gyroscope X-axis raw signal
* BodyGyroY_mean: num; Mean of Time Body Gyroscope Y-axis raw signal
* BodyGyroZ_mean: num; Mean of Time Body Gyroscope Z-axis raw signal
* BodyGyroX_sd: num; Standard Deviation of Time Body Gyroscope X-axis raw signal
* BodyGyroY_sd: num; Standard Deviation of Time Body Gyroscope Y-axis raw signal 
* BodyGyroZ_sd: num; Standard Deviation of Time Body Gyroscope Z-axis raw signal
* BodyGyroJerkX_mean: num; Mean of Time Body Gyroscope Jerk X-axis signal
* BodyGyroJerkY_mean: num; Mean of Time Body Gyroscope Jerk Y-axis signal
* BodyGyroJerkZ_mean: num; Mean of Time Body Gyroscope Jerk Z-axis signal
* BodyGyroJerkX_sd: num; Standard Deviation of Time Body Gyroscope Jerk X-axis signal
* BodyGyroJerkY_sd: num; Standard Deviation of Time Body Gyroscope Jerk Y-axis signal
* BodyGyroJerkZ_sd: num; Standard Deviation of Time Body Gyroscope Jerk Z-axis signal
* BodyAccMag_mean: num; Mean of Time Body Accelerometer Magnitude signal
* BodyAccMag_sd: num; Standard Deviation of Time Body Accelerometer Magnitude signal
* GravityAccMag_mean: num; Mean of Time Gravity Accelerometer Magnitude signal
* GravityAccMag_sd: num; Standard Deviation of Time Gravity Accelerometer Magnitude signal
* BodyAccJerkMag_mean: num; Mean of Time Body Accelerometer Jerk Magnitude signal
* BodyAccJerkMag_sd: num; Standard Deviation of Time Body Accelerometer Jerk Magnitude signal
* BodyGyroMag_mean: num; Mean of Time Body Gyroscope Magnitude signal
* BodyGyroMag_sd: num; Standard Deviation of Time Body Gyroscope Magnitude signal
* BodyGyroJerkMag_mean: num; Mean of Time Body Gyroscope Jerk Magnitude signal
* BodyGyroJerkMag_sd: num; Standard Deviation of Time Body Gyroscope Jerk Magnitude signal
* fBodyAccX_mean: num; Mean of FFT Time Body Accelerometer X-axis raw signal
* fBodyAccY_mean: num; Mean of FFT Time Body Accelerometer Y-axis raw signal
* fBodyAccZ_mean: num; Mean of FFT Time Body Accelerometer Z-axis raw signal
* fBodyAccX_sd: num; Standard Deviation of FFT Time Body Accelerometer X-axis raw signal
* fBodyAccY_sd: num; Standard Deviation of FFT Time Body Accelerometer Y-axis raw signal
* fBodyAccZ_sd: num; Standard Deviation of FFT Time Body Accelerometer Z-axis raw signal
* fBodyAccFreqX_mean: num; Mean of FFT Time Body Accelerometer Frequency X-axis signal
* fBodyAccFreqY_mean: num; Mean of FFT Time Body Accelerometer Frequency Y-axis signal
* fBodyAccFreqZ_mean: num; Mean of FFT Time Body Accelerometer Frequency Z-axis signal
* fBodyAccJerkX_mean: num; Mean of FFT Time Body Accelerometer Jerk X-axis signal
* fBodyAccJerkY_mean: num; Mean of FFT Time Body Accelerometer Jerk Y-axis signal
* fBodyAccJerkZ_mean: num; Mean of FFT Time Body Accelerometer Jerk Z-axis signal
* fBodyAccJerkX_sd: num; Standard Deviation of FFT Time Body Accelerometer Jerk X-axis signal
* fBodyAccJerkY_sd: num; Standard Deviation of FFT Time Body Accelerometer Jerk Y-axis signal
* fBodyAccJerkZ_sd: num; Standard Deviation of FFT Time Body Accelerometer Jerk Z-axis signal
* fBodyAccJerkFreqX_mean: num; Mean of FFT Time Body Accelerometer Jerk Frequency X-axis signal
* fBodyAccJerkFreqY_mean: num; Mean of FFT Time Body Accelerometer Jerk Frequency Y-axis signal
* fBodyAccJerkFreqZ_mean: num; Mean of FFT Time Body Accelerometer Jerk Frequency Z-axis signal
* fBodyGyroX_mean: num; Mean of FFT Time Body Gyroscope X-axis raw signal
* fBodyGyroY_mean: num; Mean of FFT Time Body Gyroscope Y-axis raw signal
* fBodyGyroZ_mean: num; Mean of FFT Time Body Gyroscope Z-axis raw signal
* fBodyGyroX_sd: num; Standard Deviation of FFT Time Body Gyroscope X-axis raw signal
* fBodyGyroY_sd: num; Standard Deviation of FFT Time Body Gyroscope X-axis raw signal
* fBodyGyroZ_sd: num; Standard Deviation of FFT Time Body Gyroscope X-axis raw signal
* fBodyGyroFreqX_mean: num; Mean of FFT Time Body Gyroscope Frequency X-axis signal
* fBodyGyroFreqY_mean: num; Mean of FFT Time Body Gyroscope Frequency Y-axis signal
* fBodyGyroFreqZ_mean: num; Mean of FFT Time Body Gyroscope Frequency Z-axis signal
* fBodyAccMag_mean: num; Mean of FFT Time Body Accelerometer Magnitude signal
* fBodyAccMag_sd: num; Standard Deviation of FFT Time Body Accelerometer Magnitude signal
* fBodyAccMagFreq_mean: num; Mean of FFT Time Body Accelerometer Magnitude Frequency signal
* fBodyAccJerkMag_mean: num; Mean of FFT Time Body Accelerometer Jerk Magnitude signal
* fBodyAccJerkMag_sd: num; Standard Deviation of FFT Time Body Accelerometer Magnitude Frequency signal
* fBodyAccJerkMagFreq_mean: num; Mean of FFT Time Body Accelerometer Jerk Magnitude Frequency signal
* fBodyGyroMag_mean: num; Mean of FFT Time Body Gyroscope Magnitude signal
* fBodyGyroMag_sd: num; Standard Deviation of FFT Time Body Gyroscope Magnitude signal
* fBodyGyroMagFreq_mean: num; Mean of FFT Time Body Gyroscope Magnitude Frequency signal
* fBodyGyroJerkMag_mean: num; Mean of FFT Time Body Gyroscope Jerk Magnitude signal
* fBodyGyroJerkMag_sd: num; Standard Deviation of FFT Time Body Gyroscope Jerk Magnitude signal
* fBodyGyroJerkMagFreq_mean: num; Mean of FFT Time Body Gyroscope Jerk Magnitude Frequency signal