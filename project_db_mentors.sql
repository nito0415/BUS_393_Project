CREATE DATABASE IF NOT EXISTS project_db_mentors;

DROP TABLE IF EXISTS onboarding_appt_mentees;
DROP TABLE IF EXISTS onboarding_appt_mentors;
DROP TABLE IF EXISTS onboarding_appt;
DROP TABLE IF EXISTS career_peer_staff;
DROP TABLE IF EXISTS mentees_sessions;
DROP TABLE IF EXISTS mentors_sessions;
DROP TABLE IF EXISTS mentoring_session;
-- DROP TABLE IF EXISTS participants;
DROP TABLE IF EXISTS mentees;
DROP TABLE IF EXISTS mentors;
DROP TABLE IF EXISTS company;

-- Creation of tables
-- Company
CREATE TABLE company (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name TEXT NOT NULL,
    company_sector TEXT NOT NULL,
    company_size INT NOT NULL,
    company_location TEXT NOT NULL,
    company_website TEXT NOT NULL,
    company_phone VARCHAR(20) NOT NULL
);

-- Mentors
CREATE TABLE mentors (
    mentor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    major TEXT NOT NULL,
    concentration VARCHAR(50),
    grad_year INT NOT NULL,
    years_of_experience INT NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    industry VARCHAR(100),
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES company(company_id)
);

-- Mentees
CREATE TABLE mentees (
    mentee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    major TEXT NOT NULL,
    concentration VARCHAR(50),
    grad_year INT NOT NULL,
    career_interests TEXT NOT NULL,

    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    mentor_id INT,
    FOREIGN KEY (mentor_id) REFERENCES mentors(mentor_id)
);

/*
-- Will take too long to implement and test before presentation
-- Keeping block of code for future development
-- Participants
CREATE TABLE participants (
    participant_id INT PRIMARY KEY AUTO_INCREMENT,
    participant_type TEXT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    major TEXT,
    concentration VARCHAR(50),
    grad_year INT NOT NULL,
    career_interests TEXT,
    job_title VARCHAR(100),
    industry VARCHAR(100),
    years_of_experience INT,
    onboarding_completed BOOLEAN NOT NULL,
    company_id INT,
    assigned_participant_id INT,
    FOREIGN KEY (company_id) REFERENCES company(company_id)
);
*/

-- Mentoring Session
CREATE TABLE mentoring_session (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    session_date DATE NOT NULL,
    session_time TIME NOT NULL,
    session_duration INT NOT NULL,
    session_location TEXT NOT NULL,
    session_modality TEXT NOT NULL,
    session_topic TEXT NOT NULL
);

-- Junction table for Mentors and Mentoring Sessions
CREATE TABLE mentors_sessions (
    mentor_id INT,
    session_id INT,
    PRIMARY KEY (mentor_id, session_id),
    FOREIGN KEY (mentor_id) REFERENCES mentors(mentor_id),
    FOREIGN KEY (session_id) REFERENCES mentoring_session(session_id)
);

-- Junction table for Mentees and Mentoring Sessions
CREATE TABLE mentees_sessions (
    mentee_id INT,
    session_id INT,
    PRIMARY KEY (mentee_id, session_id),
    FOREIGN KEY (mentee_id) REFERENCES mentees(mentee_id),
    FOREIGN KEY (session_id) REFERENCES mentoring_session(session_id)
);

-- Career Peer Staff
CREATE TABLE career_peer_staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_role TEXT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- Onboarding Appointment
CREATE TABLE onboarding_appt (
    onboarding_appt_id INT PRIMARY KEY AUTO_INCREMENT,
    date DATE NOT NULL,
    time TIME NOT NULL,
    duration INT NOT NULL,
    appt_location TEXT NOT NULL,
    appt_modality TEXT NOT NULL,
    reason_for_appt TEXT NOT NULL,
    topics_covered TEXT NOT NULL,
    feedback TEXT,
    staff_id INT NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES career_peer_staff(staff_id)
);

-- Junction table for Onboarding Appointments and Mentors
CREATE TABLE onboarding_appt_mentors (
    onboarding_appt_id INT NOT NULL,
    mentor_id INT NOT NULL,
    PRIMARY KEY (onboarding_appt_id, mentor_id),
    FOREIGN KEY (onboarding_appt_id) REFERENCES onboarding_appt(onboarding_appt_id),
    FOREIGN KEY (mentor_id) REFERENCES mentors(mentor_id)
);

