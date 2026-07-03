const db = require("../config/database");

exports.listar = (req, res) => {

    db.query(
        "SELECT * FROM vw_animais_detalhados",
        (err, results) => {

            if (err) {
                return res.status(500).json(err);
            }

            res.json(results);

        }
    );

};