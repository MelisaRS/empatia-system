-- =====================================================
-- Empatia System - Database Schema
-- Main relational structure of the system
-- =====================================================

-- Roles table
CREATE TABLE rol (
    id_rol SERIAL PRIMARY KEY,
    nombre_rol VARCHAR(50) NOT NULL UNIQUE
);

-- Users table
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    id_rol INT NOT NULL,
    correo VARCHAR(100) NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    estado VARCHAR(20) NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_usuario_rol
        FOREIGN KEY (id_rol)
        REFERENCES rol(id_rol)
);

-- Personnel table
CREATE TABLE personal (
    id_personal SERIAL PRIMARY KEY,
    id_usuario INT UNIQUE,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    fecha_nacimiento DATE,
    tipo_personal VARCHAR(50),
    tipo_vinculacion VARCHAR(50),
    estado_actual VARCHAR(20),
    genero VARCHAR(20),
    url_imagen_personal TEXT,

    CONSTRAINT fk_personal_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
);

-- Patients table
CREATE TABLE paciente (
    id_paciente SERIAL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    estado_actual VARCHAR(20),
    genero VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tutors table
CREATE TABLE tutor (
    id_tutor SERIAL PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(100),
    fecha_nacimiento DATE,
    genero VARCHAR(20)
);

-- Patient - Tutor relationship table
CREATE TABLE paciente_tutor (
    id_paciente INT NOT NULL,
    id_tutor INT NOT NULL,

    parentesco VARCHAR(50) NOT NULL,
    tutor_principal BOOLEAN DEFAULT FALSE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id_paciente, id_tutor),

    CONSTRAINT fk_pt_paciente
        FOREIGN KEY (id_paciente)
        REFERENCES paciente(id_paciente),

    CONSTRAINT fk_pt_tutor
        FOREIGN KEY (id_tutor)
        REFERENCES tutor(id_tutor)
);