DROP TABLE IF EXISTS onboarding_appt_mentees;
DROP TABLE IF EXISTS onboarding_appt_mentors;
DROP TABLE IF EXISTS onboarding_appt;
DROP TABLE IF EXISTS career_peer_staff;
DROP TABLE IF EXISTS mentees_sessions;
DROP TABLE IF EXISTS mentors_sessions;
DROP TABLE IF EXISTS mentoring_session;
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
    company_phone VARCHAR(20) NOT NULL,
);

-- Mentors
CREATE TABLE mentors (
    mentor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    alumni_type TEXT NOT NULL,
    years_of_experience INT NOT NULL,
    industry_sector TEXT NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    industry VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    company_id INT,
    FOREIGN KEY (company_id) REFERENCES company(company_id)
);

-- Mentees
CREATE TABLE mentees (
    mentee_id INT PRIMARY KEY AUTO_INCREMENT,
    major TEXT NOT NULL,
    grad_year INT NOT NULL,
    career_interests TEXT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    mentor_id INT,
    FOREIGN KEY (mentor_id) REFERENCES mentors(mentor_id)
);

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
    feedback TEXT NOT NULL,
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
INSERT INTO company (company_id, company_name, company_sector, company_size, company_location, company_website, company_phone)
VALUES
(1, 'Google', 'Technology', 100000, 'Mountain View, CA', 'https://www.google.com/', '650-253-0000'),
(2, 'Facebook', 'Technology', 60000, 'Menlo Park, CA', 'https://www.facebook.com/', '650-543-4800'),
(3, 'Amazon', 'Technology', 1000000, 'Seattle, WA', 'https://www.amazon.com/', '206-266-1000'),
(4, 'Microsoft', 'Technology', 150000, 'Redmond, WA', 'https://www.microsoft.com/', '425-882-8080'),
(5, 'Apple', 'Technology', 150000, 'Cupertino, CA', 'https://www.apple.com/', '408-996-1010'),
(6, 'Tesla', 'Automotive', 48000, 'Palo Alto, CA', 'https://www.tesla.com/', '888-518-3752'),
(7, 'Walmart', 'Retail', 2200000, 'Bentonville, AR', 'https://www.walmart.com/', '800-925-6278'),
(8, 'Target', 'Retail', 360000, 'Minneapolis, MN', 'https://www.target.com/', '800-440-0680'),
(9, 'Costco', 'Retail', 273000, 'Issaquah, WA', 'https://www.costco.com/', '800-774-2678'),
(10, 'Starbucks', 'Food & Beverage', 346000, 'Seattle, WA', 'https://www.starbucks.com/', '800-782-7282');

-- Mentors
INSERT INTO mentors (mentor_id, first_name, last_name, alumni_type, years_of_experience, industry_sector, job_title, industry, email, phone, company_id)
VALUES
(1, 'John', 'Doe', 'Alumni', 10, 'Technology', 'Software Engineer', 'Technology', 'johndoe@example.com', '123-456-7890', 1),
(2, 'Jane', 'Smith', 'Alumni', 15, 'Technology', 'Product Manager', 'Technology', 'janesmith@example.com', '123-456-7890', 2),
(3, 'Michael', 'Johnson', 'Alumni', 20, 'Technology', 'Data Scientist', 'Technology', 'mikejohn@example.com', '123-456-7890', 3),
(4, 'Emily', 'Williams', 'Alumni', 5, 'Technology', 'Software Engineer', 'Technology', 'emilywilliams@example.com', '123-456-7890', 4),
(5, 'David', 'Brown', 'Alumni', 8, 'Technology', 'Product Manager', 'Technology', 'davidbrown@example.com', '123-456-7890', 5),
(6, 'Olivia', 'Jones', 'Alumni', 12, 'Technology', 'Data Scientist', 'Technology', 'oliviajones@example.com', '123-456-7890', 6),
(7, 'Daniel', 'Garcia', 'Alumni', 3, 'Technology', 'Software Engineer', 'Technology', 'dangarcia@example.com', '123-456-7890', 7),
(8, 'Sophia', 'Martinez', 'Alumni', 7, 'Technology', 'Product Manager', 'Technology', 'sophiamartinez@example.com', '123-456-7890', 8),
(9, 'Matthew', 'Rodriguez', 'Alumni', 9, 'Technology', 'Data Scientist', 'Technology', 'mettrodriguez@example.com', '123-456-7890', 9),
(10, 'Isabella', 'Hernandez', 'Alumni', 11, 'Technology', 'Software Engineer', 'Technology', 'bellahernandez@example.com', '123-456-7890', 10);

