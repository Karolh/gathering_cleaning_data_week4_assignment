## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


runAnalysis <- function(){
    
    downloadData()
    directory <- "data/UCI HAR Dataset"
    trainData <- readData(directory, "train")
    testData <- readData(directory, "test")
    
    ## Finally merge both datasets together
    ## 1. Merges the training and the test sets to create one data set.
    data <- rbind(train_data, test_data)
    
    ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    ## Extracting measurements on the mean and standard deviation 
    data <- select(data, subject, activity, partition, contains("std()"), contains("mean()"))
    data
}

## Data is downloaded to a data directory
## If the data directory doesn't exist then it creates it
## This function then downloads the data to a zip file - dataset.zip
## Which is unziped in the data directory
downloadData <- function() {
    if(!dir.exists("data")){
        dir.create("data")
    }
    
    if (!file.exists("data/dataset.zip")){
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                      destfile = "data/dataset.zip", method = "curl")
        unzip("data/dataset.zip", exdir = "data")
    }
    
    
}

## This reads the X and Y data merges them and then adds a partition column
readData <- function(directory, partition) {

    x_data <- readXData(directory, partition);
    y_data <- readYData(directory, partition);
    merged_data <- cbind(x_data, y_data) ## That's the training data merged
    mutate(merged_data, partition = partition)

    
}

## Reads the Y data, applies labels to it
## Returns the Y table with just the activity labels
readYData <- function(directory, partition) {
    y_data_file <-  paste(directory, "/", partition, "/", "y_", partition, ".txt", sep = "")
    y_data <- read.table(y_data_file, stringsAsFactors = FALSE, header = FALSE)
    
    activity_file <- paste(directory, "/", "activity_labels.txt", sep = "")
    act_lab <- read.table(activity_file, stringsAsFactors = FALSE, header = FALSE)
    
    ## 3. Uses descriptive activity names to name the activities in the data set
    ## Important not to sort here as merge seems to automatically sort which would 
    ## really mess up any merging
    y_data <- merge(y_data, act_lab, by.x = "V1", by.y = "V1", sort = FALSE)
    colnames(y_data) <- c("class", "activity")
    
    ## Only need the activity columns
    y_data <- select(y_data,  activity)
    y_data
    
}

## This gets the x data.
## Applies column names to it from the features file
## Applies the subject colum - to identify the subjects with their data
## Cleans the data up a bit
readXData <- function(directory, partition) {
    x_data_file <-  paste(directory, "/", partition, "/", "X_", partition, ".txt", sep = "")
    x_data <- read.table(x_data_file, stringsAsFactors = FALSE, header = FALSE)
    
    ## Load the features to get the column names for the x_data data.
    features_file <-  paste(directory, "/", "features.txt", sep = "")
    features <- read.table(features_file, stringsAsFactors = FALSE, header = FALSE)
    ## Apply the column names
    colnames(x_data) <- features$V2
    
    subject_file <- paste(directory, "/", partition, "/", "subject_", partition, ".txt", sep = "")
    subject <- read.table(subject_file, stringsAsFactors = FALSE, header = FALSE)
    
    ## Merge x_data data with subjects
    ## merging by row index
    ## This will add 2 new columns - Row.names 
    x_data <- merge(subject, x_data, by.x = 0, by.y = 0, sort = FALSE)
    
    ## Rename V1 row to subject
    colnames(x_data)[colnames(x_data) == "V1"] <- "subject"
    
    ## Removing the Row.names column from the x_data datasets 
    x_data <- select(x_data, 2:length(names(x_data)))
    x_data
}





