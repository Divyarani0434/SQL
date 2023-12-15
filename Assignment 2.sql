create database SISDB;
--Table Creation
Create table Students(
	student_id int Not Null IDENTITY(0,1) ,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(255),
	phone_number numeric(10),
	CONSTRAINT PK_Students  PRIMARY KEY(student_id)
);

Create table Courses(
	course_id int Not Null IDENTITY(0,1) ,
    course_name varchar(255),
    credits varchar(255),
	teacher_id int,
	CONSTRAINT FK_Courses FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id),
	CONSTRAINT PK_Courses  PRIMARY KEY(course_id) 
);

Create table Teacher(
	teacher_id int Not Null IDENTITY(0,1) ,
    first_name varchar(255),
    last_name varchar(255),
	email varchar(255),
	CONSTRAINT PK_Teacher PRIMARY KEY (teacher_id),
);

Create table Enrollments(
	enrollment_id int Not Null IDENTITY(0,1) ,
    enrollment_date date,
	student_id int,
	course_id int,
	CONSTRAINT FK_Enrollments_Students FOREIGN KEY (student_id) REFERENCES Students(student_id),
	CONSTRAINT FK_Enrollments_Courses FOREIGN KEY (course_id) REFERENCES Courses(course_id),
	CONSTRAINT PK_Enrollments  PRIMARY KEY(enrollment_id) 
);
Create table Payments(
	payment_id int Not Null IDENTITY(0,1) ,
    payment_date date,
	student_id int,
	amount numeric,
	CONSTRAINT FK_Payments_Students FOREIGN KEY (student_id) REFERENCES Students(student_id),
	CONSTRAINT PK_Payments  PRIMARY KEY(payment_id) 
);
ALTER TABLE STUDENTS
  add date_of_birth date
  -- 3) a )Insertion of Records

INSERT INTO STUDENTS (first_name,last_name,email,phone_number)
values
('Divya','Rani','divya@gmail.com','515-33'),
('Surya','Teja','surya@gmail.com','654333'),
('Jagruti','T','jag@gmail.com','515-5673'),
('Gandhik','T','gandhik@gmail.com','689-33'),
('Guru','Vamsi','sunny@gmail.com','515746'),
('Sunny','H','sunny@gmail.com','645-3843'),
('Rani','T','rani@gmail.com','55693'),
('jhansi','T','jhansi@gmail.com','782363')

INSERT INTO Teacher(first_name,last_name,email)
values
('Lakshmi','T','lakshmi@gmail.com'),
('Ram','R','ram@gmail.com'),
('Sita','T','sita@gmail.com'),
('Aruna','T','aruna@gmail.com'),
('Krishna','Vamsi','krsihna@gmail.com'),
('Krish','H','krish@gmail.com'),
('Janu','T','janu@gmail.com'),
('madhu','T','madhu@gmail.com')

INSERT INTO Courses (course_name, credits, teacher_id)
VALUES
    ('Introduction to Programming', '3', 1),
    ('Database Management', '4', 2),
    ('Web Development Fundamentals', '3', 3),
    ('Data Structures and Algorithms', '4', 4),
    ('Software Engineering Principles', '3', 1),
    ('Network Security', '4', 2),
    ('Machine Learning Basics', '3', 3),
    ('Mobile App Development', '4', 4),
    ('Computer Graphics', '3', 1),
    ('Artificial Intelligence Applications', '4', 2);
select * from Students
INSERT INTO Enrollments (enrollment_date, student_id, course_id)
VALUES
    ('2023-01-01', 4, 1),
    ('2023-01-02', 5, 3),
    ('2023-01-03', 3, 2),
    ('2023-01-04', 4, 4),
    ('2023-01-05', 5, 1),
    ('2023-01-06', 3, 3),
    ('2023-01-07', 6, 2),
    ('2023-01-08', 3, 4),
    ('2023-01-09', 4, 1),
    ('2023-01-10', 5, 3);

