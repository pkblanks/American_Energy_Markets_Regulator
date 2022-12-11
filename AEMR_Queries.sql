/*
AMERICAN ENERGY MARKETS REGULATOR CASE STUDY 
DATA MANIPULATION & EXPLORATION
*/

SELECT * 
FROM AEMR  


-- 1.1 
SELECT Status,
COUNT(Status) AS Total_Number_Outage_Events, 
Reason 
FROM AEMR 
WHERE Status = 'Approved' 
              AND YEAR(Start_time) = '2016'
GROUP BY Status, Reason
ORDER BY Status, Reason;

-- 1.3
SELECT COUNT(Status) AS Total_Number_Outage_Events, Status, Reason 
FROM AEMR 
WHERE Status = 'Approved' 
              AND YEAR(Start_time) = '2017'
GROUP BY Status, Reason
ORDER BY Status, Reason;

-- 1.5
SELECT Status, Reason, COUNT(Status) AS Total_Number_Outage_Events, ROUND(AVG(TIMESTAMPDIFF(MINUTE, Start_time, End_time)/(60*24)), 2) AS Average_Outage_Duration_Time_Days, YEAR(Start_time)  AS Year
FROM AEMR 
WHERE Status = 'Approved' 
GROUP BY Status, Reason, Year
ORDER BY Year, Reason;

/*2.1 --Write a SQL statement showing the monthly COUNT of all approved outage 
types (Forced, Consequential, Scheduled, Opportunistic) that occurred for 2016. 
Order by Reason and Month.*/

SELECT
Status, 
Reason,
COUNT(*) AS Total_Number_Outage_Events,
MONTH(Start_time) AS Month
FROM AEMR
WHERE Status = 'Approved'
GROUP BY Status, Reason, MONTH(Start_time)
ORDER BY Reason, Month ;

/* 2.2 -Write a SQL statement showing the monthly COUNT of all approved outage 
types (Forced, Consequential, Scheduled, Opportunistic) that occurred for 2017. 
Order by Reason and Month.*/ 

SELECT
Status, 
Reason,
COUNT(*) AS Total_Number_Outage_Events,
MONTH(Start_time) AS Month
FROM AEMR
WHERE Status = 'Approved' AND YEAR(Start_time) = 2017
GROUP BY Status, Reason, MONTH(Start_time)
ORDER BY Reason, Month ;

-- 2.3 -- Question 2.3: Write a SQL statement showing the total number of all approved outage types (Forced, Consequential, Scheduled, Opportunistic) that occurred for both 2016 and 2017 per month (i.e. 1 – 12). Don't forget to Order this by by Month and Year.

SELECT
Status, 
COUNT(*) AS Total_Number_Outage_Events,
MONTH(Start_time) AS Month,
YEAR(Start_time) AS Year
FROM AEMR
WHERE Status = 'Approved' 
GROUP BY Status, MONTH(Start_time), YEAR(Start_time)
ORDER BY Year, Month;


-- 3.1 Question 3.1: Write a SQL statement showing the count of all approved outage types (Forced, Consequential, Scheduled, Opportunistic) for all participant codes for 2016 and 2017. Order by Year and Participant_Code.

SELECT COUNT(Status) AS Total_Number_Outage_Events, 	Participant_Code, Status, Year(Start_time) AS Year
FROM AEMR
WHERE 
  Status = 'Approved'
GROUP BY Participant_Code, Status, Year
ORDER BY Year, Participant_Code;

-- 3.2 Question 3.2: Write a SQL statement showing the average duration of all approved outage types (Forced, Consequential, Scheduled, Opportunistic) for all participant codes from 2016 to 2017. Don't forget to order the average duration in descending order with the DESC keyword.

SELECT Participant_Code, Status, Year(Start_time) AS Year, ROUND((AVG(TIMESTAMPDIFF(MINUTE, Start_time, End_time))/(60*24)), 2) AS Average_Outage_Duration_Time_Days
FROM AEMR 
WHERE 
  Status = 'Approved'
GROUP BY Participant_Code, Year, Status
ORDER BY Year, Average_Outage_Duration_Time_Days DESC;


-- Part2Q1.1 Question 1.1: Write a SQL Statement to COUNT the total number of approved forced outage events for 2016 and 2017. Order by Reason and Year. 
SELECT COUNT(Status) AS Total_Number_Outage_Events, Reason, Year(Start_time) AS Year 
FROM AEMR 
WHERE 
  Status = 'Approved'
      AND Reason =  'Forced'
GROUP BY Year, Reason
ORDER BY Year, Reason;

-- Part2Q1.2
SELECT 
SUM(CASE WHEN Reason = 'Forced' THEN 1 ELSE 0 END) AS Total_Number_Forced_Outage_Events, 
COUNT(*) AS Total_Number_Outage_Events,
ROUND(((SUM(CASE WHEN Reason='Forced' THEN 1 ELSE 0 END) / COUNT(*)) * 100), 2) AS Forced_Outage_Percentage, 
Year(Start_time) AS Year
FROM AEMR 
WHERE Status = 'Approved'
GROUP BY Year
ORDER BY Year ASC;


-- Part2Q2.1
SELECT Status,
Year(Start_time) AS Year, 
ROUND(AVG(Outage_MW), 2) AS Avg_Outage_MW_Loss,  
ROUND(AVG(TIMESTAMPDIFF(MINUTE, Start_time, End_time)), 2) AS Average_Outage_Duration_Time_Minutes  
FROM AEMR 
WHERE Status = 'Approved' AND Reason = 'Forced'
GROUP BY Status, Year
ORDER BY Year;

-- Part2Q2.2
SELECT 
Status,
Reason,
Year(Start_time) AS Year, 
ROUND(AVG(Outage_MW), 2) AS Avg_Outage_MW_Loss,  
ROUND(AVG(TIMESTAMPDIFF(MINUTE, Start_time, End_time)), 2) AS Average_Outage_Duration_Time_Minutes  
FROM AEMR 
WHERE Status = 'Approved'
GROUP BY Year, Reason, Status
ORDER BY Year;


