---
title: "CodeBook"
author: "Bruce Montgomery"
date: "Sunday, March 22, 2015"
output: html_document
---

## Code Book for UCI HAR Dataset
### Class Project - Getting and Cleaning Data

### Introduction

Per the assigment instructions, this code book describes creating a tidy data set from
the UCI HAR Dataset.  It includes sections on the study design and the code book for the data.

### Study Design

This code book describes creating a tidy data set from the UCI HAR Dataset found at:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

which is described at URL:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

An R script, run_analysis.r, was created to tidy the data and create an output summary file
called "UCI_HAR_Summary.txt"

It assumes the "UCI HCR Dataset" directory stucture found in the zip file abobe
has been extracted to a work directory without modifications.

The run_analysis script asks for two inputs: the top level UCI HAR Dataset directory location
and a working directory location to place the summary text file into.

On windows, a typical function call inside R might look like:
run_analysis('~/RWork/UCI HAR Dataset','~/Rwork')

The run_analysis.R script uses the dplyr and tidyr data libraries, and after reading in
all the general, test, and train data, follows this procedure:

There are 8 data sets to tidy up:
 * activity_labels (6 x 2 - id and description) 
 * feature_labels (561 x 2 - id and description)
 * X_train and X_test (n x 561 - 561 columns of feature data)
 * y_train and y_test (n x 1 - 1 column of activity ids)
 * subject_train and subject_test (n x 1 - 1 column of subject ids)

The tidying tasks include these steps:
 1. Merge the training and the test sets to create one data set.
 2. Extract only the measurements on the mean and standard deviation for each measurement. 
 3. Use descriptive activity names to name the activities in the data set
 4. Appropriately label the data set with descriptive variable names 
 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. This data set should go to a txt file created with write.table() using row.name=FALSE.

See the run_analysis.r script for further details of how these tasks are completed.

### Code Book

In tidying the data, only the columns representing means and standard deviations are kept from the
original data.  The combined test and train data are gathered in a tidy data set called X_final_tbl
in the run_analysis.r script.  The summary data set uses the same labeled values, grouped by activity_desc and subject 
and the mean of each data column is computed.  (The activity and type columns are not included in the summary.)

Data gathered includes the descriptive data, as well as time and frequency domain data from triaxial (X/Y/Z) acceleration from the accelerometer (total acceleration), estimated body acceleration, and Triaxial Angular velocity from the gyroscope.  More details of the data elements are included with the original source.


Descriptive values:  

|Column Name| Description|
|----------------------|--------------------|
|activity|Index 1-6 indicating the activity type|
|activity_desc|Text description of the activity|
| |(Laying, Sitting, Standing, Walking,|
| |Walking Downstairs, Walking Upstairs)|
|subject|Index 1-30 for the subject ID|
|type|Text description of data type (Test or Train)|

Time domain values - means:  

|Column Name                 | Description|
|---------------------------|------------------------------------------------------------------|
|tBodyAcc-mean()-X           | Body Accelerometer Signals (X, Y, and Z directions)|
|tBodyAcc-mean()-Y           | |
|tBodyAcc-mean()-Z	          | |
|tGravityAcc-mean()-X        | Gravity Accelerometer Signals (X, Y, and Z directions)|
|tGravityAcc-mean()-Y	      | tGravityAcc-mean()-Z	      |
|tBodyAccJerk-mean()-X	      | Body Accelerometer Jerk Signals (X, Y, and Z directions)|
|tBodyAccJerk-mean()-Y	      | |
|tBodyAccJerk-mean()-Z	      | |
|tBodyGyro-mean()-X          | Body Gyroscope Signals (X, Y, and Z directions)	|
|tBodyGyro-mean()-Y	        | |
|tBodyGyro-mean()-Z	        | |
|tBodyGyroJerk-mean()-X	    | Body Gyroscope Jerk Signals (X, Y, and Z directions)|
|tBodyGyroJerk-mean()-Y	    | |
|tBodyGyroJerk-mean()-Z	    | |
|tBodyAccMag-mean()	        | Body Acceleration Magnitude|
|tGravityAccMag-mean()	      | Gravity Acceletation Magnitude|
|tBodyAccJerkMag-mean()	    | Body Acceletation Jerk Magnitude|
|tBodyGyroMag-mean()	        | Body Gyroscope Magnitude|
|tBodyGyroJerkMag-mean()	    | Body Gyroscope Jerk Magnitude|

