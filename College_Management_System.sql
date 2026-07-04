
CREATE DATABASE CollegeDB;

USE CollegeDB;

CREATE TABLE Department (

    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,

    DepartmentName VARCHAR(100) NOT NULL,

    Building VARCHAR(100),

    TotalStudents INT DEFAULT 0

);

CREATE TABLE Teacher (

    TeacherID INT AUTO_INCREMENT PRIMARY KEY,

    TeacherName VARCHAR(100) NOT NULL,

    Email VARCHAR(100) UNIQUE,

    Phone VARCHAR(20),

    DepartmentID INT,

    Salary DECIMAL(10,2),

    HireDate DATE,

    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)

);

CREATE TABLE Student (

    StudentID INT AUTO_INCREMENT PRIMARY KEY,

    StudentName VARCHAR(100) NOT NULL,

    Gender ENUM('Male','Female'),

    DateOfBirth DATE,

    Email VARCHAR(100) UNIQUE,

    Phone VARCHAR(20),

    Address VARCHAR(200),

    DepartmentID INT,

    AdmissionYear INT,

    CGPA DECIMAL(3,2),

    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID)

);

CREATE TABLE Course (

    CourseID INT AUTO_INCREMENT PRIMARY KEY,

    CourseCode VARCHAR(20) UNIQUE,

    CourseName VARCHAR(100),

    Credit INT,

    DepartmentID INT,

    TeacherID INT,

    FOREIGN KEY (DepartmentID)
    REFERENCES Department(DepartmentID),

    FOREIGN KEY (TeacherID)
    REFERENCES Teacher(TeacherID)

);

CREATE TABLE Semester (

    SemesterID INT AUTO_INCREMENT PRIMARY KEY,

    SemesterName VARCHAR(30),

    Year INT

);

CREATE TABLE Enrollment (

    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,

    StudentID INT,

    CourseID INT,

    SemesterID INT,

    EnrollmentDate DATE,

    FOREIGN KEY (StudentID)
    REFERENCES Student(StudentID),

    FOREIGN KEY (CourseID)
    REFERENCES Course(CourseID),

    FOREIGN KEY (SemesterID)
    REFERENCES Semester(SemesterID)

);

CREATE TABLE Result (

    ResultID INT AUTO_INCREMENT PRIMARY KEY,

    EnrollmentID INT,

    Marks DECIMAL(5,2),

    Grade VARCHAR(5),

    GPA DECIMAL(3,2),

    FOREIGN KEY (EnrollmentID)
    REFERENCES Enrollment(EnrollmentID)

);

CREATE TABLE Fee (

    FeeID INT AUTO_INCREMENT PRIMARY KEY,

    StudentID INT,

    SemesterID INT,

    TotalFee DECIMAL(10,2),

    PaidAmount DECIMAL(10,2),

    DueAmount DECIMAL(10,2),

    PaymentDate DATE,

    FOREIGN KEY (StudentID)
    REFERENCES Student(StudentID),

    FOREIGN KEY (SemesterID)
    REFERENCES Semester(SemesterID)

);

SHOW TABLES;


INSERT INTO Department (DepartmentName, Building, TotalStudents)
VALUES
('Computer Science & Engineering','Academic Building A',120),
('Electrical & Electronic Engineering','Academic Building B',90),
('Business Administration','Academic Building C',80),
('Civil Engineering','Academic Building D',70),
('English','Academic Building E',60);

INSERT INTO Teacher
(TeacherName, Email, Phone, DepartmentID, Salary, HireDate)

VALUES

('Dr. Hasan','hasan@college.edu','01711111111',1,80000,'2020-01-15'),

('Dr. Ahmed','ahmed@college.edu','01722222222',2,75000,'2019-03-20'),

('Dr. Rahman','rahman@college.edu','01733333333',3,70000,'2021-07-01'),

('Dr. Karim','karim@college.edu','01744444444',4,72000,'2018-11-10'),

('Dr. Sultana','sultana@college.edu','01755555555',5,68000,'2022-02-18');


INSERT INTO Student

(StudentName,Gender,DateOfBirth,Email,Phone,Address,DepartmentID,AdmissionYear,CGPA)

VALUES

('Anik','Male','2004-05-10','anik@gmail.com','01811111111','Mirpur, Dhaka',1,2024,3.85),

('Rahim','Male','2003-08-20','rahim@gmail.com','01822222222','Uttara, Dhaka',2,2023,3.60),

