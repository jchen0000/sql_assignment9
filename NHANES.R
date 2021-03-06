###########################
#  IN-CLASS ASSIGNMENT 9  #
###########################

#Install sqldf package
install.packages("sqldf")

#Load sqldf package
library(sqldf)

#Set working directory (point to folder where you have NHANES csv files)
setwd("/Users/jiaqichen/Desktop/sql_assignment9")

#Import the NHANES demographics csv file and call it "demo"
nhanes_demographics <- read.csv("NHANES_Demographics.csv")

#Import the NHANES triglycerides csv file and call it "tri"
nhanes_triglycerides <- read.csv("NHANES_Triglycerides.csv")

#Show the first few records of each dataframe to identify any common fields between them
head(nhanes_demographics)
head(nhanes_triglycerides)

#1. Write a query that would allow you to fill out table 1 and assign the results to an object called table1
table1 <- sqldf("SELECT Race_Hispanic_origin_w_NH_Asian AS race, 
                COUNT(Race_Hispanic_origin_w_NH_Asian) AS freq, 
                ROUND(AVG(Age_in_years_at_screening), 1) AS mean_age 
                FROM nhanes_demographics 
                GROUP BY Race_Hispanic_origin_w_NH_Asian") 


#2. Show the distribution of race by gender and display the race/gender combinations from highest to lowest 
#   frequency.  Note: when using SQL in R, you *can* refer to column aliases outside of the SELECT clause.

sqldf("SELECT Gender As gender, Race_Hispanic_origin_w_NH_Asian AS race, COUNT(Race_Hispanic_origin_w_NH_Asian) AS freq 
       FROM nhanes_demographics
       GROUP BY Gender, Race_Hispanic_origin_w_NH_Asian
       ORDER BY freq DESC") 

#3. Count the number of women who were pregnant at the time of screening.  Use the column alias preg_at_screen.

sqldf("SELECT COUNT(Respondent_sequence_number) AS preg_at_screen 
       FROM nhanes_demographics
       WHERE Pregnancy_status_at_exam = 1")
    
#4. How many men refused to provide annual household income?
    
sqldf("SELECT COUNT(Respondent_sequence_number) AS num_refused 
       FROM nhanes_demographics
       WHERE Gender = 1 AND Annual_Household_Income = 77
       GROUP BY Gender")


#5. What is the mean LDL level (mg/dL) for men and women?  Use column alias mean_ldl and round results to 
#   1 decimal place.  
    
sqldf("SELECT d.Gender, ROUND(AVG(t.LDL_cholesterol_mg_dL), 1) AS mean_ldl
      FROM nhanes_demographics AS d 
          LEFT JOIN nhanes_triglycerides AS t 
          ON d.Respondent_sequence_number = t.Respondent_sequence_number
      GROUP BY d.Gender")
    
#6. Display the minimum and maximum triglyceride levels (mmol/L) for each race.  Use column aliases min_tri and max_tri.
  
sqldf("SELECT d.Race_Hispanic_origin_w_NH_Asian AS race, MIN(t.Triglyceride_mmol_L) AS min_tri, MAX(t.Triglyceride_mmol_L) AS max_tri
      FROM nhanes_demographics AS d 
          LEFT JOIN nhanes_triglycerides AS t 
          ON d.Respondent_sequence_number = t.Respondent_sequence_number
      GROUP BY race")
    
#7. Create a new data frame that can be used for future analyses that combines all demographic data and any 
#   matching triglyceride data.  Call it demo_tri.
    
table2 <- sqldf("SELECT * 
                FROM nhanes_demographics AS d 
                      LEFT JOIN nhanes_triglycerides AS t 
                      ON d.Respondent_sequence_number = t.Respondent_sequence_number")

      

