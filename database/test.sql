-- =====================================================
-- Empatia System - Development Test Script
-- Quick checks, insertions, queries and cleanup
-- =====================================================

SELECT current_database();

SELECT 1;

-- Core tables
SELECT * FROM rol;
SELECT * FROM usuario;
SELECT * FROM personal;

-- Previous role tests
/*
INSERT INTO rol (nombre_rol) VALUES
('Administrador'),
('Terapeuta Socio'),
('Terapeuta No Socio');

DELETE FROM rol
WHERE nombre_rol IN ('Administrador', 'Terapeuta Socio', 'Terapeuta No Socio');
*/

-- Dangerous: removes table structure
-- DROP TABLE personal;
-- DROP TABLE solicitud_consulta;

-- Patients and family relations
SELECT * FROM paciente;
SELECT * FROM tutor;
SELECT * FROM paciente_tutor;

-- Services and therapist assignments
SELECT * FROM servicio;
SELECT * FROM personal_servicio;

-- Recurring schedules
SELECT * FROM agenda_recurrente;
SELECT * FROM agenda_recurrente_dia;

-- Center and website content
SELECT * FROM centro;
SELECT * FROM contenido_web;
SELECT * FROM red_social;
SELECT * FROM instalacion;
SELECT * FROM solicitud_consulta;

-- Appointments and clinical sessions
SELECT * FROM cita;
SELECT * FROM sesion;

-- =====================================================
-- TEST INSERTIONS
-- =====================================================

/*
-- Patient
INSERT INTO paciente (
    nombres,
    apellidos,
    fecha_nacimiento,
    estado_actual,
    genero
) VALUES (
    'Juan',
    'Perez',
    '2018-05-10',
    'Activo',
    'Masculino'
);

-- Tutor
INSERT INTO tutor (
    nombres,
    apellidos,
    telefono,
    correo
) VALUES (
    'Maria',
    'Perez',
    '+59170000001',
    'maria@test.com'
);

-- Patient - Tutor relation
INSERT INTO paciente_tutor (
    id_paciente,
    id_tutor,
    parentesco,
    tutor_principal
) VALUES (
    1,
    1,
    'Madre',
    TRUE
);

-- Service
INSERT INTO servicio (
    nombre_servicio,
    descripcion
) VALUES (
    'Psicología Infantil',
    'Atención psicológica para niños'
);

-- User
INSERT INTO usuario (
    id_rol,
    correo,
    password_hash,
    estado
) VALUES (
    2,
    'terapeuta@test.com',
    'hash_demo',
    'Activo'
);

-- Personnel
INSERT INTO personal (
    id_usuario,
    id_centro,
    nombres,
    apellidos,
    tipo_personal,
    tipo_vinculacion,
    estado_actual
) VALUES (
    1,
    1,
    'Ana',
    'Lopez',
    'Terapeuta',
    'Interno',
    'Activo'
);

-- Personnel - Service relation
INSERT INTO personal_servicio (
    id_personal,
    id_servicio
) VALUES (
    1,
    1
);

-- Appointment
INSERT INTO cita (
    id_paciente,
    id_personal,
    id_servicio,
    fecha,
    hora_inicio,
    hora_fin,
    motivo,
    estado
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

-- Session
INSERT INTO sesion (
    id_cita,
    progreso,
    observacion
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
    p.nombres,
    p.apellidos,
    c.fecha,
    s.progreso,
    s.observacion
FROM paciente p
JOIN cita c ON p.id_paciente = c.id_paciente
LEFT JOIN sesion s ON c.id_cita = s.id_cita
WHERE p.id_paciente = 1;

-- Appointments by therapist
SELECT
    per.nombres,
    per.apellidos,
    c.fecha,
    c.hora_inicio,
    c.estado
FROM cita c
JOIN personal per ON c.id_personal = per.id_personal
WHERE per.id_personal = 1;

-- Therapist services
SELECT
    per.nombres,
    s.nombre_servicio
FROM personal per
JOIN personal_servicio ps ON per.id_personal = ps.id_personal
JOIN servicio s ON ps.id_servicio = s.id_servicio
WHERE per.id_personal = 1;
*/

-- =====================================================
-- CLEAN TEST DATA
-- Uncomment only when needed
-- Deletes data and resets IDs
-- =====================================================

/*
TRUNCATE TABLE
    sesion,
    cita,
    personal_servicio,
    paciente_tutor,
    agenda_recurrente_dia,
    agenda_recurrente,
    personal,
    usuario,
    servicio,
    tutor,
    paciente,
    contenido_web,
    valor_centro,
    red_social,
    instalacion,
    solicitud_consulta
RESTART IDENTITY CASCADE;
*/

-- =====================================================
-- CONSTRAINT VALIDATION TESTS
-- Uncomment one test at a time
-- Expected result: INSERT should FAIL
-- =====================================================

/*
-- Invalid user status
INSERT INTO usuario (
    id_rol,
    correo,
    password_hash,
    estado
) VALUES (
    2,
    'badstatus@test.com',
    'hash_demo',
    'Banana'
);
*/

/*
-- Invalid appointment time range
INSERT INTO cita (
    id_paciente,
    id_personal,
    id_servicio,
    fecha,
    hora_inicio,
    hora_fin,
    motivo,
    estado
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
INSERT INTO cita (
    id_paciente,
    id_personal,
    id_servicio,
    fecha,
    hora_inicio,
    hora_fin,
    motivo,
    estado
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
INSERT INTO solicitud_consulta (
    id_centro,
    nombre_solicitante,
    celular,
    nombre_paciente,
    edad_paciente,
    motivo_consulta
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
INSERT INTO agenda_recurrente (
    id_paciente,
    id_personal,
    id_servicio,
    hora_inicio,
    hora_fin,
    fecha_inicio,
    fecha_fin,
    estado
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
    sesion,
    cita,
    personal_servicio,
    paciente_tutor,
    agenda_recurrente_dia,
    agenda_recurrente,
    personal,
    usuario,
    servicio,
    tutor,
    paciente,
    contenido_web,
    valor_centro,
    red_social,
    instalacion,
    solicitud_consulta
RESTART IDENTITY CASCADE;
*/