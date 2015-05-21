# cleanDataProject
Project for Coursera class getting and cleaning data

The run_analysis.R scrips take care of everything.

It first download the zip files and unzip it.

It then loads the X_train/X_test, y_train/y_test, subject_train/subject_test files
and combining them into one single data frame

It creates the names of the data frame from the features.txt file

It then selects only the columns corresponding to mean and standard deviation

It then recode the activity field with meaningful words

It then recode the variable names to make them meaningful.

Finally it groups the data by activity and subject and take the mean of every variable. 
