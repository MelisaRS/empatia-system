-- =====================================================
-- Empatia System - Additional Constraints
-- Data validation and business rules
-- =====================================================



-- =====================================================
-- STATUS VALIDATIONS
-- =====================================================

ALTER TABLE users
ADD CONSTRAINT chk_users_status
CHECK (status IN ('Activo', 'Inactivo'));

ALTER TABLE staff
ADD CONSTRAINT chk_staff_status
CHECK (current_status IN ('Activo', 'Inactivo'));

ALTER TABLE patient
ADD CONSTRAINT chk_patient_status
CHECK (current_status IN ('Activo', 'Inactivo'));

ALTER TABLE appointment
ADD CONSTRAINT chk_appointment_status
CHECK (
    status IN (
        'Pendiente',
        'Confirmada',
        'Cancelada',
        'Asistida',
        'No asistio'
    )
);

ALTER TABLE recurring_schedule
ADD CONSTRAINT chk_recurring_schedule_status
CHECK (
    status IN (
        'Activo',
        'Pausado',
        'Finalizado',
        'Cancelado'
    )
);



-- =====================================================
-- TIME VALIDATIONS
-- =====================================================

ALTER TABLE appointment
ADD CONSTRAINT chk_appointment_time
CHECK (end_time > start_time);

ALTER TABLE recurring_schedule
ADD CONSTRAINT chk_recurring_schedule_time
CHECK (end_time > start_time);



-- =====================================================
-- NUMERIC VALIDATIONS
-- =====================================================

ALTER TABLE consultation_request
ADD CONSTRAINT chk_consultation_request_age
CHECK (patient_age IS NULL OR patient_age >= 0);

ALTER TABLE center_value
ADD CONSTRAINT chk_center_value_order
CHECK (visual_order IS NULL OR visual_order > 0);



-- =====================================================
-- ENUM-LIKE TEXT VALIDATIONS
-- =====================================================

ALTER TABLE recurring_schedule_day
ADD CONSTRAINT chk_recurring_schedule_weekday
CHECK (
    weekday IN (
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

ALTER TABLE recurring_schedule
ADD CONSTRAINT chk_recurring_schedule_dates
CHECK (
    end_date IS NULL
    OR end_date >= start_date
);