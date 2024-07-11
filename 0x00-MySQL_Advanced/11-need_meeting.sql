-- Defines a view named "need_meeting" that includes students

-- with a score below 80 (strict) and either no last meeting

-- or a last meeting more than 1 month ago.
DROP VIEW IF EXISTS need_meeting;
CREATE VIEW need_meeting AS
SELECT name
FROM students
WHERE score < 80
    AND (
        last_meeting IS NULL
        OR last_meeting < SUBDATE(CURRENT_DATE(), INTERVAL 1 MONTH)
    );
