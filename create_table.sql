Create Table Departments
(
    dept_num int PRIMARY KEY,
    phone_num CHAR(15),
    office_location int,
    chair_ssn CHAR(11)
);



Create Table Professor
(
    ssn CHAR(11) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    sex VARCHAR(1),
    street VARCHAR(100),
    city VARCHAR(50),
    prof_state CHAR(2),
    zip_code CHAR(5),
    phone_num CHAR(10),
    title VARCHAR(50),
    salary DECIMAL(7, 2),
    dept_num int,
    FOREIGN KEY (dept_num) REFERENCES Departments (dept_num)
);

ALTER TABLE Departments
ADD FOREIGN KEY (chair_ssn) REFERENCES Professor(ssn);

CREATE TABLE Professor_degrees
(
    ssn CHAR(11),
    degree VARCHAR(100),
    PRIMARY KEY (ssn, degree),
    FOREIGN KEY (ssn) REFERENCES Professor (ssn)
);



Create Table Student_record
(
    cwid int PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    street VARCHAR(100),
    city VARCHAR(50),
    student_state CHAR(2),
    zip_code CHAR(5),
    phone_num CHAR(10),
    major_dept_num INT,
    FOREIGN KEY (major_dept_num) REFERENCES Departments (dept_num)
);

CREATE TABLE Student_minors
(
    cwid INT,
    dept_num INT,
    PRIMARY KEY (cwid, dept_num),
    FOREIGN KEY (cwid) REFERENCES Student_record (cwid),
    FOREIGN KEY (dept_num) REFERENCES Departments (dept_num)
);

Create Table Course
(
    course_num INT Primary Key,
    title VARCHAR(50),
    textbook VARCHAR(100),
    units INT,
    dept_num INT,
    FOREIGN KEY (dept_num) REFERENCES Departments (dept_num)
);

CREATE TABLE Course_prereq
(
    course_num INT,
    prereq_course_num INT,
    PRIMARY KEY (course_num, prereq_course_num),
    FOREIGN KEY (course_num) REFERENCES Course (course_num),
    FOREIGN KEY (prereq_course_num) REFERENCES Course (course_num)
);

Create Table Sections
(
    section_num INT,
    course_num INT,
    ssn CHAR(9),
    start_time TIME,
    end_time TIME,
    classroom INT,
    meet_days VARCHAR(10),
    seat_num INT,
    Primary key (section_num, course_num),
    FOREIGN KEY (course_num) REFERENCES Course (course_num),
    FOREIGN KEY (ssn) REFERENCES Professor (ssn)
);

Create Table Enrollment_records
(
    cwid INT,
    course_num INT,
    section_num INT,
    grade VARCHAR(3),
    PRIMARY KEY (cwid, course_num, section_num),
    FOREIGN KEY (cwid) REFERENCES Student_record (cwid),
    FOREIGN KEY (section_num, course_num) REFERENCES Sections(section_num, course_num)
);