-- Junction table for Onboarding Appointments and Mentees
CREATE TABLE onboarding_appt_mentees (
    onboarding_appt_id INT NOT NULL,
    mentee_id INT NOT NULL,
    PRIMARY KEY (onboarding_appt_id, mentee_id),
    FOREIGN KEY (onboarding_appt_id) REFERENCES onboarding_appt(onboarding_appt_id),
    FOREIGN KEY (mentee_id) REFERENCES mentees(mentee_id)
);


-- Dummy data for the tables
-- Not using real data for privacy reasons

-- Company
INSERT INTO company (company_name, company_sector, company_size, company_location, company_website, company_phone)
VALUES
('Google', 'Technology', 100000, 'Mountain View, CA', 'https://www.google.com/', '650-253-0000'),
('Facebook', 'Technology', 60000, 'Menlo Park, CA', 'https://www.facebook.com/', '650-543-4800'),
('Amazon', 'Technology', 1000000, 'Seattle, WA', 'https://www.amazon.com/', '206-266-1000'),
('Microsoft', 'Technology', 150000, 'Redmond, WA', 'https://www.microsoft.com/', '425-882-8080'),
('Apple', 'Technology', 150000, 'Cupertino, CA', 'https://www.apple.com/', '408-996-1010'),
('Tesla', 'Automotive', 48000, 'Palo Alto, CA', 'https://www.tesla.com/', '888-518-3752'),
('Walmart', 'Retail', 2200000, 'Bentonville, AR', 'https://www.walmart.com/', '800-925-6278'),
('Target', 'Retail', 360000, 'Minneapolis, MN', 'https://www.target.com/', '800-440-0680'),
('Costco', 'Retail', 273000, 'Issaquah, WA', 'https://www.costco.com/', '800-774-2678'),
('Starbucks', 'Food & Beverage', 346000, 'Seattle, WA', 'https://www.starbucks.com/', '800-782-7282');

-- Mentors
INSERT INTO mentors (first_name, last_name, major, concentration, grad_year, years_of_experience, job_title, industry, email, phone, company_id)
VALUES
('John', 'Doe','Business Administration', 'Information Systems', 2012, 10, 'Software Engineer', 'Technology', 'johndoe@example.com', '123-456-7890', 1),
('Christine', 'Taylor', 'Economics', 'Quantitative Analysis', 2014, 11, 'Data Scientist', 'Data Science', 'ctaylor@example.com', '123-456-7890', 2),
('Michael', 'Johnson', 'Industrial Technology & Packaging', 'Packaging Technology', 2016, 12, 'Packaging Engineer', 'Idustrial Technology', 'mj@example.com', '123-456-7890', 3),
('Emily', 'Williams', 'Computer Science', 'Software Engineering', 2007, 13, 'Software Engineer', 'Technology', 'ew@example.com', '123-456-7890', 4),
('David', 'Brown', 'Business Administration', 'Marketing', 2008, 14, 'Product Manager', 'Technology', 'db@example.com', '123-456-7890', 5),
('Olivia', 'Jones', 'Computer Science', 'Data Science', 2009, 15, 'Data Scientist', 'Data Science', 'oj@example.com', '123-456-7890', 6),
('Daniel', 'Garcia', 'Computer Science', 'Software Engineering', 2002, 16, 'Software Engineer', 'Technology', 'dg@example.com', '123-456-7890', 7),
('Sophia', 'Martinez', 'Computer Science', 'Product Management', 2003, 17, 'Product Manager', 'Technology', 'sm@example.com', '123-456-7890', 8),
('Matthew', 'Rodriguez', 'Computer Science', 'Data Science', 2004, 18, 'Data Scientist', 'Data Science', 'mr@example.com', '123-456-7890', 9),
('Isabella', 'Hernandez', 'Computer Science', 'Software Engineering', 2003, 19, 'Software Engineer', 'Technology', 'ih@example.com', '123-456-7890', 10);




