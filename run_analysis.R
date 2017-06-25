## Loading the packages
library(data.table)
library(reshape2)

## getting the path 
path <- getwd()


## Getting The data 
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(path)){
    dir.create(path)
}
downloadedFile <- download.file(url,file.path(path,"ProjectFile.zip"))

##Unzip the file
unzip(zipfile = "ProjectFile.zip")

## The file is stored as UCI HAR Dataset 
## We list the contents in this folder
pathIn <- file.path(path,"UCI HAR Dataset")
list.files(pathIn,recursive = TRUE)

##Reading the files 

#Reading the features file
features <- read.table(file.path(pathIn,"features.txt"))
features[,2] <- as.character(features[,2])
setnames(features,c("V1","V2"),c("FeatureID","Feature"))

#Reading the activity labels
activityLabels <- read.table(file.path(pathIn,"activity_labels.txt"))


##Inorder to get the desired fields
#Getting the list of means and standard deviation features
getDesired <- grep(pattern = ".*mean.*|.*std.*", features[,2])
desiredNames <- features[getDesired,2]

# Reading the subject files
testSub <- read.table(file.path(pathIn,"test","subject_test.txt"))
trainSub <-read.table(file.path(pathIn,"train","subject_train.txt"))

#Reading the training and testing labels
testY <- read.table(file.path(pathIn,"test","y_test.txt"))
trainY <- read.table(file.path(pathIn,"train","y_train.txt"))


  
#Reading the data sets 
#Since we only need the columns of the data sets containing mean and standard deviation
#We subset the table here only by extracting the column numbers as indicated by 
#the variable getDesired.
testX <- read.table(file.path(pathIn,"test","X_test.txt"))[getDesired]
trainX <- read.table(file.path(pathIn,"train","X_train.txt"))[getDesired]


  
## Merging the files to create one complete data set
  
#Merging the testing and training files, row wise 
dtSubject <- rbind(testSub,trainSub)
dtLabels <- rbind(testY,trainY)
dt <- rbind(testX,trainX)

#Creating a larger data set encompassing the three existing data sets  
dt <- cbind(dtSubject,dtLabels,dt)
#Renaming variable names 
#As they need  to be very descriptive in a tidy data set.
colnames(dt) <- c("SubjectID","Activity",desiredNames)

##Giving descriptive activity names to  the activities in the data set
dt$Activity<-  factor(dt$Activity,levels = activityLabels[,1],labels = activityLabels[,2])


##To make the Tidy Dataset
#Melting the data into a new table 
dtMelted <- melt(dt,id = c("SubjectID","Activity"))

#Applying a formula 
dtMean <- dcast(dtMelted,SubjectID + Activity ~ variable, mean)

#Writing the tidy data to a new .txt file
write.table(dtMean,"tidy_data.txt",row.names = FALSE,quote = FALSE)
