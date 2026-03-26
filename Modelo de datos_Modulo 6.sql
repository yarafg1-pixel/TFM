CREATE TABLE students_raw (
Marital_status INT,
Application_mode INT,
Application_order INT,
Course INT,
Daytime_evening_attendance INT,
Previous_qualification INT,
Previous_qualification_grade DECIMAL(5,2),
Nationality INT,
Mother_qualification INT,
Father_qualification INT,
Mother_occupation INT,
Father_occupation INT,
Admission_grade DECIMAL(5,2),
Displaced INT,
Educational_special_needs INT,
Debtor INT,
Tuition_fees_up_to_date INT,
Gender INT,
Scholarship_holder INT,
Age_at_enrollment INT,
International INT,
Curricular_units_1st_sem_credited INT,
Curricular_units_1st_sem_enrolled INT,
Curricular_units_1st_sem_evaluations INT,
Curricular_units_1st_sem_approved INT,
Curricular_units_1st_sem_grade DECIMAL(5,2),
Curricular_units_1st_sem_without_evaluations INT,
Curricular_units_2nd_sem_credited INT,
Curricular_units_2nd_sem_enrolled INT,
Curricular_units_2nd_sem_evaluations INT,
Curricular_units_2nd_sem_approved INT,
Curricular_units_2nd_sem_grade DECIMAL(5,2),
Curricular_units_2nd_sem_without_evaluations INT,
Unemployment_rate DECIMAL(5,2),
Inflation_rate DECIMAL(5,2),
GDP DECIMAL(10,2),
Target VARCHAR(20)
);

SHOW TABLES;
DESCRIBE students_raw;
SELECT COUNT(*) FROM students_raw;
INSERT INTO dim_marital_status (marital_status_id)
SELECT DISTINCT Marital_status
FROM students_raw;

INSERT INTO dim_nationality (nationality_id)
SELECT DISTINCT Nationality
FROM students_raw;

INSERT INTO dim_application_mode (application_mode_id)
SELECT DISTINCT Application_mode
FROM students_raw;

INSERT INTO dim_course (course_id, daytime_evening_attendance, scholarship_holder, educational_special_needs)

SELECT DISTINCT
Course,
Daytime_evening_attendance,
Scholarship_holder,
Educational_special_needs
FROM students_raw;

INSERT IGNORE INTO dim_marital_status (marital_status_id, marital_status_description)
SELECT DISTINCT 
Marital_status,
Marital_status
FROM students_raw;

INSERT INTO dim_family (
student_id,
mother_qualification,
father_qualification,
mother_occupation,
father_occupation
)

SELECT
student_id,
Mother_qualification,
Father_qualification,
Mother_occupation,
Father_occupation
FROM students_raw
JOIN student ON student.student_id = student.student_id;

INSERT INTO student (

marital_status_id,
nationality_id,
application_mode_id,
course_id,

application_order,
age_at_enrollment,
gender,
international,

previous_qualification,
previous_qualification_grade,
admission_grade,

curricular_units_1st_sem_credited,
curricular_units_1st_sem_enrolled,
curricular_units_1st_sem_evaluations,
curricular_units_1st_sem_approved,
curricular_units_1st_sem_grade,
curricular_units_1st_sem_without_evaluations,

curricular_units_2nd_sem_credited,
curricular_units_2nd_sem_enrolled,
curricular_units_2nd_sem_evaluations,
curricular_units_2nd_sem_approved,
curricular_units_2nd_sem_grade,
curricular_units_2nd_sem_without_evaluations,

target
)

SELECT

Marital_status,
Nationality,
Application_mode,
Course,

Application_order,
Age_at_enrollment,
Gender,
International,

Previous_qualification,
Previous_qualification_grade,
Admission_grade,

Curricular_units_1st_sem_credited,
Curricular_units_1st_sem_enrolled,
Curricular_units_1st_sem_evaluations,
Curricular_units_1st_sem_approved,
Curricular_units_1st_sem_grade,
Curricular_units_1st_sem_without_evaluations,

Curricular_units_2nd_sem_credited,
Curricular_units_2nd_sem_enrolled,
Curricular_units_2nd_sem_evaluations,
Curricular_units_2nd_sem_approved,
Curricular_units_2nd_sem_grade,
Curricular_units_2nd_sem_without_evaluations,

Target

FROM students_raw;

INSERT INTO student (
marital_status_id,
nationality_id,
application_mode_id,
course_id,

application_order,
age_at_enrollment,
gender,
international,

previous_qualification,
previous_qualification_grade,
admission_grade,

curricular_units_1st_sem_credited,
curricular_units_1st_sem_enrolled,
curricular_units_1st_sem_evaluations,
curricular_units_1st_sem_approved,
curricular_units_1st_sem_grade,
curricular_units_1st_sem_without_evaluations,

curricular_units_2nd_sem_credited,
curricular_units_2nd_sem_enrolled,
curricular_units_2nd_sem_evaluations,
curricular_units_2nd_sem_approved,
curricular_units_2nd_sem_grade,
curricular_units_2nd_sem_without_evaluations,

target
)
SELECT
m.marital_status_id,
n.nationality_id,
a.application_mode_id,
c.course_id,

s.Application_order,
s.Age_at_enrollment,
s.Gender,
s.International,

s.Previous_qualification,
s.Previous_qualification_grade,
s.Admission_grade,

s.Curricular_units_1st_sem_credited,
s.Curricular_units_1st_sem_enrolled,
s.Curricular_units_1st_sem_evaluations,
s.Curricular_units_1st_sem_approved,
s.Curricular_units_1st_sem_grade,
s.Curricular_units_1st_sem_without_evaluations,

s.Curricular_units_2nd_sem_credited,
s.Curricular_units_2nd_sem_enrolled,
s.Curricular_units_2nd_sem_evaluations,
s.Curricular_units_2nd_sem_approved,
s.Curricular_units_2nd_sem_grade,
s.Curricular_units_2nd_sem_without_evaluations,

s.Target

FROM students_raw s
JOIN dim_marital_status m ON s.Marital_status = m.marital_status_description
JOIN dim_nationality n ON s.Nationality = n.nationality_description
JOIN dim_application_mode a ON s.Application_mode = a.application_mode_description
JOIN dim_course c ON s.Course = c.course_name;

INSERT INTO dim_family (
student_id,
mother_qualification,
father_qualification,
mother_occupation,
father_occupation
)