-- Mentees
INSERT INTO mentees (major, grad_year, career_interests, first_name, last_name, email, phone, mentor_id)
VALUES
('Computer Science', 2024, 'Software Engineering', 'Jack', 'Black', 'jackblack@example.com', '123-456-7890', 1),
('Computer Science', 2025, 'Product Management', 'Sam', 'Smith', 'samsmith@example.com', '123-456-7890', 2),
('Computer Science', 2026, 'Data Science', 'Michael', 'Johnson', 'michael@example.com', '123-456-7890', 3),
('Computer Science', 2025, 'Software Engineering', 'Camille', 'Jones', 'camille@example.com', '123-456-7890', 4),
('Computer Science', 2026, 'Product Management', 'Keaton', 'Brown', 'keaton@example.com', '123-456-7890', 5),
('Computer Science', 2024, 'Data Science', 'Jared', 'Garcia', 'jared@example.com', '123-456-7890', 6),
('Computer Science', 2026, 'Software Engineering', 'Eliana', 'Martinez', 'eli@example.com', '123-456-7890', 7),
('Computer Science', 2025, 'Product Management', 'Ava', 'Rodriguez', 'ava@example.com', '123-456-7890', 8),
('Computer Science', 2026, 'Data Science', 'Ethan', 'Hernandez', 'ethan@example.com', '123-456-7890', 9),
('Computer Science', 2024, 'Software Engineering', 'Avery', 'Smith', 'avery@example.com', '123-456-7890', 10);

/*

-- Will take too long to implement and test before presentation
-- Keeping block of code for future development
-- Participants
INSERT INTO participants (participant_type, first_name, last_name, email, phone, major, grad_year, career_interests, job_title, industry, years_of_experience, onboarding_completed, company_id, assigned_participant_id)
VALUES
('Mentor', 'John', 'Doe', 'jd@example.com', '123-456-7890', 'Computer Science', 2010, 'Software Engineering', 'Software Engineer', 'Technology', 10, FALSE, 1, NULL),
('Mentor', 'Jane', 'Smith', 'js@example.com', '123-456-7890', 'Computer Science', 2021, 'Product Management', 'Product Manager', 'Technology', 15, TRUE, 2, 8),
('Mentor', 'Michael', 'Johnson', 'mj@example.com', '123-456-7890', 'Computer Science', 2015, 'Data Science', 'Data Scientist', 'Technology', 20, FALSE, 3, NULL),
('Mentor', 'Emily', 'Williams', 'ew@example.com', '123-456-7890', 'Computer Science', 2014, 'Software Engineering', 'Software Engineer', 'Technology', 5, TRUE, 4, 9),
('Mentor', 'David', 'Brown', 'db@example.com', '123-456-7890', 'Computer Science', 2012, 'Product Management', 'Product Manager', 'Technology', 8, TRUE, 5, 10),
('Mentor', 'Olivia', 'Jones', 'oj@@example.com', '123-456-7890', 'Computer Science', 2018, 'Data Science', 'Data Scientist', 'Technology', 12, FALSE, 6, NULL),
('Mentor', 'Daniel', 'Garcia', 'dg@example.com', '123-456-7890', 'Computer Science', 2020, 'Software Engineering', 'Software Engineer', 'Technology', 3, TRUE, 7,11),
('Mentee', 'Sophia', 'Martinez', 'sm@example.com', '123-456-7890', 'Computer Science', 2025, 'Product Management', NULL, NULL, NULL, TRUE, NULL, 2),
('Mentee', 'Matthew', 'Rodriguez', 'mr@example.com', '123-456-7890', 'Computer Science', 2026, 'Data Science', NULL, NULL, NULL, TRUE, NULL, 4),
('Mentee', 'Isabella', 'Hernandez', 'ih@example.com', '123-456-7890', 'Computer Science', 2024, 'Software Engineering', NULL, NULL, NULL, TRUE, NULL, 5),
('Mentee', 'Benjamin', 'Reichwald', 'dg@example.com', '123-456-7890', 'Computer Science', 2023, 'Product Management', NULL, NULL, NULL, TRUE, NULL, 7),
('Mentee', 'Ava', 'Smith', 'as@example.com', '123-456-7890', 'Computer Science', 2026, 'Data Science', NULL, NULL, NULL, FALSE, NULL, NULL),
('Mentee', 'Ethan', 'Hernandez', 'eh@example.com', '123-456-7890', 'Computer Science', 2025, 'Software Engineering', NULL, NULL, NULL, FALSE, NULL, NULL);

*/

-- Mentoring Session
INSERT INTO mentoring_session (session_date, session_time, session_duration, session_location, session_modality, session_topic)
VALUES
('2024-03-13', '12:00:00', 15, 'Zoom', 'Virtual', 'Software Engineering'),
('2024-03-14', '11:00:00', 30, '03-111', 'In-Person', 'Product Management'),
('2024-03-15', '12:30:00', 45, 'Zoom', 'Virtual', 'Data Science'),
('2024-03-15', '13:30:00', 60, 'Zoom', 'Virtual', 'Software Engineering'),
('2024-03-15', '14:15:00', 45, 'Zoom', 'Virtual', 'Product Management'),
('2024-03-16', '12:45:00', 15, '03-113', 'In-Person', 'Data Science'),
('2024-03-17', '12:30:00', 30, '03-112', 'In-Person', 'Software Engineering'),
('2024-03-17', '12:45:00', 15, '03-111', 'In-Person', 'Product Management'),
('2024-03-18', '11:30:00', 30, '03-113', 'In-Person', 'Data Science'),
('2024-03-19', '12:00:00', 30, '03-111', 'In-Person', 'Software Engineering');

