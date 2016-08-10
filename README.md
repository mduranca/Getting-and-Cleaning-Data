The script run_analysis is implemented through an initial preparation of the data and five subsequent steps. These steps follow the 
indications given in the assignment.

The initial preparation consists in reading the six available datasets (three for each of the two groups named ‘test’ and ‘train’), 
and labeling the variable V1 in y_test and y_train as ‘subject’ and the variable V1 in subject_test and subject_train as ‘activity’, 
where ‘subject’ indicates each of 30 people performing a total of 6 activities during the experiment. These variables will be the 
first two ones in the final tidy dataset, respectively.

Step 1. Merging.

First, the three datasets from ‘test’ are merged together, and the same is done with the three datasets from ‘train’, producing the 
data frames mergeTest and mergeTrain. Secondly, mergeTest and mergeTrain are joined in the data frame mergeAll. This last data frame 
is ordered according to subject (in ascending order) and renamed as mergeAllOrd.

Step 2. Extracting.

In this second step (composed mainly by two loops), a subset of variables is extracted from mergeAllOrd. This subset corresponds to 
the variables consisting of mean and standard deviation values of the measurements.
 
The first loop identifies the variables to be extracted from the whole set (that contains 561 variables in total), searching by the 
strings “mean” and “std”. This loop produces two lists, one with the names of the variables (names.list) and the other with their 
column location (number.list).

The second loop eliminates the dashes and the brackets from the names and set capital letters separating the words within the name 
strings. This loop produces the list var.names. 

After the second loop, using number.list and adding the variables ‘subject’ and ‘activity’, the list my.names is created. This list 
is used for extracting the data corresponding to the variables contained in it from mergeAllOrd (columns in mergeAllOrd, excepting 
the first two ones, are still named as originally, from V3 to V561), yielding the new data frame named ‘Extract’. 

Step 3. Naming activities.

The variable ‘activitiy’ within ’Extract’ is changed from the original integer values, from 1 to 6, to their corresponding descriptive names.

Step 4. Labeling variables.

Using the list var.names, the variables from V3 are labeled in a descriptive manner. The resulting data frame is saved as Tidy1. 

Step 5. Creating the second dataset.

The second dataset results from averaging the first one (Tidy1) respecting to subject and activity. It is composed mainly by a ‘for’ 
double loop that calculates each row averaging the columns having equal subject and activity. The second dataset is named Tidy2 and 
its column names (from the third to the last) are built adding the prefix AVER in front of the corresponding Tidy1’s variable names.

