-- =====================================================
-- Empatia System - Initial Seed Data
-- Core records required for first system setup
-- =====================================================

-- Default system roles
INSERT INTO rol (nombre_rol) VALUES
('Administrador'),
('Terapeuta');

-- Main center information
INSERT INTO centro (
    nombre,
    direccion,
    horario,
    correo,
    telefono,
    link_ubicacion
) VALUES (
    'Empatía - Espacio Multidisciplinario',
    'Avenida del Ejército #5, Cochabamba, Bolivia',
    'Lunes a Viernes 08:30 - 12:30 / 14:30 - 19:00; Sábados 08:30 - 12:30',
    'empatiacbba@gmail.com',
    '+59162997760',
    'https://www.google.com/maps?q=-17.3794828,-66.1496833&z=17&hl=es'
);