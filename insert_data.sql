
INSERT INTO `course` (`course_num`, `title`, `textbook`, `units`, `dept_num`) VALUES
(101, 'Introduction to Programming', 'Python Basics', 3, 10),
(201, 'Data Structures', 'Data Structures in C++', 4, 10),
(301, 'Database Systems', 'Database Design Concepts', 3, 10),
(501, 'Calculus I', 'Calculus Early Transcendentals', 4, 20);



INSERT INTO `course_prereq` (`course_num`, `prereq_course_num`) VALUES
(201, 101),
(301, 201);


INSERT INTO `departments` (`dept_num`, `phone_num`, `office_location`, `chair_ssn`) VALUES
(10, '217-555-20', 301, '111-22-33'),
(20, '217-555-20', 210, '222-33-44');


INSERT INTO `enrollment records` (`EnrollmentID`, `StudentID`, `CourseNumber`, `SectionNumber`, `Grade`) VALUES
(1, 1001, 101, 1, 'A'),
(2, 1001, 501, 1, 'B+'),
(3, 1002, 101, 2, 'A-'),
(4, 1002, 501, 2, 'B'),
(5, 1003, 501, 1, 'A'),
(6, 1003, 101, 1, 'B+'),
(7, 1004, 101, 2, 'B'),
(8, 1004, 201, 1, 'A-'),
(9, 1005, 501, 2, 'A-'),
(10, 1005, 101, 1, 'B'),
(11, 1006, 101, 1, 'C+'),
(12, 1006, 201, 1, 'B+'),
(13, 1006, 501, 1, 'B'),
(14, 1007, 501, 2, 'A'),
(15, 1007, 101, 2, 'A-'),
(16, 1008, 101, 1, 'B+'),
(17, 1008, 201, 1, 'B'),
(18, 1008, 301, 1, 'A-'),
(19, 1004, 301, 1, 'B+'),
(20, 1002, 201, 1, 'A');


INSERT INTO `minors` (`MinorDepartmentNum`, `StudentID`) VALUES
(20, 1001),
(20, 1002),
(20, 1004),
(20, 1006),
(10, 1007);


INSERT INTO `professor` (`ssn`, `first_name`, `last_name`, `street`, `city`, `prof_state`, `zip_code`, `phone_num`, `title`, `salary`, `dept_num`) VALUES
('111-22-33', 'John', 'Carter', '12 Oak St', 'Springfield', 'IL', '62701', '217 555100', 'Professor', 95000.00, 10),
('222-33-44', 'Susan', 'Lee', '45 Maple Ave', 'Springfield', 'IL', '62702', '2175551002', 'Associate Professor', 87000.00, 20),
('333-44-55', 'Robert', 'Nguyen', '78 Pine Rd', 'Springfield', 'IL', '62703', '2175551003', 'Assistant Professor', 76000.00, 20);


INSERT INTO `professor_degrees` (`ssn`, `degree`) VALUES
('111-22-33', 'PhD Computer Science'),
('222-33-44', 'PhD Mathematics');

INSERT INTO `sections` (`section_num`, `course_num`, `ssn`, `start_time`, `end_time`, `classroom`, `meet_days`, `seat_num`) VALUES
(1, 101, '111-22-33', '09:00:00', '09:50:00', 101, 'MWF', 30),
(1, 201, '111-22-33', '10:00:00', '10:50:00', 201, 'MWF', 25),
(1, 301, '333-44-55', '13:00:00', '14:15:00', 305, 'TR', 20),
(1, 501, '222-33-44', '08:00:00', '08:50:00', 110, 'MWF', 35),
(2, 101, '333-44-55', '11:00:00', '12:15:00', 102, 'TR', 30),
(2, 501, '222-33-44', '09:30:00', '10:45:00', 111, 'TR', 35);


INSERT INTO `student_record` (`cwid`, `first_name`, `last_name`, `street`, `city`, `student_state`, `zip_code`, `phone_num`, `major_dept_num`) VALUES
(1001, 'Emma', 'Johnson', '101 Birch St', 'Springfield', 'IL', '62704', '2175553001', 10),
(1002, 'Liam', 'Smith', '102 Birch St', 'Springfield', 'IL', '62704', '2175553002', 10),
(1003, 'Olivia', 'Brown', '103 Birch St', 'Springfield', 'IL', '62704', '2175553003', 20),
(1004, 'Noah', 'Davis', '104 Birch St', 'Springfield', 'IL', '62704', '2175553004', 10),
(1005, 'Ava', 'Miller', '105 Birch St', 'Springfield', 'IL', '62704', '2175553005', 20),
(1006, 'William', 'Wilson', '106 Birch St', 'Springfield', 'IL', '62704', '2175553006', 10),
(1007, 'Sophia', 'Moore', '107 Birch St', 'Springfield', 'IL', '62704', '2175553007', 20),
(1008, 'James', 'Taylor', '108 Birch St', 'Springfield', 'IL', '62704', '2175553008', 10);
