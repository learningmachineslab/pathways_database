
SELECT ROUND(AVG(hs_gpa), 3) AS [mean hs gpa]
, ROUND(SQRT(STDEV(hs_gpa))/COUNT(hs_gpa), 3) as [95% confidence]
, COUNT(hs_gpa) as cnt
, COUNT(hs_gpa)*100.0/(SELECT COUNT(student_id_fk) FROM Students WHERE Students.first_course_datetime BETWEEN '1993' AND '2013') AS [Percent]
, hs_GPA_type_code
FROM Students AS s
WHERE first_course_datetime BETWEEN '1993' AND '2013'
AND hs_gpa IS NOT NULL
GROUP BY hs_GPA_type_code
ORDER BY cnt DESC

SELECT COUNT(*)
,  COUNT(*)*100.0/(SELECT COUNT(*) FROM Students WHERE Students.first_course_datetime BETWEEN '1993' AND '2013') AS [Percent]
FROM Students AS s
WHERE first_course_datetime BETWEEN '1993' AND ' 2013'
AND hs_gpa IS NULL
