SELECT * FROM company;

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

SELECT 
    'Mentee' AS attendee_type,
    m.first_name,
    m.last_name,
    m.email,
    ms.session_id
FROM 
    mentees_sessions AS ms
INNER JOIN 
    mentees AS m ON ms.mentee_id = m.mentee_id
WHERE 
    ms.session_id = 1

UNION ALL

SELECT 
    'Mentor' AS attendee_type,
    mt.first_name,
    mt.last_name,
    mt.email,
    ms.session_id
FROM 
    mentors_sessions AS ms
INNER JOIN 
    mentors AS mt ON ms.mentor_id = mt.mentor_id
WHERE 
    ms.session_id = 1

ORDER BY 
    session_id, attendee_type, first_name, last_name;
