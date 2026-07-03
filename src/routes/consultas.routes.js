const express = require("express");

const router = express.Router();

const controller =
require("../controllers/consultas.controller");

router.get(
    "/agenda/:data",
    controller.listarPorData
);

module.exports = router;
router.post(
    "/",
    controller.agendar
);
router.put(
    "/:id/concluir",
    controller.concluir
);