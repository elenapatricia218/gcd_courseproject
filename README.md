gcd_courseproject README
=================

directory for the Getting and Cleaning Data course project

## Where the data come from

From the assignment page:  
"  
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip   
"

## How has the data been manipulated

1) Imported the features.txt document in order to get column names
2) Converted column names to *all lowercase* in order to enable identification of all variables which track mean and standard deviation
3) Imported the activity_labels.txt document in order to get activity descriptions
4) Dealt with each of the training and test datasets separately at first  
-- *Training:* attach the activity number (ytrain), label (activity_labels) and subject identifier (subjecttrain) to the core training dataset (Xtrain)  
-- *Test:* attach the activity number (ytest), label (activity_labels) and subject idntifier (subjecttest) to the core test dataset (Xtest)
5) Concatenate (rbind) the training and test datasets to create one master dataset
6) Subset columns from the master dataset which we'll need to create the final, summarized dataset.  
-- *These include: subject, activity, and all columns with "mean" or "std" in the variable name.*
7) Summarize the data using the aggregate function by activity by subject, taking the mean of all mean & std variables on the subset
8) Write a table in *.txt outputformat (pipe-delimited)

Please see the run_analysis.R file in this repository for exact code and transformations.

## Outputs from the process

### Final Data: "samsung_aggregated_output.txt"

This is the end goal output for this assignment; mean of all mean & std variables on the dataset, summarized by activity by subject.

Format: pipe-delimited *.txt file  
Number of records: 40 obs.    
Number of variables: 88 variables    
Header: Yes  

Please see the codebook file for more information about this output.

### Interim Outputs

These outputs contain numerous subsets of the data as I have gone through the process to manipulate and piece together the information from the initial files. There are also several examples of dim(), str() and head() outputs as I check the work as I go along.

-- column_names: the list of column names (lowercase) to be applied as colnames to the dataset  
-- activity_labels: the list of activities as they correspond to numbers in the ytrain and ytest identifiers (1:6)  
-- samsung_Xtrain: observational dataset (training dataset)  
-- samsung_ytrain: numbers associated with the different activity types for the training dataset  
-- samsung_ytrain_labels: adding the actual activity labels to the ytrain dataset  
-- samsung_Xtrain_lab: cbind the activity information with the actual observations  
-- samsung_strain: subject identifier dataset for the training dataset  
-- samsung_train: final training dataset complete with subject and activity info  
-- samsung_Xtest: observational dataset (test dataset)  
-- samsung_ytest: numbers associated with the different activity types for the test dataset  
-- samsung_ytest_labels: adding the actual activity labels to the ytest dataset  
-- samsung_Xtest_lab: cbind the activity information with the actual observations  
-- samsung_stest: subject identifier dataset for the test dataset  
-- samsung_test: final test dataset complete with subject and activity info  
-- samsung_master: rbind the samsung_train and samsung_test datasets  
-- samsung_master_mean: all variables from the master dataset which contain the word "mean"  
-- samsung_master_std: all variables from the master dataset which contain the string "std"  
-- subject_number: random integer assignment to indicate which subject the observation came from  
-- activity: the activity label associated with the observation  
-- samsung_subset: subsetted dataset containing activity, subject, and the subsetted mean and std variables  
-- samsung_aggregated: finalized dataset summarized by activity by subject, using the mean function