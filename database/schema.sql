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

-- Services table
CREATE TABLE servicio (
    id_servicio SERIAL PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    url_imagen_servicio TEXT
);

-- Personnel - Service relationship table
CREATE TABLE personal_servicio (
    id_personal INT NOT NULL,
    id_servicio INT NOT NULL,

    PRIMARY KEY (id_personal, id_servicio),

    CONSTRAINT fk_ps_personal
        FOREIGN KEY (id_personal)
        REFERENCES personal(id_personal),

    CONSTRAINT fk_ps_servicio
        FOREIGN KEY (id_servicio)
        REFERENCES servicio(id_servicio)
);

-- Appointments table
CREATE TABLE cita (
    id_cita SERIAL PRIMARY KEY,

    id_paciente INT NOT NULL,
    id_personal INT NOT NULL,
    id_servicio INT NOT NULL,

    fecha DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,

    motivo TEXT,
    estado VARCHAR(20) NOT NULL,

    CONSTRAINT fk_cita_paciente
        FOREIGN KEY (id_paciente)
        REFERENCES paciente(id_paciente),

    CONSTRAINT fk_cita_personal
        FOREIGN KEY (id_personal)
        REFERENCES personal(id_personal),

    CONSTRAINT fk_cita_servicio
        FOREIGN KEY (id_servicio)
        REFERENCES servicio(id_servicio)
);

-- Sessions table
CREATE TABLE sesion (
    id_sesion SERIAL PRIMARY KEY,

    id_cita INT UNIQUE NOT NULL,

    progreso TEXT,
    observacion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_sesion_cita
        FOREIGN KEY (id_cita)
        REFERENCES cita(id_cita)
);