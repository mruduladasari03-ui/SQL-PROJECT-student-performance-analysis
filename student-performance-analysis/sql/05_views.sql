USE student_performance;

-- View 1: reusable student performance summary
CREATE OR REPLACE VIEW student_performance_summary AS
SELECT s.student_id, s.student_name, d.department_name,
       ROUND(AVG(m.marks_obtained), 2) AS average_marks,
       MIN(m.marks_obtained) AS lowest_marks,
       MAX(m.marks_obtained) AS highest_marks,
       COUNT(m.mark_id) AS courses_completed
FROM students s
JOIN departments d ON s.department_id = d.department_id
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name, d.department_name;

-- View 2: course performance summary
CREATE OR REPLACE VIEW course_performance_summary AS
SELECT c.course_id, c.course_name,
       ROUND(AVG(m.marks_obtained), 2) AS average_marks,
       MAX(m.marks_obtained) AS highest_marks,
       MIN(m.marks_obtained) AS lowest_marks
FROM courses c
JOIN marks m ON c.course_id = m.course_id
GROUP BY c.course_id, c.course_name;

-- Run these to see the views
SELECT * FROM student_performance_summary ORDER BY average_marks DESC;
SELECT * FROM course_performance_summary ORDER BY average_marks DESC;
