USE student_performance;

-- 1. Display all students
SELECT * FROM students;

-- 2. Display all courses
SELECT * FROM courses;

-- 3. Show each student's department
SELECT s.student_name, d.department_name
FROM students s
JOIN departments d ON s.department_id = d.department_id
ORDER BY s.student_name;

-- 4. Show marks with student and course names
SELECT s.student_name, c.course_name, m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN courses c ON m.course_id = c.course_id
ORDER BY s.student_name, c.course_name;

-- 5. Find students scoring at least 85 in DBMS
SELECT s.student_name, m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN courses c ON m.course_id = c.course_id
WHERE c.course_name = 'Database Management Systems'
  AND m.marks_obtained >= 85;

-- 6. Update a student's email (example)
-- UPDATE students SET email = 'newemail@example.com' WHERE student_id = 1;

-- 7. Delete example (commented to preserve sample data)
-- DELETE FROM marks WHERE mark_id = 999;
