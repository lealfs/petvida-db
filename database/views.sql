USE petvida;

-- =========================================
-- VIEW 1
-- CONSULTAS COMPLETAS
-- =========================================

CREATE VIEW vw_consultas_completas AS
SELECT
    c.data_hora,
    c.status AS status_consulta,
    c.diagnostico,
    c.valor,

    a.nome AS animal,
    e.nome AS especie,

    t.nome AS tutor,
    t.telefone,

    v.nome AS veterinario,
    v.especialidade,

    p.forma_pagamento,
    p.status AS status_pagamento

FROM consultas c

INNER JOIN animais a
    ON c.animal_id = a.id

INNER JOIN especies e
    ON a.especie_id = e.id

INNER JOIN tutores t
    ON a.tutor_id = t.id

INNER JOIN veterinarios v
    ON c.veterinario_id = v.id

LEFT JOIN pagamentos p
    ON c.id = p.consulta_id;

-- =========================================
-- VIEW 2
-- AGENDA DE HOJE
-- =========================================

CREATE VIEW vw_agenda_hoje AS
SELECT *
FROM vw_consultas_completas
WHERE DATE(data_hora) = CURDATE()
ORDER BY data_hora;

-- =========================================
-- VIEW 3
-- FATURAMENTO MENSAL
-- =========================================

CREATE VIEW vw_faturamento_mensal AS
SELECT
    YEAR(c.data_hora) AS ano,
    MONTH(c.data_hora) AS mes,

    v.nome AS veterinario,

    COUNT(c.id) AS total_consultas,

    SUM(c.valor) AS faturamento_total

FROM consultas c

INNER JOIN veterinarios v
    ON c.veterinario_id = v.id

GROUP BY
    YEAR(c.data_hora),
    MONTH(c.data_hora),
    v.nome;

-- =========================================
-- VIEW 4
-- ANIMAIS DETALHADOS
-- =========================================

CREATE VIEW vw_animais_detalhados AS
SELECT
    a.nome AS animal,

    e.nome AS especie,

    t.nome AS tutor,

    COUNT(c.id) AS total_consultas

FROM animais a

INNER JOIN especies e
    ON a.especie_id = e.id

INNER JOIN tutores t
    ON a.tutor_id = t.id

LEFT JOIN consultas c
    ON a.id = c.animal_id

GROUP BY
    a.nome,
    e.nome,
    t.nome;

-- =========================================
-- VIEW 5
-- INADIMPLENTES
-- =========================================

CREATE VIEW vw_inadimplentes AS
SELECT
    c.id AS consulta_id,

    a.nome AS animal,

    t.nome AS tutor,

    c.valor,

    p.status AS status_pagamento

FROM consultas c

INNER JOIN animais a
    ON c.animal_id = a.id

INNER JOIN tutores t
    ON a.tutor_id = t.id

LEFT JOIN pagamentos p
    ON c.id = p.consulta_id

WHERE
    c.status = 'concluida'
    AND (
        p.status = 'pendente'
        OR p.id IS NULL
    );