***********************************
*      IN-CLASS ASSIGNMENT 9      *
***********************************;

*Download the SAS dataset called Demographics to your computer and change the libname
 statement below to reflect the folder in which you've saved the file.;

libname sql "ADD YOUR PATH HERE";

*Run PROC CONTENTS to show the variables included in the Demographics data;
proc contents data=sql.demographics order=varnum;
run;

*1. Write a SQL query to display a list of the distinct continents represented in the data;



*2. List the total population of each continent, ordered from highest to lowest;


*3. In the absence of a data dictionary, write a query that would help you determine
	which continent is represented by the number that had the highest population in #2.;


*4. Write a query to calculate the number of individuals who reside in urban areas in each country
	and save it into a new table called sql.urban. Name the variable you calculate as total_urban_pop.;


*5. Write a query to display the maximum population value in the dataset.;


*6. Use the query you wrote in question 5 as a subquery to find the country or countries
	linked to the highest population value.;

