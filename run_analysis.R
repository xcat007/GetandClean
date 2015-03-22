# 

#import data HAR data stored in your working directory

data_features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
data_activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)

data_subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
data_x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
data_y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)


data_subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
data_x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
data_y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

# make list of all the column names from the features table and 
#  add names for subject and activity number

my_col_names <- c(as.character(data_features[,2]),"Subject","ActivityNum")


# build a vector of all of the columns of mean and standard deviation
mycols <- sort(c(grep("-mean\\(",data_features$V2), datastds <- grep("-std\\(",data_features$V2)))
mycols2 <- c(mycols,562,563)


# add subject id and activity id to test data
data_x_test[,562] <- data_subject_test[,1]
data_x_test[,563] <- data_y_test[,1]

# add subject id and activity id to train data
data_x_train[,562] <- data_subject_train[,1]
data_x_train[,563] <- data_y_train[,1]

# append test and train data
big_data <- rbind(data_x_test, data_x_train)

# update column names for test/train data set
names(big_data) <- my_col_names

# make data frame from test/train data of only mean and std values 
# as well as subject and activityid
big_data2 <- big_data[,mycols2]

# update colum names for activity table
names(data_activities) <- c("ActivityNum","Activity")

# add column of descriptive activity name to test/train data set and 
# save data set as big_data2
big_data3 <- merge(big_data2, data_activities, by = "ActivityNum")

# create table of averages of values
big_data_avgs <- aggregate(big_data3[2:67], by = list(big_data3$Subject,big_data3$Activity), FUN = mean)

# rename subject and activity column names
names(big_data_avgs)[1:2] <- c("Subject","Activity")

write.table(big_data_avgs, "HAR_CombinedOutput_avgby_subject_Activity.txt", row.names = FALSE, col.names = FALSE)





