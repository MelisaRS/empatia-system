-- =====================================================
-- Empatia System - Additional Constraints
-- Data validation and business rules
-- =====================================================



-- =====================================================
-- STATUS VALIDATIONS
-- =====================================================

ALTER TABLE usuario
ADD CONSTRAINT chk_usuario_estado
CHECK (estado IN ('Activo', 'Inactivo'));

ALTER TABLE personal
ADD CONSTRAINT chk_personal_estado
CHECK (estado_actual IN ('Activo', 'Inactivo'));

ALTER TABLE paciente
ADD CONSTRAINT chk_paciente_estado
CHECK (estado_actual IN ('Activo', 'Inactivo'));

ALTER TABLE cita
ADD CONSTRAINT chk_cita_estado
CHECK (
    estado IN (
        'Pendiente',
        'Confirmada',
        'Cancelada',
        'Asistida',
        'No asistio'
    )
);

ALTER TABLE agenda_recurrente
ADD CONSTRAINT chk_agenda_estado
CHECK (
    estado IN (
        'Activo',
        'Pausado',
        'Finalizado',
        'Cancelado'
    )
);



-- =====================================================
-- TIME VALIDATIONS
-- =====================================================

ALTER TABLE cita
ADD CONSTRAINT chk_cita_horario
CHECK (hora_fin > hora_inicio);

ALTER TABLE agenda_recurrente
ADD CONSTRAINT chk_agenda_horario
CHECK (hora_fin > hora_inicio);



-- =====================================================
-- NUMERIC VALIDATIONS
-- =====================================================

ALTER TABLE solicitud_consulta
ADD CONSTRAINT chk_solicitud_edad
CHECK (edad_paciente IS NULL OR edad_paciente >= 0);

ALTER TABLE valor_centro
ADD CONSTRAINT chk_valor_orden
CHECK (orden_visual IS NULL OR orden_visual > 0);



-- =====================================================
-- ENUM-LIKE TEXT VALIDATIONS
-- =====================================================

ALTER TABLE agenda_recurrente_dia
ADD CONSTRAINT chk_agenda_dia
CHECK (
    dia_semana IN (
        'Lunes',
        'Martes',
        'Miércoles',
        'Jueves',
        'Viernes',
        'Sábado',
        'Domingo'
    )
);



-- =====================================================
-- DATE VALIDATIONS
-- =====================================================

ALTER TABLE agenda_recurrente
ADD CONSTRAINT chk_agenda_fechas
CHECK (
    fecha_fin IS NULL
    OR fecha_fin >= fecha_inicio
);