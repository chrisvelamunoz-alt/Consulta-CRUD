# 📘 README: Fundamentos de SQL para Backend Profesional

## 🚀 Introducción

**SQL (Structured Query Language)** es el lenguaje universal para trabajar con bases de datos relacionales. Es una herramienta esencial para cualquier desarrollador backend, sin importar el lenguaje o framework que utilice, como:

- Node.js
- Python
- Golang
- Java
- PHP

Toda aplicación que maneje datos necesita interactuar con una base de datos, y ahí es donde SQL juega un papel fundamental.

---

## 🧠 ¿Por qué SQL es tan importante?

- Permite **leer, insertar, actualizar y eliminar datos**
- Es el estándar en sistemas de bases de datos como PostgreSQL, MySQL, SQL Server y Oracle
- Es clave para construir APIs, sistemas web, dashboards y aplicaciones empresariales
- Es independiente del lenguaje de programación

---

## 🏗️ Bases de Datos Relacionales

Una base de datos relacional organiza la información en **tablas** que están conectadas entre sí mediante relaciones.

Ejemplo:

| usuarios | pedidos |
|----------|--------|
| id       | id     |
| nombre   | usuario_id |
| email    | total  |

---

## 🔑 CRUD: La Base de Todo

CRUD representa las operaciones fundamentales:

| Operación | SQL        | Descripción                  |
|----------|------------|------------------------------|
| Create   | `INSERT`   | Insertar datos               |
| Read     | `SELECT`   | Consultar datos              |
| Update   | `UPDATE`   | Modificar datos existentes   |
| Delete   | `DELETE`   | Eliminar datos               |

### 📌 Ejemplos

#### 🔹 INSERT (Create)
```sql
INSERT INTO usuarios (nombre, email)
VALUES ('Juan Pérez', 'juan@example.com');
