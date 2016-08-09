## This script uses the 'Human Activity Recognition Using Smartphones Data Set' from UCI and does the following:

## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement.
## 3.Name the activities in the data set using descriptive activity names.
## 4.Label the data set with descriptive variable names.
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of 
##   each variable for each activity and each subject.

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./UCIHARdataset.zip")
unzip ("UCIHARdataset.zip")

## set working directory to UCIHARdataset.
library(data.table)

Xtest <- read.table("./test/X_test.txt", header = FALSE)
yTest <- read.table("./test/y_test.txt", header = FALSE)
subjTest <- read.table("./test/subject_test.txt", header = FALSE)

setnames(yTest, c("V1"), c("activity"))
setnames(subjTest, c("V1"), c("subject"))

Xtrain <- read.table("./train/X_train.txt", header = FALSE)
yTrain <- read.table("./train/y_train.txt", header = FALSE)
subjTrain <- read.table("./train/subject_train.txt", header = FALSE)

setnames(yTrain, c("V1"), c("activity"))
setnames(subjTrain, c("V1"), c("subject"))

## 1.Merging
library(plyr)

yTest$rn <- rownames(yTest)
subjTest$rn <- rownames(subjTest)
Xtest$rn <- rownames(Xtest)

mergeTest <- join_all(list(subjTest, yTest, Xtest), by = "rn", type = "full")
drops <- c("rn")
mergeTest <- mergeTest[ , !(names(mergeTest) %in% drops)]

yTrain$rn <- rownames(yTrain)
subjTrain$rn <- rownames(subjTrain)
Xtrain$rn <- rownames(Xtrain)

mergeTrain <- join_all(list(subjTrain, yTrain, Xtrain), by = "rn", type = "full")
mergeTrain <- mergeTrain[ , !(names(mergeTrain) %in% drops)]

mergeAll <- merge(mergeTrain,  mergeTest,  all = TRUE)
mergeAllOrd <- mergeAll[order(mergeAll$subject),]

## 2.Extracting
textString <- paste(readLines("features.txt"), collapse=" ")    ## textString is a single string.
splitString <- strsplit(textString, " ")      
splitString <- splitString[[1]]
## Next loop selects variables containing only means or standard deviations.
names.list <- list()     
number.list <- list()
j <- 1
for(i in 1:length(splitString))  {
    string.i <- splitString[i]
    string.i <- gsub("-", "",  string.i)
    string.i <- sub("\\(", "",  string.i)
    string.i <- sub("\\)", "",  string.i)
    if(length(grep("mean[X-Z]$", string.i)) == 1 | 
       length(grep("std[X-Z]$", string.i)) == 1)  {
        names.list[[j]] <- string.i
        number.list[[j]] <- i/2
        j <- j + 1
    }
    if(length(grep("mean$", string.i)) == 1 | 
       length(grep("std$", string.i)) == 1)  {
        names.list[[j]] <- string.i
        number.list[[j]] <- i/2
        j <- j + 1
    }    
}
## Next loop produces the definite variable names.
N <- length(names.list)

var.names <- list()
for(i in 1:N) {
    names.list.i <- strsplit(names.list[[i]],  "")
    l <- length(names.list.i[[1]])
    names.list.i2 <- paste(names.list.i[[1]][c(1:l)],  collapse = "")
    var.names[[i]] <- names.list.i2
    if(length(grep("mean",  names.list.i2)) == 1) {
        var.names[[i]] <- sub("m",  "M",  names.list.i2) 
    }
    if(length(grep("std",  names.list.i2)) == 1) {
        var.names[[i]] <- sub("s",  "S",  names.list.i2)
    }
    if(names.list.i[[1]][1] == "t") {
        var.names[[i]] <- sub("t",  "Time",  names.list.i2) 
    }
    if(names.list.i[[1]][1] == "f") {
        var.names[[i]] <- sub("f",  "FFT",  names.list.i2) 
    }
}

prefix <- "V"
suffix <- as.numeric(number.list)
my.names <- paste(prefix, suffix, sep = "") 
my.names <- c("subject", "activity",  my.names) 

Extract <- mergeAllOrd[, my.names]

## 3.Naming activities
textString2 <- paste(readLines("activity_labels.txt"), collapse=" ")    
splitString2 <- strsplit(textString2, " ")
seq <- seq(2,length(splitString2[[1]]),2)
activity <- splitString2[[1]][seq]
for(i in 1:length(activity)) {
    activity.i <- activity[i] 
    activity.i <- gsub("_", " ",  activity.i, fixed = TRUE)
    activity[i] <- activity.i
}

Extract$activity[Extract$activity == 1] <- activity[1];
Extract$activity[Extract$activity == 2] <- activity[2];
Extract$activity[Extract$activity == 3] <- activity[3];
Extract$activity[Extract$activity == 4] <- activity[4];
Extract$activity[Extract$activity == 5] <- activity[5];
Extract$activity[Extract$activity == 6] <- activity[6]

## 4.Labeling variables
var.names2 <- c("subject", "activity",  as.character(var.names))
Tidy1 <- setnames(Extract, my.names, var.names2)
save(Tidy1, file = "Tidy1.RData")

## 5.Creating the second dataset 
prefix <- "AVER."
suffix = as.character(var.names)
new.var.names <- paste(prefix,  suffix,  sep = "")
namesTidy2 <- c("subject",  "activity",  new.var.names)

Tidy2 <- as.data.frame(setNames(replicate(length(namesTidy2), numeric(0), simplify = FALSE),  namesTidy2))

I = max(Tidy1$subject)
J = length(activity)
for(i in 1:30)  {
    for(j in 1:6)  {
        subset <- Tidy1[which(Tidy1$subject == i & Tidy1$activity == activity[j]),  3:ncol(Tidy1)]
        Tidy2[j + 6*(i-1), ] <- c(i, activity[j], colMeans(subset))
    }
}

save(Tidy2, file = "Tidy2.RData")
write.table(Tidy2, file = "Tidy.txt", row.name = FALSE)


