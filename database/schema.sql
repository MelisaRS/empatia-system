-- =====================================================
-- Empatia System - Database Schema
-- Core authentication and personnel tables
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