create database hr;
use hr;


-- kpi 1
SELECT 
    department,
   concat( ROUND(SUM(CASE WHEN attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2),"%") AS "attrition rate (%)"
FROM 
    hr1
GROUP BY 
    department;
    
-- kpi 2
select concat(avg(HourlyRate)," hrs") as "average hourly rate"
from hr1
where JobRole = "Research Scientist" and Gender = "Male";

-- kpi 3
select * from hr1;
select * from hr2;

SELECT 
     CASE 
        WHEN hr2.MonthlyIncome BETWEEN 0 AND 10000 THEN '0-10000'
        WHEN hr2.MonthlyIncome BETWEEN 10001 AND 20000 THEN '10001-20000'
        WHEN hr2.MonthlyIncome BETWEEN 20001 AND 30000 THEN '20001-30000'
        WHEN hr2.MonthlyIncome BETWEEN 30001 AND 40000 THEN '30001-40000'
        WHEN hr2.MonthlyIncome BETWEEN 40001 AND 50000 THEN '40001-50000'
        ELSE '50000+'
    END AS IncomeGroup, 
    COUNT(hr1.Attrition) AS Attrition_Count
FROM 
    hr1 
JOIN 
    hr2 
    ON hr1.`Employee ID` = hr2.`Employee ID`
WHERE 
    hr1.Attrition = 'Yes'
GROUP BY 
     CASE 
        WHEN hr2.MonthlyIncome BETWEEN 0 AND 10000 THEN '0-10000'
        WHEN hr2.MonthlyIncome BETWEEN 10001 AND 20000 THEN '10001-20000'
        WHEN hr2.MonthlyIncome BETWEEN 20001 AND 30000 THEN '20001-30000'
        WHEN hr2.MonthlyIncome BETWEEN 30001 AND 40000 THEN '30001-40000'
        WHEN hr2.MonthlyIncome BETWEEN 40001 AND 50000 THEN '40001-50000'
        ELSE '50000+'
    END
    ORDER BY IncomeGroup;

-- kpi 4

select  hr1.department, concat(avg(hr2.TotalWorkingYears) , " yrs") as AverageWorkingYears
from hr1
join
    hr2 
    ON hr1.`Employee ID` = hr2.`Employee ID`
group by hr1.department;

-- kpi 5
select hr1.JobRole ,round( avg(hr2.WorkLifeBalance) ,2)
from hr1
join
    hr2 
    ON hr1.`Employee ID` = hr2.`Employee ID`
group by JobRole;

-- kpi 6 
select * from hr1;
select hr2.YearsSinceLastPromotion,count(hr1.Attrition)
from hr1
join
    hr2 
    ON hr1.`Employee ID` = hr2.`Employee ID`
where Attrition = "Yes"
group by hr2.YearsSinceLastPromotion 
order by hr2.YearsSinceLastPromotion;

-- kpi 7 (active employees)
select concat(round(count(*)/1000 , 2) ," K")
from hr1
where attrition = "No";

-- KPI 8 (Average age)
select concat(round(Avg(Age),2), " yrs")
from hr1;

-- kpi 9  (gender wise attrition)
select Gender , count(*)
from hr1
where attrition = "Yes"
group by Gender;

-- kpi 10 (Attrition rate)
select concat(round((count(case when attrition = "yes" then 1 end ) / count(*))*100,2),"%") As "attrition rate"
from hr1;




