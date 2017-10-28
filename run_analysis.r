library(plyr)

#set path to UCI HAR Dataset folder
setwd("C:/Users/T470/Desktop/Coursera/Data Science/GCD/Week_4/UCI HAR Dataset")

#Reading test Variables
x_test<-read.table("test/X_test.txt")
y_test<-read.table("test/y_test.txt")
subject_test<-read.table("test/subject_test.txt")

# Reading training variables
x_train<-read.table("train/X_train.txt")
y_train<-read.table("train/y_train.txt")
subject_train<-read.table("train/subject_train.txt")

#Reading feature vector
features<- read.table("features.txt")

#Reading activity labels
activitylabels<- read.table("activity_labels.txt")

#combine subject
sub_data <- rbind(subject_test,subject_train)
                
#combiney data
y_data <- rbind(y_test,y_train)

#combiney data
x_data <- rbind(x_test,x_train)

f1 <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, f1]
names(x_data) <- features[f1,2]

#combine all
all_data <- cbind(sub_data,y_data,x_data)
#rename cols 1 &2
colnames(all_data)[1:2] <- c("subject","activity")

#mean tidy table
x1 <- all_data[,-1:-2]
x2 <- all_data[,1]
x3 <- all_data[,2]
avg_dat <- aggregate(x=x1,by=list(x2,x3),FUN="mean")
write.table(avg_dat, "averages_data.txt", row.name=FALSE)


