const db = require("../config/database");

exports.registrar = (req, res) => {

    const consulta_id = req.params.consulta_id;

    const {
        metodo_pagamento
    } = req.body;

    const sql = `
        CALL sp_registrar_pagamento(
            ?, ?
        )
    `;

    db.query(
        sql,
        [
            consulta_id,
            metodo_pagamento
        ],
        (err) => {

            if (err) {
                return res.status(500).json(err);
            }

            res.json({
                mensagem: "Pagamento registrado"
            });

        }
    );

};