('Nusrat','Female','2004-03-18','nusrat@gmail.com','01833333333','Mirpur, Dhaka',1,2024,3.95),

('Mim','Female','2003-09-11','mim@gmail.com','01844444444','Dhanmondi, Dhaka',3,2023,3.72),

('Sakib','Male','2002-12-25','sakib@gmail.com','01855555555','Gazipur',4,2022,3.40),

('Fatema','Female','2004-01-30','fatema@gmail.com','01866666666','Tangail',5,2024,3.88),

('Rakib','Male','2003-07-14','rakib@gmail.com','01877777777','Mirpur, Dhaka',1,2023,3.55),

('Tanvir','Male','2004-11-06','tanvir@gmail.com','01888888888','Savar',2,2024,3.65),

('Jannat','Female','2003-02-28','jannat@gmail.com','01899999999','Uttara',3,2023,3.80),

('Fahim','Male','2004-10-15','fahim@gmail.com','01911111111','Mirpur',1,2024,3.92);


INSERT INTO Semester

(SemesterName,Year)

VALUES

('Spring',2025),

('Summer',2025),

('Fall',2025);


INSERT INTO Course

(CourseCode,CourseName,Credit,DepartmentID,TeacherID)

VALUES

('CSE101','Programming Fundamentals',3,1,1),

('CSE201','Database Management System',3,1,1),

('EEE101','Basic Electronics',3,2,2),

('BBA101','Principles of Management',3,3,3),

('CE101','Engineering Mechanics',3,4,4),

('ENG101','English Composition',3,5,5);



-- 1. Display all students
SELECT * FROM Student;

-- 2. Display all teachers
SELECT * FROM Teacher;

-- 3. Display all courses
SELECT * FROM Course;

-- 5. Find students with CGPA greater than 3.80
SELECT *
FROM Student
WHERE CGPA > 3.80;

-- 4. Show student names and their CGPA
SELECT StudentName, CGPA
FROM Student;

-- 6. Find all students from the CSE department
SELECT *
FROM Student
WHERE DepartmentID = 1;

SELECT * 
FROM Student
WHERE DepartmentID = 2;

-- 7. Display all female students
SELECT *
FROM Student
WHERE Gender = 'Female';
 
 -- 8. Display students admitted in 2024
SELECT *
FROM Student
WHERE AdmissionYear = 2024;


-- 9. Find students who live in Mirpur
SELECT *
FROM Student
WHERE Address LIKE '%Mirpur%';

-- 10. Display students with CGPA between 3.50 and 3.90
SELECT *
FROM Student
WHERE CGPA BETWEEN 3.50 AND 3.90;

-- 15. Count total number of students
SELECT COUNT(*) AS TotalStudents
FROM Student;

-- 16. Calculate average CGPA
SELECT AVG(CGPA) AS AverageCGPA
FROM Student;

-- 17. Find the highest CGPA
SELECT MAX(CGPA) AS HighestCGPA
FROM Student;


-- Count the number of students in each department

SELECT
    DepartmentID,
    COUNT(*) AS TotalStudents
FROM Student
GROUP BY DepartmentID;

-- Calculate average CGPA for each department

SELECT
    DepartmentID,
    AVG(CGPA) AS AverageCGPA
FROM Student
GROUP BY DepartmentID;

-- Find the highest CGPA in every department

SELECT
    DepartmentID,
    MAX(CGPA) AS HighestCGPA
FROM Student
GROUP BY DepartmentID;

-- Find the lowest CGPA in every department

SELECT
    DepartmentID,
    MIN(CGPA) AS LowestCGPA
FROM Student
GROUP BY DepartmentID;

-- Calculate total teacher salary for each department

SELECT
    DepartmentID,
    SUM(Salary) AS TotalSalary
FROM Teacher
GROUP BY DepartmentID;

-- Calculate average salary for each department

SELECT
    DepartmentID,
    AVG(Salary) AS AverageSalary
FROM Teacher
GROUP BY DepartmentID;

-- Show departments having more than 2 students

SELECT
    DepartmentID,
    COUNT(*) AS TotalStudents
FROM Student
GROUP BY DepartmentID
HAVING COUNT(*) > 2;

-- Show departments whose average CGPA is greater than 3.70

SELECT
    DepartmentID,
    AVG(CGPA) AS AverageCGPA
