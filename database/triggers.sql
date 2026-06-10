USE petvida;

CREATE TABLE IF NOT EXISTS log_auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tabela_afetada VARCHAR(50),
    acao VARCHAR(50),
    registro_id INT,
    detalhes TEXT,
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

-- a) INSERT CONSULTA
DROP TRIGGER IF EXISTS trg_after_insert_consulta $$
CREATE TRIGGER trg_after_insert_consulta
AFTER INSERT ON consultas
FOR EACH ROW
BEGIN

    INSERT INTO log_auditoria
    (
        tabela_afetada,
        acao,
        registro_id,
        detalhes
    )
    VALUES
    (
        'consultas',
        'INSERT',
        NEW.id,
        CONCAT(
            'Consulta criada para animal ',
            NEW.animal_id
        )
    );

END $$

-- b) UPDATE STATUS CONSULTA
DROP TRIGGER IF EXISTS trg_after_update_consulta_status $$
CREATE TRIGGER trg_after_update_consulta_status
AFTER UPDATE ON consultas
FOR EACH ROW
BEGIN

    IF OLD.status <> NEW.status THEN

        INSERT INTO log_auditoria
        (
            tabela_afetada,
            acao,
            registro_id,
            detalhes
        )
        VALUES
        (
            'consultas',
            'UPDATE',
            NEW.id,
            CONCAT(
                'Status alterado de ',
                OLD.status,
                ' para ',
                NEW.status
            )
        );

    END IF;

END $$

-- c) BLOQUEAR DELETE CONSULTA PAGA
DROP TRIGGER IF EXISTS trg_before_delete_consulta $$
CREATE TRIGGER trg_before_delete_consulta
BEFORE DELETE ON consultas
FOR EACH ROW
BEGIN

    DECLARE status_pagamento VARCHAR(20);

    SELECT status
    INTO status_pagamento
    FROM pagamentos
    WHERE consulta_id = OLD.id
    LIMIT 1;

    IF status_pagamento = 'pago' THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Nao e permitido excluir consulta com pagamento pago';

    END IF;

END $$

-- d) INSERT ANIMAL
DROP TRIGGER IF EXISTS trg_after_insert_animal $$
CREATE TRIGGER trg_after_insert_animal
AFTER INSERT ON animais
FOR EACH ROW
BEGIN

    INSERT INTO log_auditoria
    (
        tabela_afetada,
        acao,
        registro_id,
        detalhes
    )
    VALUES
    (
        'animais',
        'INSERT',
        NEW.id,
        CONCAT(
            'Animal cadastrado: ',
            NEW.nome
        )
    );

END $$

-- e) PAGAMENTO AUTOMATICO
DROP TRIGGER IF EXISTS trg_before_update_pagamento $$
CREATE TRIGGER trg_before_update_pagamento
BEFORE UPDATE ON pagamentos
FOR EACH ROW
BEGIN

    IF
        OLD.status <> 'pago'
        AND
        NEW.status = 'pago'
    THEN

        SET NEW.data_pagamento =
        CURDATE();

    END IF;

END $$

DELIMITER ;