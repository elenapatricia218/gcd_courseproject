Codebook / Data Dictionary
===

Date Modified: July 26, 2014, 3:08pm Eastern

### Data: "samsung_aggregated_output.txt"
Format: pipe-delimited *.txt file  
Number of records: 40 obs.  
Number of variables: 88 variables  
Header: Yes

Contents: Means of all of the mean and standard deviation variables by activity
by subject. For each person observed, for each type of activity, there is an average 
value associated with each tracked movement.

## Key Variable values

### 1: activity
A variable to designate the type of activity a subject was engaged in when
the measurement was taken.

Type: Character  
Valid Values (there are 6):

WALKING  
WALKING_UPSTAIRS  
WALKING_DOWNSTAIRS  
SITTING  
STANDING  
LAYING  

### 2: subject
An integer to designate each separate participant in the experiment.

Type: Integer  
Valid Values: 1-30

Note that one subject can have averages for multiple activities, and one activity
can have averages across multiple subjects.

### all other variables are measurement variables
Type: Numeric  
Values: mean of that variable for that activity for that subject across observations  
Range: continuous scale between -1 and 1  
Note: These features are normalized and thus do not have any units, per the community TA

## Variable Breakdown

```{r getvars}
samsung_aggregated_output <- read.table("./samsung_aggregated_output.txt",header=TRUE, sep="|",
           stringsAsFactors=FALSE)
str(samsung_aggregated_output)
```

