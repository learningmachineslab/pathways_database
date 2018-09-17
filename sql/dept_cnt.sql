DECLARE @enrolledcount TABLE (cnt int, department_name varchar(500), student_level_code varchar(2))
DECLARE @gradcount TABLE (cnt int, department_name varchar(500), student_level_code varchar(2))

INSERT INTO @enrolledcount
SELECT COUNT(DISTINCT s.student_id_fk) as cnt
, m.dept_name
, m.Student_Level_Code
FROM Majors AS m
JOIN department_categories as dc
ON dc.dept_name = m.dept_name
JOIN Students AS s
ON s.student_id_fk = m.student_id_fk

WHERE dc.category IN ('engineering', 'science')
AND m.Student_Level_Code IN ('UN')
AND s.first_course_datetime BETWEEN '1993' AND '2013'
AND m.graduated IS NULL

GROUP BY m.dept_name
, m.Student_Level_Code

ORDER BY cnt DESC, dept_name

INSERT INTO @gradcount
SELECT COUNT(DISTINCT s.student_id_fk) as cnt
, m.dept_name
, m.Student_Level_Code
FROM Majors AS m
JOIN department_categories as dc
ON dc.dept_name = m.dept_name
JOIN Students AS s
ON s.student_id_fk = m.student_id_fk

WHERE dc.category IN ('engineering', 'science')
AND m.Student_Level_Code IN ('UN' )
AND s.first_course_datetime BETWEEN '1993' AND '2013'
AND m.graduated = 'CONF'

GROUP BY m.dept_name
, m.Student_Level_Code
ORDER BY cnt DESC, dept_name


SELECT ec.department_name
, ec.student_level_code
, ec.cnt AS [enrolled]
, gc.cnt AS [graduated]
FROM @enrolledcount as ec
LEFT JOIN @gradcount as gc
ON ec.department_name = gc.department_name
AND ec.student_level_code = gc.student_level_code

ORDER BY ec.cnt DESC

SELECT SUM(ec.cnt) AS [total enrolled]
FROM @enrolledcount AS ec

SELECT SUM(gc.cnt) AS [total graduated]
FROM @gradcount AS gc
