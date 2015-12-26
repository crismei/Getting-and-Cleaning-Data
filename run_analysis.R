# Download File

if(!file.exists("./CourseProject")){dir.create("./CourseProject")}

fileUrl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./CourseProject/archive.zip")

# Unzip
unzip("./CourseProject/archive.zip")

# List the files to verify the name of unziped file
list.files()
list.files("./UCI HAR Dataset")
list.files("./UCI HAR Dataset/test")
list.files("./UCI HAR Dataset/train")

# To examine the files
library(descr)
file.head("./UCI HAR Dataset/test/X_test.txt")
file.head("./UCI HAR Dataset/test/subject_test.txt")
file.head("./UCI HAR Dataset/test/y_test.txt")

file.head("./UCI HAR Dataset/train/X_train.txt")
file.head("./UCI HAR Dataset/train/subject_train.txt")
file.head("./UCI HAR Dataset/train/y_train.txt")

# To verify the number of observations
length(readLines("./UCI HAR Dataset/test/X_test.txt"))
length(readLines("./UCI HAR Dataset/test/subject_test.txt"))
length(readLines("./UCI HAR Dataset/test/y_test.txt"))

length(readLines("./UCI HAR Dataset/train/X_train.txt"))
length(readLines("./UCI HAR Dataset/train/subject_train.txt"))
length(readLines("./UCI HAR Dataset/train/y_train.txt"))

# 1) Merges the training and the test sets to create one data set.
# Load the files and Merge the data
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
test<-cbind(y_test,subject_test,X_test)

X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
train<-cbind(y_train,subject_train,X_train)

AllData<-rbind(test,train)

names(AllData)<-c("activity","subject",names(X_test))

# 2) Extracts only the measurements on the mean and standard deviation for each measurement
# Verify and load the data
file.head("./UCI HAR Dataset/features.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
features_mean_std<-features[grep(".*mean.*|.*std.*", features[,2]),]
names(features_mean_std)<-c("V1","feature")

# 3) Uses descriptive activity names to name the activities in the data set
file.head("./UCI HAR Dataset/activity_labels.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
names(activity_labels)<-c("activity","activityName")
library(dplyr)
AllData<-inner_join(AllData,activity_labels,by=NULL,copy=FALSE)
#shows the Activity ID, Subject and Activity Name
AllData[,c(1,2,564)]

# 4) Appropriately labels the data set with descriptive variable names.
features_names<-features[,2]
features_names<-as.vector(features_names)
names(AllData)<-c("activity","subject",features_names,"activityName")

# 5) From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
mean_data<-aggregate(AllData, by=list(activity = AllData$activity, subject=AllData$subject,activity_name=AllData$activityName), mean)
#Remove columns in duplicated due aggregate
mean_data<-mean_data[-c(4,5,567)]
write.table(mean_data, "mean_data.txt", sep="\t",row.name=FALSE)

