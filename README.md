# Getting And Clean Data 
# Week 4 Assignment

## Introduction

The purpose of this Assignment is to merge the training and test data obtained from the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Included in the project is the:
* run_analysis.R
* CodeBook.md

## Perform the Analysis

### Prerequisite

The library dplyr is required to use the analysis.

To install dplyr.

```sh
$ install.packages("dplyr")
```

### Load the script
First load the script in the R console:
```sh
$ source("path/to/the/script/run_analysis.R")
```

### Run Analysis
Next, execute the function analysis function in R console:
```sh
$ runAnalysis()
```
This will output the data to the output directory `output`.


### View Summarized Data
To view the generated data run:
```sh
$ readSummarisedData()
```
This will return a data frame of the data in the csv file.