FROM Student
GROUP BY DepartmentID
HAVING AVG(CGPA) > 3.70;

-- Show departments where total teacher salary exceeds 70000

SELECT
    DepartmentID,
    SUM(Salary) AS TotalSalary
FROM Teacher
GROUP BY DepartmentID
HAVING SUM(Salary) > 70000;

-- Count students admitted each year

SELECT
    AdmissionYear,
    COUNT(*) AS TotalStudents
FROM Student
GROUP BY AdmissionYear;


-- ==========================================
-- PART 5 : SQL JOIN QUERIES
-- ==========================================

-- 36. Display student name with department name
SELECT
    s.StudentID,
    s.StudentName,
    d.DepartmentName
FROM Student s
INNER JOIN Department d
ON s.DepartmentID = d.DepartmentID;

---------------------------------------------------

-- 37. Display teacher name with department name
SELECT
    t.TeacherName,
    d.DepartmentName,
    t.Salary
FROM Teacher t
INNER JOIN Department d
ON t.DepartmentID = d.DepartmentID;

---------------------------------------------------

-- 38. Display course with teacher name
SELECT
    c.CourseCode,
    c.CourseName,
    t.TeacherName
FROM Course c
INNER JOIN Teacher t
ON c.TeacherID = t.TeacherID;

---------------------------------------------------

-- 39. Display course with department name
SELECT
    c.CourseName,
    d.DepartmentName
FROM Course c
INNER JOIN Department d
ON c.DepartmentID = d.DepartmentID;

---------------------------------------------------

-- 40. Display student enrollment details
SELECT
    s.StudentName,
    c.CourseName,
    sem.SemesterName
FROM Enrollment e
INNER JOIN Student s
ON e.StudentID = s.StudentID
INNER JOIN Course c
ON e.CourseID = c.CourseID
INNER JOIN Semester sem
ON e.SemesterID = sem.SemesterID;

---------------------------------------------------

-- 41. Display student result
SELECT
    s.StudentName,
    c.CourseName,
    r.Marks,
    r.Grade,
    r.GPA
FROM Result r
INNER JOIN Enrollment e
ON r.EnrollmentID = e.EnrollmentID
INNER JOIN Student s
ON e.StudentID = s.StudentID
INNER JOIN Course c
ON e.CourseID = c.CourseID;

---------------------------------------------------

-- 42. Display fee information
SELECT
    s.StudentName,
    f.TotalFee,
    f.PaidAmount,
    f.DueAmount
FROM Fee f
INNER JOIN Student s
ON f.StudentID = s.StudentID;

---------------------------------------------------

-- 43. Display teacher with courses
SELECT
    t.TeacherName,
    c.CourseName
FROM Teacher t
INNER JOIN Course c
ON t.TeacherID = c.TeacherID;

---------------------------------------------------

-- 44. Count students in each department using JOIN
SELECT
    d.DepartmentName,
    COUNT(s.StudentID) AS TotalStudents
FROM Department d
LEFT JOIN Student s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

---------------------------------------------------

-- 45. Count courses in each department
SELECT
    d.DepartmentName,
    COUNT(c.CourseID) AS TotalCourses
FROM Department d
LEFT JOIN Course c
ON d.DepartmentID = c.DepartmentID
GROUP BY d.DepartmentName;

---------------------------------------------------

-- 46. Average CGPA by department
SELECT
    d.DepartmentName,
    AVG(s.CGPA) AS AverageCGPA
FROM Department d
INNER JOIN Student s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

---------------------------------------------------

-- 47. Highest CGPA by department
SELECT
    d.DepartmentName,
    MAX(s.CGPA) AS HighestCGPA
FROM Department d
INNER JOIN Student s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName;

---------------------------------------------------

-- 48. Total teacher salary by department
SELECT
    d.DepartmentName,
    SUM(t.Salary) AS TotalSalary
FROM Department d
INNER JOIN Teacher t
ON d.DepartmentID = t.DepartmentID
GROUP BY d.DepartmentName;

---------------------------------------------------

-- 49. Student, Department and Advisor
SELECT
    s.StudentName,
    d.DepartmentName,
    t.TeacherName
FROM Student s
INNER JOIN Department d
ON s.DepartmentID = d.DepartmentID
INNER JOIN Teacher t
ON d.DepartmentID = t.DepartmentID;

---------------------------------------------------

