set schema 'mimiciii';

SELECT p.subject_id, p.dob, p.gender, p.expire_flag, a1.admittime as last_admittime,
	a1.ethnicity, a1.language AS language_p, a1.religion, a1.marital_status,
	ROUND( (cast(a1.admittime as date) - cast(p.dob as date)) / 365.242,2) AS last_admit_age
FROM patients p
JOIN admissions a1 ON (p.subject_id = a1.subject_id)
LEFT OUTER JOIN admissions a2 ON (p.subject_id = a2.subject_id AND 
    (a1.admittime < a2.admittime OR (a1.admittime = a2.admittime AND a1.row_id < a2.row_id)))
WHERE a2.row_id IS NULL
ORDER BY p.subject_id;

WITH last_admission_time AS
(
	SELECT p.subject_id, p.dob, p.gender, p.expire_flag, a1.admittime as last_admittime,
		a1.ethnicity, a1.language AS language_p, a1.religion, a1.marital_status,
		ROUND( (cast(a1.admittime as date) - cast(p.dob as date)) / 365.242,2) AS last_admit_age
	FROM patients p
	JOIN admissions a1 ON (p.subject_id = a1.subject_id)
	LEFT OUTER JOIN admissions a2 ON (p.subject_id = a2.subject_id AND 
		(a1.admittime < a2.admittime OR (a1.admittime = a2.admittime AND a1.row_id < a2.row_id)))
	WHERE a2.row_id IS NULL
	ORDER BY p.subject_id
)
SELECT
    *
    , CASE
        -- all ages > 89 in the database were replaced with 300
        WHEN last_admission_time.last_admit_age > 89
            then '>89'
        WHEN last_admission_time.last_admit_age >= 14
            THEN 'adult'
        WHEN last_admission_time.last_admit_age <= 1
            THEN 'neonate'
        ELSE 'middle'
        END AS age_group
FROM last_admission_time
ORDER BY subject_id;