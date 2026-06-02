USE petvida;

DELIMITER $$

-- =========================================
-- PROCEDURE 1
-- AGENDAR CONSULTA
-- =========================================

CREATE PROCEDURE sp_agendar_consulta(
    IN p_animal_id INT,
    IN p_vet_id INT,
    IN p_data_hora DATETIME,
    IN p_valor DECIMAL(10,2)
)
BEGIN

    DECLARE v_count INT;

    -- valida animal
    SELECT COUNT(*)
    INTO v_count
    FROM animais
    WHERE id = p_animal_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Animal nao encontrado';
    END IF;

    -- valida veterinario
    SELECT COUNT(*)
    INTO v_count
    FROM veterinarios
    WHERE id = p_vet_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Veterinario nao encontrado';
    END IF;

    -- valida horario
    SELECT COUNT(*)
    INTO v_count
    FROM consultas
    WHERE veterinario_id = p_vet_id
    AND data_hora = p_data_hora;

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Horario indisponivel';
    END IF;

    START TRANSACTION;

    INSERT INTO consultas (
        animal_id,
        veterinario_id,
        data_hora,
        diagnostico,
        valor,
        status
    )
    VALUES (
        p_animal_id,
        p_vet_id,
        p_data_hora,
        '',
        p_valor,
        'agendada'
    );

    INSERT INTO pagamentos (
        consulta_id,
        valor_pago,
        forma_pagamento,
        data_pagamento,
        status
    )
    VALUES (
        LAST_INSERT_ID(),
        p_valor,
        'pix',
        CURDATE(),
        'pendente'
    );

    COMMIT;

END $$

-- =========================================
-- PROCEDURE 2
-- CONCLUIR CONSULTA
-- =========================================

CREATE PROCEDURE sp_concluir_consulta(
    IN p_consulta_id INT,
    IN p_diagnostico TEXT
)
BEGIN

    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM consultas
    WHERE id = p_consulta_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Consulta nao encontrada';
    END IF;

    UPDATE consultas
    SET
        status = 'concluida',
        diagnostico = p_diagnostico
    WHERE id = p_consulta_id;

END $$

-- =========================================
-- PROCEDURE 3
-- REGISTRAR PAGAMENTO
-- =========================================

CREATE PROCEDURE sp_registrar_pagamento(
    IN p_consulta_id INT,
    IN p_forma VARCHAR(20)
)
BEGIN

    DECLARE v_count INT;

    SELECT COUNT(*)
    INTO v_count
    FROM pagamentos
    WHERE consulta_id = p_consulta_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento nao encontrado';
    END IF;

    SELECT COUNT(*)
    INTO v_count
    FROM pagamentos
    WHERE consulta_id = p_consulta_id
    AND status = 'pago';

    IF v_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Pagamento ja realizado';
    END IF;

    UPDATE pagamentos
    SET
        status = 'pago',
        forma_pagamento = p_forma,
        data_pagamento = CURDATE()
    WHERE consulta_id = p_consulta_id;

END $$

-- =========================================
-- PROCEDURE 4
-- CANCELAR CONSULTA
-- =========================================

CREATE PROCEDURE sp_cancelar_consulta(
    IN p_consulta_id INT
)
BEGIN

    START TRANSACTION;

    UPDATE consultas
    SET status = 'cancelada'
    WHERE id = p_consulta_id;

    UPDATE pagamentos
    SET status = 'cancelado'
    WHERE consulta_id = p_consulta_id;

    COMMIT;

END $$

-- =========================================
-- PROCEDURE 5
-- CADASTRAR ANIMAL
-- =========================================

CREATE PROCEDURE sp_cadastrar_animal(
    IN p_nome VARCHAR(100),
    IN p_especie_id INT,
    IN p_raca VARCHAR(100),
    IN p_nascimento DATE,
    IN p_tutor_id INT
)
BEGIN

    DECLARE v_count INT;

    -- valida especie
    SELECT COUNT(*)
    INTO v_count
    FROM especies
    WHERE id = p_especie_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Especie nao encontrada';
    END IF;

    -- valida tutor
    SELECT COUNT(*)
    INTO v_count
    FROM tutores
    WHERE id = p_tutor_id;

    IF v_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tutor nao encontrado';
    END IF;

    INSERT INTO animais (
        nome,
        especie_id,
        raca,
        data_nascimento,
        tutor_id
    )
    VALUES (
        p_nome,
        p_especie_id,
        p_raca,
        p_nascimento,
        p_tutor_id
    );

    SELECT LAST_INSERT_ID() AS novo_animal_id;

END $$

DELIMITER ;