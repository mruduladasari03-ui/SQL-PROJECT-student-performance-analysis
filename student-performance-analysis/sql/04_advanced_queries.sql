USE student_performance;

-- 1. Average marks in each course
SELECT c.course_name, ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM courses c
JOIN marks m ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name
ORDER BY average_marks DESC;

-- 2. Department-wise average marks
SELECT d.department_name, ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM departments d
JOIN students s ON d.department_id = s.department_id
JOIN marks m ON s.student_id = m.student_id
GROUP BY d.department_id, d.department_name
ORDER BY average_marks DESC;

-- 3. Overall student performance
SELECT s.student_id, s.student_name,
       ROUND(AVG(m.marks_obtained), 2) AS average_marks,
       CASE
           WHEN AVG(m.marks_obtained) >= 85 THEN 'Excellent'
           WHEN AVG(m.marks_obtained) >= 70 THEN 'Good'
           WHEN AVG(m.marks_obtained) >= 50 THEN 'Average'
           ELSE 'Needs Improvement'
       END AS performance
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
ORDER BY average_marks DESC;

-- 4. Students whose average is above the overall average (subquery)
SELECT s.student_name, ROUND(AVG(m.marks_obtained), 2) AS student_average
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
HAVING AVG(m.marks_obtained) > (
    SELECT AVG(marks_obtained) FROM marks
)
ORDER BY student_average DESC;

-- 5. Pass percentage by course (pass mark = 40)
SELECT c.course_name,
       COUNT(*) AS students_appeared,
       SUM(m.marks_obtained >= 40) AS students_passed,
       ROUND(100.0 * SUM(m.marks_obtained >= 40) / COUNT(*), 2) AS pass_percentage
FROM courses c
JOIN marks m ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name;

-- 6. Highest scorer in each course
SELECT c.course_name, s.student_name, m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN courses c ON m.course_id = c.course_id
WHERE m.marks_obtained = (
    SELECT MAX(m2.marks_obtained)
    FROM marks m2
    WHERE m2.course_id = m.course_id
)
ORDER BY c.course_name;

-- 7. Rank students inside each department (MySQL 8 window function)
WITH student_averages AS (
    SELECT s.student_id, s.student_name, s.department_id,
           AVG(m.marks_obtained) AS average_marks
    FROM students s
    JOIN marks m ON s.student_id = m.student_id
    GROUP BY s.student_id, s.student_name, s.department_id
)
SELECT d.department_name, sa.student_name,
       ROUND(sa.average_marks, 2) AS average_marks,
       DENSE_RANK() OVER (
           PARTITION BY sa.department_id
           ORDER BY sa.average_marks DESC
       ) AS department_rank
FROM student_averages sa
JOIN departments d ON sa.department_id = d.department_id
ORDER BY d.department_name, department_rank;

-- 8. Students who need academic support (average below 65)
SELECT s.student_name, ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name
HAVING AVG(m.marks_obtained) < 65
ORDER BY average_marks;

-- 9. Count students in each department
SELECT d.department_name, COUNT(s.student_id) AS student_count
FROM departments d
LEFT JOIN students s ON d.department_id = s.department_id
GROUP BY d.department_id, d.department_name
ORDER BY student_count DESC;

-- 10. Find courses with an average score above 80
SELECT c.course_name, ROUND(AVG(m.marks_obtained), 2) AS average_marks
FROM courses c
JOIN marks m ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name
HAVING AVG(m.marks_obtained) > 80;
