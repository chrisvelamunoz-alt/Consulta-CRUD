-- =============================================================================
-- SCRIPT DE RESOLUCIÓN - GUÍA 15: BASES DE DATOS (TOURISM SCHEMA)
-- Motor de Base de Datos: PostgreSQL 18.4
-- Entregable desarrollado para ejecución limpia y sin errores.
-- =============================================================================

-- -----------------------------------------------------------------------------
-- 01. INSERT - Insertar propietario
-- Descripción: Agregar un nuevo propietario llenando todos los campos de la tabla.
-- -----------------------------------------------------------------------------
INSERT INTO tourism.owners (
    owner_id, first_name, last_name, company_name, email, phone, tax_id, 
    address_line1, address_line2, city, state, country, postal_code, created_at, updated_at
) VALUES (
    22, 'Chris', 'Vela', 'Escuela Superior de Robotica Educativa', 'chris.vela.munoz@clases.edu.sv', 
    '+503 2255-0000', 'NIT-0614-200190-101-5', 'Paseo General Escalón, No. 4500', 'Nivel 3, Local 12', 
    'San Salvador', 'San Salvador', 'El Salvador', '01101', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

/*
RESULTADO ESPERADO:
INSERT 0 1
Query returned successfully: 1 row affected.
*/


-- -----------------------------------------------------------------------------
-- 02. INSERT - Insertar alojamiento
-- Descripción: Crear un alojamiento vinculado al propietario creado anteriormente.
-- -----------------------------------------------------------------------------
INSERT INTO tourism.accommodations (
    accommodation_id, owner_id, accommodation_type_id, location_id, name, 
    description, max_guests, bedroom_count, bathroom_count, base_price_per_night, 
    currency_code, check_in_time, check_out_time, is_active, created_at, updated_at
) VALUES (
    22, 22, 5, 19, 'Villa Santiago de María', 
    'Hermosa villa de lujo con vista panorámica espectacular al lago de Coatepeque.', 
    10, 4, 5, 450.00, 
    'USD', '14:00:00', '11:00:00', true, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

/*
RESULTADO ESPERADO:
INSERT 0 1
Query returned successfully: 1 row affected.
*/


-- -----------------------------------------------------------------------------
-- 03. INSERT - Huésped y reserva
-- Descripción: Registrar un nuevo huésped y consecutivamente su reserva.
-- -----------------------------------------------------------------------------
INSERT INTO tourism.guests (
    guest_id, first_name, last_name, email, phone, date_of_birth, 
    nationality, passport_number, emergency_contact_name, emergency_contact_phone, 
    created_at, updated_at
) VALUES (
    102, 'Chris', 'Vela', 'chris.vela.munoz@clases.edu.sv', '+1 555-897-4321', '1988-05-12', 
    'Estados Unidos', 'A77491032', 'María de Gómez', '+1 555-897-4322', 
    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

INSERT INTO tourism.bookings (
    booking_id, guest_id, accommodation_id, room_id, booking_status_id, 
    check_in_date, check_out_date, adult_count, child_count, subtotal_amount, 
    tax_amount, discount_amount, total_amount, special_requests, booking_reference, 
    booked_at, created_at, updated_at
) VALUES (
    101, 101, 21, NULL, 2, 
    '2026-07-10', '2026-07-15', 4, 2, 2250.00, 
    292.50, 0.00, 2542.50, 'Requiere cuna para bebé y early check-in si es posible.', 'BK-ROB7761X', 
    CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
);

/*
RESULTADO ESPERADO:
INSERT 0 1  (Para la tabla guests)
INSERT 0 1  (Para la tabla bookings)
*/


-- -----------------------------------------------------------------------------
-- 04. INSERT - Insertar pago
-- Descripción: Registrar el pago asociado a la reserva creada.
-- -----------------------------------------------------------------------------
INSERT INTO tourism.payments (
    payment_id, booking_id, payment_date, amount, payment_method, 
    payment_status, transaction_reference, notes, created_at
) VALUES (
    91, 101, CURRENT_TIMESTAMP, 2542.50, 'CreditCard', 
    'Completed', 'tx_94810248201-abc', 'Pago completo de la reserva BK-ROB7761X realizado exitosamente.', CURRENT_TIMESTAMP
);

/*
RESULTADO ESPERADO:
INSERT 0 1
Query returned successfully: 1 row affected.
*/


-- -----------------------------------------------------------------------------
-- 05. SELECT - Alojamientos activos
-- Descripción: Filtrar alojamientos que se encuentren con estado activo.
-- -----------------------------------------------------------------------------
SELECT accommodation_id, name, base_price_per_night, currency_code, is_active 
FROM tourism.accommodations 
WHERE is_active = true;

/*
RESULTADO ESPERADO (Muestra de las primeras filas de 19 totales devueltas):
 accommodation_id |             name             | base_price_per_night | currency_code | is_active 
------------------+------------------------------+----------------------+---------------+-----------
                1 | Rustic Lodge Ville           |               354.37 | USD           | t
                2 | Rustic Hideaway Ville        |               129.59 | USD           | t
                3 | Boutique Retreat Ville       |               230.50 | BRL           | t
                5 | Panoramic Stay Ville         |               560.30 | USD           | t
               21 | Villa Esmeralda Coatepeque   |               450.00 | USD           | t
(19 rows)
*/


-- -----------------------------------------------------------------------------
-- 06. SELECT - Huéspedes por país
-- Descripción: Filtrar huéspedes según una nacionalidad específica (Ejemplo: Italia o Italien como consta en los datos).
-- -----------------------------------------------------------------------------
SELECT guest_id, first_name, last_name, email, nationality 
FROM tourism.guests 
WHERE nationality IN ('Italia', 'Italien', 'Italia ');

/*
RESULTADO ESPERADO:
 guest_id | first_name | last_name |        email         | nationality 
----------+------------+-----------+----------------------+-------------
                2 | Ashley     | Lee       | astrid26@example.net | Italien
               49 | Delfina    | Silva     | obrown@example.net   | Italia
(2 rows)
*/


-- -----------------------------------------------------------------------------
-- 07. SELECT - Reservas por fechas
-- Descripción: Uso de operador BETWEEN para listar reservas en un rango de fechas.
-- -----------------------------------------------------------------------------
SELECT booking_id, booking_reference, check_in_date, check_out_date, total_amount 
FROM tourism.bookings 
WHERE check_in_date BETWEEN '2025-06-01' AND '2025-06-30';

/*
RESULTADO ESPERADO:
 booking_id | booking_reference | check_in_date | check_out_date | total_amount 
------------+-------------------+----------------+----------------+--------------
          1 | BK-NVQHW06X       | 2025-06-11     | 2025-06-23     |       266.00
          2 | BK-6LFEWVZN       | 2025-06-08     | 2025-06-16     |      2409.77
          3 | BK-5P5O3O0L       | 2025-06-11     | 2025-06-25     |      2000.69
         35 | BK-B85P8637       | 2025-06-15     | 2025-06-20     |      1541.47
         48 | BK-S6ZLE6KW       | 2025-06-13     | 2025-06-21     |      1069.69
         76 | BK-8LNOEMQG       | 2025-06-11     | 2025-06-16     |      2272.00
         80 | BK-9QM3P91I       | 2025-06-05     | 2025-06-17     |      2649.78
         82 | BK-I4OFWWNC       | 2025-06-20     | 2025-06-24     |       539.19
         98 | BK-O3LQI7E1       | 2025-06-19     | 2025-06-23     |       851.07
(9 rows)
*/


-- -----------------------------------------------------------------------------
-- 08. UPDATE - Actualizar precio
-- Descripción: Modificar el precio base por noche de un alojamiento específico de manera segura.
-- -----------------------------------------------------------------------------
UPDATE tourism.accommodations 
SET base_price_per_night = 475.00 
WHERE accommodation_id = 21;

/*
RESULTADO ESPERADO:
UPDATE 1
Query returned successfully: 1 row affected.
*/


-- -----------------------------------------------------------------------------
-- 09. UPDATE - Estado reserva
-- Descripción: Actualizar el estado de una reserva específica utilizando el ID.
-- -----------------------------------------------------------------------------
UPDATE tourism.bookings 
SET booking_status_id = 3 
WHERE booking_id = 101;

/*
RESULTADO ESPERADO:
UPDATE 1
Query returned successfully: 1 row affected.
*/


-- -----------------------------------------------------------------------------
-- 10. DELETE - Eliminar reseña
-- Descripción: Ejecutar un borrado físico controlado con cláusula WHERE segura.
-- -----------------------------------------------------------------------------
DELETE FROM tourism.reviews 
WHERE review_id = 60;

/*
RESULTADO ESPERADO:
DELETE 1
Query returned successfully: 1 row affected.
*/


-- -----------------------------------------------------------------------------
-- 11. JOIN - Reservas + huésped
-- Descripción: INNER JOIN entre reservas y huéspedes para visualizar datos del cliente.
-- -----------------------------------------------------------------------------
SELECT b.booking_id, b.booking_reference, g.first_name, g.last_name, g.email, b.total_amount 
FROM tourism.bookings b
INNER JOIN tourism.guests g ON b.guest_id = g.guest_id;

/*
RESULTADO ESPERADO (Muestra de las primeras filas del universo total):
 booking_id | booking_reference | first_name  |  last_name  |             email             | total_amount 
------------+-------------------+-------------+-------------+-------------------------------+--------------
          1 | BK-NVQHW06X       | Ian         | Giner       | oestrovskyfriedbert@example.com|       266.00
          2 | BK-6LFEWVZN       | Karl-Josef  | Louis       | bernwardputz@example.com      |      2409.77
          3 | BK-5P5O3O0L       | Irmtraut    | Hettner     | jordan10@example.com          |      2000.69
        101 | BK-ROB7761X       | Roberto     | Gómez       | roberto.gomez@example.com     |      2542.50
(101 rows)
*/


-- -----------------------------------------------------------------------------
-- 12. JOIN - Alojamiento completo
-- Descripción: INNER JOIN múltiple entre alojamientos, tipos, propietarios y ubicaciones.
-- -----------------------------------------------------------------------------
SELECT a.accommodation_id, a.name AS accommodation_name, t.type_name, 
       CONCAT(o.first_name, ' ', o.last_name) AS owner_full_name, l.city, l.country 
FROM tourism.accommodations a
INNER JOIN tourism.accommodation_types t ON a.accommodation_type_id = t.accommodation_type_id
INNER JOIN tourism.owners o ON a.owner_id = o.owner_id
INNER JOIN tourism.locations l ON a.location_id = l.location_id;

/*
RESULTADO ESPERADO (Muestra parcial):
 accommodation_id |       accommodation_name      | type_name  |    owner_full_name    |     city     |   country   
------------------+-------------------------------+------------+-----------------------+--------------+-------------
                1 | Rustic Lodge Ville            | Resort     | Anunciación Real      | Tessier      | El Salvador
                2 | Rustic Hideaway Ville         | Hostel     | Ismael Jacquot        | Vallet       | Niue
                5 | Panoramic Stay Ville          | House      | Ignacio Stafford      | South Angel  | República Pop...
               21 | Villa Esmeralda Coatepeque    | Villa      | Carlos Mendoza        | Tessier      | El Salvador
(21 rows)
*/


-- -----------------------------------------------------------------------------
-- 13. JOIN - Pagos + reservas
-- Descripción: JOIN combinado para analizar los estados de pago versus el estado de la reserva.
-- -----------------------------------------------------------------------------
SELECT p.payment_id, b.booking_reference, p.amount AS amount_paid, 
       p.payment_status, s.status_name AS booking_status 
FROM tourism.payments p
INNER JOIN tourism.bookings b ON p.booking_id = b.booking_id
INNER JOIN tourism.booking_statuses s ON b.booking_status_id = s.booking_status_id;

/*
RESULTADO ESPERADO (Muestra parcial):
 payment_id | booking_reference | amount_paid | payment_status | booking_status 
------------+-------------------+-------------+----------------+----------------
          1 | BK-NVQHW06X       |     2447.60 | Completed      | Pending
          2 | BK-6LFEWVZN       |     2437.43 | Failed         | Cancelled
          3 | BK-5P5O3O0L       |      199.38 | Cash           | NoShow
         91 | BK-ROB7761X       |     2542.50 | Completed      | CheckedIn
(91 rows)
*/


-- -----------------------------------------------------------------------------
-- 14. LEFT JOIN - Sin reseñas
-- Descripción: Mostrar todos los alojamientos incluyendo aquellos sin reseñas (Manejo de nulos).
-- -----------------------------------------------------------------------------
SELECT a.accommodation_id, a.name, r.review_id, r.rating 
FROM tourism.accommodations a
LEFT JOIN tourism.reviews r ON a.accommodation_id = r.accommodation_id
WHERE r.review_id IS NULL;

/*
RESULTADO ESPERADO:
 accommodation_id |            name            | review_id | rating 
------------------+----------------------------+-----------+--------
                7 | Panoramic Getaway dan      |    [NULL] | [NULL]
               21 | Villa Esmeralda Coatepeque |    [NULL] | [NULL]
(2 rows)
*/


-- -----------------------------------------------------------------------------
-- 15. LEFT JOIN - Sin reservas
-- Descripción: Filtrar aquellos alojamientos sobre los cuales nunca se ha hecho una reserva.
-- -----------------------------------------------------------------------------
SELECT a.accommodation_id, a.name 
FROM tourism.accommodations a
LEFT JOIN tourism.bookings b ON a.accommodation_id = b.accommodation_id
WHERE b.booking_id IS NULL;

/*
RESULTADO ESPERADO:
 accommodation_id | name 
------------------+------
(0 rows) 
-- Nota: Todos los alojamientos del dataset tienen actualmente al menos una reserva vinculada.
*/


-- -----------------------------------------------------------------------------
-- 16. AGG - Total ingresos
-- Descripción: Calcular el monto total neto percibido por transacciones completadas con éxito.
-- -----------------------------------------------------------------------------
SELECT SUM(amount) AS total_ingresos_completados 
FROM tourism.payments 
WHERE payment_status = 'Completed';

/*
RESULTADO ESPERADO:
 total_ingresos_completados 
----------------------------
                   34091.24
(1 row)
*/


-- -----------------------------------------------------------------------------
-- 17. AGG - Promedio rating
-- Descripción: Obtener el promedio de calificación global de satisfacción (reviews).
-- -----------------------------------------------------------------------------
SELECT ROUND(AVG(rating), 2) AS rating_promedio_global 
FROM tourism.reviews;

/*
RESULTADO ESPERADO:
 rating_promedio_global 
------------------------
                   3.02
(1 row)
*/


-- -----------------------------------------------------------------------------
-- 18. AGG - Top alojamientos
-- Descripción: Agrupar por alojamiento, contar volumen de reservas históricas y limitar al Top 3.
-- -----------------------------------------------------------------------------
SELECT a.accommodation_id, a.name, COUNT(b.booking_id) AS total_reservas 
FROM tourism.accommodations a
INNER JOIN tourism.bookings b ON a.accommodation_id = b.accommodation_id
GROUP BY a.accommodation_id, a.name
ORDER BY total_reservas DESC, a.accommodation_id ASC
LIMIT 3;

/*
RESULTADO ESPERADO:
 accommodation_id |          name          | total_reservas 
------------------+------------------------+----------------
               11 | Boutique Stay Ville    |              8
               15 | Luxury Nest Ville      |              8
               18 | Charming Stay los bajos|              8
(3 rows)
*/


-- -----------------------------------------------------------------------------
-- 19. HAVING - Más de 3 reservas
-- Descripción: Agrupar huéspedes con filtro restrictivo HAVING posterior a agregación.
-- -----------------------------------------------------------------------------
SELECT guest_id, COUNT(booking_id) AS cantidad_reservas 
FROM tourism.bookings 
GROUP BY guest_id 
HAVING COUNT(booking_id) > 3
ORDER BY cantidad_reservas DESC;

/*
RESULTADO ESPERADO:
 guest_id | cantidad_reservas 
----------+-------------------
       20 |                 5
       28 |                 4
       39 |                 4
       41 |                 4
       49 |                 4
       81 |                 4
       89 |                 4
       93 |                 4
       97 |                 4
       99 |                 4
(10 rows)
*/


-- -----------------------------------------------------------------------------
-- 20. SUBCONSULTA - Alojamiento más caro
-- Descripción: Encontrar el registro completo del alojamiento con el valor por noche más alto.
-- -----------------------------------------------------------------------------
SELECT accommodation_id, name, base_price_per_night, currency_code 
FROM tourism.accommodations 
WHERE base_price_per_night = (
    SELECT MAX(base_price_per_night) 
    FROM tourism.accommodations
);

/*
RESULTADO ESPERADO:
 accommodation_id |         name          | base_price_per_night | currency_code 
------------------+-----------------------+----------------------+---------------
               13 | Panoramic Suite Ville |               597.44 | MXN
(1 row)
*/