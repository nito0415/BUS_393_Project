-- Assuming the database 'project_db_mentors' has already been created and selected
-- DROP TABLE statements in reverse order due to foreign key constraints
DROP TABLE IF EXISTS mentees_sessions;
DROP TABLE IF EXISTS mentors_sessions;
DROP TABLE IF EXISTS onboarding_appt_mentees;
DROP TABLE IF EXISTS onboarding_appt_mentors;
DROP TABLE IF EXISTS mentoring_session;
DROP TABLE IF EXISTS onboarding_appt;
DROP TABLE IF EXISTS mentees;
DROP TABLE IF EXISTS mentors;
DROP TABLE IF EXISTS career_peer_staff;
DROP TABLE IF EXISTS company;

-- Create the 'company' table as per ERD
CREATE TABLE company (
    Company_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Phone VARCHAR(20) -- Not specified as NOT NULL in ERD
);

-- Create the 'alumni_mentors' table as per ERD
CREATE TABLE alumni_mentors (
    Mentor_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Alumni_Type ENUM('Alumni', 'Other'), -- Assuming Alumni Type is an ENUM type
    Years_of_Exp INT,
    Industry_Sector VARCHAR(100),
    Job_Title VARCHAR(100),
    Major VARCHAR(100),
    Concentration VARCHAR(100),
    Email VARCHAR(100) NOT NULL,
    Mentee_Capacity INT,
    Company_ID INT,
    FOREIGN KEY (Company_ID) REFERENCES company(Company_ID)
);

-- Create the 'student_mentor' table as per ERD
CREATE TABLE student_mentor (
    Student_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Major VARCHAR(100) NOT NULL,
    Concentration VARCHAR(100),
    Year INT,
    Industry_Sector_Interest VARCHAR(100),
    Assigned BOOLEAN -- Assuming Assigned is a BOOLEAN type
);

-- Create the 'career_peer_staff' table as per ERD
CREATE TABLE career_peer_staff (
    Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Role ENUM('Career Peer', 'Lead Career Peer', 'Manager'), -- Assuming Role is an ENUM type
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20)
);

-- Create the 'training_appointment' table as per ERD
CREATE TABLE training_appointment (
    Appointment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    Duration INT,
    Appointment_Location VARCHAR(100),
    Modality ENUM('In-Person', 'Virtual'), -- Assuming Modality is an ENUM type
    Reason TEXT,
    Type ENUM('Onboarding', 'Training') -- Assuming Type is an ENUM type
);

-- Create the 'mentoring_sessions' table as per ERD
CREATE TABLE mentoring_sessions (
    Session_ID INT PRIMARY KEY AUTO_INCREMENT,
    Start_Date DATE NOT NULL,
    Time TIME NOT NULL,
    Location_Mode ENUM('Phone', 'Video Call', 'In Person'), -- Assuming Location/Mode is an ENUM type
    Topics_Discussed TEXT
);

-- Create the 'mentors_sessions' junction table as per ERD
CREATE TABLE mentors_sessions (
    Session_ID INT,
    Mentor_ID INT,
    PRIMARY KEY (Session_ID, Mentor_ID),
    FOREIGN KEY (Session_ID) REFERENCES mentoring_sessions(Session_ID),
    FOREIGN KEY (Mentor_ID) REFERENCES alumni_mentors(Mentor_ID)
);

-- Create the 'mentees_sessions' junction table as per ERD
CREATE TABLE mentees_sessions (
    Session_ID INT,
    Student_ID INT,
    PRIMARY KEY (Session_ID, Student_ID),
    FOREIGN KEY (Session_ID) REFERENCES mentoring_sessions(Session_ID),
    FOREIGN KEY (Student_ID) REFERENCES student_mentor(Student_ID)
);

