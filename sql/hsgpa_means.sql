
SELECT ROUND(AVG(hs_gpa), 3) AS [mean hs gpa]
, ROUND(SQRT(STDEV(hs_gpa))/COUNT(hs_gpa), 3) as [95% confidence]
, COUNT(hs_gpa) as cnt
, hs_GPA_type_code
FROM Students AS s
WHERE first_course_datetime BETWEEN '1993' AND '2013'
AND hs_gpa IS NOT NULL
GROUP BY hs_GPA_type_code
ORDER BY cnt DESC

