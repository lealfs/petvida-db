const express = require("express");

const router = express.Router();

const controller =
require("../controllers/pagamentos.controller");

router.post(
    "/:consulta_id",
    controller.registrar
);

module.exports = router;