Create Table Professor
(
    ssn CHAR(9) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    street VARCHAR(100),
    city VARCHAR(50),
    prof_state CHAR(2),
    zip_code CHAR(5),
    phone_num CHAR(10),
    title VARCHAR(50),
    salary DECIMAL(7, 2),
    -- figure out how to handle multiple degrees
    FOREIGN KEY (dept_num) REFERENCES Departments (dept_num)
);

CREATE TABLE Professor_Degrees 
(
    ssn CHAR(9),
    degree VARCHAR(100),
    PRIMARY KEY (ssn, degree),
    FOREIGN KEY (ssn) REFERENCES Professor(ssn)
);

Create Table Departments
(
    dept_num int PRIMARY KEY,
    phone_num CHAR(10),
    office_location int,
    FOREIGN KEY (cwid) REFERENCES Student_record (cwid),
    FOREIGN KEY (chair_ssn) REFERENCES Professor (ssn)
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
    FOREIGN KEY (major_dept_num) REFERENCES Departments (dept_num)
);

CREATE TABLE Student_Minors
(
    cwid INT,
    dept_num INT,

    PRIMARY KEY (cwid, dept_num),
    FOREIGN KEY (cwid) REFERENCES Student_record(cwid),
    FOREIGN KEY (dept_num) REFERENCES Departments(dept_num)
);

Create Table Course
(
    course_num int Primary Key,
    title VARCHAR(50),
    textbook VARCHAR(100),
    units VARCHAR(10),
    FOREIGN KEY (dept_num) REFERENCES Departments (dept_num)
);

Create Table Sections
(
    section_num int,
    course_num int,
    ssn CHAR(9),
    Primary key (section_num, course_num),
    start_time TIME,
    end_time TIME,
    classroom int,
    meet_days VARCHAR(10),
    seat_num int,
    FOREIGN KEY (course_num) REFERENCES Course (course_num),
    FOREIGN KEY (ssn) REFERENCES Proffesor(ssn)
);

Create Table Enrollment
(
    cwid int,
    course_num int,
    section_num int,
    PRIMARY KEY (cwid, course_num, section_num),
    FOREIGN KEY (cwid) REFERENCES Student_record(cwid),
    FOREIGN KEY (course_num) REFERENCES Course(course_num)
);