-- 50. Complete College Report
SELECT
    s.StudentName,
    d.DepartmentName,
    c.CourseName,
    sem.SemesterName,
    r.Grade,
    r.GPA
FROM Result r
INNER JOIN Enrollment e
ON r.EnrollmentID = e.EnrollmentID
INNER JOIN Student s
ON e.StudentID = s.StudentID
INNER JOIN Course c
ON e.CourseID = c.CourseID
INNER JOIN Semester sem
ON e.SemesterID = sem.SemesterID
INNER JOIN Department d
ON s.DepartmentID = d.DepartmentID
ORDER BY s.StudentName;


-- ==========================================
-- PART 6 : REAL-WORLD DATA ANALYSIS
-- ==========================================

-- 51. Total number of students
SELECT COUNT(*) AS TotalStudents
FROM Student;

---------------------------------------------------

-- 52. Total number of teachers
SELECT COUNT(*) AS TotalTeachers
FROM Teacher;

---------------------------------------------------

-- 53. Total number of departments
SELECT COUNT(*) AS TotalDepartments
FROM Department;

---------------------------------------------------

-- 54. Total number of courses
SELECT COUNT(*) AS TotalCourses
FROM Course;

---------------------------------------------------

-- 55. Average CGPA of all students
SELECT ROUND(AVG(CGPA),2) AS AverageCGPA
FROM Student;

---------------------------------------------------

-- 56. Highest CGPA
SELECT MAX(CGPA) AS HighestCGPA
FROM Student;

---------------------------------------------------

-- 57. Lowest CGPA
SELECT MIN(CGPA) AS LowestCGPA
FROM Student;

---------------------------------------------------

-- 58. Top 5 students based on CGPA
SELECT
StudentName,
CGPA
FROM Student
ORDER BY CGPA DESC
LIMIT 5;

---------------------------------------------------

-- 59. Bottom 5 students based on CGPA
SELECT
StudentName,
CGPA
FROM Student
ORDER BY CGPA ASC
LIMIT 5;

---------------------------------------------------

-- 60. Students eligible for scholarship (CGPA >=3.80)

SELECT
StudentName,
CGPA
FROM Student
WHERE CGPA>=3.80
ORDER BY CGPA DESC;

---------------------------------------------------

-- 61. Students with due fees

SELECT
s.StudentName,
f.DueAmount
FROM Fee f
JOIN Student s
ON f.StudentID=s.StudentID
WHERE f.DueAmount>0;

---------------------------------------------------

-- 62. Students who paid full fees

SELECT
s.StudentName,
f.TotalFee,
f.PaidAmount
FROM Fee f
JOIN Student s
ON f.StudentID=s.StudentID
WHERE f.DueAmount=0;

---------------------------------------------------

-- 63. Total fee collection

SELECT
SUM(PaidAmount) AS TotalCollection
FROM Fee;

---------------------------------------------------

-- 64. Total due amount

SELECT
SUM(DueAmount) AS TotalDue
FROM Fee;

---------------------------------------------------

-- 65. Average teacher salary

SELECT
ROUND(AVG(Salary),2) AS AverageSalary
FROM Teacher;

---------------------------------------------------

-- 66. Highest paid teacher

SELECT
TeacherName,
Salary
FROM Teacher
ORDER BY Salary DESC
LIMIT 1;

---------------------------------------------------

-- 67. Lowest paid teacher

SELECT
TeacherName,
Salary
FROM Teacher
ORDER BY Salary ASC
LIMIT 1;

---------------------------------------------------

-- 68. Department wise average teacher salary

SELECT
d.DepartmentName,
ROUND(AVG(t.Salary),2) AS AverageSalary
FROM Teacher t
JOIN Department d
ON t.DepartmentID=d.DepartmentID
GROUP BY d.DepartmentName;

---------------------------------------------------

-- 69. Department wise average student CGPA

SELECT
d.DepartmentName,
ROUND(AVG(s.CGPA),2) AS AverageCGPA
FROM Student s
JOIN Department d
ON s.DepartmentID=d.DepartmentID
GROUP BY d.DepartmentName;

---------------------------------------------------

-- 70. Department ranking based on average CGPA

SELECT
d.DepartmentName,
ROUND(AVG(s.CGPA),2) AS AverageCGPA
FROM Student s
JOIN Department d
ON s.DepartmentID=d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageCGPA DESC;

---------------------------------------------------

