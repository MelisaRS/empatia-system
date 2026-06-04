-- =====================================================
-- Empatia System - Database Schema
-- Main relational structure of the system
-- =====================================================

-- Roles table
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Users table
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    role_id INT NOT NULL,
	
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_users_roles
        FOREIGN KEY (role_id)
        REFERENCES roles(role_id)
);

-- Staff table
CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    user_id INT UNIQUE,
	
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    birth_date DATE,
    staff_type VARCHAR(50),
    affiliation_type VARCHAR(50),
	
    current_status VARCHAR(20),
    gender VARCHAR(20),
	
    staff_image_url TEXT,

    CONSTRAINT fk_staff_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

-- Patients table
CREATE TABLE patient (
    patient_id SERIAL PRIMARY KEY,
	
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
	
    birth_date DATE,
	
    current_status VARCHAR(20),
    gender VARCHAR(20),
	
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Guardians table
CREATE TABLE guardian (
    guardian_id SERIAL PRIMARY KEY,
	
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
	
    phone VARCHAR(20),
    email VARCHAR(100),
	
    birth_date DATE,
    gender VARCHAR(20)
);

-- Patient - Guardian relationship table
CREATE TABLE patient_guardian (
    patient_id INT NOT NULL,
    guardian_id INT NOT NULL,

    relationship VARCHAR(50) NOT NULL,
    primary_guardian BOOLEAN DEFAULT FALSE,
	
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (patient_id, guardian_id),

    CONSTRAINT fk_pg_patient
        FOREIGN KEY (patient_id)
        REFERENCES patient(patient_id),

    CONSTRAINT fk_pg_guardian
        FOREIGN KEY (guardian_id)
        REFERENCES guardian(guardian_id)
);

-- Services table
CREATE TABLE service (
    service_id SERIAL PRIMARY KEY,
	
    service_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
	
    service_image_url TEXT
);

--  Staff - Service relationship table
CREATE TABLE staff_service (
    staff_id INT NOT NULL,
    service_id INT NOT NULL,

    PRIMARY KEY (staff_id, service_id),

    CONSTRAINT fk_ss_staff
        FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id),

    CONSTRAINT fk_ss_service
        FOREIGN KEY (service_id)
        REFERENCES service(service_id)
);

-- Appointments table
CREATE TABLE appointment (
    appointment_id SERIAL PRIMARY KEY,

    patient_id INT NOT NULL,
    staff_id INT NOT NULL,
    service_id INT NOT NULL,

    appointment_date DATE NOT NULL,
	
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,

    reason TEXT,
	
    status VARCHAR(20) NOT NULL,

    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id)
        REFERENCES patient(patient_id),

    CONSTRAINT fk_appointment_staff
        FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id),

    CONSTRAINT fk_appointment_service
        FOREIGN KEY (service_id)
        REFERENCES service(service_id)
);

-- Therapy sessions table
CREATE TABLE therapy_session (
    therapy_session_id SERIAL PRIMARY KEY,

    appointment_id INT UNIQUE NOT NULL,

    progress TEXT,
    observation TEXT,
	
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_therapy_session_appointment
        FOREIGN KEY (appointment_id)
        REFERENCES appointment(appointment_id)
);

-- Recurring schedules table
CREATE TABLE recurring_schedule (
    recurring_schedule_id SERIAL PRIMARY KEY,

    patient_id INT NOT NULL,
    staff_id INT NOT NULL,
    service_id INT NOT NULL,

    start_time TIME NOT NULL,
    end_time TIME NOT NULL,

    start_date DATE NOT NULL,
    end_date DATE,

    status VARCHAR(20) NOT NULL,
	
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_rs_patient
        FOREIGN KEY (patient_id)
        REFERENCES patient(patient_id),

    CONSTRAINT fk_rs_staff
        FOREIGN KEY (staff_id)
        REFERENCES staff(staff_id),

    CONSTRAINT fk_rs_service
        FOREIGN KEY (service_id)
        REFERENCES service(service_id)
);

-- Recurring schedule days table
CREATE TABLE recurring_schedule_day (
    recurring_schedule_id INT NOT NULL,
	
    weekday VARCHAR(20) NOT NULL,

    PRIMARY KEY (recurring_schedule_id, weekday),

    CONSTRAINT fk_rsd_schedule
        FOREIGN KEY (recurring_schedule_id)
        REFERENCES recurring_schedule(recurring_schedule_id)
);

-- Add recurring schedule relation to appointments
ALTER TABLE appointment
ADD COLUMN recurring_schedule_id INT;

ALTER TABLE appointment
ADD CONSTRAINT fk_appointment_recurring_schedule
FOREIGN KEY (recurring_schedule_id)
REFERENCES recurring_schedule(recurring_schedule_id);

-- Centers table
CREATE TABLE center (
    center_id SERIAL PRIMARY KEY,
	
    center_name VARCHAR(150) NOT NULL,
	
    address TEXT,
    schedule VARCHAR(150),
	
    email VARCHAR(100),
    phone VARCHAR(20),
	
    location_link TEXT
);

-- Add center relation to staff
ALTER TABLE staff
ADD COLUMN center_id INT;

ALTER TABLE staff
ADD CONSTRAINT fk_staff_center
FOREIGN KEY (center_id)
REFERENCES center(center_id);

-- Website content table
CREATE TABLE website_content (
    website_content_id SERIAL PRIMARY KEY,
	
    center_id INT UNIQUE NOT NULL,

    about_us TEXT,
    about_empathy TEXT,
	
    mission TEXT,
    vision TEXT,

    CONSTRAINT fk_wc_center
        FOREIGN KEY (center_id)
        REFERENCES center(center_id)
);

-- Center values table
CREATE TABLE center_value (
    center_value_id SERIAL PRIMARY KEY,
	
    center_id INT NOT NULL,

    title VARCHAR(100) NOT NULL,
    description TEXT,
	
    visual_order INT,

    CONSTRAINT fk_center_value_center
        FOREIGN KEY (center_id)
        REFERENCES center(center_id)
);

-- Social media table
CREATE TABLE social_media (
    social_media_id SERIAL PRIMARY KEY,
	
    center_id INT NOT NULL,

    profile_name VARCHAR(100) NOT NULL,
    platform VARCHAR(50),
	
    social_media_link TEXT NOT NULL,

    CONSTRAINT fk_social_media_center
        FOREIGN KEY (center_id)
        REFERENCES center(center_id)
);

-- Facilities table
CREATE TABLE facility (
    facility_id SERIAL PRIMARY KEY,
	
    center_id INT NOT NULL,

    title VARCHAR(100) NOT NULL,

    description TEXT,
	
    facility_image_url TEXT,

    CONSTRAINT fk_facility_center
        FOREIGN KEY (center_id)
        REFERENCES center(center_id)
);

-- Consultation requests table
CREATE TABLE consultation_request (
    consultation_request_id SERIAL PRIMARY KEY,
	
    center_id INT NOT NULL,

    applicant_name VARCHAR(100) NOT NULL,	
    cellphone VARCHAR(20),
    
	patient_name VARCHAR(100),
    patient_age INT,
    
	consultation_reason TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_consultation_request_center
        FOREIGN KEY (center_id)
        REFERENCES center(center_id)
);