SELECT
student_id,
Mother_qualification,
Father_qualification,
Mother_occupation,
Father_occupation
FROM students_raw
JOIN student ON student.student_id = student.student_id;

INSERT INTO dim_financial (
student_id,
debtor,
tuition_fees_up_to_date,
displaced
)

SELECT
student_id,
Debtor,
Tuition_fees_up_to_date,
Displaced
FROM students_raw;

INSERT INTO dim_family (
    student_id,
    mother_qualification,
    father_qualification,
    mother_occupation,
    father_occupation
)
SELECT
    s.student_id,
    r.Mother_qualification,
    r.Father_qualification,
    r.Mother_occupation,
    r.Father_occupation
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name
JOIN student s 
  ON s.marital_status_id = m.marital_status_id
 AND s.nationality_id = n.nationality_id
 AND s.application_mode_id = a.application_mode_id
 AND s.course_id = c.course_id
 AND s.age_at_enrollment = r.Age_at_enrollment
 AND s.gender = r.Gender
 AND s.international = r.International;
 
 INSERT INTO dim_financial (
    student_id,
    debtor,
    tuition_fees_up_to_date,
    displaced
)
SELECT
    s.student_id,
    r.Debtor,
    r.Tuition_fees_up_to_date,
    r.Displaced
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name
JOIN student s 
  ON s.marital_status_id = m.marital_status_id
 AND s.nationality_id = n.nationality_id
 AND s.application_mode_id = a.application_mode_id
 AND s.course_id = c.course_id
 AND s.age_at_enrollment = r.Age_at_enrollment
 AND s.gender = r.Gender
 AND s.international = r.International;
 
 INSERT INTO dim_economic_context (
    student_id,
    unemployment_rate,
    inflation_rate,
    gdp
)
SELECT
    s.student_id,
    r.Unemployment_rate,
    r.Inflation_rate,
    r.GDP
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name
JOIN student s 
  ON s.marital_status_id = m.marital_status_id
 AND s.nationality_id = n.nationality_id
 AND s.application_mode_id = a.application_mode_id
 AND s.course_id = c.course_id
 AND s.age_at_enrollment = r.Age_at_enrollment
 AND s.gender = r.Gender
 AND s.international = r.International;
 
SELECT COUNT(*) FROM student;
SELECT COUNT(*) FROM dim_family;
SELECT COUNT(*) FROM dim_financial;
SELECT COUNT(*) FROM dim_economic_context;

SELECT * FROM dim_marital_status LIMIT 10;
SELECT * FROM dim_course LIMIT 10;

UPDATE students_raw
SET Marital_status = TRIM(Marital_status);
UPDATE students_raw
SET Marital_status = UPPER(Marital_status); -- opcional, si quieres mayúsculas uniformes

SET SQL_SAFE_UPDATES = 0;

UPDATE students_raw
SET Marital_status = TRIM(Marital_status);

UPDATE students_raw
SET Marital_status = UPPER(Marital_status);

-- Volver a activar safe mode por seguridad
SET SQL_SAFE_UPDATES = 1;

UPDATE students_raw
SET Marital_status = TRIM(Marital_status)
WHERE Marital_status IS NOT NULL;

UPDATE students_raw
SET Marital_status = UPPER(Marital_status)
WHERE Marital_status IS NOT NULL;

SET SQL_SAFE_UPDATES = 0;

UPDATE students_raw
SET Marital_status = TRIM(Marital_status);

UPDATE students_raw
SET Marital_status = UPPER(Marital_status);

UPDATE students_raw
SET Course = TRIM(Course);

UPDATE students_raw
SET Course = UPPER(Course);

UPDATE students_raw
SET Nationality = TRIM(Nationality);

UPDATE students_raw
SET Nationality = UPPER(Nationality);

UPDATE students_raw
SET Application_mode = TRIM(Application_mode);

UPDATE students_raw
SET Application_mode = UPPER(Application_mode);

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;

-- Limpiar espacios y uniformizar mayúsculas
UPDATE students_raw
SET Marital_status = UPPER(TRIM(Marital_status));

UPDATE students_raw
SET Course = UPPER(TRIM(Course));

UPDATE students_raw
SET Nationality = UPPER(TRIM(Nationality));

UPDATE students_raw
SET Application_mode = UPPER(TRIM(Application_mode));

-- dim_marital_status
INSERT IGNORE INTO dim_marital_status (marital_status_id, marital_status_description)
SELECT DISTINCT Marital_status, Marital_status
FROM students_raw;

-- dim_nationality
INSERT IGNORE INTO dim_nationality (nationality_id, nationality_description)
SELECT DISTINCT Nationality, Nationality
FROM students_raw;

-- dim_application_mode
INSERT IGNORE INTO dim_application_mode (application_mode_id, application_mode_description)
SELECT DISTINCT Application_mode, Application_mode
FROM students_raw;

-- dim_course
INSERT IGNORE INTO dim_course (course_name, daytime_evening_attendance, scholarship_holder, educational_special_needs)
SELECT 
Course,
MAX(Daytime_evening_attendance),
MAX(Scholarship_holder),
MAX(Educational_special_needs)
FROM students_raw
GROUP BY Course;

INSERT INTO student (
marital_status_id,
nationality_id,
application_mode_id,
course_id,

application_order,
age_at_enrollment,
gender,
international,

previous_qualification,
previous_qualification_grade,
admission_grade,

curricular_units_1st_sem_credited,
curricular_units_1st_sem_enrolled,
curricular_units_1st_sem_evaluations,
curricular_units_1st_sem_approved,
curricular_units_1st_sem_grade,
curricular_units_1st_sem_without_evaluations,

curricular_units_2nd_sem_credited,
curricular_units_2nd_sem_enrolled,
curricular_units_2nd_sem_evaluations,
curricular_units_2nd_sem_approved,
curricular_units_2nd_sem_grade,
curricular_units_2nd_sem_without_evaluations,

target
)
SELECT
m.marital_status_id,
n.nationality_id,
a.application_mode_id,
c.course_id,

r.Application_order,
r.Age_at_enrollment,
r.Gender,
r.International,

r.Previous_qualification,
r.Previous_qualification_grade,
r.Admission_grade,

r.Curricular_units_1st_sem_credited,
r.Curricular_units_1st_sem_enrolled,
r.Curricular_units_1st_sem_evaluations,
r.Curricular_units_1st_sem_approved,
r.Curricular_units_1st_sem_grade,
r.Curricular_units_1st_sem_without_evaluations,

