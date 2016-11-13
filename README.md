# Getting And Clean Data 
# Week 4 Assignment

## Introduction

The purpose of this Assignment is to merge the training and test data obtained from the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Included in the project is the:
* run_analysis.R
* CodeBook.md
* summarised_data.csv

## Running the Analysis

There are 3 main functions in the `run_analysis.R` script.  This script requires the `dplyr` package to be installed.

To install dplyr.

```sh
$ install.packages("dplyr")
```

### Perform the Analysis

First load the script in the R console:
```sh
$ source("path/to/the/script/run_analysis.R")
```

Next, execute the function analysis function in R console:
```sh
$ runAnalysis()
```
This will output the data to the output directory `output`.

To view the generated data run:
```sh
$ readSummarisedData()
```
This will return a data frame of the data in the csv file.

### Merging the Data

The function `mergeData()`:
* downloads and unzips the data in the directory `data`.  If this directory does not exist it will create it.
* Then it pulls in the data
* Cleans it
* Merges X and y data first for both train and test data.
* Then merges the train and test data
* Finally just extracting columns that have either "mean()" or "std()"

### Summarising the Data

The output from the `mergeData()` function is used in the `summariseData()` function.  This creates a second, independent tidy data set with the average of each variable for each activity and each subject.