INSERT INTO Payments (payment_date, student_id, amount)
VALUES
    ('2023-01-01', 5, 500.00),
    ('2023-01-02', 6, 600.00),
    ('2023-01-03', 3, 750.00),
    ('2023-01-04', 4, 400.00),
    ('2023-01-05', 5, 550.00),
    ('2023-01-06', 6, 700.00),
    ('2023-01-07', 3, 450.00),
    ('2023-01-08', 3, 800.00),
    ('2023-01-09', 4, 350.00),
    ('2023-01-10', 5, 900.00);
--3) b) 1) SQL query to insert a new student into the "Students" 
Insert into STUDENTS (first_name,last_name,email,phone_number,date_of_birth)
values
('John','Doe','john.doe@gmail.com','1234567890','1995-08-15')
--2)SQL query to enroll a student in a course. Choose an existing student and course and 
--insert a record into the "Enrollments" table with the enrollment date
Insert into Enrollments values (GETDATE(),3,4)
select * from Enrollments
--3)Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.
Update Teacher Set Email='divya_new@Gmail.com' where teacher_id=2;
--4)SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on student and course
Delete From Enrollments Where student_id = 1 AND course_id = 2;
--5)Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables
Update Courses set teacher_id=3 where course_id =2;
--6). Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity
Delete From Enrollments Where student_id = 1; 
Delete From Students Where student_id = 1; 
--7)Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.
Update Payments set amount ='400' where payment_date=4



---4) joins
--1)SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID
Declare @student_id int
set @student_id=3
SELECT Students.student_id, Students.first_name, SUM(Payments.Amount) AS TotalPayments FROM Students
JOIN Payments ON Students.student_id = Payments.student_id
WHERE Students.student_id = '3'
GROUP BY Students.student_id, Students.student_id;

--2)SQL query to retrieve a list of courses along with the count of students enrolled in each course.
--Use a JOIN operation between the "Courses" table and the "Enrollments" table.
SELECT c.course_id, course_name, COUNT(e.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, course_name;

---3)n SQL query to find the names of students who have not enrolled in any course. Use a 
--LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments
SELECT s.student_id, first_name, last_name FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;


---4)Retrieve first name, last name of students, and names of courses they are enrolled in
SELECT Students.first_name,Students.last_name, Courses.course_name
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id;

---5)query to list the names of teachers and the courses they are assigned to. Join the 
--"Teacher" table with the "Courses" table.
SELECT Teacher.first_name,Courses.course_name
FROM Teacher
JOIN Courses ON Teacher.teacher_id = Courses.teacher_id;

---6)Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the 
--"Students" table with the "Enrollments" and "Courses" tables.
SELECT Students.first_name,Students.last_name,Enrollments.enrollment_date
FROM Students
JOIN Enrollments ON Students.student_id = Enrollments.student_id
JOIN Courses ON Enrollments.course_id = Courses.course_id
WHERE Courses.course_name = 'YourSpecificCourseName';

---7)Find the names of students who have not made any payments. Use a LEFT JOIN between the 
--"Students" table and the "Payments" table and filter for students with NULL payment records
SELECT Students.first_name,Students.last_name
FROM Students
LEFT JOIN Payments ON Students.student_id = Payments.student_id
WHERE Payments.payment_id IS NULL;

---8)query to identify courses that have no enrollments. You'll need to use a LEFT JOIN 
--between the "Courses" table and the "Enrollments" table and filter for courses with NULL 
--enrollment records.
SELECT Courses.course_name
FROM Courses
LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id
WHERE Enrollments.course_id IS NULL;


---9)Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" 
--table to find students with multiple enrollment records
SELECT DISTINCT s1.first_name, s1.last_name
FROM Students s1
JOIN Enrollments e1 ON s1.student_id = e1.student_id
JOIN Enrollments e2 ON s1.student_id = e2.student_id AND e1.course_id <> e2.course_id;


---10)Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" 
--table and the "Courses" table and filter for teachers with NULL course assignments.
SELECT Teacher.first_name
FROM Teacher
LEFT JOIN Courses ON Teacher.teacher_id = Courses.teacher_id
WHERE Courses.course_id IS NULL;


---5)Aggregate and SubQueries

