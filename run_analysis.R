## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
              destfile = "data/dataset.zip", method = "curl")

## Read acceleration data x
acc_x_train <- read.table("data/train/Inertial Signals/body_acc_x_train.txt", stringsAsFactors = FALSE, header = FALSE)
acc_y_train <- read.table("data/train/Inertial Signals/body_acc_y_train.txt", stringsAsFactors = FALSE, header = FALSE)
acc_z_train <- read.table("data/train/Inertial Signals/body_acc_z_train.txt", stringsAsFactors = FALSE, header = FALSE)

## get the subject data - 
subject_train <- read.table("data/train/subject_train.txt", stringsAsFactors = FALSE, header = FALSE)

merged_x_sub <- merge(subject_train, acc_x_train, by.x = 0, by.y = 0, sort = FALSE)
merged_y_sub <- merge(subject_train, acc_y_train, by.x = 0, by.y = 0, sort = FALSE)
merged_z_sub <- merge(subject_train, acc_z_train, by.x = 0, by.y = 0, sort = FALSE)

merged_x_sub <- merged_x_sub %>% mutate(axis = 'x')
merged_y_sub <- merged_y_sub %>% mutate(axis = 'y')
merged_z_sub <- merged_z_sub %>% mutate(axis = 'z')