r.Curricular_units_2nd_sem_credited,
r.Curricular_units_2nd_sem_enrolled,
r.Curricular_units_2nd_sem_evaluations,
r.Curricular_units_2nd_sem_approved,
r.Curricular_units_2nd_sem_grade,
r.Curricular_units_2nd_sem_without_evaluations,

r.Target
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name;

INSERT INTO dim_family (
    student_id,
    mother_qualification,
    father_qualification,
    mother_occupation,
    father_occupation
)
SELECT
    s.student_id,
    r.Mother_qualification,
    r.Father_qualification,
    r.Mother_occupation,
    r.Father_occupation
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name
JOIN student s 
  ON s.marital_status_id = m.marital_status_id
 AND s.nationality_id = n.nationality_id
 AND s.application_mode_id = a.application_mode_id
 AND s.course_id = c.course_id
 AND s.age_at_enrollment = r.Age_at_enrollment
 AND s.gender = r.Gender
 AND s.international = r.International;
 
INSERT INTO dim_financial (
    student_id,
    debtor,
    tuition_fees_up_to_date,
    displaced
)
SELECT
    s.student_id,
    r.Debtor,
    r.Tuition_fees_up_to_date,
    r.Displaced
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name
JOIN student s 
  ON s.marital_status_id = m.marital_status_id
 AND s.nationality_id = n.nationality_id
 AND s.application_mode_id = a.application_mode_id
 AND s.course_id = c.course_id
 AND s.age_at_enrollment = r.Age_at_enrollment
 AND s.gender = r.Gender
 AND s.international = r.International;
 
 INSERT INTO dim_economic_context (
    student_id,
    unemployment_rate,
    inflation_rate,
    gdp
)
SELECT
    s.student_id,
    r.Unemployment_rate,
    r.Inflation_rate,
    r.GDP
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name
JOIN student s 
  ON s.marital_status_id = m.marital_status_id
 AND s.nationality_id = n.nationality_id
 AND s.application_mode_id = a.application_mode_id
 AND s.course_id = c.course_id
 AND s.age_at_enrollment = r.Age_at_enrollment
 AND s.gender = r.Gender
 AND s.international = r.International;
 
 SET SQL_SAFE_UPDATES = 1;
 
 SELECT 'students_raw' AS table_name, COUNT(*) AS total_rows FROM students_raw
UNION ALL
SELECT 'dim_marital_status', COUNT(*) FROM dim_marital_status
UNION ALL
SELECT 'dim_nationality', COUNT(*) FROM dim_nationality
UNION ALL
SELECT 'dim_application_mode', COUNT(*) FROM dim_application_mode
UNION ALL
SELECT 'dim_course', COUNT(*) FROM dim_course
UNION ALL
SELECT 'student', COUNT(*) FROM student
UNION ALL
SELECT 'dim_family', COUNT(*) FROM dim_family
UNION ALL
SELECT 'dim_financial', COUNT(*) FROM dim_financial
UNION ALL
SELECT 'dim_economic_context', COUNT(*) FROM dim_economic_context;

SELECT s.student_id, m.marital_status_description, n.nationality_description, a.application_mode_description, c.course_name
FROM student s
JOIN dim_marital_status m ON s.marital_status_id = m.marital_status_id
JOIN dim_nationality n ON s.nationality_id = n.nationality_id
JOIN dim_application_mode a ON s.application_mode_id = a.application_mode_id
JOIN dim_course c ON s.course_id = c.course_id
LIMIT 10;

SELECT f.student_id, s.age_at_enrollment, f.mother_qualification, f.father_qualification
FROM dim_family f
JOIN student s ON f.student_id = s.student_id
LIMIT 10;

SELECT f.student_id, s.gender, f.debtor, f.tuition_fees_up_to_date
FROM dim_financial f
JOIN student s ON f.student_id = s.student_id
LIMIT 10;

SELECT e.student_id, s.Course, e.unemployment_rate, e.gdp
FROM dim_economic_context e
JOIN student s ON e.student_id = s.student_id
LIMIT 10;

SELECT e.student_id, c.course_name, e.unemployment_rate, e.gdp
FROM dim_economic_context e
JOIN student s ON e.student_id = s.student_id
JOIN dim_course c ON s.course_id = c.course_id
LIMIT 10;

-- Estudiantes sin dim_family
SELECT COUNT(*) FROM student s
LEFT JOIN dim_family f ON s.student_id = f.student_id
WHERE f.student_id IS NULL;

-- Estudiantes sin dim_financial
SELECT COUNT(*) FROM student s
LEFT JOIN dim_financial f ON s.student_id = f.student_id
WHERE f.student_id IS NULL;

-- Estudiantes sin dim_economic_context
SELECT COUNT(*) FROM student s
LEFT JOIN dim_economic_context e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- Estudiantes sin dim_family
SELECT COUNT(*) 
FROM student s
LEFT JOIN dim_family f ON s.student_id = f.student_id
WHERE f.student_id IS NULL;

-- Estudiantes sin dim_financial
SELECT COUNT(*) 
FROM student s
LEFT JOIN dim_financial f ON s.student_id = f.student_id
WHERE f.student_id IS NULL;

-- Estudiantes sin dim_economic_context
SELECT COUNT(*) 
FROM student s
LEFT JOIN dim_economic_context e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 1️⃣ Conteo de filas por tabla
SELECT 'students_raw' AS table_name, COUNT(*) AS total_rows FROM students_raw
UNION ALL
SELECT 'dim_marital_status', COUNT(*) FROM dim_marital_status
UNION ALL
SELECT 'dim_nationality', COUNT(*) FROM dim_nationality
UNION ALL
SELECT 'dim_application_mode', COUNT(*) FROM dim_application_mode
UNION ALL
SELECT 'dim_course', COUNT(*) FROM dim_course
UNION ALL
SELECT 'student', COUNT(*) FROM student
UNION ALL
SELECT 'dim_family', COUNT(*) FROM dim_family
UNION ALL
SELECT 'dim_financial', COUNT(*) FROM dim_financial
UNION ALL
SELECT 'dim_economic_context', COUNT(*) FROM dim_economic_context;

