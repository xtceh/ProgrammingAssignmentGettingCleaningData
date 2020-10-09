library(dplyr)
library(tidyr)

#Load the features (1-561 corresponding to types of measurement)
features<-read.table("UCI HAR Dataset/features.txt",col.names=c("id","measure"))
#Load the activity labels (1-6 corresponding to walking, walking upstairs, etc)
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt",col.names=c("id","activity"))

#Tidy the features data to separate the labels into component parts
features<-separate(features,measure,into=c("measuretype","measure","XYZAxis"),"-")

#Function to tidy and import the test and train data - one argument to set to "train" or "test"
ImportTidyData<-function(subset="train") {
  #Load the training data (with lookups showing which activity/subject each observation is for)
  X<-read.table(paste0("UCI HAR Dataset/",subset,"/X_",subset,".txt"))
  activity<-read.table(paste0("UCI HAR Dataset/",subset,"/Y_",subset,".txt"),col.names="id")
  subject<-read.table(paste0("UCI HAR Dataset/",subset,"/subject_",subset,".txt"),col.names="subjectid")
  
  #Tidy the training data by adding the subject and a descriptive activity
  activity<-select(left_join(activity,activity_labels),activity)
  X<-bind_cols(subject,activity,X)
  #Tidy the training data by moving the column names for each measure to a variable
  X<-pivot_longer(X,V1:V561,names_to="measureid")
  #Tidy the training data by adding the detail from the features table
  X<-mutate(X,measureid=as.numeric(substr(measureid,2,4)),set=subset)
  X<-right_join(features,X,by=c("id"="measureid"))
  #Final tidying - include only mean and std, remove id column, move train/test marker in the first column
  X<-X %>% select(-id) %>% filter(measure=="mean()"|measure=="std()") %>% relocate(set)
  X
}

#Call ImportTidayData to import both the test and training data
train<-ImportTidyData("train")
test<-ImportTidyData("test")

#Merge the train and test data to produce the required first data set
allmeanstddata<-bind_rows(train,test)

#Summarise the first data set to get the second data set
meandata<-allmeanstddata %>% filter(measure=="mean()") %>%
  group_by(activity,subjectid,measuretype,XYZAxis) %>%
  summarise(mean(value))

#Write the two data sets to csv files
write.csv(allmeanstddata,"result_set_1.csv",row.names=FALSE)
write.csv(meandata,"result_set_2.csv",row.names=FALSE)