-- Mentees
INSERT INTO mentees (mentee_id, major, grad_year, career_interests, first_name, last_name, email, phone, mentor_id)
VALUES
(1, 'Computer Science', 2024, 'Software Engineering', 'Jack', 'Black', 'jackblack@example.com', '123-456-7890', 1),
(2, 'Computer Science', 2025, 'Product Management', 'Sam', 'Smith', 'samsmith@example.com', '123-456-7890', 2),
(3, 'Computer Science', 2026, 'Data Science', 'Michael', 'Johnson', 'michael@example.com', '123-456-7890', 3),
(4, 'Computer Science', 2025, 'Software Engineering', 'Camille', 'Jones', 'camille@example.com', '123-456-7890', 4),
(5, 'Computer Science', 2026, 'Product Management', 'Keaton', 'Brown', 'keaton@example.com', '123-456-7890', 5),
(6, 'Computer Science', 2024, 'Data Science', 'Jared', 'Garcia', 'jared@example.com', '123-456-7890', 6),
(7, 'Computer Science', 2026, 'Software Engineering', 'Eliana', 'Martinez', 'eli@example.com', '123-456-7890', 7),
(8, 'Computer Science', 2025, 'Product Management', 'Ava', 'Rodriguez', 'ava@example.com', '123-456-7890', 8),
(9, 'Computer Science', 2026, 'Data Science', 'Ethan', 'Hernandez', 'ethan@example.com', '123-456-7890', 9),
(10, 'Computer Science', 2024, 'Software Engineering', 'Avery', 'Smith', 'avery@example.com', '123-456-7890', 10);

-- Mentoring Session
INSERT INTO mentoring_session (session_id, session_date, session_time, session_duration, session_location, session_modality, session_topic)
VALUES
(1, '2022-01-01', '10:00:00', 60, 'Zoom', 'Virtual', 'Software Engineering'),
(2, '2022-01-02', '11:00:00', 60, 'Zoom', 'Virtual', 'Product Management'),
(3, '2022-01-03', '12:00:00', 60, 'Zoom', 'Virtual', 'Data Science'),
(4, '2022-01-04', '13:00:00', 60, 'Zoom', 'Virtual', 'Software Engineering'),
(5, '2022-01-05', '14:00:00', 60, 'Zoom', 'Virtual', 'Product Management'),
(6, '2022-01-06', '15:00:00', 60, 'Zoom', 'Virtual', 'Data Science'),
(7, '2022-01-07', '16:00:00', 60, 'Zoom', 'Virtual', 'Software Engineering'),
(8, '2022-01-08', '17:00:00', 60, 'Zoom', 'Virtual', 'Product Management'),
(9, '2022-01-09', '18:00:00', 60, 'Zoom', 'Virtual', 'Data Science'),
(10, '2022-01-10', '19:00:00', 60, 'Zoom', 'Virtual', 'Software Engineering');

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
INSERT INTO career_peer_staff (staff_id, staff_role, first_name, last_name, email, phone)
VALUES
(1, 'Career Peer', 'Aubrey', 'Graham', 'drake@example.com', '123-456-7890'),
(2, 'Career Peer', 'Rihanna', 'Fenty', 'riri@example.com', '123-456-7890'),
(3, 'Career Peer', 'Beyonce', 'Knowles', 'queenbey@example.com', '123-456-7890'),
(4, 'Career Peer', 'Jeffrey', 'Free', 'freejeffrey@example.com', '123-456-7890'),
(5, 'Career Peer', 'Kendrick', 'Lamar', 'kdot@example.com', '123-456-7890'),
(6, 'Career Peer', 'Jack', 'Johnson', 'jj@example.com', '123-456-7890'),
(7, 'Career Peer', 'John', 'Legend', 'jl@example.com', '123-456-7890'),
(8, 'Career Peer', 'Alicia', 'Keys', 'alicia@example.com', '123-456-7890'),
(9, 'Career Peer', 'Adele', 'Adkins', 'aa@example.com', '123-456-7890'),
(10, 'Career Peer', 'Bruno', 'Mars', 'bm@example.com', '123-456-7890');