-- Mentors Sessions
INSERT INTO mentors_sessions (mentor_id, session_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Mentees Sessions
INSERT INTO mentees_sessions (mentee_id, session_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Career Peer Staff
INSERT INTO career_peer_staff (staff_role, first_name, last_name, email, phone)
VALUES
('Career Peer', 'Aubrey', 'Graham', 'drake@example.com', '123-456-7890'),
('Career Peer', 'Rihanna', 'Fenty', 'riri@example.com', '123-456-7890'),
('Career Peer', 'Beyonce', 'Knowles', 'queenbey@example.com', '123-456-7890'),
('Career Peer', 'Jeffrey', 'Free', 'freejeffrey@example.com', '123-456-7890'),
('Career Peer', 'Kendrick', 'Lamar', 'kdot@example.com', '123-456-7890'),
('Career Peer', 'Jack', 'Johnson', 'jj@example.com', '123-456-7890'),
('Career Peer', 'John', 'Legend', 'jl@example.com', '123-456-7890'),
('Career Peer', 'Alicia', 'Keys', 'alicia@example.com', '123-456-7890'),
('Career Peer', 'Adele', 'Adkins', 'aa@example.com', '123-456-7890'),
('Career Peer', 'Bruno', 'Mars', 'bm@example.com', '123-456-7890');

-- Onboarding Appt
INSERT INTO onboarding_appt (date, time, duration, appt_location, appt_modality, reason_for_appt, topics_covered, feedback, staff_id)
VALUES
('2024-03-10', '11:00:00', 15, 'Zoom', 'Virtual', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', NULL, 1),
('2024-03-11', '12:00:00', 30, 'Zoom', 'Virtual', 'Interview Prep', 'Behavioral Interview, Technical Interview', NULL, 2),
('2024-03-11', '11:30:00', 45, 'Zoom', 'Virtual', 'Networking', 'Elevator Pitch, Informational Interview', NULL, 3),
('2024-03-11', '12:30:00', 60, '03-113', 'In-Person', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', NULL, 4),
('2024-03-12', '14:15:00', 45, '03-112', 'In-Person', 'Interview Prep', 'Behavioral Interview, Technical Interview', NULL, 5),
('2024-03-13', '15:45:00', 15, '03-111', 'In-Person', 'Networking', 'Elevator Pitch, Informational Interview', NULL, 6),
('2024-03-14', '14:30:00', 30, '03-113', 'In-Person', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', NULL, 7),
('2024-03-15', '12:45:00', 15, '03-111', 'In-Person', 'Interview Prep', 'Behavioral Interview, Technical Interview', NULL, 8),
('2024-03-16', '11:30:00', 30, 'Zoom', 'Virtual', 'Networking', 'Elevator Pitch, Informational Interview', NULL, 9),
('2024-03-17', '12:00:00', 30, 'Zoom', 'Virtual', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', NULL, 10);

-- Onboarding Appt Mentors
INSERT INTO onboarding_appt_mentors (onboarding_appt_id, mentor_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Onboarding Appt Mentees
INSERT INTO onboarding_appt_mentees (onboarding_appt_id, mentee_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Queries

-- TODO: Create 3 queries that include grouping

-- View mentor and mentee assignment along with their names, email, and relevant career information
-- Testing Statement: 
DROP VIEW IF EXISTS mentee_mentor_info_sessions;
CREATE VIEW mentee_mentor_info_sessions AS
SELECT 'Mentee' AS attendee_type, m.first_name, m.last_name, m.email, m.career_interests, ms.session_id
FROM mentees_sessions AS ms
INNER JOIN mentees AS m ON ms.mentee_id = m.mentee_id
-- WHERE ms.session_id = 1
UNION ALL
SELECT 'Mentor' AS attendee_type, mt.first_name, mt.last_name, mt.email, mt.industry, ms.session_id
FROM mentors_sessions AS ms
INNER JOIN mentors AS mt ON ms.mentor_id = mt.mentor_id
-- WHERE ms.session_id = 1
ORDER BY session_id ASC;

-- View mentoring sessions and their attendees
DROP VIEW IF EXISTS mentoring_session_attendees;
CREATE VIEW mentoring_session_attendees AS
SELECT s.session_id,s.session_date, s.session_time, s.session_duration, s.session_location, s.session_topic, s.session_modality, 
    'Mentee' AS attendee_type, m.first_name, m.last_name, m.email
FROM mentoring_session s
INNER JOIN mentees_sessions AS ms ON s.session_id = ms.session_id
INNER JOIN mentees m ON ms.mentee_id = m.mentee_id
UNION ALL
SELECT s.session_id, s.session_date, s.session_time, s.session_duration, s.session_location, s.session_topic, s.session_modality,
    'Mentor' AS attendee_type, mt.first_name, mt.last_name, mt.email
FROM mentoring_session s 
INNER JOIN mentors_sessions AS ms ON s.session_id = ms.session_id
INNER JOIN mentors mt ON ms.mentor_id = mt.mentor_id
ORDER BY session_id ASC;


-- Example statements: DISREGARD
/* SELECT 'Mentee' AS attendee_type, m.first_name, m.last_name, m.email, m.career_interests, ms.session_id
FROM mentees_sessions AS ms
INNER JOIN mentees AS m ON ms.mentee_id = m.mentee_id
ORDER BY session_id ASC;
-- WHERE ms.session_id = 1
-- UNION ALL
SELECT 'Mentor' AS attendee_type, mt.first_name, mt.last_name, mt.email, mt.industry, ms.session_id
FROM mentors_sessions AS ms
INNER JOIN mentors AS mt ON ms.mentor_id = mt.mentor_id
-- WHERE ms.session_id = 1
ORDER BY session_id ASC; */

-- TODO: Add 2 more queries that implement subqueries

-- View career peer staff and their onboarding appointments
DROP VIEW IF EXISTS career_peer_staff_appts;
CREATE VIEW career_peer_staff_appts AS
SELECT s.staff_id, s.staff_role, s.first_name, s.last_name, s.email, s.phone, a.onboarding_appt_id, a.date, a.time, a.duration, a.appt_location, a.appt_modality, a.reason_for_appt, a.topics_covered, a.feedback
FROM career_peer_staff s
INNER JOIN onboarding_appt a ON s.staff_id = a.staff_id
ORDER BY onboarding_appt_id ASC;

-- View mentors and their onboarding appointments
DROP VIEW IF EXISTS mentor_onboarding_appts;
CREATE VIEW mentor_onboarding_appts AS
SELECT m.mentor_id, m.first_name, m.last_name, m.email, m.phone, a.onboarding_appt_id, a.date, a.time, a.duration, a.appt_location, a.appt_modality, a.reason_for_appt, a.topics_covered, a.feedback
FROM mentors m
INNER JOIN onboarding_appt_mentors om ON m.mentor_id = om.mentor_id
INNER JOIN onboarding_appt a ON om.onboarding_appt_id = a.onboarding_appt_id
ORDER BY onboarding_appt_id ASC;

-- View career peers and all their onboarding appointments
DROP VIEW IF EXISTS onboarding_appt_attendees;
CREATE VIEW onboarding_appt_attendees AS
SELECT "Career Peer" AS attendee_type, s.first_name, s.last_name, s.email, a.onboarding_appt_id, a.date, a.time, a.duration, a.appt_location, a.appt_modality, a.reason_for_appt, a.topics_covered, a.feedback
FROM career_peer_staff s
INNER JOIN onboarding_appt a ON s.staff_id = a.staff_id
UNION ALL
SELECT "Mentor" AS attendee_type, m.first_name, m.last_name, m.email, a.onboarding_appt_id, a.date, a.time, a.duration, a.appt_location, a.appt_modality, a.reason_for_appt, a.topics_covered, a.feedback
FROM mentors m
INNER JOIN onboarding_appt_mentors om ON m.mentor_id = om.mentor_id
INNER JOIN onboarding_appt a ON om.onboarding_appt_id = a.onboarding_appt_id
UNION ALL
SELECT "Mentee" AS attendee_type, n.first_name, n.last_name, n.email, a.onboarding_appt_id, a.date, a.time, a.duration, a.appt_location, a.appt_modality, a.reason_for_appt, a.topics_covered, a.feedback
FROM mentees n
INNER JOIN onboarding_appt_mentees nm ON n.mentee_id = nm.mentee_id
INNER JOIN onboarding_appt a ON nm.onboarding_appt_id = a.onboarding_appt_id
ORDER BY onboarding_appt_id;