-- 2️⃣ Verificar integridad de tablas relacionadas (cuántos estudiantes no tienen registros)
SELECT 
    (SELECT COUNT(*) FROM student s LEFT JOIN dim_family f ON s.student_id = f.student_id WHERE f.student_id IS NULL) AS missing_family,
    (SELECT COUNT(*) FROM student s LEFT JOIN dim_financial f ON s.student_id = f.student_id WHERE f.student_id IS NULL) AS missing_financial,
    (SELECT COUNT(*) FROM student s LEFT JOIN dim_economic_context e ON s.student_id = e.student_id WHERE e.student_id IS NULL) AS missing_economic;

-- 3️⃣ Muestra de 10 estudiantes con sus dimensiones
SELECT 
    s.student_id,
    m.marital_status_description,
    n.nationality_description,
    a.application_mode_description,
    c.course_name,
    s.age_at_enrollment,
    s.gender,
    s.international
FROM student s
JOIN dim_marital_status m ON s.marital_status_id = m.marital_status_id
JOIN dim_nationality n ON s.nationality_id = n.nationality_id
JOIN dim_application_mode a ON s.application_mode_id = a.application_mode_id
JOIN dim_course c ON s.course_id = c.course_id
LIMIT 10;

-- 4️⃣ Muestra de 10 filas de cada tabla relacionada
SELECT s.student_id, f.mother_qualification, f.father_qualification, f.mother_occupation, f.father_occupation
FROM dim_family f
JOIN student s ON f.student_id = s.student_id
LIMIT 10;

SELECT s.student_id, f.debtor, f.tuition_fees_up_to_date, f.displaced
FROM dim_financial f
JOIN student s ON f.student_id = s.student_id
LIMIT 10;

SELECT s.student_id, e.unemployment_rate, e.inflation_rate, e.gdp
FROM dim_economic_context e
JOIN student s ON e.student_id = s.student_id
LIMIT 10;

SELECT c.course_name, a.application_mode_description, COUNT(*) AS total_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
JOIN dim_application_mode a ON s.application_mode_id = a.application_mode_id
GROUP BY c.course_name, a.application_mode_description;

SELECT AVG(curricular_units_1st_sem_approved) AS avg_1st_sem,
       AVG(curricular_units_2nd_sem_approved) AS avg_2nd_sem
FROM student;

SELECT s.student_id, f.debtor, f.tuition_fees_up_to_date, c.educational_special_needs
FROM student s
JOIN dim_financial f ON s.student_id = f.student_id
JOIN dim_course c ON s.course_id = c.course_id
WHERE f.debtor = 'YES' OR c.educational_special_needs = 'YES';

SELECT COUNT(*) AS total_rows FROM students_raw;
SELECT * FROM students_raw LIMIT 10;

-- Desactivar temporalmente safe mode
SET SQL_SAFE_UPDATES = 0;

-- Limpiar y uniformizar columnas clave
UPDATE students_raw
SET Marital_status = UPPER(TRIM(Marital_status)),
    Course = UPPER(TRIM(Course)),
    Nationality = UPPER(TRIM(Nationality)),
    Application_mode = UPPER(TRIM(Application_mode));
    
    -- dim_marital_status
INSERT IGNORE INTO dim_marital_status (marital_status_id, marital_status_description)
SELECT DISTINCT Marital_status, Marital_status
FROM students_raw;

-- dim_nationality
INSERT IGNORE INTO dim_nationality (nationality_id, nationality_description)
SELECT DISTINCT Nationality, Nationality
FROM students_raw;

-- dim_application_mode
INSERT IGNORE INTO dim_application_mode (application_mode_id, application_mode_description)
SELECT DISTINCT Application_mode, Application_mode
FROM students_raw;

-- dim_course
INSERT IGNORE INTO dim_course (course_name, daytime_evening_attendance, scholarship_holder, educational_special_needs)
SELECT Course,
       MAX(Daytime_evening_attendance),
       MAX(Scholarship_holder),
       MAX(Educational_special_needs)
FROM students_raw
GROUP BY Course;

INSERT IGNORE INTO dim_marital_status (marital_status_id, marital_status_description)
SELECT DISTINCT Marital_status, Marital_status
FROM students_raw;

INSERT IGNORE INTO dim_marital_status (marital_status_description)
SELECT DISTINCT Marital_status
FROM students_raw;

INSERT IGNORE INTO dim_course (course_name, daytime_evening_attendance, scholarship_holder, educational_special_needs)
SELECT Course,
       MAX(Daytime_evening_attendance),
       MAX(Scholarship_holder),
       MAX(Educational_special_needs)
FROM students_raw
GROUP BY Course;

-- Marital Status
INSERT IGNORE INTO dim_marital_status (marital_status_description)
SELECT DISTINCT Marital_status FROM students_raw;

-- Nationality
INSERT IGNORE INTO dim_nationality (nationality_description)
SELECT DISTINCT Nationality FROM students_raw;

-- Application Mode
INSERT IGNORE INTO dim_application_mode (application_mode_description)
SELECT DISTINCT Application_mode FROM students_raw;

INSERT IGNORE INTO dim_course (course_name, daytime_evening_attendance, scholarship_holder, educational_special_needs)
SELECT Course,
       MAX(Daytime_evening_attendance),
       MAX(Scholarship_holder),
       MAX(Educational_special_needs)
FROM students_raw
GROUP BY Course;

DESCRIBE dim_marital_status;
DESCRIBE dim_nationality;
DESCRIBE dim_application_mode;
DESCRIBE dim_course;

DROP TABLE IF EXISTS dim_marital_status;

