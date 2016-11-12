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

readData <- function(directory, partition) {

    x_data <- readXData(directory, partition);
    y_data <- readYData(directory, partition);
    merged_data <- cbind(x_data, y_data) ## That's the training data merged
    mutate(merged_data, partition = partition)

    
}

readYData <- function(directory, partition) {
    y_data_file <-  paste(directory, "/", partition, "/", "y_", partition, ".txt", sep = "")
    y_train <- read.table(y_data_file, stringsAsFactors = FALSE, header = FALSE)
    
    activity_file <- paste(directory, "/", "activity_labels.txt", sep = "")
    act_lab <- read.table(activity_file, stringsAsFactors = FALSE, header = FALSE)
    
    ## 3. Uses descriptive activity names to name the activities in the data set
    ## Important not to sort here as merge seems to automatically sort which would 
    ## really mess up any merging
    y_train <- merge(y_train, act_lab, by.x = "V1", by.y = "V1", sort = FALSE)
    colnames(y_train) <- c("class", "activity")
    
    ## Only need the activity columns
    y_train <- select(y_train,  activity)
    y_train
    
}

readXData <- function(directory, partition) {
    x_data_file <-  paste(directory, "/", partition, "/", "X_", partition, ".txt", sep = "")
    x_train <- read.table(x_data_file, stringsAsFactors = FALSE, header = FALSE)
    
    ## Load the features to get the column names for the x_train data.
    features <- read.table("data/features.txt", stringsAsFactors = FALSE, header = FALSE)
    ## Apply the column names
    colnames(x_train) <- features$V2
    
    subject_file <- paste(directory, "/", partition, "/", "subject_", partition, ".txt", sep = "")
    subject_train <- read.table(subject_file, stringsAsFactors = FALSE, header = FALSE)
    
    ## Merge x_train data with subjects
    ## merging by row index
    ## This will add 2 new columns - Row.names 
    x_tr_sub <- merge(subject_train, x_train, by.x = 0, by.y = 0, sort = FALSE)
    
    ## Rename V1 row to subject
    colnames(x_tr_sub)[colnames(x_tr_sub) == "V1"] <- "subject"
    
    ## Removing the Row.names column from the x_tr_sub datasets 
    x_tr_sub <- select(x_tr_sub, 2:length(names(x_tr_sub)))
    x_tr_sub
}





