const db = require("../config/database");

exports.dashboard = (req, res) => {

    const sql = `
        SELECT

        COUNT(*) AS total_consultas,

        SUM(valor) AS faturamento_bruto,

        SUM(
            CASE
            WHEN p.status = 'pago'
            THEN valor
            ELSE 0
            END
        ) AS recebido,

        SUM(
            CASE
            WHEN p.status = 'pendente'
            THEN valor
            ELSE 0
            END
        ) AS pendente,

        ROUND(
            SUM(
                CASE
                WHEN p.status='pendente'
                THEN 1
                ELSE 0
                END
            )
            /
            COUNT(*)
            *100
        ,2) AS percentual_inadimplencia

        FROM consultas c

        LEFT JOIN pagamentos p
        ON c.id = p.consulta_id
    `;

    db.query(sql, (err, results) => {

        if (err) {
            return res.status(500).json(err);
        }

        res.json(results[0]);

    });

};

exports.inadimplentes = (req, res) => {

    db.query(
        "SELECT * FROM vw_inadimplentes",
        (err, results) => {

            if (err) {
                return res.status(500).json(err);
            }

            res.json(results);

        }
    );

};