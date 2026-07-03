const db = require("../config/database");

exports.listarPorData = (req, res) => {

    const data = req.params.data;

    const sql = `
        SELECT *
        FROM vw_consultas_completas
        WHERE DATE(data_hora) = ?
    `;

    db.query(
        sql,
        [data],
        (err, results) => {

            if (err) {
                return res.status(500).json(err);
            }

            res.json(results);

        }
    );

};
exports.agendar = (req, res) => {

    const {
        animal_id,
        veterinario_id,
        data_hora,
        valor
    } = req.body;

    const sql = `
        CALL sp_agendar_consulta(
            ?, ?, ?, ?
        )
    `;

    db.query(
        sql,
        [
            animal_id,
            veterinario_id,
            data_hora,
            valor
        ],
        (err) => {

            if (err) {
                return res.status(500).json(err);
            }

            res.json({
                mensagem: "Consulta agendada com sucesso"
            });

        }
    );

};
exports.concluir = (req, res) => {

    const id = req.params.id;

    const {
        diagnostico
    } = req.body;

    const sql = `
        CALL sp_concluir_consulta(
            ?, ?
        )
    `;

    db.query(
        sql,
        [
            id,
            diagnostico
        ],
        (err) => {

            if (err) {
                return res.status(500).json(err);
            }

            res.json({
                mensagem: "Consulta concluída"
            });

        }
    );

};