---
title: "README"
author: "Bruce Montgomery"
date: "Sunday, March 22, 2015"
output: html_document
---

###Readme for UCI HAR Dataset class project for Getting and Cleaning Data

###Repository Contents

This repository includes several files for tidying the UCI HAR Datasets.
* README.md - This file, a breif overview of the elements in the repository
* CodeBook.md - An R Markdown file containg details of the assignment, data sources, and a codebook for the tidyed data.
* run_analysis.R - An R function for taking the data found in the UCI HAR Datasets and creating a tidy combined
   dataset as well as a summary text file (UCI_HAR_Summary.txt)
   
###Analysis Approach

The run_analysis.R script makes a tidy data set from the UCI HAR Dataset found at:

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
1) Merge the training and the test sets to create one data set.
2) Extract only the measurements on the mean and standard deviation for each measurement. 
3) Use descriptive activity names to name the activities in the data set
4) Appropriately label the data set with descriptive variable names 
5) From the data set in step 4, create a second, independent tidy data set with the 
   average of each variable for each activity and each subject.
   This data set should go to a txt file created with write.table() using row.name=FALSE.

See the run_analysis.r script for further details of how these tasks are completed.
