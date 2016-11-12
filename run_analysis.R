## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


runAnalysis <- function(){
    if (!file.exists("data/dataset.zip")){
        downloadData();
    }
    trainData <- readData("data", "train");
    testData <- readData("data", "test")
}

downloadData <- function() {
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                  destfile = "data/dataset.zip", method = "curl")
}

readData <- function(directory, data) {

    x_data <- readXData(directory, data);
    y_data <- readYData(directory, data);
    merged_data <- cbind(x_data, y_data) ## That's the training data merged
    merged_data

    
}

readYData <- function(directory, data) {
    y_data_file <-  paste(directory, "/", data, "/", "y_", data, ".txt", sep = "")
    y_train <- read.table(y_data_file, stringsAsFactors = FALSE, header = FALSE)
    
    activity_file <- paste(directory, "/", "activity_labels.txt", sep = "")
    act_lab <- read.table(activity_file, stringsAsFactors = FALSE, header = FALSE)
    
    ## Important not to sort here as merge seems to automatically sort which would 
    ## really mess up any merging
    y_train <- merge(y_train, act_lab, by.x = "V1", by.y = "V1", sort = FALSE)
    colnames(y_train) <- c("class", "activity")
    
    ## Only need the activity columns
    y_train <- select(y_train,  activity)
    y_train
    
}

readXData <- function(directory, data) {
    x_data_file <-  paste(directory, "/", data, "/", "X_", data, ".txt", sep = "")
    x_train <- read.table(x_data_file, stringsAsFactors = FALSE, header = FALSE)
    
    ## Load the features to get the column names for the x_train data.
    features <- read.table("data/features.txt", stringsAsFactors = FALSE, header = FALSE)
    ## Apply the column names
    colnames(x_train) <- features$V2
    
    subject_file <- paste(directory, "/", data, "/", "subject_", data, ".txt", sep = "")
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





