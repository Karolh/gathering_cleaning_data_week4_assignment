## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              destfile = "data/dataset.zip", method = "curl")

## Staring over - only need trained data & not Inertial Signal data
x_train <- read.table("data/train/X_train.txt", stringsAsFactors = FALSE, header = FALSE)
y_train <- read.table("data/train/y_train.txt", stringsAsFactors = FALSE, header = FALSE)
subject_train <- read.table("data/train/subject_train.txt", stringsAsFactors = FALSE, header = FALSE)
act_lab <- read.table("data/activity_labels.txt", stringsAsFactors = FALSE, header = FALSE)

## Important not to sort here as merge seems to automatically sort which would 
## really mess up any merging
y_train <- merge(y_train, act_lab, by.x = "V1", by.y = "V1", sort = FALSE)
## Name the columns
colnames(y_train) <- c("class", "activity")

## Load the features to get the column names for the x_train data.
features <- read.table("data/features.txt", stringsAsFactors = FALSE, header = FALSE)
## Apply the column names
colnames(x_train) <- features$V2

## Merge x_train data with subjects
## merging by row index
## This will add 2 new columns - Row.names 
x_tr_sub <- merge(subject_train, x_train, by.x = 0, by.y = 0, sort = FALSE)

## Rename V1 row to subject
colnames(x_tr_sub)[colnames(x_tr_sub) == "V1"] <- "subject"

## This will speed things up for the merging
x_tr_sub <- tbl_df(x_tr_sub)
y_tr_sub <- tbl_df(y_tr_sub)

## Removing the Row.names column from the x_tr_sub datasets 
x_tr_sub <- select(x_tr_sub, 2:length(names(x_tr_sub)))
## Only need the activity columns
y_tr_sub <- select(y_tr_sub,  activity)
x_y_tr_merged <- cbind(x_tr_sub, y_tr_sub) ## That's the training data merged

## Now the test data
## Starting with the X_test.txt
x_test <- read.table("data/test/X_test.txt", stringsAsFactors = FALSE, header = FALSE)
## Add column names to x_test dataset
colnames(x_test) <- features$V2
## Get the subject data
subject_test <- read.table("data/test/subject_test.txt", stringsAsFactors = FALSE, header = FALSE)
## Merge subject data with the x_test data
x_test_sub <- merge(subject_test, x_test, by.x = 0, by.y = 0, sort = FALSE)
## Rename the V1 col to "subject"
colnames(x_test_sub)[colnames(x_test_sub) == "V1"] <- "subject"
## Remove column "Row.names" from the merged x_test_sub dataset
x_test_sub <- select(x_test_sub, 2:length(names(x_test_sub)))
## -- finished transforming x_test data

## Now read and transform the the y_test data
y_test <- read.table("data/test/y_test.txt", stringsAsFactors = FALSE, header = FALSE)
## Apply the Activty labels to the y_test data
y_test <- merge(y_test, act_lab, by.x = "V1", by.y = "V1", sort = FALSE)
colnames(y_test) <- c("class", "activity")
y_test_sub <- merge(subject_test, y_test, by.x = 0, by.y = 0, sort = FALSE)
colnames(y_test_sub)[colnames(y_test_sub) == "V1"] <- "subject"

## Only unterested in the activity column
y_test_sub <- select(y_test_sub, subject, activity)

test_data <- merge(y_test_sub, x_test_sub, by.x = 0, by.y = 0, sort = FALSE) 

## --- Merging of test data complete