-- Create the 'onboarding_appt_mentors' junction table as per ERD
CREATE TABLE onboarding_appt_mentors (
    Appointment_ID INT,
    Mentor_ID INT,
    PRIMARY KEY (Appointment_ID, Mentor_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES training_appointment(Appointment_ID),
    FOREIGN KEY (Mentor_ID) REFERENCES alumni_mentors(Mentor_ID)
);

-- Create the 'onboarding_appt_mentees' junction table as per ERD
CREATE TABLE onboarding_appt_mentees (
    Appointment_ID INT,
    Student_ID INT,
    PRIMARY KEY (Appointment_ID, Student_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES training_appointment(Appointment_ID),
    FOREIGN KEY (Student_ID) REFERENCES student_mentor(Student_ID)
);


-- Insert data into 'company' table
INSERT INTO company (Name, Location, Phone)
VALUES
('Google', 'Mountain View, CA', '650-253-0000'),
('Facebook', 'Menlo Park, CA', '650-543-4800'),
('Amazon', 'Seattle, WA', '206-266-1000'),
('Microsoft', 'Redmond, WA', '425-882-8080'),
('Apple', 'Cupertino, CA', '408-996-1010'),
('Tesla', 'Palo Alto, CA', '888-518-3752'),
('Walmart', 'Bentonville, AR', '800-925-6278'),
('Target', 'Minneapolis, MN', '800-440-0680'),
('Costco', 'Issaquah, WA', '800-774-2678'),
('Starbucks', 'Seattle, WA', '800-782-7282');

-- Insert data into 'alumni_mentors' table
INSERT INTO alumni_mentors (First_Name, Last_Name, Alumni_Type, Years_of_Exp, Industry_Sector, Job_Title, Major, Concentration, Email, Mentee_Capacity, Company_ID)
VALUES
('Emma', 'Johnson', 'Alumni', 10, 'Finance', 'Senior Accountant', 'Business Administration', 'Accounting', 'ejohnson@example.com', NULL, NULL),
('Santiago', 'Garcia', 'Alumni', 8, 'Banking', 'Financial Analyst', 'Economics', 'Quantitative Analysis', 'sgarcia@example.com', NULL, 1),
-- ... Add other mentors following the pattern ...

-- Insert data into 'student_mentor' table
INSERT INTO student_mentor (First_Name, Last_Name, Email, Major, Concentration, Year, Industry_Sector_Interest, Assigned)
VALUES
('Michael', 'Taylor', 'mtaylor@example.com', 'Business Administration', 'Accounting', 2024, 'Accounting', NULL),
('Ana', 'Rivera', 'arivera@example.com', 'Economics', 'Quantitative Analysis', 2025, 'Economic Research', NULL),
-- ... Add other mentees following the pattern ...

-- Insert data into 'career_peer_staff' table
INSERT INTO career_peer_staff (Role, First_Name, Last_Name, Email, Phone)
VALUES
('Career Peer', 'Aubrey', 'Graham', 'drake@example.com', '123-456-7890'),
('Career Peer', 'Rihanna', 'Fenty', 'riri@example.com', '123-456-7890'),
-- ... Add other career peer staff following the pattern ...

-- Insert data into 'mentoring_sessions' table
INSERT INTO mentoring_sessions (Start_Date, Time, Location_Mode, Topics_Discussed)
VALUES
('2024-03-13', '12:00:00', 'Virtual', 'Software Engineering'),
('2024-03-14', '11:00:00', 'In-Person', 'Product Management'),
-- ... Add other mentoring sessions following the pattern ...

-- Insert data into 'mentors_sessions' junction table
INSERT INTO mentors_sessions (Mentor_ID, Session_ID)
VALUES
(1, 1),
(2, 2),
-- ... Add other mentor-session associations following the pattern ...

-- Insert data into 'mentees_sessions' junction table
INSERT INTO mentees_sessions (Student_ID, Session_ID)
VALUES
(1, 1),
(2, 2),
-- ... Add other mentee-session associations following the pattern ...

-- Insert data into 'training_appointment' table
INSERT INTO training_appointment (Date, Time, Duration, Appointment_Location, Modality, Reason, Type)
VALUES
('2024-03-10', '11:00:00', 15, 'Zoom', 'Virtual', 'Training', 'Onboarding'),
-- ... Add other training appointments following the pattern ...

-- Insert data into 'onboarding_appt_mentors' junction table
INSERT INTO onboarding_appt_mentors (Appointment_ID, Mentor_ID)
VALUES
(1, 1),
(2, 2),
-- ... Add other onboarding appointment-mentor associations following the pattern ...

-- Insert data into 'onboarding_appt_mentees' junction table
INSERT INTO onboarding_appt_mentees (Appointment_ID, Student_ID)
VALUES
(1, 1),
(2, 2),
-- ... Add other onboarding appointment-mentee associations following the pattern ...
