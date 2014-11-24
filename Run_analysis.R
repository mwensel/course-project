# Course Project

# Set Working Directory

setwd("C://Users/e3ew/Desktop/Working Directories")

# read all files and assign each to a variable
# Note that not all raw data is needed as final output requires only mean and sd, found in
# more processed X_test and y_test data


# Test Datasets

x_test<-read.table("UCI HAR Dataset/test/X_test.txt")

y_test<-read.table("UCI HAR Dataset/test/y_test.txt")

# Train Datasets

x_train<-read.table("UCI HAR Dataset/train/X_train.txt")

y_train<-read.table("UCI HAR Dataset/train/y_train.txt")

# Import Variable Names

varnames<-read.table("UCI HAR Dataset/features.txt")

# Merge Train and Test Datasets by row

datframe<-rbind(x_train, x_test)

# Assign Variable Names to columns of data

varnamesvec<-as.vector(varnames[, 2])

names(datframe)<-varnamesvec

# Import Subject Data

subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")

subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")

# Row bind subject data, assign name, then column bind onto data frame to assign subjects to 
# measurements of existing data

subjectdat<-rbind(subject_train, subject_test)

names(subjectdat)<-c("Subject")

datframe<-cbind(datframe, subjectdat)

# Included str function here to check that datframe now has 562 variables
str(datframe)


# Row bind y_train and y_test

activity<-rbind(y_train, y_test)

# Assign names to activity variable

names(activity)<-"activity"


# Reassign each number in activity data frame to relevant character label

activity$activity[which(activity$activity==1)]<-"Walking"

activity$activity[which(activity$activity==2)]<-"Walking_Upstairs"

activity$activity[which(activity$activity==3)]<-"Walking_Downstairs"

activity$activity[which(activity$activity==4)]<-"Sitting"

activity$activity[which(activity$activity==5)]<-"Standing"

activity$activity[which(activity$activity==6)]<-"Laying"

# Column Bind activity to existing data

datframe<-cbind(datframe, activity)

# Check that datframe now has 563 variables
str(datframe)

# Now that data is tidy, extract column names containing "mean" or "std"

namesvec<-names(datframe)

# Use grepl fxn to return a logical vector

logvec<-grepl("std" , namesvec)

logvec2<-grepl("mean", namesvec)

# Find which are TRUE for both logical vectors, add together
istrue<-which(logvec)

istrue2<-which(logvec2)

# combine two new vectors

totaltrue<-c(istrue, istrue2)

totaltrue

# order totaltrue

totaltrueord<-sort(totaltrue)

# subset existing data according to totaltrue, make sure to include columnds 562 and 563 
# as these are acticity and subject

datframe2<-datframe[, c(totaltrueord, 562,563)]

# Apply mean to each numeric vector based on factors in subject and activity

fact1<-factor(datframe2[, 80])

fact2<-factor(datframe2[, 81])

finalfact<-list(fact1, fact2)

finalfact
# Use by to apply column means based on two factors-- subject and activity
finaldat<-by(datframe2[, 1:79], finalfact, colMeans)



