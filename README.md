# GettingAndCleaningData-Project
Contains the course project.

### Data collected from the accelerometers from the Samsung Galaxy S smartphone.

## Requirements of the project 
Creating one R script called run_analysis.R that does the following :- 

   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement.
   3. Uses descriptive activity names to name the activities in the data set
   4. Appropriately labels the data set with descriptive variable names.
   5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable	for each activity and each subject.

## Packages used
Primarily the used packages were - 
	reshape2
	data.table

These were loaded into the environment by using an appropriate code.

## Getting data 
 
The data was obtained from the link - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Appropriate ways of downloading and unzipping the file are mentioned.


## Extracting the measurements on mean and standard deviation 

### It first involves reading the features and subject files and storing them in descriptive variables.

Based on the list of features we read from the features file, we narrow down the list of column numbers we actually need.
Thus obtaining a vector of column numbers which include only the means and standard deviations.


## Reading the files 

On Reading the files we extract only the desired columns which we obtained in the previous step.

## Merging the data sets 

The data sets are merged, by combining the test and train data sets to form one whole data set.
In this set the three individual files are bound to create one single file which contains - subject ID, Activity number and the rest of the feature variables as the column names.

## Using Descriptive activity names

In the data set, to give descriptive names I transformed the activity number into factors where, the activity numbers were levels and the descriptive activity name obtained from the "activity_labels.txt" were the labels.

## Appropriately labels the data set with descriptive variable names 

This has been taken care of while reading the data set, by renaming the variables.

## Creating a tidy data set

Created by subsetting the data set as per requirements and writing it out to a .txt file.
