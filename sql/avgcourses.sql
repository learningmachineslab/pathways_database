
SELECT dept_name
, avg([cnt courses]*1.0) AS [AVG courses taken by graduate]
, count([cnt courses]) AS [Number of graduates]
FROM (
SELECT DISTINCT s.student_id_fk
, m.dept_name
, COUNT(c.Crse_Code) AS [cnt courses]
FROM Majors AS m
JOIN department_categories as dc
ON dc.dept_name = m.dept_name
JOIN Students AS s
ON s.student_id_fk = m.student_id_fk
JOIN Courses AS c
ON s.student_id_fk = c.student_id_fk
WHERE dc.category IN ('science', 'engineering')
AND m.Student_Level_Code = 'UN'
AND s.first_course_datetime BETWEEN '1993' AND '2013'
AND m.graduated = 'CONF'

GROUP BY s.student_id_fk, m.dept_name
) as t
GROUP BY dept_name
ORDER BY [Number of graduates] DESC
