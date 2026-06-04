-- =====================================================
-- Empatia System - Development Test Script
-- Quick checks, insertions, queries and cleanup
-- =====================================================

SELECT current_database();

SELECT 1;

-- Core tables
SELECT * FROM roles;
SELECT * FROM users;
SELECT * FROM staff;

-- Previous role tests
/*
INSERT INTO roles (role_name) VALUES
('Administrador'),
('Terapeuta Socio'),
('Terapeuta No Socio');

DELETE FROM roles
WHERE role_name IN ('Administrador', 'Terapeuta Socio', 'Terapeuta No Socio');
*/

-- Dangerous: removes table structure
-- DROP TABLE staff;
-- DROP TABLE consultation_request;
-- DROP TABLE social_media;

-- Patients and family relations
SELECT * FROM patient;
SELECT * FROM guardian;
SELECT * FROM patient_guardian;

-- Services and therapist assignments
SELECT * FROM service;
SELECT * FROM staff_service;

-- Recurring schedules
SELECT * FROM recurring_schedule;
SELECT * FROM recurring_schedule_day;

-- Center and website content
SELECT * FROM center;
SELECT * FROM website_content;
SELECT * FROM center_value;
SELECT * FROM social_media;
SELECT * FROM facility;
SELECT * FROM consultation_request;

-- Appointments and clinical sessions
SELECT * FROM appointment;
SELECT * FROM therapy_session;

-- =====================================================
-- TEST INSERTIONS
-- =====================================================

/*
-- Patient
INSERT INTO patient (
    first_name,
    last_name,
    birth_date,
    current_status,
    gender
) VALUES (
    'Juan',
    'Perez',
    '2018-05-10',
    'Activo',
    'Masculino'
);

-- Guardian
INSERT INTO guardian (
    first_name,
    last_name,
    phone,
    email
) VALUES (
    'Maria',
    'Perez',
    '+59170000001',
    'maria@test.com'
);

-- Patient - Guardian relation
INSERT INTO patient_guardian (
    patient_id,
    guardian_id,
    relationship,
    primary_guardian
) VALUES (
    1,
    1,
    'Madre',
    TRUE
);

-- Service
INSERT INTO service (
    service_name,
    description
) VALUES (
    'Psicología Infantil',
    'Atención psicológica para niños'
);

-- User
INSERT INTO users (
    role_id,
    email,
    password_hash,
    status
) VALUES (
    2,
    'terapeuta@test.com',
    'hash_demo',
    'Activo'
);

-- Staff
INSERT INTO staff (
    user_id,
    center_id,
    first_name,
    last_name,
    staff_type,
    affiliation_type,
    current_status
) VALUES (
    1,
    1,
    'Ana',
    'Lopez',
    'Terapeuta',
    'Interno',
    'Activo'
);

-- Staff - Service relation
INSERT INTO staff_service (
    staff_id,
    service_id
) VALUES (
    1,
    1
);

-- Appointment
INSERT INTO appointment (
    patient_id,
    staff_id,
    service_id,
    appointment_date,
    start_time,
    end_time,
    reason,
    status
) VALUES (
    1,
    1,
    1,
    '2026-04-20',
    '16:00',
    '17:00',
    'Evaluación inicial',
    'Confirmada'
);

-- Therapy session
INSERT INTO therapy_session (
    appointment_id,
    progress,
    observation
) VALUES (
    1,
    'Buena adaptación inicial',
    'Paciente colaboró en actividades'
);
*/

-- =====================================================
-- BASIC TEST QUERIES
-- =====================================================

/*
-- Patient history
SELECT 
    p.first_name,
    p.last_name,
    a.appointment_date,
    ts.progress,
    ts.observation
FROM patient p
JOIN appointment a 
    ON p.patient_id = a.patient_id
LEFT JOIN therapy_session ts 
    ON a.appointment_id = ts.appointment_id
WHERE p.patient_id = 1;

-- Appointments by therapist
SELECT
    st.first_name,
    st.last_name,
    a.appointment_date,
    a.start_time,
    a.status
FROM appointment a
JOIN staff st 
    ON a.staff_id = st.staff_id
WHERE st.staff_id = 1;

-- Therapist services
SELECT
    st.first_name,
    s.service_name
FROM staff st
JOIN staff_service ss 
    ON st.staff_id = ss.staff_id
JOIN service s 
    ON ss.service_id = s.service_id
WHERE st.staff_id = 1;
*/

-- =====================================================
-- CLEAN TEST DATA
-- Uncomment only when needed
-- Deletes data and resets IDs
-- =====================================================

/*
TRUNCATE TABLE
    therapy_session,
    appointment,
    staff_service,
    patient_guardian,
    recurring_schedule_day,
    recurring_schedule,
    staff,
    users,
    service,
    guardian,
    patient,
    website_content,
    center_value,
    social_media,
    facility,
    consultation_request
RESTART IDENTITY CASCADE;
*/

-- =====================================================
-- CONSTRAINT VALIDATION TESTS
-- Uncomment one test at a time
-- Expected result: INSERT should FAIL
-- =====================================================

/*
-- Invalid user status
INSERT INTO users (
    role_id,
    email,
    password_hash,
    status
) VALUES (
    2,
    'badstatus@test.com',
    'hash_demo',
    'Banana'
);
*/

/*
-- Invalid appointment time range
INSERT INTO appointment (
    patient_id,
    staff_id,
    service_id,
    appointment_date,
    start_time,
    end_time,
    reason,
    status
) VALUES (
    1,
    1,
    1,
    '2026-05-01',
    '10:00',
    '09:00',
    'Horario inválido',
    'Confirmada'
);
*/

/*
-- Invalid appointment status
INSERT INTO appointment (
    patient_id,
    staff_id,
    service_id,
    appointment_date,
    start_time,
    end_time,
    reason,
    status
) VALUES (
    1,
    1,
    1,
    '2026-05-01',
    '10:00',
    '11:00',
    'Estado inválido',
    'Banana'
);
*/

/*
-- Negative age
INSERT INTO consultation_request (
    center_id,
    applicant_name,
    cellphone,
    patient_name,
    patient_age,
    consultation_reason
) VALUES (
    1,
    'Maria',
    '70000000',
    'Juan',
    -5,
    'Consulta inicial'
);
*/

/*
-- Invalid recurring schedule dates
INSERT INTO recurring_schedule (
    patient_id,
    staff_id,
    service_id,
    start_time,
    end_time,
    start_date,
    end_date,
    status
) VALUES (
    1,
    1,
    1,
    '15:00',
    '16:00',
    '2026-06-10',
    '2026-06-01',
    'Activo'
);
*/

-- =====================================================
-- OPTIONAL CLEANUP AFTER CONSTRAINT TESTS
-- =====================================================

/*
TRUNCATE TABLE
    therapy_session,
    appointment,
    staff_service,
    patient_guardian,
    recurring_schedule_day,
    recurring_schedule,
    staff,
    users,
    service,
    guardian,
    patient,
    website_content,
    center_value,
    social_media,
    facility,
    consultation_request
RESTART IDENTITY CASCADE;
*/