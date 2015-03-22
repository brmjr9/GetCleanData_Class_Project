## Bruce Montgomery 3/16/2015 brmjr@computer.org

## Class project: Getting and Cleaning Data 

## This R function is a custom function for preparing a tidy data set from 
## the data found at URL:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## which is described at URL:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## It assumes the "UCI HCR Dataset" directory has been extracted to a work directory.
## It also asks for an output directory for placing a resulting tidy data set. 
##
## On windows, a typical function call might look like:
## run_analysis('~/RWork/UCI HAR Dataset','~/Rwork')

run_analysis <- function(data_directory, output_directory) {
    # 'data_directory' is a character vector of length 1 indicating
    # the location of the directory "UCI HCR Dataset" extracted
		# from the zip file above.
		# 'output_directory' is a character vector of length 1
		# where the resulting tidy data file will be written.
		# Both must be valid directories.

    # Load the data wrangling libraries
    library(dplyr)
    library(tidyr)
      
    # Save the original working directory
		olddir <- getwd()
    
    # Go to the base data directory and get the activity and feature labels
    print("Loading base data...")
    setwd(data_directory)
		activity_labels <- read.table('activity_labels.txt',stringsAsFactors = FALSE)
		feature_labels <- read.table('features.txt',stringsAsFactors = FALSE)
		
    # Go to the test subdirectory and get the subject, X, and y data
		print("Loading test data...")
		setwd('./test')
		X_test <- read.table('X_test.txt')
		y_test <- read.table('y_test.txt')
		subject_test <- read.table('subject_test.txt')

		# Go to the train subdirectory and get the subject, X, and y data
		print("Loading train data...")
		setwd('../train')
		X_train <- read.table('X_train.txt')
    y_train <- read.table('y_train.txt')
		subject_train <- read.table('subject_train.txt')

    # Go to the output directory before we start creating the tidy data
		print("Making tidy data...")
		setwd(output_directory)

    ## We have 8 data sets to tidy up:
    ##   activity_labels (6 x 2 - id and description) 
    ##   feature_labels (561 x 2 - id and description)
    ##   X_train and X_test (n x 561 - 561 columns of feature data)
    ##   y_train and y_test (n x 1 - 1 column of activity ids)
    ##   subject_train and subject_test (n x 1 - 1 column of subject ids)
    ## Tasks (not necessarily in this order):
    ##   1) Merge the training and the test sets to create one data set.
		##   2) Extract only the measurements on the mean and standard deviation for each measurement. 
		##   3) Use descriptive activity names to name the activities in the data set
		##   4) Appropriately label the data set with descriptive variable names 
    ##   5) From the data set in step 4, create a second, independent tidy data set with the 
    ##      average of each variable for each activity and each subject.
    ##      This data set should go to a txt file created with write.table() using row.name=FALSE.
    
		# the activity_label data needs headings
    colnames(activity_labels) <- c("activity", "activity_desc")
		activity_labels_tbl <- tbl_df(activity_labels)
		
    # Start tidying the data with the train data    
		# Use the feature_labels descriptions as the column labels for X_train (step 4)
    colnames(X_train) <- feature_labels[,2]
    # Label the subject and activity columns for later merge
    colnames(subject_train) <- "subject"
    colnames(y_train) <- "activity"
    
    # Put the data into dplyr tables
    X_train_tbl <- tbl_df(X_train)
    subject_tbl <- tbl_df(subject_train)
    y_train_tbl <- tbl_df(y_train)
    
	  # Merge the subject_train subject ids onto X_train in a column called subject (part of step 1)
		# Merge the y_train activity ids onto X_train in a column called activity (part of step 1)
		X_train_tbl <- bind_cols(list(y_train_tbl,subject_tbl,X_train_tbl))
    
		# Replace the X_train activity ids with descriptions from activity_labels (step 3)
		X_train_tbl <- merge(activity_labels_tbl,X_train_tbl,all=TRUE)
    
		# Drop the X_train data columns that are not labeled mean or std (step 2)
    X_train_tbl <- select(X_train_tbl,contains("activity"),contains("subject"),contains("mean()"),contains("std()"))

    # Repeat the tidying steps for the test data
		# Use the feature_labels descriptions as the column labels for X_test (step 4)
		colnames(X_test) <- feature_labels[,2]
		# Label the subject and activity columns for later merge
		colnames(subject_test) <- "subject"
		colnames(y_test) <- "activity"
		
		# Put the data into dplyr tables
		X_test_tbl <- tbl_df(X_test)
		subject_test_tbl <- tbl_df(subject_test)
		y_test_tbl <- tbl_df(y_test)
		
		# Merge the subject_test subject ids onto X_test in a column called subject (part of step 1)
		# Merge the y_test activity ids onto X_test in a column called activity (part of step 1)
		X_test_tbl <- bind_cols(list(y_test_tbl,subject_test_tbl,X_test_tbl))
		
		# Replace the X_test activity ids with descriptions from activity_labels (step 3)
		X_test_tbl <- merge(activity_labels_tbl,X_test_tbl,all=TRUE)
		
		# Drop the X_test data columns that are not labeled mean or std (step 2)
		X_test_tbl <- select(X_test_tbl,contains("activity"),contains("subject"),contains("mean()"),contains("std()"))
		
    # Merge the test and train data into a single data set with a column indicating test or train (complete step 1)
    X_train_tbl <- mutate(X_train_tbl,type="Train")
    X_test_tbl <- mutate(X_test_tbl,type="Test")
    X_final_tbl <- bind_rows(X_train_tbl,X_test_tbl)
    X_final_tbl <- select(X_final_tbl,contains("activity"),contains("subject"),contains("type"),contains("mean()"),contains("std()"))
    
		## This provides a single tidy data set of the original data
    View(X_final_tbl)
    
    ## Group this data by activity and by subject and create the table of averages (for step 5)    
		print("Making summary data...")
    X_summary_tbl <- X_final_tbl %>% group_by(activity_desc,subject) %>% summarise_each(funs(mean),-activity,-type)
		View(X_summary_tbl)
    
    ## Write this data out to a txt file as specified (complete step 5)
		write.table(X_summary_tbl,file="UCI_HAR_Summary.txt",row.name=FALSE)
    
    # set the work directory back to the original directory
    setwd(olddir)
		print("Run Analysis Complete")
	}