-- 71. Number of students in each department

SELECT
d.DepartmentName,
COUNT(s.StudentID) AS TotalStudents
FROM Department d
LEFT JOIN Student s
ON d.DepartmentID=s.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalStudents DESC;

---------------------------------------------------

-- 72. Number of courses in each department

SELECT
d.DepartmentName,
COUNT(c.CourseID) AS TotalCourses
FROM Department d
LEFT JOIN Course c
ON d.DepartmentID=c.DepartmentID
GROUP BY d.DepartmentName;

---------------------------------------------------

-- 73. Teacher teaching the highest number of courses

SELECT
t.TeacherName,
COUNT(c.CourseID) AS TotalCourses
FROM Teacher t
JOIN Course c
ON t.TeacherID=c.TeacherID
GROUP BY t.TeacherName
ORDER BY TotalCourses DESC;

---------------------------------------------------

-- 74. Students with GPA greater than department average

SELECT
StudentName,
CGPA
FROM Student
WHERE CGPA>(
SELECT AVG(CGPA)
FROM Student
);

---------------------------------------------------

-- 75. Final College Summary Report

SELECT

s.StudentName,
d.DepartmentName,
s.CGPA,
f.PaidAmount,
f.DueAmount

FROM Student s

JOIN Department d
ON s.DepartmentID=d.DepartmentID

LEFT JOIN Fee f
ON s.StudentID=f.StudentID

ORDER BY s.CGPA DESC;


-- ==========================================
-- PART 7 : ADVANCED SQL (Views & Subqueries)
-- ==========================================

-- 76. Create a view for student details

CREATE VIEW StudentDetails AS
SELECT
    s.StudentID,
    s.StudentName,
    d.DepartmentName,
    s.CGPA
FROM Student s
JOIN Department d
ON s.DepartmentID = d.DepartmentID;

---------------------------------------------------

-- 77. View all student details

SELECT *
FROM StudentDetails;

---------------------------------------------------

-- 78. Create a view for teacher information

CREATE VIEW TeacherDetails AS
SELECT
    t.TeacherName,
    d.DepartmentName,
    t.Salary
FROM Teacher t
JOIN Department d
ON t.DepartmentID=d.DepartmentID;

---------------------------------------------------

-- 79. Display teacher view

SELECT *
FROM TeacherDetails;

---------------------------------------------------

-- 80. Students whose CGPA is above average

SELECT
StudentName,
CGPA
FROM Student
WHERE CGPA >
(
SELECT AVG(CGPA)
FROM Student
);

---------------------------------------------------

-- 81. Teacher earning above average salary

SELECT
TeacherName,
Salary
FROM Teacher
WHERE Salary >
(
SELECT AVG(Salary)
FROM Teacher
);

---------------------------------------------------

-- 82. Student with highest CGPA

SELECT
StudentName,
CGPA
FROM Student
WHERE CGPA=
(
SELECT MAX(CGPA)
FROM Student
);

---------------------------------------------------

-- 83. Student with lowest CGPA

SELECT
StudentName,
CGPA
FROM Student
WHERE CGPA=
(
SELECT MIN(CGPA)
FROM Student
);

---------------------------------------------------

-- 84. Departments having more than one teacher

SELECT
DepartmentID,
COUNT(*) AS TotalTeachers
FROM Teacher
GROUP BY DepartmentID
HAVING COUNT(*)>1;

---------------------------------------------------

-- 85. Students whose CGPA is above department average

SELECT
s.StudentName,
s.CGPA,
d.DepartmentName

FROM Student s

JOIN Department d
ON s.DepartmentID=d.DepartmentID

WHERE s.CGPA>

(
SELECT AVG(CGPA)

FROM Student

WHERE DepartmentID=s.DepartmentID

);

---------------------------------------------------

-- 86. Courses with assigned teacher

SELECT
CourseName

FROM Course

WHERE TeacherID IS NOT NULL;

---------------------------------------------------

-- 87. Students with no fee record

SELECT

StudentName

FROM Student

WHERE StudentID NOT IN

(
SELECT StudentID
FROM Fee
);

---------------------------------------------------

-- 88. Teachers who teach at least one course

SELECT

TeacherName

FROM Teacher

WHERE TeacherID IN

(
SELECT TeacherID
FROM Course
);

---------------------------------------------------

-- 89. Department having highest average CGPA

SELECT

