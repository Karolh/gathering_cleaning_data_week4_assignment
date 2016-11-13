# Code Book

This code book describes the script and the data used by the script `run_analysis.R`.

Included in the project are the files:
* run_analysis.R
* README.md

## Actions performed

### Downloading the Data
* This is a zip filed downloaded to `data/dataset.zip` if it does not exist.
* The `dataset.zip` is unziped to the directory `UCI HAR Dataset`

### The Dataset

For this assignment we're only interested in the data contained in the following from the downloaded data:
* test/X_test.txt
* test/y_test.txt
* test/subject_test.txt
* train/X_train.txt
* train/y_train.txt
* train/subject_train.txt
* activity_labels.txt
* features.txt

The `X` data files provided details on the measurements
The `y` data files associates the activity with the measurements.
The `subject` data provides subject data for the rows in both the `X` and `y` datasets.
The `activity_labels` links the `y` data with their activity names.
The `features` defines the columns in the `X` dataset.

### Cleaning and Merging the Data

Performed by the function `mergeData()`:
* This pulls in the data
* On the `X` data the `readXData()` applies the features as the column names. Then it merges the subject data to it. Naming the merged column as 'subject'.
* On the `y` data the `readYData()` applies labels from the activity_labels.txt.  It renames columns and removes any unneeded columns.
* The `X` and `y` data are merged for both train and test data first.
* Then the train and test data are merged.
* Finally just extracting columns that have either "mean()" or "std()" along with the subject and activty columns.

### Summarising the Data

The output from the `mergeData()` function is used in the `summariseData()` function.  This creates a second, independent tidy data set with the average of each variable for each activity and each subject.
To view the summarised data:
```sh
$ head(readSummarisedData()[, 1:5], 3)
  subject activity tBodyAcc.std...X tBodyAcc.std...Y tBodyAcc.std...Z tGravityAcc.std...X
1       1 STANDING       -0.5457953       -0.3677162       -0.5026457          -0.9598594
2       2 STANDING       -0.6055865       -0.4289630       -0.5893601          -0.9630155
3       3 STANDING       -0.6234136       -0.4800159       -0.6536256          -0.9664576

```