The code book describes the variables, the data, and any transformations or work that have been performed to clean up the data.

The variables that appear in the original dataset from UCIHARDataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) are the following: 
-Mean value.
-Standard Deviation.
-Median Absolute Deviation. 
-Largest value in array.
-Smallest value in array.
-Signal magnitude area.
-Energy measure. Sum of the squares divided by the number of values. 
-Interquartile range. 
-Signal Entropy.
-Autorregresion coefficients with Burg order equal to 4.
-Correlation coefficient between two signals.
-Index of the frequency component with largest magnitude.
-Mean Frequency.
-Skewness of the frequency domain signal. 
-Kurtosis of the frequency domain signal. 
-Energy of a frequency interval within the 64 bins of the FFT of each window.
-Angle between two vectors.

These variables were taken on the following signals:
-tBodyAcc-XYZ
-tGravityAcc-XYZ
-tBodyAccJerk-XYZ
-tBodyGyro-XYZ
-tBodyGyroJerk-XYZ
-tBodyAccMag
-tGravityAccMag
-tBodyAccJerkMag
-tBodyGyroMag
-tBodyGyroJerkMag
-fBodyAcc-XYZ
-fBodyAccJerk-XYZ
-fBodyGyro-XYZ
-fBodyAccMag
-fBodyAccJerkMag
-fBodyGyroMag
-fBodyGyroJerkMag
-fBodyBodyAccJerkMag
-fBodyBodyGyroMag
-fBodyBodyGyroJerkMag

where ‘t’ and ‘f’ indicate that the signals belong to the time domain and the frequency domain, respectively. The frequency domain is obtained from the time domain through the 
Fast Fourier Transform (FFT). BodyAcc and GravityAcc are body and gravity accelerations, respectively, measured in standard gravity units (g). BodyGyro is body angular velocity 
and is expressed in rad/sec. AccJerk and GyroJerk mean rate of change of acceleration and angular velocity, respectively. XYZ indicates that the signal is tridimensional, namely, 
it has three components along X, Y, and Z axis. Finally, Mag is magnitude, calculated using the Euclidean norm.

The signals were measured on a group of 30 volunteers performing 6 different activities. Each volunteer is assigned an integer number from 1 to 30, which is named as ‘subject’. 
Each ‘activity’ is an integer number from 1 to 6 that is replaced during the cleaning process by a descriptive character string. The correspondence between subjects/activities and 
variables is given in the files with prefixes ‘subject’, ‘y’, and X, belonging to the UCIHARDataset.  

The tidy dataset is a data frame that contains the averaged value of the previous variables, taken over the rows corresponding to equal subject and activity. In the tidy dataset 
the prefixes t and f were replaced by Time and FFT, respectively, and the variables were reduced only to Mean and Standard Deviation (Std) values. The first and second columns of 
the tidy dataset contain the subject and the activity, respectively. The rest of the columns are the variables corresponding to the averaged mean and standard deviation of the 
signals. The variable names in the data frame has the following scheme (without dashes):

AVER. - Time or FFT  -  Variable  -  Mean or Std  -  X, Y or Z
















 






























