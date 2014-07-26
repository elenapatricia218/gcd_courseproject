## Getting and Cleaning Data
## Course Project

getwd()
setwd("/Users/Elena/gcd_courseproject")

# ------------------------------------------------
# download the files from the website
# ------------------------------------------------

# identify the link
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download only if it doesn't already exist
if (!file.exists("./samsung_data.zip")){
        download.file(fileUrl,destfile="./samsung_data.zip",method="curl")
}
# unzip & take a look
unzip("./samsung_data.zip")
list.files()
# creates a folder called "UCI HAR Dataset"
list.files("./UCI HAR Dataset")
# contains 4 text files and 2 folders
list.files("./UCI HAR Dataset/test")
# contains 3 text files and 1 folder
list.files("./UCI HAR Dataset/train")
# contains 3 text files and 1 folder

# ------------------------------------------------
# read all the necessary files in
# for the training dataset
# and create a master training dataset
# ------------------------------------------------

# ------------------------------------------------
# satisfies the needs in step 3
# Step 3 Uses descriptive activity names to name the activities in the dataset
# ------------------------------------------------

# read in table with column names
column_names <- read.table("./UCI HAR Dataset/features.txt",header=FALSE,
                           stringsAsFactors=FALSE)
# create a new var which makes them all lowercase
# this is to enable the identification of all of the 
# mean and std variables
column_names$true_names <- tolower(column_names$V2)
column_names

# read in the table with activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,
                      stringsAsFactors=FALSE)
colnames(activity_labels) <- c("ylab","activity")
str(activity_labels)
activity_labels

# now read in the training dataset
samsung_Xtrain=read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE,
                          stringsAsFactors=FALSE)
dim(samsung_Xtrain)
str(samsung_Xtrain)

# assign column names to the training dataset
colnames(samsung_Xtrain) <- column_names$true_names
str(samsung_Xtrain)

# read in the ytrain labels
samsung_ytrain=read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE,
                          stringsAsFactors=FALSE)
dim(samsung_ytrain)
str(samsung_ytrain)
unique(samsung_ytrain)
colnames(samsung_ytrain) <- c("ylab")
str(samsung_ytrain)

# merge on activity labels
samsung_ytrain_labels <- merge(samsung_ytrain,activity_labels,by="ylab")
samsung_ytrain_labels
str(samsung_ytrain_labels)

# assign ytrain labels to the dataset
samsung_Xtrain_lab <- cbind(samsung_ytrain_labels,samsung_Xtrain)
str(samsung_Xtrain_lab)

# read table of the subjects who performed the experiment
samsung_strain=read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE,
                          stringsAsFactors=FALSE)
dim(samsung_strain)
str(samsung_strain)
unique(samsung_strain)
colnames(samsung_strain) <- c("subject_no")
str(samsung_strain)

# create master training dataset with subject indicators
samsung_train <- cbind(samsung_strain,samsung_Xtrain_lab)
# add a variable to indicate which dataset it came from
samsung_train$group="train"
str(samsung_train)

# ------------------------------------------------
# read all the necessary files in
# for the test dataset
# and create a master test dataset
# ------------------------------------------------

# don't need to read in table with column names
# since we already did that

# now read in the test dataset
samsung_Xtest=read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE,
                          stringsAsFactors=FALSE)
dim(samsung_Xtest)
str(samsung_Xtest)

# assign column names to the test dataset
colnames(samsung_Xtest) <- column_names$true_names
str(samsung_Xtest)

# read in the ytest labels
samsung_ytest=read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE,
                          stringsAsFactors=FALSE)
dim(samsung_ytest)
str(samsung_ytest)
unique(samsung_ytest)
colnames(samsung_ytest) <- c("ylab")
str(samsung_ytest)

# merge on activity labels
samsung_ytest_labels <- merge(samsung_ytest,activity_labels,by="ylab")
samsung_ytest_labels
str(samsung_ytest_labels)

# assign ytest labels to the dataset
samsung_Xtest_lab <- cbind(samsung_ytest_labels,samsung_Xtest)
str(samsung_Xtest_lab)

# read table of the subjects who performed the experiment
samsung_stest=read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE,
                          stringsAsFactors=FALSE)
dim(samsung_stest)
str(samsung_stest)
unique(samsung_stest)
colnames(samsung_stest) <- c("subject_no")
str(samsung_stest)

# create master test dataset with subject indicators
samsung_test <- cbind(samsung_stest,samsung_Xtest_lab)
# add a variable to indicate which group it came from
samsung_test$group="test"
str(samsung_test)

# ------------------------------------------------
# Step 1 Merges the training and the test sets to create one data set
# merge the training and test datasets
# to get one total master dataset
# ------------------------------------------------

samsung_master <- rbind(samsung_train,samsung_test)
str(samsung_master)
unique(samsung_master$subject_no)
# check interaction of subject and activity
table(samsung_master$subject_no,samsung_master$activity)
# will have 40 records

# ------------------------------------------------
# Step 2 extracts only the measurements on the mean and standard deviation
# for each measurement

# create first tidy dataset
# with only the mean and standard deviations
# and necessary linking variables
# ------------------------------------------------

# identify columns with mean
# and subset
samsung_master_mean <- samsung_master[,grepl("mean",names(samsung_master))]
str(samsung_master_mean)

# identify columns with std
# and subset
samsung_master_std <- samsung_master[,grepl("std",names(samsung_master))]
str(samsung_master_std)

# ------------------------------------------------
# Step 4 Appropriately labels the data set with descriptive variable names
# ------------------------------------------------

# include id/linking variables
subject_number <- samsung_master[,1]
activity <- samsung_master[,3]
#test_or_train <- samsung_master[,565]
# put them all together
samsung_subset <- cbind(subject_number,activity,#test_or_train, 
                        samsung_master_mean, samsung_master_std)
str(samsung_subset)

# ------------------------------------------------
# step 5 creates a second, independent tiny data set with the average
# of each variable for each activity and each subject

# aggregate the data by activity by subject
# using the function to average each value
# across all records for an activity/person
# ------------------------------------------------

samsung_aggregated <- aggregate.data.frame(samsung_subset[,3:88],
                        by=list(activity,subject_number),
                        FUN=mean,
                        na.rm=TRUE)
str(samsung_aggregated)
samsung_aggregated <- rename(samsung_aggregated, replace=c("Group.1"="activity"))
samsung_aggregated <- rename(samsung_aggregated, replace=c("Group.2"="subject"))
str(samsung_aggregated)
samsung_aggregated

samsung_aggregated[order(samsung_aggregated$activity,samsung_aggregated$subject),]
samsung_aggregated

# ------------------------------------------------
# output the final file
# ------------------------------------------------

write.table(samsung_aggregated, file="./samsung_aggregated_output.txt",
            sep="|",col.names=TRUE)

# test reading it in
read.table("./samsung_aggregated_output.txt",header=TRUE, sep="|",
           stringsAsFactors=FALSE)