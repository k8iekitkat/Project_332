Create Table Departments
(
    dept_num int PRIMARY KEY,
    phone_num CHAR(10),
    office_location int,
    chair_ssn CHAR(9),
);



Create Table Professor
(
    ssn CHAR(9) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    sex VARCHAR(50),
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
    ssn CHAR(9),
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
    course_num int Primary Key,
    title VARCHAR(50),
    textbook VARCHAR(100),
    units VARCHAR(10),
    dept_num INT,
    FOREIGN KEY (dept_num) REFERENCES Departments (dept_num)
);

CREATE TABLE Course_prereq
(
    course_num int,
    prereq_course_num int,
    PRIMARY KEY (course_num, prereq_course_num),
    FOREIGN KEY (course_num) REFERENCES Course (course_num),
    FOREIGN KEY (prereq_course_num) REFERENCES Course (course_num)
);

Create Table Sections
(
    section_num int,
    course_num int,
    ssn CHAR(9),
    start_time TIME,
    end_time TIME,
    classroom int,
    meet_days VARCHAR(10),
    seat_num int,
    Primary key (section_num, course_num),
    FOREIGN KEY (course_num) REFERENCES Course (course_num),
    FOREIGN KEY (ssn) REFERENCES Professor (ssn)
);

Create Table Enrollment_records
(
    cwid int,
    course_num int,
    section_num int,
    grade VARCHAR(3),
    PRIMARY KEY (cwid, course_num, section_num),
    FOREIGN KEY (cwid) REFERENCES Student_record (cwid),
    FOREIGN KEY (section_num, course_num) REFERENCES Sections(section_num, course_num)
);