--1)SQL query to calculate the average number of students enrolled in each course. Use 
--aggregate functions and subqueries to achieve this.
SELECT Courses.course_name,AVG(student_count) AS avg_students
FROM Courses
LEFT JOIN (SELECT course_id,COUNT(DISTINCT student_id) AS student_count FROM Enrollments GROUP BY course_id)
AS CourseCounts ON Courses.course_id = CourseCounts.course_id
GROUP BY Courses.course_id, Courses.course_name;


---2)student(s) who made the highest payment. Use a subquery to find the maximum 
--payment amount and then retrieve the student(s) associated with that amount.
SELECT Students.first_name,Students.last_name
FROM Students
JOIN Payments ON Students.student_id = Payments.student_id
WHERE Payments.amount = (SELECT MAX(amount) FROM Payments);

---3)a list of courses with the highest number of enrollments. Use subqueries to find the 
--course(s) with the maximum enrollment count
SELECT Courses.course_name
FROM Courses
WHERE Courses.course_id IN (SELECT TOP 1 WITH TIES course_id FROM Enrollments GROUP BY course_id ORDER BY COUNT(student_id) DESC);

---4)total payments made to courses taught by each teacher. Use subqueries to sum 
--payments for each teacher's courses
SELECT Teacher.teacher_id,Teacher.first_name,AVG(Payments.amount) AS avg_payment
FROM Teacher
LEFT JOIN Courses ON Teacher.teacher_id = Courses.teacher_id
LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id
LEFT JOIN Payments ON Enrollments.student_id = Payments.student_id
GROUP BY Teacher.teacher_id, Teacher.first_name;


---5)students who are enrolled in all available courses. Use subqueries to compare a 
--student's enrollments with the total number of course
SELECT Students.first_name,Students.last_name
FROM Students
WHERE
(SELECT COUNT(DISTINCT course_id) FROM Courses) = (SELECT COUNT(DISTINCT course_id) FROM Enrollments WHERE Students.student_id = Enrollments.student_id);

---6)names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments
SELECT Teacher.first_name
FROM Teacher
WHERE Teacher.teacher_id NOT IN (SELECT DISTINCT teacher_id FROM Courses);

---7)the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.
SELECT AVG(DATEDIFF(YEAR, Students.date_of_birth, GETDATE())) AS average_age
FROM Students;

---8)Identify courses with no enrollments. Use subqueries to find courses without enrollment records
SELECT Courses.course_name
FROM Courses
left JOIN Enrollments ON Courses.course_id = Enrollments.course_id
WHERE Enrollments.course_id IS NULL;


---9)e total payments made by each student for each course they are enrolled in. Use 
--subqueries and aggregate functions to sum payments.
SELECT Courses.course_name
FROM Courses
LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id
WHERE Enrollments.course_id IS NULL;

---10)Identify students who have made more than one payment. Use subqueries and aggregate 
--functions to count payments per student and filter for those with counts greater than one.
SELECT Students.student_id,Students.first_name,Students.last_name
FROM Students
JOIN(SELECT student_id,COUNT(payment_id) AS payment_count FROM Payments GROUP BY student_id
HAVING COUNT(payment_id) > 1)
AS PaymentCounts ON Students.student_id = PaymentCounts.student_id;

---11) Calculate the total payments made by each student:
SELECT Students.student_id, Students.first_name, Students.last_name, COALESCE(SUM(Payments.amount), 0) AS TotalPayments
FROM Students
LEFT JOIN Payments ON Students.student_id = Payments.student_id
GROUP BY Students.student_id, Students.first_name, Students.last_name;

---12)Retrieve a list of course names along with the count of students enrolled in each course:
SELECT Courses.course_id, Courses.course_name, COUNT(Enrollments.student_id) AS EnrolledStudents
FROM Courses
LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id
GROUP BY Courses.course_id, Courses.course_name;

---13) Calculate the average payment amount made by students:
SELECT Students.student_id, Students.first_name, Students.last_name, COALESCE(AVG(Payments.amount), 0) AS AveragePayment
FROM Students
LEFT JOIN Payments ON Students.student_id = Payments.student_id
GROUP BY Students.student_id, Students.first_name, Students.last_name;
