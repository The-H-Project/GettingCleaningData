# Coursera R Getting and Cleaning Data Course Project
# run_analysis.R

library(plyr)
library(data.table)

# Load the column headers for training and test datasets.
x_headers <- read.delim('./UCI HAR Dataset/features.txt', sep = ' ', header = FALSE, stringsAsFactors = FALSE, 
                            col.names = c('Col_Num','Col_Name'))

# Load the activity labels for the training and test datasets.
activity_labels <- read.delim ('./UCI HAR Dataset/activity_labels.txt', sep = ' ', header = FALSE, stringsAsFactors = FALSE,
                   col.names = c('Num', 'Description'))

# Load the x_training dataset, and assign column headers.
dataset_training <- fread('./UCI HAR Dataset/train/X_train.txt', header = FALSE,
                      col.names = x_headers$Col_Name)

# Load the y_training dataset, which contains the activity labels for each row of the x_training dataset.
y_train_data <- fread('./UCI HAR Dataset/train/y_train.txt', header = FALSE, col.names = 'ActivityNum')

# Load the subject_train dataset, which contains the Participant Number for each row of the x_training dataset
subject_train_data <- fread('./UCI HAR Dataset/train/subject_train.txt', header = FALSE, col.names = 'Participant')

# Combine the training datasets together.
dataset_training <- cbind(subject_train_data, y_train_data, dataset_training)

# Perform the same steps for the test datasets.
dataset_test <- fread('./UCI HAR Dataset/test/X_test.txt', header = FALSE,
                          col.names = x_headers$Col_Name)
y_train_test <- fread('./UCI HAR Dataset/test/y_test.txt', header = FALSE, col.names = 'ActivityNum')
subject_test_data <- fread('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, col.names = 'Participant')
dataset_test <- cbind(subject_test_data, y_train_test, dataset_test)

# Combine the datasets, and convert to a dataframe table.
dataset_combined <- rbind(dataset_training, dataset_test)

# Replace the activity values with text labels.
dataset_combined$Activity <- mapvalues(dataset_combined$ActivityNum, from = activity_labels$Num, to = activity_labels$Description)

# Extract the columns for means and standard deviations data -- mean() and std(), only.
# Columns that are not selected include:
# - meanFreq columns, as they have no corresponding standard deviation values. Also, meanFreq columns
#   are weighted averages, instead of arithmetic means.
# - Angle Measurements, because they represent the angle between 2 vectors, and are not 
#   measure of mean.
columncriteria <- c(grep('Participant', names(dataset_combined), ignore.case = TRUE),
                    grep('Activity$', names(dataset_combined), ignore.case = TRUE),
                    grep('mean\\(\\)|std\\(\\)', names(dataset_combined), ignore.case = TRUE))
dataset_shrunk <- dataset_combined[,columncriteria, with=FALSE]

# Get rid of the extraneous work variables.
rm(subject_test_data, subject_train_data, y_train_data, y_train_test, x_headers, dataset_test, dataset_training, dataset_combined, activity_labels)

# Get a list of column names that specify the dataset columns to summarize the dataset values, 
# and get rid of 'Participant' and 'Activity' because they are organizing columns.
castcolumns <- names(dataset_shrunk)
NamestoRemove <- c('Participant','Activity')
castcolumns <- castcolumns[-which(castcolumns %in% NamestoRemove)]

dataset_output <- dcast.data.table(dataset_shrunk, Participant + Activity ~ 'tBodyAcc-mean()-X', fun.aggregate=mean, value.var=castcolumns)

# Perform some name cleaning on the column labels.
# - Get rid of the '_mean_.' appended by dcast to every value.var variable.
# - Get rid of the '()' present in most variables.
names(dataset_output) <- gsub('_mean_.$', '', names(dataset_output))
names(dataset_output) <- gsub('\\(\\)', '', names(dataset_output))

castcolumns <- names(dataset_output)
write.table(dataset_output, file = './UCI HAR Dataset/output.txt', row.names=FALSE)

