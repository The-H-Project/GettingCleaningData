#  Readme file for Coursera Getting and Cleaning Data Course Project
Version: 24 October 2015

## Purpose
This repository contains the R script, codebook, and readme files as necessary to meet Course Project requirements. The Course Project asks students to take a dataset and provide a summary of selected variables, in accordance tidy data principles.

## Source & License
This project uses the 'Human Activity Recognition Using Smartphones Dataset' (hereafter, 'UCI HAR Dataset') at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

A background description for this dataset is at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  

License Attribution for this dataset is:  
* [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012  

* This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.  

## Included Files
**readme.md**: This file.  

**codebook.md**: The codebook describing the output of this process.  

**run_analysis.R** : This script reads and transforms 6 (six) files from the UCI HAR Dataset into a table that summarizes the mean and standard deviation for the subjects and activities in the dataset. The table is written as space-delimited file 'output.txt' to the 'UCI HAR Dataset' folder.

## Tested Platforms / Additional Requirements
**run_analysis.R** has been tested and confirmed to work on:
- Mac OS 10.11.1 with R Studio 0.99.473 and R 3.2.2.
- Windows 7 with R Studio 0.99.467 and R 3.2.2.

Required R packages that should be installed before  run_analysis.R is used:
- plyr 1.8.3.
- data.table 1.9.6.  

## Procedure
1. The UCI HAR Dataset (listed above, in the Source sections) must be downloaded and extracted to the R current working directory, such that '**UCI HAR Dataset**' is a folder within the current working directory. The extraction process should result  in the placement of '**train**' and '**test**' folders inside the 'UCI HAR Dataset' folder.
2. 'run_analysis.R' is downloaded to the current working directory.
3. The 'run_analysis.R' file is sourced and run within R.

## Output  
The output file 'output.txt' is a space-delimited file that summarizes the mean and standard deviation of selected variables for the subjects and activities in the dataset. This product is a 'wide-form' of tidy data.

'output.txt' is placed into the current working directory, and may be read back into R with a read.table or fread (requires the data.table package) statement, for example:    

```
testread <- read.table('output.txt', sep=' ', header = TRUE)
```  

or  

```
testread <- fread('output.txt')
```

The output file is equivalent to a Microsoft Excel pivot table of selected mean and standard deviation variables in the dataset, by average. Discussions of how the output file is assembled (including choice and exclusion of variables) are in the codebook.
