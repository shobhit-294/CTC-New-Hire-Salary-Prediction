select * from ctc;

# 1.	What are the average graduation marks of employees who have worked in Tier 1 colleges?
SELECT AVG(`Graduation marks`) AS average_marks
FROM ctc
WHERE `College` = 'Tier 1';


# 2.	Which city type has the highest average CTC among executives?
SELECT `City type`, AVG(CTC) AS average_ctc
FROM ctc
WHERE Role = 'Executive'
GROUP BY `City type`
ORDER BY average_ctc DESC
LIMIT 1;


# 3.	How many executives in the dataset have more than 3 years of experience?
SELECT COUNT(*) AS num_executives
FROM ctc
WHERE Role = 'Executive' AND `Exp (Months)` > 36;


# 4.	Which college has the highest number of managers?
SELECT College, COUNT(*) AS num_managers
FROM ctc
WHERE Role = 'Manager'
GROUP BY College
ORDER BY num_managers DESC
LIMIT 1;


# 5.	What is the percentage of employees who have changed jobs more than once?
SELECT (COUNT(*) / (SELECT COUNT(*) FROM ctc)) * 100 AS percentage
FROM ctc
WHERE `Previous job changes` > 1;


# 6.	How many executives in the dataset have graduation marks above 80?
SELECT COUNT(*) FROM ctc WHERE role="executive" AND `Graduation marks`>80  ;


# 7.	What is the average CTC of employees who have worked in Tier 3 colleges?
SELECT AVG(ctc) AS ctc FROM ctc WHERE `College`= "Tier 3";


# 8.	How many executives in the dataset have a previous CTC of more than 60,000?
SELECT COUNT(*) AS num_executives
FROM ctc
WHERE Role = 'Executive' AND `Previous CTC` > '60,000.00';


# 9.	What is the total number of executives in the dataset?
SELECT COUNT(*) AS num_executives
FROM ctc
WHERE Role = 'Executive';


 #10.	What is the total number of managers in the dataset?
 SELECT COUNT(*) AS num_managers
FROM ctc
WHERE Role = 'Manager';


#11.	What is the average previous CTC of the employees in the dataset?
SELECT AVG(`Previous CTC`) AS average_previous_ctc
FROM ctc;


#12.	How many employees have worked in non-metro cities?
SELECT COUNT(*) AS num_employees_non_metro_cities
FROM ctc
WHERE `City type` != 'Metro';


#13.	Is there a correlation between graduation marks and current CTC?
SELECT
    (COUNT(*) * SUM(`Graduation marks` * CTC) - SUM(`Graduation marks`) * SUM(CTC)) /
    SQRT((COUNT(*) * SUM(`Graduation marks` * `Graduation marks`) - SUM(`Graduation marks`) * SUM(`Graduation marks`)) *
    (COUNT(*) * SUM(CTC * CTC) - SUM(CTC) * SUM(CTC))) AS correlation_coefficient
FROM ctc;
#correlation_coefficient = (n * Σ(x * y) - Σx * Σy) / √((n * Σ(x^2) - Σx^2) * (n * Σ(y^2) - Σy^2))


#14.	What is the highest and lowest CTC offered to an employee in the dataset?
SELECT MAX(CTC) AS highest_ctc
FROM ctc
union all
SELECT MIN(CTC) AS lowest_ctc
FROM ctc;


#15.	What is the median experience in months of the employees in the dataset?
SELECT AVG(`Exp (Months)`) AS median_experience
FROM (
    SELECT `Exp (Months)`,
           ROW_NUMBER() OVER (ORDER BY `Exp (Months)`) AS row_num,
           COUNT(*) AS total_rows
    FROM ctc
    GROUP BY `Exp (Months)`
) AS t
WHERE row_num IN (FLOOR((total_rows + 1) / 2), CEIL((total_rows + 1) / 2));

 