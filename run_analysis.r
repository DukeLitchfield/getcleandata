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
                
#combine y data
y_data <- rbind(y_test,y_train)

#combine x data
x_data <- rbind(x_test,x_train)

#begin code to extract only mean & std dev cols from x data

#extract mean and std dev col #s from features
f1 <- grep("-(mean|std)\\(\\)", features[, 2])

#extract mean/std cols from x_data
x_data <- x_data[, f1]
#Colnames of x_data lbeled appropriatey
names(x_data) <- features[f1,2] #10299 x 66

#combine all
all_data <- cbind(sub_data,y_data,x_data) #10299 x 68
#rename cols 1 &2
colnames(all_data)[1:2] <- c("subject","activity")

#change acivity values to descriptive names
all_data[,2] <- activitylabels[all_data[,2],2]


#generate mean tidy table
avg_dat <- ddply(all_data, .(subject,activity),function(all_data) colMeans(all_data[,3:68]))
write.table(avg_dat, "averages_data.txt", row.name=FALSE)


