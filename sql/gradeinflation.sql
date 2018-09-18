/****** Script for SelectTopNRows command from SSMS  ******/

DECLARE @phys1 TABLE (tc varchar(4), dt datetime, phys1_avg float, phys1_std float, phys1_cnt int)
DECLARE @phys2 TABLE (tc varchar(4), dt datetime, phys2_avg float, phys2_std float, phys2_cnt int)
DECLARE @calc1 TABLE (tc varchar(4), dt datetime, calc1_avg float, calc1_std float, calc1_cnt int)
DECLARE @calc2 TABLE (tc varchar(4), dt datetime, calc2_avg float, calc2_std float, calc2_cnt int)
DECLARE @phys215 TABLE (tc varchar(4), dt datetime, phys215_avg float, phys215_std float, phys215_cnt int)

INSERT INTO @phys1
SELECT c.Term_Code
, c.Start_Date
, AVG(c.Grade) AS [phy1 avg]
, STDEV(c.Grade) AS [phy1 stdev]
, COUNT(c.Grade) AS [phy1 n]
FROM [msu_db].[dbo].[Courses] AS c
JOIN intro_courses_lookup as icl
ON c.Crse_Code = icl.crse_code
AND c.Subj_Code = icl.subj_code
WHERE icl.course_id = 'phys1'
AND c.Term_Code NOT LIKE '%U%'
GROUP BY  c.Term_Code, c.Start_Date
ORDER BY c.Start_Date

INSERT INTO @phys2
SELECT c.Term_Code
, c.Start_Date
, AVG(c.Grade) AS [phy2 avg]
, STDEV(c.Grade) AS [phy2 stdev]
, COUNT(c.Grade) AS [phy2 n]
FROM [msu_db].[dbo].[Courses] AS c
JOIN intro_courses_lookup as icl
ON c.Crse_Code = icl.crse_code
AND c.Subj_Code = icl.subj_code
WHERE icl.course_id = 'phys2'
AND c.Term_Code NOT LIKE '%U%'
GROUP BY  c.Term_Code, c.Start_Date
ORDER BY c.Start_Date

INSERT INTO @calc1
SELECT c.Term_Code
, c.Start_Date
, AVG(c.Grade) AS [calc1 avg]
, STDEV(c.Grade) AS [calc1 stdev]
, COUNT(c.Grade) AS [calc1 n]
FROM [msu_db].[dbo].[Courses] AS c
JOIN intro_courses_lookup as icl
ON c.Crse_Code = icl.crse_code
AND c.Subj_Code = icl.subj_code
WHERE icl.course_id = 'calc1'
AND c.Term_Code NOT LIKE '%U%'
GROUP BY  c.Term_Code, c.Start_Date
ORDER BY c.Start_Date

INSERT INTO @calc2
SELECT c.Term_Code
, c.Start_Date
, AVG(c.Grade) AS [calc2 avg]
, STDEV(c.Grade) AS [calc2 stdev]
, COUNT(c.Grade) AS [calc2 n]
FROM [msu_db].[dbo].[Courses] AS c
JOIN intro_courses_lookup as icl
ON c.Crse_Code = icl.crse_code
AND c.Subj_Code = icl.subj_code
WHERE icl.course_id = 'calc2'
AND c.Term_Code NOT LIKE '%U%'
GROUP BY  c.Term_Code, c.Start_Date
ORDER BY c.Start_Date

INSERT INTO @phys215
SELECT c.Term_Code
, c.Start_Date
, AVG(c.Grade) AS [phys215 avg]
, STDEV(c.Grade) AS [phys215 stdev]
, COUNT(c.Grade) AS [phys215 n]
FROM [msu_db].[dbo].[Courses] AS c
JOIN intro_courses_lookup as icl
ON c.Crse_Code = icl.crse_code
AND c.Subj_Code = icl.subj_code
WHERE c.Subj_Code = 'PHY'
AND c.Crse_Code = '215'
AND c.Term_Code NOT LIKE '%U%'
GROUP BY  c.Term_Code, c.Start_Date
ORDER BY c.Start_Date

SELECT p1.tc
, p1.dt
, p1.phys1_avg
, p1.phys1_cnt
, p1.phys1_std
, p2.phys2_avg
, p2.phys2_cnt
, p2.phys2_std
, c1.calc1_avg
, c1.calc1_cnt
, c1.calc1_std
, c2.calc2_avg
, c2.calc2_cnt
, c2.calc2_std
, p215.phys215_avg
, p215.phys215_cnt
, p215.phys215_std
FROM @phys1 AS p1
JOIN @phys2 AS p2
ON p1.tc = p2.tc
JOIN @calc1 AS c1
ON p1.tc = c1.tc
JOIN @calc2 AS c2
on p1.tc = c2.tc
LEFT JOIN @phys215 as p215
ON p1.tc = p215.tc
