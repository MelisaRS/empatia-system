-- =====================================================
-- Development test queries
-- =====================================================

SELECT current_database();

SELECT 1;

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
--DROP TABLE personal;
--DROP TABLE solicitud_consulta;

SELECT * FROM paciente;
SELECT * FROM tutor;
SELECT * FROM paciente_tutor;

SELECT * FROM servicio;
SELECT * FROM personal_servicio;

SELECT * FROM agenda_recurrente;
SELECT * FROM agenda_recurrente_dia;

SELECT * FROM centro;
SELECT * FROM contenido_web;
SELECT * FROM red_social;
SELECT * FROM instalacion;
SELECT * FROM solicitud_consulta;
SELECT * FROM cita;
SELECT * FROM sesion;