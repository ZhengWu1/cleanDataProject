library(dplyr)
setwd("/Users/mac/Documents/coursera/cleanDataProject")
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./Dataset.zip", method = "curl")
unzip("./Dataset.zip")
features <- read.table("./UCI HAR Dataset/features.txt")
train <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubject, trainLabel, train)
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubject, testLabel, test)
#1
combined <- rbind(train, test)
names(combined) <- make.names(names=c("Subject", "Activity", as.character(features[[2]])), unique=TRUE, allow_ = TRUE)
combined <- tbl_df(combined)
#2
combined <- select(combined, c(1:2, which(grepl("[Mm]ean",names(combined)) | grepl("[Ss]td",names(combined)))))
#3
activityMap <- read.table("./UCI HAR Dataset/activity_labels.txt")
combined <- tbl_df(merge(activityMap, combined, by.x = "V1", by.y = "Activity"))
combined <- mutate(combined, Activity = V2)
combined <- select(combined, Activity, 3:89)
#4
names(combined) <- gsub("[\\.]+", "", names(combined))
#5
combined <- group_by(combined, Activity, Subject)
View(summarise_each(combined, funs(mean)))
summary <- summarise_each(combined, funs(mean))
write.table(summary, "./summary.txt", row.name=FALSE)

