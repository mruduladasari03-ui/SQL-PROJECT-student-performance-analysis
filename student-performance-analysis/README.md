# Student Performance & Academic Analytics (MySQL)

A pure-SQL beginner portfolio project for storing student marks and analysing academic performance. No frontend, backend, or application code.

## Database
Database name: `student_performance`

### Tables
- `departments`: department names
- `students`: student details and department
- `courses`: course catalogue and maximum marks
- `marks`: each student's marks in each course

## Run in MySQL Workbench
Run these files in order:
1. `sql/01_create_tables.sql`
2. `sql/02_insert_data.sql`
3. `sql/03_basic_queries.sql`
4. `sql/04_advanced_queries.sql`
5. `sql/05_views.sql`

The first script creates the database and tables. The second inserts fictional sample data.

## SQL concepts demonstrated
DDL, DML, primary keys, foreign keys, constraints, joins, aggregate functions, GROUP BY, HAVING, subqueries, CASE, views, and ranking with a window function.

## Example analysis
- Department-wise average marks
- Top-performing students
- Course-wise pass percentage
- Students scoring above the overall average
- Rank students within each department
- Identify students who need academic support

All sample data is fictional and intended for learning.
