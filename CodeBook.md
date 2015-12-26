## Introduction

The script run_analysis.R performs the 5 steps of the Course Project. 

First of all, we download the file using **download.file()**, then we unzip the file **unzip()**. We used the commands **list.files()**, **file.head()**, **length(readLines())** to have a brief view of the folder and files.

The variables **x_train, y_train, x_test, y_test, subject_train and subject_test** contain the data loaded.

The **cbind(),rbind()** was used to merge the data. The variable **AllData** is the variable that contains the union of train and test datasets requested in item 1

The variable **features_mean_std** contains only the measurements on the mean and standard deviation requested in item 2. To extract only this measures we used the function **grep()**

To name the activities in the data set according item 3, we used **join** to have the names of activities

In item 4, to label the dataset, the variable **features_names** contains the names of the columns and the **names()** was used to label the dataset

The variable **mean_data** contains the average of each variable for each activity and each subject, to have this result was used **aggregate()**




