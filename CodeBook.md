# ProgrammingAssignmentGettingCleaningData
Programming Assignment for the Getting and Cleaning Data course on Coursera

The 'result_set_1.csv':

1. For each of the training and test sets ('X_train.txt' and 'X_test.txt'):
  a. moves the 561 column names representing measurement types to become a variable.
  b. Uses the 'subject_test.txt' file to attach a subject id to each observation.
  c. Uses the 'y_test.txt' file to attach one of the 6 activities to each observation.
  d. Uses the 'features.txt' file to attach a measure type to each observation.
  e. Splits the description from 'features.txt' into its component parts.
  f. Filters to only include measurements of mean and standard deviation.
  
The 'result_set_2.csv':

1. Summarises 'result_set_1.csv' to show the mean value for each activity type, subject and measurement type.

Variables in 'result_set_1.csv':

1. set           Holding whether this observation came from the training or testing set
2. measuretype   The detailed measure type, e.g. tbodyacc, tgravityacc, etc.
3. measure       The mesurement taken, e.g mean, std, max, etc.
4. XYZAxis       X, Y or Z representing the axis of the acceleration. NA if not applicable.
5. subjectid     Id representing the 30 participants.
6. activity      Description of which of the 6 activities was taking place.
7. value         The value captured for the relevant measurement type.

Variables in 'result_set_1.csv':

1. activity      Description of which of the 6 activities was taking place.
2. subjectid     Id representing the 30 participants.
3. measuretype   The detailed measure type, e.g. tbodyacc, tgravityacc, etc.
4. XYZAxis       X, Y or Z representing the axis of the acceleration. NA if not applicable.
5. mean(value)   The mean of the values captured for the relevant measurement type.