d.DepartmentName,
AVG(s.CGPA) AverageCGPA

FROM Department d

JOIN Student s

ON d.DepartmentID=s.DepartmentID

GROUP BY d.DepartmentName

ORDER BY AverageCGPA DESC

LIMIT 1;

---------------------------------------------------

-- 90. Students ordered by CGPA

SELECT

StudentName,
CGPA

FROM Student

ORDER BY CGPA DESC;


-- ==========================================
-- PART 8 : STORED PROCEDURES & FINAL REPORTS
-- ==========================================

-- 91. Stored Procedure: Display All Students
DELIMITER $$

CREATE PROCEDURE GetAllStudents()
BEGIN
    SELECT * FROM Student;
END $$

DELIMITER ;

-- Execute Procedure
CALL GetAllStudents();

---------------------------------------------------

-- 92. Stored Procedure: Students by Department

DELIMITER $$

CREATE PROCEDURE GetStudentsByDepartment(IN DeptID INT)
BEGIN
    SELECT
        StudentName,
        CGPA
    FROM Student
    WHERE DepartmentID = DeptID;
END $$

DELIMITER ;

-- Execute Procedure
CALL GetStudentsByDepartment(1);

---------------------------------------------------

-- 93. Stored Procedure: Top Students

DELIMITER $$

CREATE PROCEDURE TopStudents()
BEGIN
    SELECT
        StudentName,
        CGPA
    FROM Student
    ORDER BY CGPA DESC
    LIMIT 5;
END $$

DELIMITER ;

CALL TopStudents();

---------------------------------------------------

-- 94. Students with Due Amount

SELECT
    s.StudentName,
    d.DepartmentName,
    f.DueAmount
FROM Student s
JOIN Department d
ON s.DepartmentID = d.DepartmentID
JOIN Fee f
ON s.StudentID = f.StudentID
WHERE f.DueAmount > 0;

---------------------------------------------------

-- 95. Top Paid Teacher

SELECT
    TeacherName,
    Salary
FROM Teacher
ORDER BY Salary DESC
LIMIT 1;

---------------------------------------------------

-- 96. Department Performance Report

SELECT
    d.DepartmentName,
    COUNT(s.StudentID) AS TotalStudents,
    ROUND(AVG(s.CGPA),2) AS AverageCGPA
FROM Department d
LEFT JOIN Student s
ON d.DepartmentID = s.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageCGPA DESC;

---------------------------------------------------

-- 97. Course Enrollment Report

SELECT
    c.CourseName,
    COUNT(e.StudentID) AS TotalEnrollment
FROM Course c
LEFT JOIN Enrollment e
ON c.CourseID = e.CourseID
GROUP BY c.CourseName
ORDER BY TotalEnrollment DESC;

---------------------------------------------------

-- 98. Fee Collection Report

SELECT
    SUM(TotalFee) AS TotalFee,
    SUM(PaidAmount) AS TotalCollected,
    SUM(DueAmount) AS TotalDue
FROM Fee;

---------------------------------------------------

-- 99. Student Academic Report

SELECT
    s.StudentName,
    d.DepartmentName,
    s.CGPA,
    CASE
        WHEN s.CGPA >= 3.80 THEN 'Excellent'
        WHEN s.CGPA >= 3.50 THEN 'Very Good'
        WHEN s.CGPA >= 3.00 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS Performance
FROM Student s
JOIN Department d
ON s.DepartmentID = d.DepartmentID
ORDER BY s.CGPA DESC;

---------------------------------------------------

-- 100. FINAL COLLEGE MANAGEMENT REPORT

SELECT
    s.StudentID,
    s.StudentName,
    d.DepartmentName,
    c.CourseName,
    sem.SemesterName,
    t.TeacherName,
    r.GPA,
    f.PaidAmount,
    f.DueAmount

FROM Student s

LEFT JOIN Department d
ON s.DepartmentID = d.DepartmentID

LEFT JOIN Enrollment e
ON s.StudentID = e.StudentID

LEFT JOIN Course c
ON e.CourseID = c.CourseID

LEFT JOIN Semester sem
ON e.SemesterID = sem.SemesterID

LEFT JOIN Teacher t
ON c.TeacherID = t.TeacherID

LEFT JOIN Result r
ON e.EnrollmentID = r.EnrollmentID

LEFT JOIN Fee f
ON s.StudentID = f.StudentID

ORDER BY s.StudentName;