Frequency domain values - means:  

|Column Name                 | Description|
|--------------------------|------------------------------------------------------------------|
|fBodyAcc-mean()-X	          | Body Accelerometer Signals (X, Y, and Z directions)|
|fBodyAcc-mean()-Y	          | |
|fBodyAcc-mean()-Z	          | |
|fBodyAccJerk-mean()-X       | Body Accelerometer Jerk Signals (X, Y, and Z directions)	|
|fBodyAccJerk-mean()-Y	      | |
|fBodyAccJerk-mean()-Z	      | |
|fBodyGyro-mean()-X	        | Body Gyroscope Signals (X, Y, and Z directions)|
|fBodyGyro-mean()-Y	        | |
|fBodyGyro-mean()-Z	        | |
|fBodyAccMag-mean()	        | Body Acceleration Magnitude|
|fBodyBodyAccJerkMag-mean()	| Body Acceletation Jerk Magnitude|
|fBodyBodyGyroMag-mean()	    | Body Gyroscope Magnitude|
|fBodyBodyGyroJerkMag-mean()	| Body Gyroscope Jerk Magnitude|

Time domain values - standard deviations:  

|Column Name                 | Description |
|---------------------------|------------------------------------------------------------------|
|tBodyAcc-std()-X	          | Body Accelerometer Signals (X, Y, and Z directions)
|tBodyAcc-std()-Y	          | 
|tBodyAcc-std()-Z	          | 
|tGravityAcc-std()-X	        | Gravity Accelerometer Signals (X, Y, and Z directions)
|tGravityAcc-std()-Y	        | 
|tGravityAcc-std()-Z	        | 
|tBodyAccJerk-std()-X	      | Body Accelerometer Jerk Signals (X, Y, and Z directions)
|tBodyAccJerk-std()-Y	      | 
|tBodyAccJerk-std()-Z	      | 
|tBodyGyro-std()-X	          | Body Gyroscope Signals (X, Y, and Z directions)
|tBodyGyro-std()-Y           | 	
|tBodyGyro-std()-Z	          | 
|tBodyGyroJerk-std()-X	      | Body Gyroscope Jerk Signals (X, Y, and Z directions)
|tBodyGyroJerk-std()-Y	      | 
|tBodyGyroJerk-std()-Z	      | 
|tBodyAccMag-std()	          | Body Acceleration Magnitude
|tGravityAccMag-std()	      | Gravity Acceletation Magnitude
|tBodyAccJerkMag-std()	      | Body Acceletation Jerk Magnitude
|tBodyGyroMag-std()	        | Body Gyroscope Magnitude
|tBodyGyroJerkMag-std()	    | Body Gyroscope Jerk Magnitude

Frequency domain values - standard deviations:  

|Column Name                 | Description|
|---------------------------|---------------------------------------------------|
|fBodyAcc-std()-X	          | Body Accelerometer Signals (X, Y, and Z directions)|
|fBodyAcc-std()-Y	          | |
|fBodyAcc-std()-Z	          | |
|fBodyAccJerk-std()-X	      | Body Accelerometer Jerk Signals (X, Y, and Z directions)|
|fBodyAccJerk-std()-Y	      | |
|fBodyAccJerk-std()-Z	      | |
|fBodyGyro-std()-X	          | Body Gyroscope Signals (X, Y, and Z directions)|
|fBodyGyro-std()-Y	          | |
|fBodyGyro-std()-Z	          | |
|fBodyAccMag-std()	          | Body Acceleration Magnitude|
|fBodyBodyAccJerkMag-std()	  | Body Acceletation Jerk Magnitude|
|fBodyBodyGyroMag-std()	    | Body Gyroscope Magnitude|
|fBodyBodyGyroJerkMag-std()  | Body Gyroscope Jerk Magnitude|