-- Onboarding Appt
INSERT INTO onboarding_appt (onboarding_appt_id, date, time, duration, appt_location, appt_modality, reason_for_appt, topics_covered, feedback, staff_id)
VALUES
(1, '2022-01-01', '10:00:00', 60, 'Zoom', 'Virtual', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', 'Great session!', 1),
(2, '2022-01-02', '11:00:00', 60, 'Zoom', 'Virtual', 'Interview Prep', 'Behavioral Interview, Technical Interview', 'Great session!', 2),
(3, '2022-01-03', '12:00:00', 60, 'Zoom', 'Virtual', 'Networking', 'Elevator Pitch, Informational Interview', 'Great session!', 3),
(4, '2022-01-04', '13:00:00', 60, 'Zoom', 'Virtual', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', 'Great session!', 4),
(5, '2022-01-05', '14:00:00', 60, 'Zoom', 'Virtual', 'Interview Prep', 'Behavioral Interview, Technical Interview', 'Great session!', 5),
(6, '2022-01-06', '15:00:00', 60, 'Zoom', 'Virtual', 'Networking', 'Elevator Pitch, Informational Interview', 'Great session!', 6),
(7, '2022-01-07', '16:00:00', 60, 'Zoom', 'Virtual', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', 'Great session!', 7),
(8, '2022-01-08', '17:00:00', 60, 'Zoom', 'Virtual', 'Interview Prep', 'Behavioral Interview, Technical Interview', 'Great session!', 8),
(9, '2022-01-09', '18:00:00', 60, 'Zoom', 'Virtual', 'Networking', 'Elevator Pitch, Informational Interview', 'Great session!', 9),
(10, '2022-01-10', '19:00:00', 60, 'Zoom', 'Virtual', 'Resume Review', 'Resume, Cover Letter, LinkedIn Profile', 'Great session!', 10);

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

-- Statememts used to test AUTO_INCREMENT and FOREIGN KEY constraints

INSERT INTO company (company_name, company_sector, company_size, company_location, company_website, company_phone, )
VALUES ('Pepsi Co.', 'Food & Beverage', 40000000, 'Harrison, NY', 'https://www.pepsi.com/', '800-123-4567');

INSERT INTO mentees (major, grad_year, career_interests, first_name, last_name, email, phone, mentor_id)
VALUES ('Economics' , '2024', 'Information Systems', 'Juan', 'Sanchez', 'jsanc@example.com', '800-123-4567', 1);

INSERT INTO mentors (first_name, last_name, alumni_type, years_of_experience, industry_sector, job_title, industry, email, phone, company_id)
VALUES ('Jack', 'Doherty', 'Alumni', 5, 'Technology', 'Software Engineer', 'Information Systems', 'jd@example.com', '800-123-4567', 11);

INSERT INTO mentors_sessions (mentor_id, session_id)
VALUES (11, 1);

INSERT INTO mentees_sessions (mentee_id, session_id)
VALUES (11, 1);