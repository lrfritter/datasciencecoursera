This file explains the code saved in run_analysis.R.
======================================

The objective is to create a tidy dataset containing all of the original observations of the study. 
The following steps were taken to create the final output:

- Read in the following text files as data.tables into R:
  features.txt, activity_labels.txt, subject_train.txt, X_train.txt, y_train.txt, subject_test.txt, X_test.txt, y_test.txt
  (available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
  
- Rename the columns in the "X_train" and "X_test" datasets with feature names from "features".

- Append the columns for subject and response (y): that is, append "subject_train" and "y_train" to "X_train" and append "subject_test" and "y_test" to "X_test".

- Row bind "X_train" and "X_test" to create a dataset called "merged".

- Filter the columns to only include subject, response (y), and any variables related to a mean or standard deviation.

- Join activity name to the merged dataset from "activity_labels", matching the activity code to the code in the response column of merged.

- Rename the joined activity name column to be "activity" and drop the response column.

- Using dplyr package, group by subject and activity and compute the mean of all numeric variables.

The resulting "final_dataset" is a tidy dataset, containing observations for only the mean and standard deviation variables.
The table has been summarized to each row representing the average reading for each subject/activity combo.
