SELECT * FROM company;



-- TODO: Create 3 queries that include grouping
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
-- WHERE 
--    ms.session_id = 1

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
-- WHERE 
--    ms.session_id = 1

ORDER BY 
    session_id, attendee_type;

-- View mentoring sessions and their attendees

SELECT 
    s.session_id,
    s.session_date,
    s.session_time,
    s.session_duration,
    s.session_location,
    s.session_topic,
    s.session_modality,
    'Mentee' AS attendee_type,
    m.first_name,
    m.last_name,
    m.email
FROM
    mentoring_session AS s
INNER JOIN
    mentees_sessions AS ms ON s.session_id = ms.session_id
INNER JOIN
    mentees AS m ON ms.mentee_id = m.mentee_id

UNION ALL

SELECT 
    s.session_id,
    s.session_date,
    s.session_time,
    s.session_duration,
    s.session_location,
    s.session_topic,
    s.session_modality,
    'Mentor' AS attendee_type,
    mt.first_name,
    mt.last_name,
    mt.email
FROM
    mentoring_session AS s 
INNER JOIN
    mentors_sessions AS ms ON s.session_id = ms.session_id
INNER JOIN
    mentors AS mt ON ms.mentor_id = mt.mentor_id

ORDER BY
    session_id, attendee_type;

-- TODO: Add 2 more queries that implement subqueries
