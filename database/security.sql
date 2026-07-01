USE petvida;

-- =========================
-- RECEPCIONISTA
-- =========================

CREATE USER IF NOT EXISTS 'recepcionista'@'localhost'
IDENTIFIED BY '123456';

GRANT SELECT, INSERT
ON petvida.tutores
TO 'recepcionista'@'localhost';

GRANT SELECT, INSERT
ON petvida.animais
TO 'recepcionista'@'localhost';

GRANT SELECT, INSERT
ON petvida.consultas
TO 'recepcionista'@'localhost';

GRANT SELECT, INSERT
ON petvida.especies
TO 'recepcionista'@'localhost';

GRANT EXECUTE
ON PROCEDURE petvida.sp_agendar_consulta
TO 'recepcionista'@'localhost';

GRANT EXECUTE
ON PROCEDURE petvida.sp_cadastrar_animal
TO 'recepcionista'@'localhost';


-- =========================
-- VETERINARIO
-- =========================

CREATE USER IF NOT EXISTS 'veterinario'@'localhost'
IDENTIFIED BY '123456';

GRANT SELECT
ON petvida.*
TO 'veterinario'@'localhost';

GRANT UPDATE(status, diagnostico)
ON petvida.consultas
TO 'veterinario'@'localhost';

GRANT EXECUTE
ON PROCEDURE petvida.sp_concluir_consulta
TO 'veterinario'@'localhost';


-- =========================
-- GERENTE
-- =========================

CREATE USER IF NOT EXISTS 'gerente'@'localhost'
IDENTIFIED BY '123456';

GRANT SELECT, INSERT, UPDATE
ON petvida.*
TO 'gerente'@'localhost';

GRANT DELETE
ON petvida.consultas
TO 'gerente'@'localhost';

GRANT EXECUTE
ON PROCEDURE petvida.sp_agendar_consulta
TO 'gerente'@'localhost';

GRANT EXECUTE
ON PROCEDURE petvida.sp_concluir_consulta
TO 'gerente'@'localhost';

GRANT EXECUTE
ON PROCEDURE petvida.sp_registrar_pagamento
TO 'gerente'@'localhost';

GRANT EXECUTE
ON PROCEDURE petvida.sp_cancelar_consulta
TO 'gerente'@'localhost';

GRANT EXECUTE
ON PROCEDURE petvida.sp_cadastrar_animal
TO 'gerente'@'localhost';


-- =========================
-- ADMIN
-- =========================

CREATE USER IF NOT EXISTS 'admin'@'localhost'
IDENTIFIED BY '123456';

GRANT ALL PRIVILEGES
ON petvida.*
TO 'admin'@'localhost';


-- =========================
-- REVOKE
-- =========================

REVOKE INSERT
ON petvida.consultas
FROM 'recepcionista'@'localhost';

FLUSH PRIVILEGES;