CREATE TABLE dim_marital_status (
    marital_status_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    marital_status_description VARCHAR(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS dim_nationality;

CREATE TABLE dim_nationality (
    nationality_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nationality_description VARCHAR(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS dim_application_mode;

CREATE TABLE dim_application_mode (
    application_mode_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    application_mode_description VARCHAR(50) NOT NULL UNIQUE
);

DROP TABLE IF EXISTS dim_course;

CREATE TABLE dim_course (
    course_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    daytime_evening_attendance VARCHAR(20),
    scholarship_holder VARCHAR(10),
    educational_special_needs VARCHAR(10)
);

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS dim_course;

CREATE TABLE dim_course (
    course_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    daytime_evening_attendance VARCHAR(20),
    scholarship_holder VARCHAR(10),
    educational_special_needs VARCHAR(10)
);

SET FOREIGN_KEY_CHECKS = 1;
SHOW TABLES;

-- Revisar los primeros valores de cada columna clave
SELECT DISTINCT TRIM(UPPER(Marital_status)) AS Marital_status FROM students_raw;
SELECT DISTINCT TRIM(UPPER(Nationality)) AS Nationality FROM students_raw;
SELECT DISTINCT TRIM(UPPER(Application_mode)) AS Application_mode FROM students_raw;
SELECT DISTINCT TRIM(UPPER(Course)) AS Course FROM students_raw;

SET SQL_SAFE_UPDATES = 0;

UPDATE students_raw
SET Marital_status = UPPER(TRIM(Marital_status)),
    Course = UPPER(TRIM(Course)),
    Nationality = UPPER(TRIM(Nationality)),
    Application_mode = UPPER(TRIM(Application_mode));
    
    -- Marital Status
INSERT IGNORE INTO dim_marital_status (marital_status_description)
SELECT DISTINCT Marital_status FROM students_raw;

-- Nationality
INSERT IGNORE INTO dim_nationality (nationality_description)
SELECT DISTINCT Nationality FROM students_raw;

-- Application Mode
INSERT IGNORE INTO dim_application_mode (application_mode_description)
SELECT DISTINCT Application_mode FROM students_raw;

-- Course
INSERT IGNORE INTO dim_course (course_name, daytime_evening_attendance, scholarship_holder, educational_special_needs)
SELECT DISTINCT Course, Daytime_evening_attendance, Scholarship_holder, Educational_special_needs
FROM students_raw;

SELECT * FROM dim_marital_status LIMIT 10;
SELECT * FROM dim_nationality LIMIT 10;
SELECT * FROM dim_application_mode LIMIT 10;
SELECT * FROM dim_course LIMIT 10;

INSERT INTO student (
marital_status_id, nationality_id, application_mode_id, course_id,
application_order, age_at_enrollment, gender, international,
previous_qualification, previous_qualification_grade, admission_grade,
curricular_units_1st_sem_credited, curricular_units_1st_sem_enrolled, curricular_units_1st_sem_evaluations,
curricular_units_1st_sem_approved, curricular_units_1st_sem_grade, curricular_units_1st_sem_without_evaluations,
curricular_units_2nd_sem_credited, curricular_units_2nd_sem_enrolled, curricular_units_2nd_sem_evaluations,
curricular_units_2nd_sem_approved, curricular_units_2nd_sem_grade, curricular_units_2nd_sem_without_evaluations,
target
)
SELECT
m.marital_status_id, n.nationality_id, a.application_mode_id, c.course_id,
r.Application_order, r.Age_at_enrollment, r.Gender, r.International,
r.Previous_qualification, r.Previous_qualification_grade, r.Admission_grade,
r.Curricular_units_1st_sem_credited, r.Curricular_units_1st_sem_enrolled, r.Curricular_units_1st_sem_evaluations,
r.Curricular_units_1st_sem_approved, r.Curricular_units_1st_sem_grade, r.Curricular_units_1st_sem_without_evaluations,
r.Curricular_units_2nd_sem_credited, r.Curricular_units_2nd_sem_enrolled, r.Curricular_units_2nd_sem_evaluations,
r.Curricular_units_2nd_sem_approved, r.Curricular_units_2nd_sem_grade, r.Curricular_units_2nd_sem_without_evaluations,
r.Target
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name;

-- ==========================================
-- SCRIPT COMPLETO PARA POBLAR MVP
-- ==========================================

-- 1️⃣ Limpiar datos en students_raw
SET SQL_SAFE_UPDATES = 0;

UPDATE students_raw
SET Marital_status = UPPER(TRIM(Marital_status)),
    Course = UPPER(TRIM(Course)),
    Nationality = UPPER(TRIM(Nationality)),
    Application_mode = UPPER(TRIM(Application_mode)),
    Daytime_evening_attendance = UPPER(TRIM(Daytime_evening_attendance)),
    Scholarship_holder = UPPER(TRIM(Scholarship_holder)),
    Educational_special_needs = UPPER(TRIM(Educational_special_needs)),
    Gender = UPPER(TRIM(Gender)),
    International = UPPER(TRIM(International)),
    Previous_qualification = UPPER(TRIM(Previous_qualification)),
    Mother_qualification = UPPER(TRIM(Mother_qualification)),
    Father_qualification = UPPER(TRIM(Father_qualification)),
    Mother_occupation = UPPER(TRIM(Mother_occupation)),
    Father_occupation = UPPER(TRIM(Father_occupation)),
    Debtor = UPPER(TRIM(Debtor)),
    Tuition_fees_up_to_date = UPPER(TRIM(Tuition_fees_up_to_date)),
    Displaced = UPPER(TRIM(Displaced));

-- 2️⃣ Desactivar restricciones FK temporalmente
SET FOREIGN_KEY_CHECKS = 0;

-- 3️⃣ Recrear dimensiones

-- dim_marital_status
DROP TABLE IF EXISTS dim_marital_status;
CREATE TABLE dim_marital_status (
    marital_status_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    marital_status_description VARCHAR(50) NOT NULL UNIQUE
);

-- dim_nationality
DROP TABLE IF EXISTS dim_nationality;
CREATE TABLE dim_nationality (
    nationality_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nationality_description VARCHAR(50) NOT NULL UNIQUE
);

-- dim_application_mode
DROP TABLE IF EXISTS dim_application_mode;
CREATE TABLE dim_application_mode (
    application_mode_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    application_mode_description VARCHAR(50) NOT NULL UNIQUE
);

-- dim_course
DROP TABLE IF EXISTS dim_course;
CREATE TABLE dim_course (
    course_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL UNIQUE,
    daytime_evening_attendance VARCHAR(20),
    scholarship_holder VARCHAR(10),
    educational_special_needs VARCHAR(10)
);

-- Tabla central student
DROP TABLE IF EXISTS student;
CREATE TABLE student (
    student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    marital_status_id INT,
    nationality_id INT,
    application_mode_id INT,
    course_id INT,
    application_order INT,
    age_at_enrollment INT,
    gender VARCHAR(10),
    international VARCHAR(10),
    previous_qualification VARCHAR(50),
    previous_qualification_grade VARCHAR(10),
    admission_grade VARCHAR(10),
    curricular_units_1st_sem_credited INT,
    curricular_units_1st_sem_enrolled INT,
    curricular_units_1st_sem_evaluations INT,
    curricular_units_1st_sem_approved INT,
    curricular_units_1st_sem_grade DECIMAL(5,2),
    curricular_units_1st_sem_without_evaluations INT,
    curricular_units_2nd_sem_credited INT,
    curricular_units_2nd_sem_enrolled INT,
    curricular_units_2nd_sem_evaluations INT,
    curricular_units_2nd_sem_approved INT,
    curricular_units_2nd_sem_grade DECIMAL(5,2),
    curricular_units_2nd_sem_without_evaluations INT,
    target VARCHAR(10),
    FOREIGN KEY (marital_status_id) REFERENCES dim_marital_status(marital_status_id),
    FOREIGN KEY (nationality_id) REFERENCES dim_nationality(nationality_id),
    FOREIGN KEY (application_mode_id) REFERENCES dim_application_mode(application_mode_id),
    FOREIGN KEY (course_id) REFERENCES dim_course(course_id)
);

-- Tablas dependientes
DROP TABLE IF EXISTS dim_family;
CREATE TABLE dim_family (
    student_id INT PRIMARY KEY,
    mother_qualification VARCHAR(50),
    father_qualification VARCHAR(50),
    mother_occupation VARCHAR(50),
    father_occupation VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

DROP TABLE IF EXISTS dim_financial;
CREATE TABLE dim_financial (
    student_id INT PRIMARY KEY,
    debtor VARCHAR(10),
    tuition_fees_up_to_date VARCHAR(10),
    displaced VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

DROP TABLE IF EXISTS dim_economic_context;
CREATE TABLE dim_economic_context (
    student_id INT PRIMARY KEY,
    unemployment_rate DECIMAL(5,2),
    inflation_rate DECIMAL(5,2),
    gdp DECIMAL(12,2),
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- 4️⃣ Insertar datos en dimensiones

INSERT IGNORE INTO dim_marital_status (marital_status_description)
SELECT DISTINCT Marital_status FROM students_raw;

INSERT IGNORE INTO dim_nationality (nationality_description)
SELECT DISTINCT Nationality FROM students_raw;

INSERT IGNORE INTO dim_application_mode (application_mode_description)
SELECT DISTINCT Application_mode FROM students_raw;

INSERT IGNORE INTO dim_course (course_name, daytime_evening_attendance, scholarship_holder, educational_special_needs)
SELECT DISTINCT Course, Daytime_evening_attendance, Scholarship_holder, Educational_special_needs
FROM students_raw;

-- 5️⃣ Insertar datos en student
INSERT INTO student (
marital_status_id, nationality_id, application_mode_id, course_id,
application_order, age_at_enrollment, gender, international,
previous_qualification, previous_qualification_grade, admission_grade,
curricular_units_1st_sem_credited, curricular_units_1st_sem_enrolled, curricular_units_1st_sem_evaluations,
curricular_units_1st_sem_approved, curricular_units_1st_sem_grade, curricular_units_1st_sem_without_evaluations,
curricular_units_2nd_sem_credited, curricular_units_2nd_sem_enrolled, curricular_units_2nd_sem_evaluations,
curricular_units_2nd_sem_approved, curricular_units_2nd_sem_grade, curricular_units_2nd_sem_without_evaluations,
target
)
SELECT
m.marital_status_id, n.nationality_id, a.application_mode_id, c.course_id,
r.Application_order, r.Age_at_enrollment, r.Gender, r.International,
r.Previous_qualification, r.Previous_qualification_grade, r.Admission_grade,
r.Curricular_units_1st_sem_credited, r.Curricular_units_1st_sem_enrolled, r.Curricular_units_1st_sem_evaluations,
r.Curricular_units_1st_sem_approved, r.Curricular_units_1st_sem_grade, r.Curricular_units_1st_sem_without_evaluations,
r.Curricular_units_2nd_sem_credited, r.Curricular_units_2nd_sem_enrolled, r.Curricular_units_2nd_sem_evaluations,
r.Curricular_units_2nd_sem_approved, r.Curricular_units_2nd_sem_grade, r.Curricular_units_2nd_sem_without_evaluations,
r.Target
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name;

-- 6️⃣ Insertar tablas dependientes
INSERT INTO dim_family (student_id, mother_qualification, father_qualification, mother_occupation, father_occupation)
SELECT s.student_id, r.Mother_qualification, r.Father_qualification, r.Mother_occupation, r.Father_occupation
FROM students_raw r
JOIN student s
  ON r.Age_at_enrollment = s.age_at_enrollment
 AND r.Gender = s.gender
 AND r.International = s.international;

INSERT INTO dim_financial (student_id, debtor, tuition_fees_up_to_date, displaced)
SELECT s.student_id, r.Debtor, r.Tuition_fees_up_to_date, r.Displaced
FROM students_raw r
JOIN student s
  ON r.Age_at_enrollment = s.age_at_enrollment
 AND r.Gender = s.gender
 AND r.International = s.international;

INSERT INTO dim_economic_context (student_id, unemployment_rate, inflation_rate, gdp)
SELECT s.student_id, r.Unemployment_rate, r.Inflation_rate, r.GDP
FROM students_raw r
JOIN student s
  ON r.Age_at_enrollment = s.age_at_enrollment
 AND r.Gender = s.gender
 AND r.International = s.international;

-- 7️⃣ Reactivar restricciones FK
SET FOREIGN_KEY_CHECKS = 1;

-- 8️⃣ Verificar datos
SELECT 'student' AS table_name, COUNT(*) FROM student
UNION ALL
SELECT 'dim_family', COUNT(*) FROM dim_family
UNION ALL
SELECT 'dim_financial', COUNT(*) FROM dim_financial
UNION ALL
SELECT 'dim_economic_context', COUNT(*) FROM dim_economic_context
UNION ALL
SELECT 'dim_marital_status', COUNT(*) FROM dim_marital_status
UNION ALL
SELECT 'dim_nationality', COUNT(*) FROM dim_nationality
UNION ALL
SELECT 'dim_application_mode', COUNT(*) FROM dim_application_mode
UNION ALL
SELECT 'dim_course', COUNT(*) FROM dim_course;

INSERT IGNORE INTO dim_family (student_id, mother_qualification, father_qualification, mother_occupation, father_occupation)
SELECT s.student_id, r.Mother_qualification, r.Father_qualification, r.Mother_occupation, r.Father_occupation
FROM students_raw r
JOIN student s
  ON r.Age_at_enrollment = s.age_at_enrollment
 AND r.Gender = s.gender
 AND r.International = s.international;
 
 SELECT 'student' AS table_name, COUNT(*) FROM student
UNION ALL
SELECT 'dim_family', COUNT(*) FROM dim_family
UNION ALL
SELECT 'dim_financial', COUNT(*) FROM dim_financial
UNION ALL
SELECT 'dim_economic_context', COUNT(*) FROM dim_economic_context
UNION ALL
SELECT 'dim_marital_status', COUNT(*) FROM dim_marital_status
UNION ALL
SELECT 'dim_nationality', COUNT(*) FROM dim_nationality
UNION ALL
SELECT 'dim_application_mode', COUNT(*) FROM dim_application_mode
UNION ALL
SELECT 'dim_course', COUNT(*) FROM dim_course;

SELECT * FROM student LIMIT 10;
SELECT * FROM dim_course LIMIT 10;
SELECT * FROM dim_family LIMIT 10;

SELECT c.course_name, COUNT(*) AS total_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
GROUP BY c.course_name;

SELECT c.course_name, COUNT(*) AS scholarship_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
WHERE c.scholarship_holder = 'YES'
GROUP BY c.course_name;

SELECT c.course_name, AVG(curricular_units_1st_sem_approved) AS avg_approved
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
GROUP BY c.course_name;

UPDATE dim_course
SET scholarship_holder = UPPER(TRIM(scholarship_holder));

SELECT DISTINCT scholarship_holder FROM dim_course;

SELECT c.course_name, COUNT(*) AS scholarship_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
WHERE c.scholarship_holder = 'YES'
GROUP BY c.course_name;

SELECT COUNT(*) AS null_courses FROM student WHERE course_id IS NULL;
SELECT course_name, scholarship_holder FROM dim_course;

UPDATE students_raw
SET Course = UPPER(TRIM(Course)),
    Scholarship_holder = UPPER(TRIM(Scholarship_holder));
    
TRUNCATE TABLE student;
TRUNCATE TABLE dim_course;

INSERT IGNORE INTO dim_course (course_name, daytime_evening_attendance, scholarship_holder, educational_special_needs)
SELECT DISTINCT 
    Course, 
    UPPER(TRIM(Daytime_evening_attendance)), 
    Scholarship_holder, 
    UPPER(TRIM(Educational_special_needs))
FROM students_raw;

INSERT INTO student (
marital_status_id, nationality_id, application_mode_id, course_id,
application_order, age_at_enrollment, gender, international,
previous_qualification, previous_qualification_grade, admission_grade,
curricular_units_1st_sem_credited, curricular_units_1st_sem_enrolled, curricular_units_1st_sem_evaluations,
curricular_units_1st_sem_approved, curricular_units_1st_sem_grade, curricular_units_1st_sem_without_evaluations,
curricular_units_2nd_sem_credited, curricular_units_2nd_sem_enrolled, curricular_units_2nd_sem_evaluations,
curricular_units_2nd_sem_approved, curricular_units_2nd_sem_grade, curricular_units_2nd_sem_without_evaluations,
target
)
SELECT
m.marital_status_id, n.nationality_id, a.application_mode_id, c.course_id,
r.Application_order, r.Age_at_enrollment, r.Gender, r.International,
r.Previous_qualification, r.Previous_qualification_grade, r.Admission_grade,
r.Curricular_units_1st_sem_credited, r.Curricular_units_1st_sem_enrolled, r.Curricular_units_1st_sem_evaluations,
r.Curricular_units_1st_sem_approved, r.Curricular_units_1st_sem_grade, r.Curricular_units_1st_sem_without_evaluations,
r.Curricular_units_2nd_sem_credited, r.Curricular_units_2nd_sem_enrolled, r.Curricular_units_2nd_sem_evaluations,
r.Curricular_units_2nd_sem_approved, r.Curricular_units_2nd_sem_grade, r.Curricular_units_2nd_sem_without_evaluations,
r.Target
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name
    AND r.Scholarship_holder = c.scholarship_holder;  -- esto asegura que el course_id se asigne correctamente
    
    SELECT course_id, course_name, scholarship_holder FROM dim_course;
SELECT COUNT(*) FROM student WHERE course_id IS NULL;
SELECT c.course_name, COUNT(*) AS scholarship_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
WHERE c.scholarship_holder = 'YES'
GROUP BY c.course_name;

SELECT DISTINCT course_name, scholarship_holder FROM dim_course;

SELECT student_id, course_id FROM student LIMIT 10;

SELECT DISTINCT r.Course, r.Scholarship_holder, c.course_id, c.scholarship_holder
FROM students_raw r
LEFT JOIN dim_course c
ON r.Course = c.course_name;

SELECT DISTINCT r.Course, r.Scholarship_holder, c.course_id, c.scholarship_holder
FROM students_raw r
LEFT JOIN dim_course c
ON r.Course = c.course_name;

INSERT INTO student (
  marital_status_id, nationality_id, application_mode_id, course_id,
  application_order, age_at_enrollment, gender, international,
  previous_qualification, previous_qualification_grade, admission_grade,
  curricular_units_1st_sem_credited, curricular_units_1st_sem_enrolled, curricular_units_1st_sem_evaluations,
  curricular_units_1st_sem_approved, curricular_units_1st_sem_grade, curricular_units_1st_sem_without_evaluations,
  curricular_units_2nd_sem_credited, curricular_units_2nd_sem_enrolled, curricular_units_2nd_sem_evaluations,
  curricular_units_2nd_sem_approved, curricular_units_2nd_sem_grade, curricular_units_2nd_sem_without_evaluations,
  target
)
SELECT
  m.marital_status_id, n.nationality_id, a.application_mode_id, c.course_id,
  r.Application_order, r.Age_at_enrollment, r.Gender, r.International,
  r.Previous_qualification, r.Previous_qualification_grade, r.Admission_grade,
  r.Curricular_units_1st_sem_credited, r.Curricular_units_1st_sem_enrolled, r.Curricular_units_1st_sem_evaluations,
  r.Curricular_units_1st_sem_approved, r.Curricular_units_1st_sem_grade, r.Curricular_units_1st_sem_without_evaluations,
  r.Curricular_units_2nd_sem_credited, r.Curricular_units_2nd_sem_enrolled, r.Curricular_units_2nd_sem_evaluations,
  r.Curricular_units_2nd_sem_approved, r.Curricular_units_2nd_sem_grade, r.Curricular_units_2nd_sem_without_evaluations,
  r.Target
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name;

SELECT c.course_name, COUNT(*) AS scholarship_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
WHERE c.scholarship_holder = 'YES'
GROUP BY c.course_name;

SELECT DISTINCT scholarship_holder FROM dim_course;

SELECT c.course_name, COUNT(*) AS scholarship_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
WHERE UPPER(c.scholarship_holder) = 'YES'
GROUP BY c.course_name;

UPDATE dim_course
SET scholarship_holder = UPPER(TRIM(scholarship_holder));

SELECT c.course_name, COUNT(*) AS scholarship_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
WHERE c.scholarship_holder = 'YES'
GROUP BY c.course_name;

-- Eliminar espacios y uniformar mayúsculas
UPDATE students_raw
SET Course = UPPER(TRIM(Course)),
    Scholarship_holder = UPPER(TRIM(Scholarship_holder)),
    Marital_status = UPPER(TRIM(Marital_status)),
    Nationality = UPPER(TRIM(Nationality)),
    Application_mode = UPPER(TRIM(Application_mode)),
    Daytime_evening_attendance = UPPER(TRIM(Daytime_evening_attendance)),
    Educational_special_needs = UPPER(TRIM(Educational_special_needs));
    
    -- Marital Status
TRUNCATE TABLE dim_marital_status;
INSERT IGNORE INTO dim_marital_status (marital_status_id, marital_status_description)
SELECT DISTINCT Marital_status, Marital_status
FROM students_raw;

-- Nationality
TRUNCATE TABLE dim_nationality;
INSERT IGNORE INTO dim_nationality (nationality_id, nationality_description)
SELECT DISTINCT Nationality, Nationality
FROM students_raw;

-- Application Mode
TRUNCATE TABLE dim_application_mode;
INSERT IGNORE INTO dim_application_mode (application_mode_id, application_mode_description)
SELECT DISTINCT Application_mode, Application_mode
FROM students_raw;

-- Course
TRUNCATE TABLE dim_course;
INSERT IGNORE INTO dim_course (course_name, daytime_evening_attendance, scholarship_holder, educational_special_needs)
SELECT DISTINCT Course, 
       Daytime_evening_attendance, 
       Scholarship_holder, 
       Educational_special_needs
FROM students_raw;

TRUNCATE TABLE student;

INSERT INTO student (
  marital_status_id, nationality_id, application_mode_id, course_id,
  application_order, age_at_enrollment, gender, international,
  previous_qualification, previous_qualification_grade, admission_grade,
  curricular_units_1st_sem_credited, curricular_units_1st_sem_enrolled, curricular_units_1st_sem_evaluations,
  curricular_units_1st_sem_approved, curricular_units_1st_sem_grade, curricular_units_1st_sem_without_evaluations,
  curricular_units_2nd_sem_credited, curricular_units_2nd_sem_enrolled, curricular_units_2nd_sem_evaluations,
  curricular_units_2nd_sem_approved, curricular_units_2nd_sem_grade, curricular_units_2nd_sem_without_evaluations,
  target
)
SELECT
  m.marital_status_id, n.nationality_id, a.application_mode_id, c.course_id,
  r.Application_order, r.Age_at_enrollment, r.Gender, r.International,
  r.Previous_qualification, r.Previous_qualification_grade, r.Admission_grade,
  r.Curricular_units_1st_sem_credited, r.Curricular_units_1st_sem_enrolled, r.Curricular_units_1st_sem_evaluations,
  r.Curricular_units_1st_sem_approved, r.Curricular_units_1st_sem_grade, r.Curricular_units_1st_sem_without_evaluations,
  r.Curricular_units_2nd_sem_credited, r.Curricular_units_2nd_sem_enrolled, r.Curricular_units_2nd_sem_evaluations,
  r.Curricular_units_2nd_sem_approved, r.Curricular_units_2nd_sem_grade, r.Curricular_units_2nd_sem_without_evaluations,
  r.Target
FROM students_raw r
JOIN dim_marital_status m ON r.Marital_status = m.marital_status_description
JOIN dim_nationality n ON r.Nationality = n.nationality_description
JOIN dim_application_mode a ON r.Application_mode = a.application_mode_description
JOIN dim_course c ON r.Course = c.course_name AND r.Scholarship_holder = c.scholarship_holder;

SELECT c.course_name, COUNT(*) AS scholarship_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
WHERE c.scholarship_holder = 'YES'
GROUP BY c.course_name;

SELECT c.course_name, AVG(curricular_units_1st_sem_approved) AS avg_approved
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
GROUP BY c.course_name;

SELECT c.course_name, COUNT(*) AS total_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
GROUP BY c.course_name
ORDER BY total_students DESC;

SELECT a.application_mode_description, COUNT(*) AS total_students
FROM student s
JOIN dim_application_mode a ON s.application_mode_id = a.application_mode_id
GROUP BY a.application_mode_description;

SELECT c.course_name, AVG(age_at_enrollment) AS avg_age
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
GROUP BY c.course_name;

SELECT c.course_name, COUNT(*) AS international_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
WHERE s.international = 1
GROUP BY c.course_name;

SELECT c.course_name, 
       SUM(CASE WHEN c.educational_special_needs = 'YES' THEN 1 ELSE 0 END) AS special_needs,
       COUNT(*) AS total_students,
       ROUND(SUM(CASE WHEN c.educational_special_needs = 'YES' THEN 1 ELSE 0 END)/COUNT(*)*100, 2) AS percent_special_needs
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
GROUP BY c.course_name;

SELECT c.course_name,
       SUM(CASE WHEN c.scholarship_holder = 'YES' THEN 1 ELSE 0 END) AS scholarship_students,
       SUM(CASE WHEN c.scholarship_holder = 'NO' THEN 1 ELSE 0 END) AS no_scholarship_students
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
GROUP BY c.course_name;

SELECT c.course_name,
       AVG(curricular_units_1st_sem_approved) AS avg_units_1st,
       AVG(curricular_units_2nd_sem_approved) AS avg_units_2nd
FROM student s
JOIN dim_course c ON s.course_id = c.course_id
GROUP BY c.course_name;

SELECT m.marital_status_description, n.nationality_description, COUNT(*) AS total_students
FROM student s
JOIN dim_marital_status m ON s.marital_status_id = m.marital_status_id
JOIN dim_nationality n ON s.nationality_id = n.nationality_id
GROUP BY m.marital_status_description, n.nationality_description
ORDER BY total_students DESC;

