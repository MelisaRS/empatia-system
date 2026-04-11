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

SELECT * FROM paciente;
SELECT * FROM tutor;
SELECT * FROM paciente_tutor;

SELECT * FROM servicio;
SELECT * FROM personal_servicio;