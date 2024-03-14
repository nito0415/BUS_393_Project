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
    accepted BOOLEAN NOT NULL DEFAULT FALSE,
    questions_for_mentor TEXT,
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
    appt_location VARCHAR(20) NOT NULL,
    appt_modality VARCHAR(20) NOT NULL,
    reason_for_appt VARCHAR(20) DEFAULT 'Onboarding',
    topics_covered TEXT NOT NULL,
    feedback VARCHAR(100),
    staff_id INT,
    FOREIGN KEY (staff_id) REFERENCES career_peer_staff(staff_id)
);

-- Junction table for Onboarding Appointments and Mentors
CREATE TABLE onboarding_appt_mentors (
    onboarding_appt_id INT NOT NULL,
    mentor_id INT NOT NULL,
    accepted BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (onboarding_appt_id, mentor_id),
    FOREIGN KEY (onboarding_appt_id) REFERENCES onboarding_appt(onboarding_appt_id),
    FOREIGN KEY (mentor_id) REFERENCES mentors(mentor_id)
);

-- Junction table for Onboarding Appointments and Mentees
CREATE TABLE onboarding_appt_mentees (
    onboarding_appt_id INT NOT NULL,
    mentee_id INT NOT NULL,
    questions_for_mentor TEXT,
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
('Emma', 'Johnson', 'Business Administration', 'Accounting', 2012, 10, 'Senior Accountant', 'Finance', 'ejohnson@example.com', '123-456-7890', NULL),
('Santiago', 'Garcia', 'Economics', 'Quantitative Analysis', 2014, 8, 'Financial Analyst', 'Banking', 'sgarcia@example.com', '123-456-7891', 1),
('Aiden', 'Smith', 'Industrial Technology & Packaging', 'Industrial Technology', 2016, 7, 'Process Engineer', 'Manufacturing', 'asmith@example.com', '123-456-7892', 2),
('Mia', 'Wang', 'Business Administration', 'Marketing', 2008, 16, 'Brand Manager', 'Advertising', 'mwang@example.com', '123-456-7893', 3),
('Jayden', 'Johnson', 'Business Administration', 'Finance', 2007, 17, 'Investment Banker', 'Finance', 'jjohnson@example.com', '123-456-7894', 4),
('Camila', 'Rodriguez', 'Business Administration', 'Entrepreneurship', 2009, 15, 'Startup Founder', 'Tech Startups', 'crodriguez@example.com', '123-456-7895', 5),
('Zoe', 'Kim', 'Business Administration', 'Information Systems', 2002, 22, 'Systems Analyst', 'Technology', 'zkim@example.com', '123-456-7896', 6),
('Elijah', 'Martinez', 'Economics', 'Real Estate Finance', 2004, 20, 'Real Estate Broker', 'Real Estate', 'emartinez@example.com', '123-456-7897', 7),
('Sophia', 'Chen', 'Industrial Technology & Packaging', 'Packaging Technology', 2003, 21, 'Packaging Designer', 'Design', 'schen@example.com', '123-456-7898', 8),
('Lucas', 'Brown', 'Business Administration', 'Management & Human Resources', 2005, 19, 'HR Director', 'Corporate', 'lbrown@example.com', '123-456-7899', 9),
('Isabella', 'Wilson', 'Business Administration', 'Accounting', 2010, 14, 'Auditor', 'Accounting', 'iwilson@example.com', '123-456-7800', 10),
('Mateo', 'Hernandez', 'Economics', 'Quantitative Analysis', 2011, 13, 'Econometrician', 'Research', 'mhernandez@example.com', '123-456-7801', NULL),
('Chloe', 'Lee', 'Industrial Technology & Packaging', 'Consumer Packaging', 2013, 11, 'Quality Control Manager', 'Consumer Goods', 'clee@example.com', '123-456-7802', 1),
('William', 'Jones', 'Business Administration', 'Marketing', 2015, 9, 'Digital Marketing Coordinator', 'E-Commerce', 'wjones@example.com', '123-456-7803', 2),
('Ava', 'Davis', 'Business Administration', 'Entrepreneurship', 2017, 7, 'Business Development Manager', 'Startup', 'adavis@example.com', '123-456-7804', 3),
('Ethan', 'Taylor', 'Business Administration', 'Finance', 2018, 6, 'Financial Planner', 'Financial Services', 'etaylor@example.com', '123-456-7805', 4),
('Isabel', 'Martinez', 'Economics', 'Real Estate Finance', 2006, 18, 'Mortgage Advisor', 'Banking', 'imartinez@example.com', '123-456-7806', 5),
('Noah', 'Kim', 'Industrial Technology & Packaging', 'Industrial Technology', 2019, 5, 'Operations Manager', 'Logistics', 'nkim@example.com', '123-456-7807', 6);


-- Mentees
INSERT INTO mentees (first_name, last_name, major, concentration, grad_year, career_interests, email, phone, mentor_id)
VALUES
('Michael', 'Taylor', 'Business Administration', 'Accounting', 2024, 'Accounting', 'mtaylor@example.com', '123-456-7890', NULL),
('Ana', 'Rivera', 'Economics', 'Quantitative Analysis', 2025, 'Economic Research', 'arivera@example.com', '123-456-7891', 1),
('Liam', 'Chen', 'Industrial Technology & Packaging', 'Industrial Technology', 2026, 'Process Improvement', 'lchen@example.com', '123-456-7892', 2),
('Emma', 'Martinez', 'Business Administration', 'Marketing', 2025, 'Brand Development', 'emartinez@example.com', '123-456-7893', 3),
('Jacob', 'Rodriguez', 'Business Administration', 'Finance', 2024, 'Investment Banking', 'jrodriguez@example.com', '123-456-7894', 4),
('Olivia', 'Gomez', 'Business Administration', 'Entrepreneurship', 2026, 'Startup Management', 'ogomez@example.com', '123-456-7895', 5),
('James', 'Park', 'Business Administration', 'Information Systems', 2025, 'System Analysis', 'jpark@example.com', '123-456-7896', 6),
('Sofia', 'Lopez', 'Economics', 'Real Estate Finance', 2026, 'Real Estate Investment', 'slopez@example.com', '123-456-7897', 7),
('Ethan', 'Wong', 'Industrial Technology & Packaging', 'Packaging Technology', 2024, 'Packaging Design', 'ewong@example.com', '123-456-7898', 8),
('Emily', 'Johnson', 'Business Administration', 'Management & Human Resources', 2025, 'Human Resources Management', 'ejohnson@example.com', '123-456-7899', 9),
('Daniel', 'Lee', 'Business Administration', 'Accounting', 2024, 'Corporate Accounting', 'dlee@example.com', '123-456-7800', 10),
('Isabella', 'Smith', 'Economics', 'Quantitative Analysis', 2025, 'Financial Analysis', 'ismith@example.com', '123-456-7801', NULL),
('Lucas', 'Nguyen', 'Industrial Technology & Packaging', 'Consumer Packaging', 2026, 'Consumer Product Packaging', 'lnguyen@example.com', '123-456-7802', 1),
('Mia', 'Jones', 'Business Administration', 'Marketing', 2024, 'Digital Marketing', 'mjones@example.com', '123-456-7803', 2),
('Noah', 'Kim', 'Business Administration', 'Entrepreneurship', 2025, 'Innovation Management', 'nkim@example.com', '123-456-7804', 3),
('Sophia', 'Garcia', 'Business Administration', 'Finance', 2026, 'Financial Planning', 'sgarcia@example.com', '123-456-7805', 4),
('Ava', 'Martinez', 'Economics', 'Real Estate Finance', 2024, 'Mortgage Banking', 'amartinez@example.com', '123-456-7806', 5),
('Elijah', 'Lee', 'Industrial Technology & Packaging', 'Industrial Technology', 2025, 'Manufacturing Operations', 'elee@example.com', '123-456-7807', 6);

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
('2024-03-10', '11:00:00', 15, 'Zoom', 'Virtual', 'Training', 'Resume, Cover Letter, LinkedIn Profile', NULL, 1),
('2024-03-11', '12:00:00', 30, 'Zoom', 'Virtual', 'Onboarding', 'Behavioral Interview, Technical Interview', NULL, 2),
('2024-03-11', '11:30:00', 45, 'Zoom', 'Virtual', 'Onboarding', 'Elevator Pitch, Informational Interview', NULL, 3),
('2024-03-11', '12:30:00', 60, '03-113', 'In-Person', 'Onboarding', 'Resume, Cover Letter, LinkedIn Profile', NULL, 4),
('2024-03-12', '14:15:00', 45, '03-112', 'In-Person', 'Onboarding', 'Behavioral Interview, Technical Interview', NULL, 5),
('2024-03-13', '15:45:00', 15, '03-111', 'In-Person', 'Training', 'Elevator Pitch, Informational Interview', NULL, 6),
('2024-03-14', '14:30:00', 30, '03-113', 'In-Person', 'Training', 'Resume, Cover Letter, LinkedIn Profile', NULL, 7),
('2024-03-15', '12:45:00', 15, '03-111', 'In-Person', 'Onboarding', 'Behavioral Interview, Technical Interview', NULL, 8),
('2024-03-16', '11:30:00', 30, 'Zoom', 'Virtual', 'Onboarding', 'Elevator Pitch, Informational Interview', NULL, 9),
('2024-03-17', '12:00:00', 30, 'Zoom', 'Virtual', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', NULL, 10);

-- Onboarding Appt Mentors
INSERT INTO onboarding_appt_mentors (onboarding_appt_id, mentor_id, accepted)
VALUES
(1, 1, TRUE),
(2, 2, TRUE),
(3, 3, TRUE),
(4, 4, TRUE),
(5, 5, TRUE),
(6, 6, TRUE),
(7, 7, TRUE),
(8, 8, TRUE),
(9, 9, TRUE),
(10, 10, TRUE),
(1, 11, TRUE),
(2, 12, TRUE),
(3, 13, TRUE),
(4, 14, TRUE),
(5, 15, TRUE),
(6, 16, TRUE),
(7, 17, TRUE),
(8, 18, TRUE);

-- Onboarding Appt Mentees
INSERT INTO onboarding_appt_mentees (onboarding_appt_id, mentee_id, questions_for_mentor)
VALUES
(1, 1, 'What skills are crucial for advancing in my field?'),
(2, 2, 'Can you recommend any resources for learning more about our industry trends?'),
(3, 3, 'How did you choose your specialty within our field?'),
(4, 4, 'What are common challenges newcomers face, and how can I avoid them?'),
(5, 5, 'Could you share your experience about work-life balance?'),
(6, 6, 'What networking opportunities should I not miss?'),
(7, 7, 'How important is personal branding in our industry?'),
(8, 8, 'What strategies have you found effective for staying updated with industry news?'),
(9, 9, 'How can I make the most out of this mentoring relationship?'),
(10, 10, 'What are the first steps I should take to start my career successfully?'),
(1, 11, 'How can I improve my resume to reflect my career interests accurately?'),
(2, 12, 'What steps did you take to land your first job in the industry?'),
(3, 13, 'Can you suggest any certifications that would be beneficial for my career?'),
(4, 14, 'What has been your most challenging experience in your career, and how did you overcome it?'),
(5, 15, 'How do you approach networking within our industry?'),
(6, 16, 'What are some effective strategies for time management and prioritization?'),
(7, 17, 'In what ways can I gain practical experience while still in school?'),
(8, 18, 'What do you wish you had known when you were starting out in your career?');


-- Queries

-- View mentor and mentee assignment along with their names, email, and relevant career information
-- Testing Statement: 
DROP VIEW IF EXISTS mentee_mentor_info_sessions;
CREATE VIEW mentee_mentor_info_sessions AS
SELECT 'Mentee' AS attendee_type, m.first_name, m.last_name, m.email, m.career_interests, ms.session_id
FROM mentees_sessions ms
INNER JOIN mentees m ON ms.mentee_id = m.mentee_id
-- WHERE ms.session_id = 1
UNION ALL
SELECT 'Mentor' AS attendee_type, mt.first_name, mt.last_name, mt.email, mt.industry, ms.session_id
FROM mentors_sessions ms
INNER JOIN mentors mt ON ms.mentor_id = mt.mentor_id
-- WHERE ms.session_id = 1
ORDER BY session_id ASC;

-- View mentoring sessions and their attendees
DROP VIEW IF EXISTS mentoring_session_attendees;
CREATE VIEW mentoring_session_attendees AS
SELECT s.session_id,s.session_date, s.session_time, s.session_duration, s.session_location, s.session_topic, s.session_modality, 
    'Mentee' AS attendee_type, m.first_name, m.last_name, m.email
FROM mentoring_session s
INNER JOIN mentees_sessions ms ON s.session_id = ms.session_id
INNER JOIN mentees m ON ms.mentee_id = m.mentee_id
UNION ALL
SELECT s.session_id, s.session_date, s.session_time, s.session_duration, s.session_location, s.session_topic, s.session_modality,
    'Mentor' AS attendee_type, mt.first_name, mt.last_name, mt.email
FROM mentoring_session s 
INNER JOIN mentors_sessions ms ON s.session_id = ms.session_id
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

